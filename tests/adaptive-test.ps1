# ============================================================================
#  adaptive-test.ps1   -   tests the ASCII-art reveal in winGG10&11.ps1
# ============================================================================
#  Run it directly. It needs a real console window, makes no system changes,
#  and only draws to the screen.
#
#    powershell -NoProfile -ExecutionPolicy Bypass -File .	estsdaptive-test.ps1
#
#  WHAT IT COVERS
#  Show-ArtReveal picks one of three outcomes at runtime, depending on the
#  console it finds: a plain print when there is no console or no VT, the
#  line-by-line Show-ArtCascade when the art will not fit on screen, and the
#  in-place animation when it will. This forces each of those deliberately
#  instead of waiting for a machine that happens to trigger it. It also
#  asserts the VT guard on Restore-ConsoleColour.
#
#  Part 1 shows the real effects, paused, so they can be judged by eye.
#  Part 2 asserts the branches and prints a pass/fail summary.
#
#  HOW IT AVOIDS LYING
#  The VT probe, $script:VTIndex, Restore-ConsoleColour, Write-Gradient,
#  $script:CanAnimate, Show-ArtReveal and Show-ArtCascade below are lifted
#  VERBATIM from winGG10&11.ps1. A test holding a reimplementation drifts,
#  keeps passing, and proves nothing - so Test-NoDrift re-parses the script
#  beside it and fails if these copies no longer match it.
#
#  It also does not infer the branch from how long a call took. It captures
#  the real Show-ArtCascade and Write-Gradient, shadows those names with
#  spies that record the path and then call through, and shadows Write-Host
#  to catch plain prints. Every case asserts the path ACTUALLY taken. That
#  matters, because art wider than the window takes two hops - the cascade,
#  then the cascade's own width guard plain-printing it - which is
#  indistinguishable from a direct plain print by eye or by stopwatch.
#
#  READING A FAILURE
#  A branch failure names what it expected and what it got. A drift failure
#  means the script changed and this file needs relifting - not that the
#  chain is broken.
# ============================================================================

#ADDED: VT probe. ENABLE_VIRTUAL_TERMINAL_PROCESSING lets a whole frame carry its
#own colour inside one [Console]::Write. Without it, per-cell colour needs
#Write-Host per character - about 120 ms a frame for the banner, which looks worse
#than no animation at all, so Show-ArtReveal falls back to a plain print instead.
#This matters under Windows PowerShell 5.1, which is what actually renders these.
$script:VTOK = $false
try {
    if (-not ('Win32.VTNative' -as [type])) {
        Add-Type -Name VTNative -Namespace Win32 -MemberDefinition @'
[DllImport("kernel32.dll", SetLastError=true)] public static extern IntPtr GetStdHandle(int n);
[DllImport("kernel32.dll", SetLastError=true)] public static extern bool GetConsoleMode(IntPtr h, out uint m);
[DllImport("kernel32.dll", SetLastError=true)] public static extern bool SetConsoleMode(IntPtr h, uint m);
'@
    }
    $vtH = [Win32.VTNative]::GetStdHandle(-11)
    [uint32]$vtM = 0
    if ([Win32.VTNative]::GetConsoleMode($vtH, [ref]$vtM)) {
        if ([Win32.VTNative]::SetConsoleMode($vtH, $vtM -bor 0x0004)) { $script:VTOK = $true }
    }
} catch { $script:VTOK = $false }

$script:VTIndex = @{
    'Black'=0; 'DarkRed'=1; 'DarkGreen'=2; 'DarkYellow'=3
    'DarkBlue'=4; 'DarkMagenta'=5; 'DarkCyan'=6; 'Gray'=7
    'DarkGray'=8; 'Red'=9; 'Green'=10; 'Yellow'=11
    'Blue'=12; 'Magenta'=13; 'Cyan'=14; 'White'=15
}

Function Restore-ConsoleColour {
    #Re-asserts the host's current colours as VT escapes, so animation state does not
    #leak into the rest of the run.
    #A VT escape is only meaningful when VT is on. Both call sites sit after the
    #plain-print early-returns, so this cannot currently be reached with VT off - but
    #without this guard a future call site would print [38;5;7m as literal text into
    #the output, which is exactly what happened when the test harness called it
    #unconditionally. Guarding here rather than at each call site.
    if (-not $script:VTOK) { return }
    try {
        $e = [char]27
        $f = "$($Host.UI.RawUI.ForegroundColor)"
        $b = "$($Host.UI.RawUI.BackgroundColor)"
        if ($script:VTIndex.ContainsKey($f) -and $script:VTIndex.ContainsKey($b)) {
            [Console]::Write($e + '[38;5;' + $script:VTIndex[$f] + 'm' + $e + '[48;5;' + $script:VTIndex[$b] + 'm')
        }
    } catch { }
}

Function Write-Gradient {
    param(
        [string]$Text,
        [System.ConsoleColor[]]$Palette = @('DarkCyan','Cyan','White','Cyan','DarkCyan','Blue'),
        [int]$DelayMs = 0
    )
    if (-not $script:CanAnimate) { Write-Host $Text; return }
    $i = 0
    foreach ($ch in $Text.ToCharArray()) {
        if ($ch -eq "`n") { Write-Host ''; $i++; continue }
        if ($ch -eq "`r") { continue }
        Write-Host $ch -NoNewline -ForegroundColor $Palette[$i % $Palette.Count]
        if ($DelayMs -gt 0 -and $ch -ne ' ') { Start-Sleep -Milliseconds $DelayMs }
        $i++
    }
    Write-Host ''
}

$script:CanAnimate = $false
try {
    $script:CanAnimate = ($Host.Name -eq 'ConsoleHost') -and (-not [Console]::IsOutputRedirected)
}
catch { $script:CanAnimate = $false }

Function Show-ArtReveal {
    param(
        [string]$Art,
        [ValidateSet('Sweep','Rain')][string]$Style = 'Sweep',
        [ValidateSet('Banner','Leaf')][string]$Theme = 'Banner',
        [int]$FrameMs = 45,
        [switch]$ClearFirst
    )

    $rows = $Art -split "`r?`n"
    while ($rows.Count -gt 1 -and $rows[0].Trim() -eq '') { $rows = $rows[1..($rows.Count-1)] }
    while ($rows.Count -gt 1 -and $rows[-1].Trim() -eq '') { $rows = $rows[0..($rows.Count-2)] }
    $BW = 0; foreach ($r in $rows) { if ($r.Length -gt $BW) { $BW = $r.Length } }
    $BH = $rows.Count

    #fall back to a plain print when there is no console to animate on, when VT is
    #unavailable, or when the art is wider than the window and would wrap.
    $cantFit = $false
    $winH    = 0
    try {
        $win  = $Host.UI.RawUI.WindowSize
        $winH = $win.Height
        #Too wide always wraps and shreds the alignment. Too tall depends on where it
        #starts: with -ClearFirst the art begins at row 0 and can use the whole window,
        #without it the art has to fit with the cursor somewhere below it.
        if ($ClearFirst) { $fits = ($BH -le $winH) } else { $fits = ($BH -lt $winH) }
        #Art taller than the window cannot be repainted in place - the whole block has
        #to be visible at once. Growing the console was tried and abandoned: MaxWindowSize
        #is itself capped by the BUFFER, so a 120x30 buffer reports a 30-row ceiling that
        #is not the screen's real limit - MaxPhysicalWindowSize is. Growing it properly
        #means resizing buffer and window together, in the right order, and a resize is
        #still refused outright once MaxWindowSize equals the current window. Not worth
        #it for art that has a height-independent path available: Show-ArtCascade
        #rewrites one line at a time and does not care about height at all.

        $cantFit = ($BW -ge $win.Width) -or (-not $fits)
    } catch { $cantFit = $true }
    #Adaptive, because this runs on whatever machine it lands on. Three outcomes:
    #  no console or no VT   -> plain print, nothing animated is possible
    #  will not fit on screen -> hand to Show-ArtCascade, which rewrites one line at
    #                            a time and so does not care how tall the art is
    #  fits                   -> animate in place, the effect that was asked for
    #Screen geometry varies wildly - laptop, big console font, high DPI, RDP - so the
    #decision is made at runtime per machine rather than assumed.
    if (-not $script:CanAnimate -or -not $script:VTOK) {
        if ($Theme -eq 'Leaf') { Write-Host $Art -ForegroundColor DarkGreen }
        else { Write-Gradient -Text $Art -Palette DarkCyan,Cyan,White,Cyan,DarkCyan,Blue -DelayMs 0 }
        return
    }
    if ($cantFit) {
        Show-ArtCascade -Art $Art -Theme $Theme -StepMs 18 -Steps 3
        return
    }

    $esc = [char]27
    if ($Theme -eq 'Leaf') {
        $pal  = @(@(20,120,40), @(60,180,70), @(140,230,140), @(60,180,70), @(20,120,40), @(10,90,30))
        $dim  = "$esc[38;2;10;80;30m"
        $head = "$esc[38;2;200;255;200m"
    } else {
        $pal  = @(@(0,139,139), @(0,220,220), @(235,255,255), @(0,220,220), @(0,139,139), @(40,90,220))
        $dim  = "$esc[38;2;0;110;110m"
        $head = "$esc[38;2;235;255;255m"
    }

    $grid = New-Object 'char[]' ($BW * $BH)
    for ($y = 0; $y -lt $BH; $y++) {
        $line = $rows[$y].PadRight($BW)
        for ($x = 0; $x -lt $BW; $x++) { $grid[$x + $BW*$y] = $line[$x] }
    }

    #Anchor AFTER the blank lines, not before. Writing $BH blank lines scrolls the
    #window whenever the cursor is near the bottom, which moves everything up - so a
    #$top captured beforehand points at a row that has since shifted, and every frame
    #then repaints in the wrong place. That is the smeared art you get on a short
    #window: tall art plus any preceding output guarantees a scroll. Deriving $top
    #from where the cursor ENDED UP absorbs however many rows actually scrolled.
    if ($ClearFirst) {
        #after a clear the screen is empty and the cursor is at 0,0 - so the art can
        #simply start there. Skipping the reserve lines also skips the scroll they
        #would cause, which is what broke this in the first place.
        try { Clear-Host } catch { }
        $top = 0
    } else {
        for ($i = 0; $i -lt $BH; $i++) { Write-Host '' }
        $top = [Console]::CursorTop - $BH
        if ($top -lt 0) { $top = 0 }
    }
    try { [Console]::CursorVisible = $false } catch { }

    $rnd   = New-Object System.Random
    $noise = '8.*dPYb:;=-~'.ToCharArray()
    $sb    = New-Object System.Text.StringBuilder

    if ($Style -eq 'Rain') {
        $drop = New-Object double[] $BW
        $spd  = New-Object double[] $BW
        for ($x = 0; $x -lt $BW; $x++) { $drop[$x] = -$rnd.Next(0, 14); $spd[$x] = 0.7 + $rnd.NextDouble() * 0.9 }
        while ($true) {
            $fsw = [System.Diagnostics.Stopwatch]::StartNew()
            $done = $true
            for ($x = 0; $x -lt $BW; $x++) { if ($drop[$x] -le $BH) { $done = $false }; $drop[$x] += $spd[$x] }
            $null = $sb.Clear(); $lastCol = ''
            $null = $sb.Append("$esc[48;5;0m")   #keep the black background; a bare reset drops to the console default
            for ($y = 0; $y -lt $BH; $y++) {
                for ($x = 0; $x -lt $BW; $x++) {
                    $hy = [int]$drop[$x]
                    if ($y -eq $hy -and $hy -lt $BH) { $c = $head; $o = $noise[$rnd.Next($noise.Count)] }
                    elseif ($y -gt $hy)              { $c = '';    $o = ' ' }
                    elseif ($y -lt $hy)              { $p = $pal[($x + $y) % $pal.Count]; $c = "$esc[38;2;$($p[0]);$($p[1]);$($p[2])m"; $o = $grid[$x + $BW*$y] }
                    else                             { $c = $dim;  $o = $noise[$rnd.Next($noise.Count)] }
                    if ($c -ne '' -and $c -ne $lastCol) { $null = $sb.Append($c); $lastCol = $c }
                    $null = $sb.Append($o)
                }
                if ($y -lt $BH-1) { $null = $sb.Append("`n") }
            }
            $null = $sb.Append("$esc[39m")
            [Console]::SetCursorPosition(0, $top)
            [Console]::Write($sb.ToString())
            if ($done) { break }
            $rem = $FrameMs - $fsw.Elapsed.TotalMilliseconds
            if ($rem -gt 0) { Start-Sleep -Milliseconds ([int]$rem) }
        }
    } else {
        for ($edge = 0; $edge -le $BW + 6; $edge += 2) {
            $fsw = [System.Diagnostics.Stopwatch]::StartNew()
            $null = $sb.Clear(); $lastCol = ''
            $null = $sb.Append("$esc[48;5;0m")   #keep the black background; a bare reset drops to the console default
            for ($y = 0; $y -lt $BH; $y++) {
                for ($x = 0; $x -lt $BW; $x++) {
                    if ($x -lt $edge - 3)   { $p = $pal[($x + $y) % $pal.Count]; $c = "$esc[38;2;$($p[0]);$($p[1]);$($p[2])m"; $o = $grid[$x + $BW*$y] }
                    elseif ($x -le $edge)   { $c = $head; $o = $grid[$x + $BW*$y]; if ($o -eq ' ') { $o = '|' } }
                    else                    { $c = '';    $o = ' ' }
                    if ($c -ne '' -and $c -ne $lastCol) { $null = $sb.Append($c); $lastCol = $c }
                    $null = $sb.Append($o)
                }
                if ($y -lt $BH-1) { $null = $sb.Append("`n") }
            }
            $null = $sb.Append("$esc[39m")
            [Console]::SetCursorPosition(0, $top)
            [Console]::Write($sb.ToString())
            $rem = $FrameMs - $fsw.Elapsed.TotalMilliseconds
            if ($rem -gt 0) { Start-Sleep -Milliseconds ([int]$rem) }
        }
    }

    $end = $top + $BH
    if ($winH -gt 0 -and $end -gt ($winH - 1)) { $end = $winH - 1 }
    try { [Console]::SetCursorPosition(0, $end) } catch { }
    try { [Console]::CursorVisible = $true } catch { }
    Restore-ConsoleColour
}

Function Show-ArtCascade {
    param(
        [string]$Art,
        [ValidateSet('Banner','Leaf')][string]$Theme = 'Leaf',
        [int]$StepMs = 18,
        [int]$Steps  = 3
    )
    $rows = $Art -split "`r?`n"
    while ($rows.Count -gt 1 -and $rows[0].Trim()  -eq '') { $rows = $rows[1..($rows.Count-1)] }
    while ($rows.Count -gt 1 -and $rows[-1].Trim() -eq '') { $rows = $rows[0..($rows.Count-2)] }

    $wide = $false
    try {
        $maxLen = 0; foreach ($r in $rows) { if ($r.Length -gt $maxLen) { $maxLen = $r.Length } }
        $wide = ($maxLen -ge $Host.UI.RawUI.WindowSize.Width)
    } catch { $wide = $true }
    if (-not $script:CanAnimate -or -not $script:VTOK -or $wide) {
        if ($Theme -eq 'Leaf') { Write-Host $Art -ForegroundColor DarkGreen } else { Write-Host $Art }
        return
    }

    $esc = [char]27
    if ($Theme -eq 'Leaf') {
        $pal = @(@(20,120,40), @(60,180,70), @(140,230,140), @(60,180,70), @(20,120,40), @(10,90,30))
        $dim = "$esc[38;2;15;95;35m"
    } else {
        $pal = @(@(0,139,139), @(0,220,220), @(235,255,255), @(0,220,220), @(0,139,139), @(40,90,220))
        $dim = "$esc[38;2;0;110;110m"
    }
    $noise = '8.*dPYb:;=-~'.ToCharArray()
    $rnd   = New-Object System.Random
    $sb    = New-Object System.Text.StringBuilder

    try { [Console]::CursorVisible = $false } catch { }
    for ($y = 0; $y -lt $rows.Count; $y++) {
        $line = $rows[$y]
        $len  = $line.Length
        for ($s = 1; $s -le $Steps; $s++) {
            $shown = [int][Math]::Ceiling($len * $s / $Steps)
            $null = $sb.Clear()
            $null = $sb.Append("`r")
            $null = $sb.Append("$esc[48;5;0m")   #keep the black background; a bare reset drops to the console default
            $lastCol = ''
            for ($x = 0; $x -lt $len; $x++) {
                $ch = $line[$x]
                if ($ch -eq ' ') { $null = $sb.Append(' '); continue }
                if ($x -lt $shown) {
                    $p = $pal[($x + $y) % $pal.Count]
                    $c = "$esc[38;2;$($p[0]);$($p[1]);$($p[2])m"
                    $o = $ch
                } else {
                    $c = $dim
                    $o = $noise[$rnd.Next($noise.Count)]
                }
                if ($c -ne $lastCol) { $null = $sb.Append($c); $lastCol = $c }
                $null = $sb.Append($o)
            }
            $null = $sb.Append("$esc[39m")
            [Console]::Write($sb.ToString())
            if ($s -lt $Steps) { Start-Sleep -Milliseconds $StepMs }
        }
        [Console]::Write("`n")
    }
    try { [Console]::CursorVisible = $true } catch { }
    Restore-ConsoleColour
}

# ===================== spies over the real functions ========================
# Capture the genuine implementations, then shadow the names. Each spy records
# the path it saw and then calls through, so what happens on screen is exactly
# what the shipped script does.
${function:Real-Cascade}  = ${function:Show-ArtCascade}
${function:Real-Gradient} = ${function:Write-Gradient}

$script:spyOn = $false
$script:trace = @()

function Show-ArtCascade {
    param([string]$Art,[ValidateSet('Banner','Leaf')][string]$Theme='Banner',[int]$StepMs=18,[int]$Steps=3)
    if ($script:spyOn) { $script:trace += 'cascade' }
    Real-Cascade @PSBoundParameters
}

function Write-Gradient {
    param([string]$Text,[System.ConsoleColor[]]$Palette=@('DarkCyan','Cyan','White','Cyan','DarkCyan','Blue'),[int]$DelayMs=0)
    if ($script:spyOn) { $script:trace += 'gradient' }
    Real-Gradient @PSBoundParameters
}

# The plain-print fallbacks hand the WHOLE art to Write-Host in a single call,
# so a multi-line argument is the signature of a plain print. Single-line calls
# are Show-ArtReveal's blank-line padding and Write-Gradient's per-character
# output, and are deliberately ignored.
function Write-Host {
    [CmdletBinding()]
    param([Parameter(Position=0,ValueFromPipeline=$true)]$Object,
          [System.ConsoleColor]$ForegroundColor,
          [System.ConsoleColor]$BackgroundColor,
          [switch]$NoNewline)
    if ($script:spyOn -and $Object -is [string] -and $Object -match "`n") { $script:trace += 'plain' }
    Microsoft.PowerShell.Utility\Write-Host @PSBoundParameters
}

# Shorthand so the harness's own output never goes through the spy.
Set-Alias say Microsoft.PowerShell.Utility\Write-Host

# ============================== helpers =====================================
function New-TestArt([int]$rows,[int]$cols) {
    $out = @()
    for ($y = 0; $y -lt $rows; $y++) {
        $s = ''
        for ($x = 0; $x -lt $cols; $x++) { $s += $(if ((($x + $y) % 4) -eq 0) { '8' } else { '.' }) }
        $out += ('{0:00}' -f ($y + 1)) + $s
    }
    return ($out -join "`n")
}

$script:results = @()

function Test-Branch {
    param([string]$Name,[string]$Art,[string]$Style,[string]$Theme,
          [switch]$ClearFirst,[string]$Expect,[string]$Timing = 'any')

    $script:trace = @()
    $script:spyOn = $true
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    if ($ClearFirst) { Show-ArtReveal -Art $Art -Style $Style -Theme $Theme -FrameMs 20 -ClearFirst }
    else             { Show-ArtReveal -Art $Art -Style $Style -Theme $Theme -FrameMs 20 }
    $sw.Stop()
    $script:spyOn = $false
    # Called unconditionally on purpose: the function carries its own VT guard
    # now, and Test-ColourGuard below asserts that guard directly.
    Restore-ConsoleColour

    $got = ($script:trace -join ',')
    $ms  = $sw.Elapsed.TotalMilliseconds
    $pathOK = ($got -eq $Expect)
    # a reveal, in place or cascading, has to span many frames.
    # a plain print has to be effectively instant.
    $timeOK = switch ($Timing) {
        'animated' { $ms -gt 300 }
        'instant'  { $ms -lt 400 }
        default    { $true }
    }
    $script:results += [pscustomobject]@{
        Name     = $Name
        Expected = $(if ($Expect -eq '') { '(in-place)' } else { $Expect })
        Got      = $(if ($got -eq '')    { '(in-place)' } else { $got })
        Ms       = [int]$ms
        Timing   = $Timing
        PathOK   = $pathOK
        TimeOK   = $timeOK
        Pass     = ($pathOK -and $timeOK)
    }
}


function Add-Result([string]$name,[string]$expected,[string]$got,[bool]$pass) {
    $script:results += [pscustomobject]@{
        Name = $name; Expected = $expected; Got = $got; Ms = 0
        Timing = 'n/a'; PathOK = $pass; TimeOK = $true; Pass = $pass
    }
}


# A test carrying copies of the code it tests goes stale silently. This
# re-parses the script next to it and compares the lifted functions against
# the real ones, so staleness becomes a visible failure. Run from somewhere
# without the script beside it, it reports skipped rather than failing.
function Test-NoDrift {
    $src = Join-Path (Split-Path -Parent $PSCommandPath) '..\winGG10&11.ps1'
    if (-not (Test-Path -LiteralPath $src)) {
        Add-Result 'lifted code still matches the script' 'match' 'skipped - script not beside test' $true
        return
    }
    $firstDefs = {
        param($path)
        $e = $null; $t = $null
        $ast = [System.Management.Automation.Language.Parser]::ParseFile(
                   (Resolve-Path -LiteralPath $path).Path, [ref]$t, [ref]$e)
        $out = @{}
        foreach ($f in $ast.FindAll({ $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $true)) {
            # First definition wins. In THIS file the spies redefine two of
            # these names further down, and the verbatim copies come first.
            if (-not $out.ContainsKey($f.Name)) { $out[$f.Name] = $f.Extent.Text }
        }
        return $out
    }
    try {
        $inScript = & $firstDefs $src
        $inTest   = & $firstDefs $PSCommandPath
    }
    catch {
        Add-Result 'lifted code still matches the script' 'match' ('could not parse - ' + $_.Exception.Message) $false
        return
    }
    $drifted = @()
    foreach ($n in 'Restore-ConsoleColour','Write-Gradient','Show-ArtReveal','Show-ArtCascade') {
        if     (-not $inScript.ContainsKey($n)) { $drifted += "$n gone from script" }
        elseif (-not $inTest.ContainsKey($n))   { $drifted += "$n gone from test" }
        elseif ($inScript[$n] -ne $inTest[$n])  { $drifted += $n }
    }
    $got = $(if ($drifted.Count -eq 0) { 'match' } else { 'STALE: ' + ($drifted -join ', ') })
    Add-Result 'lifted code still matches the script' 'match' $got ($drifted.Count -eq 0)
}

# Restore-ConsoleColour writes through [Console]::Write, so swapping Console.Out for
# a StringWriter captures exactly what it emits. That turns "does the VT guard work"
# into a string comparison instead of something judged by eye.
function Test-ColourGuard {
    $orig = [Console]::Out
    $sw   = New-Object System.IO.StringWriter
    $vtSaved = $script:VTOK
    $offOut = $null; $onOut = $null
    try {
        [Console]::SetOut($sw)
        $script:VTOK = $false
        Restore-ConsoleColour
        $offOut = $sw.ToString()
        $null = $sw.GetStringBuilder().Clear()
        $script:VTOK = $true
        Restore-ConsoleColour
        $onOut = $sw.ToString()
    }
    finally {
        $script:VTOK = $vtSaved
        [Console]::SetOut($orig)
    }
    Add-Result 'VT off  -> emits nothing' 'empty' $(if ($offOut -eq '') { 'empty' } else { 'WROTE ' + $offOut.Length + ' chars' }) ($offOut -eq '')
    $looksRight = ($onOut -match '\[38;5;') -and ($onOut -match '\[48;5;')
    Add-Result 'VT on   -> emits fg+bg escapes' 'fg+bg' $(if ($looksRight) { 'fg+bg' } else { 'got ' + $onOut.Length + ' chars' }) $looksRight
}

# ================================ run ========================================
Clear-Host
$win = $Host.UI.RawUI.WindowSize
$buf = $Host.UI.RawUI.BufferSize
say ""
say "   ADAPTIVE FALLBACK CHAIN - TEST HARNESS" -ForegroundColor Cyan
say "   ======================================" -ForegroundColor Cyan
say ""
say ("   host        : {0}" -f $Host.Name)
say ("   PowerShell  : {0}" -f $PSVersionTable.PSVersion)
say ("   window      : {0} x {1}" -f $win.Width, $win.Height)
say ("   buffer      : {0} x {1}" -f $buf.Width, $buf.Height)
say ("   VTOK        : {0}" -f $script:VTOK)
say ("   CanAnimate  : {0}" -f $script:CanAnimate)
say ""
say "   PART 1 - the real effects, paused so you can watch each one." -ForegroundColor Yellow
say "   PART 2 - automated branch assertions, with a summary at the end." -ForegroundColor Yellow
say ""
say "   Enter to start." -ForegroundColor DarkGray
$null = Read-Host

# ------------- PART 1a: fits, in-place sweep (the banner) --------------------
Clear-Host
say ""
say " [1a] ART THAT FITS  ->  in-place SWEEP   (what the opening banner does)" -ForegroundColor Yellow
say ""
Show-ArtReveal -Art (New-TestArt 8 56) -Style Sweep -Theme Banner -FrameMs 25
Restore-ConsoleColour
say ""
say "   Enter for the next one." -ForegroundColor DarkGray
$null = Read-Host

# ------------- PART 1b: fits, in-place rain (the closing art) ----------------
Clear-Host
say ""
say " [1b] ART THAT FITS  ->  in-place RAIN   (what the closing art does)" -ForegroundColor Yellow
say ""
Show-ArtReveal -Art (New-TestArt 9 56) -Style Rain -Theme Leaf -FrameMs 40
Restore-ConsoleColour
say ""
say "   Enter for the next one." -ForegroundColor DarkGray
$null = Read-Host

# ------------- PART 1c: too tall, hands off to the cascade -------------------
Clear-Host
$tallRows = $win.Height + 8
say ("  [1c] ART TALLER THAN THE WINDOW  ({0} rows in a {1}-row window)" -f $tallRows, $win.Height) -ForegroundColor Yellow
say "       It must hand off to the cascade, still animate, and not smear." -ForegroundColor DarkGray
Start-Sleep -Milliseconds 1200
Show-ArtReveal -Art (New-TestArt $tallRows 56) -Style Rain -Theme Leaf -FrameMs 40
Restore-ConsoleColour
say ""
say "   Scroll up - every row should be clean and complete." -ForegroundColor DarkGray
say "   Enter to continue." -ForegroundColor DarkGray
$null = Read-Host

# ------------- PART 1d: colour must not leak ---------------------------------
Clear-Host
say ""
say " [1d] COLOUR MUST SURVIVE AN ANIMATION" -ForegroundColor Yellow
say ""
$savedFg = $Host.UI.RawUI.ForegroundColor
$Host.UI.RawUI.ForegroundColor = 'Magenta'
"   BEFORE - this line sets no colour of its own and should be MAGENTA"
Show-ArtReveal -Art (New-TestArt 7 56) -Style Sweep -Theme Banner -FrameMs 25
Restore-ConsoleColour
"   AFTER  - this line sets no colour of its own and should STILL be MAGENTA"
say ""
say "   Both magenta means Restore-ConsoleColour is doing its job." -ForegroundColor DarkGray
say "   Enter to continue." -ForegroundColor DarkGray
$null = Read-Host
$Host.UI.RawUI.ForegroundColor = $savedFg

# ------------- PART 2: automated branch assertions ---------------------------
Clear-Host
say ""
say " PART 2 - asserting which branch each input actually takes..." -ForegroundColor Yellow
say "          (the art below is scratch, only the summary matters)" -ForegroundColor DarkGray
say ""
Start-Sleep -Milliseconds 900

$fitsArt  = New-TestArt 8 56
$tallArt  = New-TestArt ($win.Height + 8) 56
$wideArt  = New-TestArt 6 ($win.Width + 24)
$exactArt = New-TestArt $win.Height 56
# The Banner plain-print path goes through Write-Gradient, which emits one
# Write-Host per character. Keep that art small so a slow host cannot blur the
# line between "printed at once" and "animated over many frames".
$smallArt = New-TestArt 4 40

# --- normal operation: the art fits, so it animates in place ---
Test-Branch 'fits, Banner         -> in-place'      $fitsArt Sweep Banner -Expect ''        -Timing animated
Test-Branch 'fits, Leaf           -> in-place'      $fitsArt Rain  Leaf   -Expect ''        -Timing animated

# --- too tall for an in-place repaint, so the cascade takes it ---
Test-Branch 'too tall             -> cascade'       $tallArt Rain  Leaf   -Expect 'cascade' -Timing animated

# --- too wide: the chain sends it to the cascade, whose own width guard then
#     plain-prints it. Two hops, and both have to show up. ---
Test-Branch 'too wide             -> cascade,plain' $wideArt Rain Leaf -Expect 'cascade,plain' -Timing instant

# --- the height boundary, the subtle part. -ClearFirst starts the art at row 0
#     so it may use the whole window (-le). Without it the cursor has to sit
#     below the art, so it needs one row spare (-lt). ---
Test-Branch 'exactly winH, +Clear -> in-place'      $exactArt Rain Leaf -ClearFirst -Expect ''        -Timing animated
Test-Branch 'exactly winH, -Clear -> cascade'       $exactArt Rain Leaf             -Expect 'cascade' -Timing animated

# --- VT unavailable: no per-cell colour, so nothing animated is possible ---
$savedVT = $script:VTOK
$script:VTOK = $false
Test-Branch 'no VT, Leaf          -> plain'         $fitsArt Rain  Leaf   -Expect 'plain'    -Timing instant
Test-Branch 'no VT, Banner        -> gradient'      $smallArt Sweep Banner -Expect 'gradient' -Timing instant
$script:VTOK = $savedVT

# --- no console to animate on: redirected output, ISE, any non-ConsoleHost.
#     Write-Gradient has its own CanAnimate guard, so Banner degrades twice. ---
$savedCA = $script:CanAnimate
$script:CanAnimate = $false
Test-Branch 'no console, Leaf     -> plain'          $fitsArt Rain  Leaf   -Expect 'plain' -Timing instant
Test-Branch 'no console, Banner   -> gradient,plain' $smallArt Sweep Banner -Expect 'gradient,plain' -Timing instant
$script:CanAnimate = $savedCA

# --- the VT guard on Restore-ConsoleColour, asserted directly ---
Test-ColourGuard

# --- is this file still in step with the script it tests? ---
Test-NoDrift

# ------------------------------- summary -------------------------------------
Clear-Host
$pass = @($script:results | Where-Object { $_.Pass }).Count
$fail = @($script:results | Where-Object { -not $_.Pass }).Count
say ""
say "   ADAPTIVE CHAIN - BRANCH ASSERTIONS" -ForegroundColor Cyan
say "   ==================================" -ForegroundColor Cyan
say ("   window {0} x {1}    VT={2}    CanAnimate={3}" -f $win.Width, $win.Height, $script:VTOK, $script:CanAnimate) -ForegroundColor DarkGray
say ""
foreach ($r in $script:results) {
    $tag = $(if ($r.Pass) { 'PASS' } else { 'FAIL' })
    $col = $(if ($r.Pass) { 'Green' } else { 'Red' })
    say ("   {0}  {1,-38} got {2,-16} {3,5} ms" -f $tag, $r.Name, $r.Got, $r.Ms) -ForegroundColor $col
    if (-not $r.PathOK) { say ("            wrong branch - expected {0}" -f $r.Expected) -ForegroundColor Red }
    if (-not $r.TimeOK) { say ("            wrong timing - expected {0}" -f $r.Timing)   -ForegroundColor Red }
}
say ""
say ("   {0} passed, {1} failed" -f $pass, $fail) -ForegroundColor $(if ($fail -eq 0) { 'Green' } else { 'Red' })
say ""
say "   Enter to close." -ForegroundColor DarkGray
$null = Read-Host
