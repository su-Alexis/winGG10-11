############################################################################################################################################################################################################################################################################
############################################################################################################################################################################################################################################################################
##|/////
##|////
##|///
##|//
##|/
##
##  Hi, I'm Alexis! This project started as a way to pass the time during quarantine and to learn PowerShell. 
##  Initially, I attempted to build this script in .bat, but quickly realized it wasn't the right tool for the job—it felt like digging a river with a spork! 
##  After some research, I discovered Syncex's script, and I'd like to extend a huge thanks to them and all their contributors for their work. 
##  This project builds upon their debloater, with additional functions I've added for optimization, system tweaks, stability, gaming enhancements, and network improvements.
##  
##  This script aims to be an all-in-one solution for anyone, like my friends and me, who needed a tool that simplifies system optimization after a reformat or major Windows update. Special thanks also go out to Dan Pollock and their contributors for their fantastic Hosts file—your work deserves all the recognition!
##  
##  In short, this script is designed to help users get the most out of their machine with minimal hassle.
##  
##  I hope it serves you as well as it has helped my friends and me!
##
##  
##  Credit goes to Syncex and all their contributers for the original Windows10Debloater script that this was built off of.
##  Syncex's Github:  https://github.com/Sycnex
##  Syncex's Win10Debloater script:  https://github.com/Sycnex/Windows10Debloater
##  
##  Credit goes to Dan Pollock and all their contributers for the Hosts file
##  Dan Pollock's website:  https://someonewhocares.org
##  Dan Pollock's Hosts file:  https://someonewhocares.org/hosts/
##  
##  Credit always goes to stackoverflow and everyone there <3
##  Stackoverflow's website:  https://stackoverflow.com/
##  
##  Credit also ofcourse goes towards github and everyone there <3
##  Github's website:  https://github.com
##  
##
##  SPECIAL THANKS TO : Topoman, Nightingale, Barn, Mari, Online, AriderM, Zal 
##  and everyone else who helped me in one way or another and gave me feedback <3
##
##  
##  2/20/2022 update: Everyone wanted it automated with no GUI and easier to read terminal and stuffs so here you all go <3 
##
##¡
##|\
##|\\
##|\\\
##|\\\\
##|\\\\\
##|\\\\\\
##|\\\\\\\ 
###################################################################
###################################################################
##                                                               ##
##           LAST EDITED : 09 - 13 - 2026 01:08:15 A.M.          ##
##                          Version 24H2                         ##
##                                                               ##
###################################################################
###################################################################
##|///////
##|//////
##|/////
##|////
##|///
##|//
##|/
##!
##
##  FUNCTION LIST
##
##  HOW THE FILE IS LAID OUT:
##
##    header + story + licences        this bit
##    all the logic                    every function, together
##    EMBEDDED DATA                    hosts blocklist + the 3 .bat tools, fenced off
##    MAIN                             the run order, at the bottom
##
##
##  HELPERS:
##
##  Write-Color                     colour a line piece by piece (the table + status tags)
##  Write-Countdown                 3. . . 2. . . 1. . .
##  redundantColors                 set the terminal colours
##  Invoke-Step                     run one step, report OK / PARTIAL / ERROR, record it
##  Write-RunSummary                the tally printed at the end
##  CleanMemoryy                    drop variables created during the run
##
##
##  DEBLOAT:
##
##  DebloatAll                      whitelist sweep - removes everything not protected
##  DebloatBlacklist                the curated list - sponsored junk, CandyCrush etc.
##  FixWhitelistedApps              re-registers anything the sweep took by mistake
##  Remove-Keys                     leftover bloatware registry keys
##
##
##  PRIVACY:
##
##  Protect-Privacy                 telemetry, ad ID, Wi-Fi Sense, live tiles, tasks
##  DisableCortana                  Cortana + input personalisation
##  DisableDiagTrackService         stop + disable DiagTrack
##  CheckDMWService                 put dmwappushservice back if something disabled it
##  Stop-EdgePDF                    stop Edge grabbing .pdf
##
##
##  OPTIMIZE / TWEAK:
##
##  GameOptimizer                   network throttle, GPU priority, GameDVR off
##  SystemOpti                      clock sync, mouse, keyboard, sound, explorer, shutdown
##  UnparkCPU                       unpark the cores
##  HSdisable                       Fast Boot / hybrid shutdown off
##  SystemClockSec                  seconds on the taskbar clock
##  AutoRunDis                      AutoRun off
##  OSKDis                          on-screen keyboard off
##  AeroShakeDisable                stop shake-to-minimise
##  Remove3dObjects                 drop 3D Objects from This PC
##  HIGHPOWA                        power plan -> High Performance
##
##
##  NETWORK:
##
##  NagleAlgoDis                    Nagle's algorithm off per interface
##  BlocklistMNNSSM                 write Dan Pollock's hosts blocklist (backs up first)
##  Set-CloudFlareDNS               1.1.1.1 / 1.0.0.1 on every connected PHYSICAL adapter
##  NetResetReboot                  runs net-reset-reboot.bat /y /none  (resets, never reboots)
##
##
##  SYSTEM / TOOLS:
##
##  GenSysRestorePoint              restore point - verified, not just attempted
##  DISMWinRepair                   CheckHealth, repair only if needed, then sfc /scannow
##  Build-DesktopTools              writes the 3 .bat tools + God Mode to the Desktop
##  .Net 3.5                        enabled inline from MAIN
##
##
##  WHAT LANDS ON YOUR DESKTOP:
##
##  cleanup_main.bat                                     (built by Build-DesktopTools)
##  net-reset-reboot.bat                                 (built, and used by NetResetReboot)
##  net-reset-lite.bat                                   (built - no reboot needed)
##  GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}       (built - every control panel task)
##
##
##  GONE:  NetFullReset and NetResetLite were removed - net-reset-reboot.bat and
##         net-reset-lite.bat do the same jobs properly. Cloud-StoreRem was listed
##         here for years but never actually existed.
##
##|\
##|\\
##|\\\
##|\\\\
##|////
##|///
##|//
##|/
##
##
##
##|\
##|\\
##|\\\
##|\\\\
##|\\\\\  
##|/////
##|////
##|///
##|//
##|/  
##
##
##
##|\
##|\\
##|\\\
##|\\\\
##|////
##|///
##|//
##|/
##
##
##  My Updated License 
##
##  MIT License
##  
##  Copyright (c) 2024 su-Alexis
##  
##  Permission is hereby granted, free of charge, to any person obtaining a copy
##  of this software and associated documentation files (the "Software"), to deal
##  in the Software without restriction, including without limitation the rights
##  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
##  copies of the Software, and to permit persons to whom the Software is
##  furnished to do so, subject to the following conditions:
##  
##  The above copyright notice and this permission notice shall be included in all
##  copies or substantial portions of the Software.
##  
##  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
##  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
##  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
##  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
##  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
##  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
##  SOFTWARE.
##
##  
##
##  
##
##  Syncex's original script is licensed under the MIT License.
## 
##  MIT License
##
##  Copyright (c) 2017 Richard Newton
##  
##  Permission is hereby granted, free of charge, to any person obtaining a copy
##  of this software and associated documentation files (the "Software"), to deal
##  in the Software without restriction, including without limitation the rights
##  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
##  copies of the Software, and to permit persons to whom the Software is
##  furnished to do so, subject to the following conditions:
##  
##  The above copyright notice and this permission notice shall be included in all
##  copies or substantial portions of the Software.
##  
##  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
##  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
##  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
##  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
##  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
##  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
##  SOFTWARE.
##
##
##  Dan Pollock's hosts file carries its own terms, quoted from its header:
##
##    "You are free to copy and distribute this file for non-commercial uses,
##     as long the original URL and attribution is included."
##
##  Note that is NOT a Creative Commons licence - it is the author's own wording,
##  and it restricts commercial use. The source URL and attribution are retained
##  inside the embedded copy, which is what those terms require.
##
##  
##|\
##|\\
##|\\\
##|\\\\
##|\\\\\  
############################################################################################################################################################################################################################################################################
############################################################################################################################################################################################################################################################################


#Google is a great tool found this function by accident
function CleanMemoryy { 
    <# 
    SYNOPSIS : Removes all variables from memory that did not exist before this script was run. 
    DESCRIPTION : Removes all variables from memory that did not exist before this script was run. 
    The script uses a global variable to record any existing variables before the script is run and uses this to idetnify new variables which must have been created during the script run.
    $Global:startupVariables          
    Call the function at the beginning of a script and then call it at the end   to clear all the veriables created during the script run. 
    The script uses the Remove-Variable cmdlet to force the deletion of the variables not stored in the $Global:startupVariables variable.  
    The script does not have any input parameters .
    EXAMPLE     : CleanMemoryy 
    INPUTS      : None 
    OUTPUTS     : A global variable $Global:startupVariables .
    NOTES NAME  : CleanMemoryy 
    VERSION     : Version 1.0 
    AUTHOR      : Lee Andrews 
    CREATED     : 13th November 2012 
    LASTEDIT    : 13th November 2012 - 
    Version 1.0 . LINK Remove-Variable .
    LINK        : http://collaborate/technology/eng/global/platform/ps/default.aspx        
    #>   
    if ($Global:startupvariables) {    
    # if the startup variable exists we assume the call is to clean up after a script run     
    Get-Variable | Where-Object { $Global:startupVariables -notcontains $_.Name } | ForEach-Object { try { Remove-Variable -Name "$($_.Name)" -Force -Scope "global" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue} catch { } } # remove the variables from memory that are not in the startupVariable global variable     
    # now clean the startupVariables                                                                    # just in case this is an inital run after the script had failed in the last run lets set up the variable again     
    try {Remove-Variable -Name startupvariables  -Scope "Global" -Force -ErrorAction SilentlyContinue } catch { } New-Variable -name startupVariables -Force -Scope "Global" -value ( Get-Variable | ForEach-Object { $_.Name } ) 
    }   # If the global variable startupVariables exists then remove any variables that are not in it.   
    else {     
    New-Variable -name startupVariables -Force -Scope "Global" -value ( Get-Variable | ForEach-Object { $_.Name } )   
    }   # Else - Store all the start up variables in startupVariables so you can clean up when the script finishes.
    # Removes all redundant variables from memory #
}

#CONSOLIDATED: this block existed 7 times across the file - twice as a function called
#redundantColors (the second definition silently overwrote the first) and 5 more times
#copy-pasted inline. It also never worked properly. The old form was:
#
#    If (!($host.UI.RawUI.BackgroundColor = "Black") -and ($host.UI.RawUI.ForegroundColor = "Magenta")) { ... }
#
#A parenthesised assignment in PowerShell *returns* the assigned value, so the background
#was set as a side effect of evaluating the condition, "!" made it $false, and -and then
#short-circuited - which meant the foreground assignment never ran and the body was dead
#code. It half-worked by accident. One parameterised version now, and it sets both.
#Keeping the name, it's a good one.
Function redundantColors {
    #The name stays - it earned it. What changed is HOW the colour gets set, and why the blue
    #background never behaved.
    #
    #$Host.UI.RawUI.BackgroundColor does not just set a colour. conhost responds by REPAINTING
    #THE ENTIRE SCREEN BUFFER in the new colour - so everything still sitting in scrollback is
    #redrawn, padded out to the full window width. That is why changing the foreground looks
    #fine and changing the background looks broken: output from thirty steps ago reappears
    #underneath the prompt. Windows is not breaking this. It is what the API has always done.
    #
    #Two paths now, which is the whole point of a function called redundantColors:
    #  1. VT escape sequences - the modern console path. These colour SUBSEQUENT output only and
    #     never touch scrollback, so there is no repaint and no artifact. conhost has supported
    #     them since Win10 1511; Windows Terminal always has.
    #  2. RawUI, exactly as before, for hosts where VT is unavailable or switched off.
    #
    #-ClearScreen empties the buffer BEFORE the colour change, so when RawUI does repaint there
    #is nothing stale left to redraw. Use it wherever a full-screen colour change is intended -
    #the exit branches at the bottom of this script are the reason it exists.
    param(
        [System.ConsoleColor]$Background = 'Black',
        [System.ConsoleColor]$Foreground = 'Magenta',
        [switch]$ClearScreen
    )


    #Path 1: VT. Silent no-op anywhere it is not understood.
    try {
        $vt = @{
            'Black' = 0; 'DarkRed' = 1; 'DarkGreen' = 2; 'DarkYellow' = 3
            'DarkBlue' = 4; 'DarkMagenta' = 5; 'DarkCyan' = 6; 'Gray' = 7
            'DarkGray' = 8; 'Red' = 9; 'Green' = 10; 'Yellow' = 11
            'Blue' = 12; 'Magenta' = 13; 'Cyan' = 14; 'White' = 15
        }
        $fg = "$Foreground"
        $bg = "$Background"
        if ($vt.ContainsKey($fg) -and $vt.ContainsKey($bg)) {
            $esc = [char]27
            [Console]::Write($esc + '[38;5;' + $vt[$fg] + 'm' + $esc + '[48;5;' + $vt[$bg] + 'm')
        }
    }
    catch { }

    #Path 2: RawUI. This is what actually persists the colour for the window - harmless now that
    #the buffer has been cleared above when a full-screen change was asked for.
    try {
        $pswindow = (Get-Host).UI.RawUI
        $pswindow.BackgroundColor = $Background
        $pswindow.ForegroundColor = $Foreground
    }
    catch {
        #Some hosts (ISE, certain terminal embeddings) don't allow this. Not worth failing over.
    }

    #Clear LAST, not first. Clearing before the colour change wipes the buffer using the OLD
    #background, so the new colour only applies to whatever is written afterwards - which is
    #how the closing countdown ended up as blue text sitting on a black screen. Clearing after
    #both colour paths have run fills the visible buffer with the new background, so the screen
    #and everything printed on it agree. This also still solves what -ClearFirst was for: any
    #repaint conhost does has already happened by now, and this wipes whatever it redrew.
    if ($ClearScreen) { try { Clear-Host } catch { } }
}

Function Close-ScriptWindow {
    #Closes the console a few seconds after the run finishes.
    #
    #Plain 'Exit' only ends the SCRIPT and hands control back to the host - so the window stays
    #open whenever powershell.exe was started with -NoExit, which is most of the time in practice
    #(any wrapper that wants to read the output uses it, and so does anything that launches this
    #for logging). [Environment]::Exit ends the process itself, so the window goes away either
    #way. Stop-Transcript has already run well before this point, so nothing is lost by it.
    #
    #Only the two NO-REBOOT branches call this. The reboot branches hand off to Restart-Computer,
    #which takes the window with it.
    param([int]$Seconds = 3)
    Write-Host ''
    for ($i = $Seconds; $i -ge 1; $i--) {
        Write-Host "  Closing in $i. . ." -ForegroundColor DarkGray
        Start-Sleep -Seconds 1
    }
    [Environment]::Exit(0)
}

<#
I just use this for the table!
This function is Copy Pasta from stackoverflow <3 all credit goes to them for this!
Takes output and changes the color of text 
Examples:

>>  Write-Color (@(NetFullReset) | %{"$_  " + "`n"}) -ForeGroundColor Green, Green, Green, Green -BackGroundColor Black, Black, Black, Black
>>  Write-Color "Check color list. . . ".PadRight(50), '[', '   OK   ', ']' -ForeGroundColor Black, White, green, white -BackGroundColor White, DarkBlue, DarkBlue, DarkBlue
>>  Write-Color "Red Check is ERROR. . . ".PadRight(50), '[' ,' ERROR! ', ']' -ForeGroundColor Black, White, red, white -BackGroundColor White, Black, Black, Black
>>  Write-Color "System messages. . .".PadRight(50), '[', ' SYSTEM ', ']' -fore Black, White, Yellow, white -BackGroundColor White, DarkBlue, DarkBlue, DarkBlue
>>  Write-Color (@(100..115) | %{" -> $_ : ".PadRight(30) + "`n"}) -ForeGroundColor cyan, yellow, magenta, red -BackGroundColor gray, black

colors: 
Black
DarkBlue
DarkGreen
DarkCyan
DarkRed
DarkMagenta
DarkYellow
Gray
DarkGray
Blue
Green
Cyan
Red
Magenta
Yellow
White
#>

function Write-Color([String[]]$Text, [ConsoleColor[]]$ForeGroundColor, [ConsoleColor[]]$BackGroundColor) {
    for ($i = 0; $i -lt $Text.Length; $i++) {
        $Color = @{}
        if ($ForeGroundColor -and $BackGroundColor){
            $Color = @{
                ForegroundColor = $ForeGroundColor[$i%($ForeGroundColor.count)]
                BackgroundColor = $BackGroundColor[$i%($BackGroundColor.count)]
            }
        } elseif ($ForeGroundColor) {
            $Color = @{
                ForegroundColor = $ForeGroundColor[$i%($ForeGroundColor.count)]
            }
        } elseif ($BackGroundColor) {
            $Color = @{
                BackgroundColor = $BackGroundColor[$i%($BackGroundColor.count)]
            }
        }
        Write-Host $Text[$i] @color -NoNewline
    }
    Write-Host
}

#Set the terminal to the script's colours before anything prints.
redundantColors

function Write-Countdown {
    param (
        [int]$start,
        [int]$delay = 250
    )
    for ($i = $start; $i -ge 1; $i--) {
        Write-Host -NoNewline "$i" -ForegroundColor Yellow -BackgroundColor Black
        for ($j = 1; $j -le 3; $j++) {
            Start-Sleep -Milliseconds ($delay / 4)
            Write-Host -NoNewline "." -ForegroundColor Yellow -BackgroundColor Black
        }
    }
    Write-Host ""  # Move to the next line after the countdown
}

#ADDED: a real step runner, and the reason it exists.
#
#The main body used to wrap every function call like this:
#
#    try   { GameOptimizer -ErrorAction Stop; Write-Host "worked!" }
#    catch { Write-Host "failed!" }
#
#That could never work. These are simple functions with no [CmdletBinding()] and no param()
#block, so they do not accept common parameters - "-ErrorAction Stop" was not bound to
#anything, it just fell into $args and was thrown away. Combined with the global
#$ErrorActionPreference = 'SilentlyContinue' a few lines below, nothing inside a function
#could ever raise a terminating error, so no catch block in the file could ever fire. Every
#step reported success no matter what actually happened.
#
#Rather than bolt -ErrorAction Stop onto each function (which would make a step abandon its
#remaining work at the first bad registry write - most of these functions do 20-30 mostly
#independent things and SHOULD keep going), Invoke-Step runs the step, lets it attempt
#everything, and then reports honestly: OK, PARTIAL if something errored along the way, or
#ERROR if it died outright. Results are collected for the summary printed at the end.
$Global:StepLog = [System.Collections.Generic.List[object]]::new()

#ADDED: console-capability probe. The spinner rewrites one line with carriage returns, which
#only works on a real console. If output is redirected or piped - which is exactly what
#turned this script's drawing into one-character-per-line garbage when it was run through a
#Tee-Object wrapper - animation is switched off and the original static rendering is used.
$script:CanAnimate = $false
try {
    $script:CanAnimate = ($Host.Name -eq 'ConsoleHost') -and (-not [Console]::IsOutputRedirected)
}
catch { $script:CanAnimate = $false }

#Braille frames look better but need a UTF-8 console. Fall back to plain ASCII otherwise so
#this never renders as a row of question marks on a default codepage-437 console.
$script:SpinFrames = @('|','/','-','\')
try {
    if ([Console]::OutputEncoding.CodePage -eq 65001) {
        $script:SpinFrames = @([char]0x280B,[char]0x2819,[char]0x2839,[char]0x2838,[char]0x283C,[char]0x2834,[char]0x2826,[char]0x2827,[char]0x2807,[char]0x280F)
    }
}
catch { }

#Renders text one character at a time, cycling a colour palette. Used for the banner.
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

#Cmdlets that emit progress records are supposed to send a final "completed" record when they
#finish. Several of the Appx and DISM ones do not, so the host leaves the blue banner sitting
#across the top of the console covering whatever prints afterwards. There is no "clear whatever
#is up there" call, so this writes a completed record for the handful of IDs those cmdlets
#actually use. Called at the end of every step, which means progress stays visible WHILE work
#happens - the whole point of it - without leaving anything behind once the step is done.
Function Clear-ProgressBar {
    for ($pid_ = 0; $pid_ -le 16; $pid_++) {
        try { Write-Progress -Id $pid_ -Activity ' ' -Completed } catch { }
    }
}

Function Invoke-Step {
    param(
        [Parameter(Mandatory, Position = 0)][string]$Name,
        [Parameter(Mandatory, Position = 1)][scriptblock]$Action,
        #ADDED: opt-in live spinner with a ticking elapsed counter. Only set this on steps that
        #print little or nothing of their own. A step writing to the console while the spinner
        #redraws the same line fights over the cursor and garbles both. The 14 noisy steps
        #(DISM/SFC, the Appx loops, the .bat runners) deliberately do NOT get it.
        [switch]$Spin,
        #ADDED: suppress progress rendering for the duration of this step only.
        #The Appx deployment cmdlets emit a SEPARATE progress record per package, each with
        #its own dynamically-assigned id - a dozen of them stack up and several never send a
        #completed record, so the banner sits there for the rest of the run. There is no id
        #range wide enough to reliably clear them, so the steps that produce them opt out of
        #progress entirely. They finish in seconds now, so nothing useful is lost. DISM, SFC
        #and netsh are unaffected: those are external executables printing plain text, not
        #progress records, so their percentages still show.
        [switch]$NoProgress
    )

    $useSpin = $Spin.IsPresent -and $script:CanAnimate

    if (-not $useSpin) {
        Write-Color "$Name. . .".PadRight(50), '[', '  PROCESS  '.PadLeft(12), ']' `
            -ForeGroundColor Magenta, White, Magenta, White -BackGroundColor Black, Black, Black, Black
    }

    #$Error is a ring buffer capped at $MaximumErrorCount (256 by default) - once it fills, it
    #drops the oldest entry for every new one, so its Count stops growing. A before/after DELTA
    #would therefore read 0 from that point on and cheerfully report failing steps as OK.
    #Clearing first and reading the raw count afterwards measures THIS step and cannot saturate.
    $Error.Clear()
    $fatal = $null
    $captured = $null
    $spinPs = $null
    $spinRs = $null
    $sw = [System.Diagnostics.Stopwatch]::StartNew()

    if ($useSpin) {
        try {
            $spinRs = [runspacefactory]::CreateRunspace()
            $spinRs.Open()
            $spinRs.SessionStateProxy.SetVariable('lbl', ("$Name. . .".PadRight(50)))
            $spinRs.SessionStateProxy.SetVariable('frames', $script:SpinFrames)
            $spinPs = [powershell]::Create()
            $spinPs.Runspace = $spinRs
            [void]$spinPs.AddScript({
                $i = 0
                $t0 = Get-Date
                while ($true) {
                    $el = ((Get-Date) - $t0).TotalSeconds
                    [Console]::Write(("`r{0}  {1}  {2,7:0.0}s" -f $lbl, $frames[$i % $frames.Count], $el))
                    $i++
                    Start-Sleep -Milliseconds 80
                }
            })
            [void]$spinPs.BeginInvoke()
        }
        catch { $useSpin = $false }
    }

    #Saved and restored around the action so -NoProgress is scoped to this step only.
    $savedProgress = $ProgressPreference
    if ($NoProgress) { $ProgressPreference = 'SilentlyContinue' }
    try {
        if ($useSpin) { $captured = & $Action *>&1 | Out-String }
        else          { & $Action }
    }
    catch { $fatal = $_ }
    $ProgressPreference = $savedProgress

    if ($useSpin) {
        try { $spinPs.Stop() } catch { }
        try { $spinRs.Close() } catch { }
        try { [Console]::Write("`r" + (' ' * 78) + "`r") } catch { }
    }

    #Clear any progress banner this step left behind before the status line prints.
    Clear-ProgressBar
    $sw.Stop()
    $newErrors = $Error.Count
    $firstErrors = @($Error | Select-Object -First 3 | ForEach-Object { $_.Exception.Message })

    if ($fatal) {
        $status = 'ERROR'
        Write-Color "$Name".PadRight(50), '[', '   ERROR  '.PadRight(12), ']' `
            -ForeGroundColor Red, White, Red, White -BackGroundColor Black, Black, Black, Black
        Write-Host "     $($fatal.Exception.Message)" -ForegroundColor Red
    }
    elseif ($newErrors -gt 0) {
        $status = 'PARTIAL'
        Write-Color "$Name".PadRight(50), '[', '  PARTIAL '.PadRight(12), ']' `
            -ForeGroundColor Yellow, White, Yellow, White -BackGroundColor Black, Black, Black, Black
        Write-Host "     Finished, but $newErrors operation(s) inside it failed." -ForegroundColor Yellow
        foreach ($msg in $firstErrors) { Write-Host "       - $msg" -ForegroundColor DarkYellow }
        if ($newErrors -gt $firstErrors.Count) {
            Write-Host "       ...and $($newErrors - $firstErrors.Count) more (full text in the transcript)." -ForegroundColor DarkYellow
        }
    }
    else {
        $status = 'OK'
        Write-Color "$Name".PadRight(50), '[', '     OK  '.PadRight(12), ']' `
            -ForeGroundColor Green, White, Green, White -BackGroundColor Black, Black, Black, Black
    }

    #A spun step had its output captured so it could not fight the spinner for the cursor.
    #Replay it here, dimmed and indented, so nothing is actually lost from the console or
    #the transcript - it just arrives after the status line instead of before it.
    if ($useSpin -and $captured) {
        foreach ($line in ($captured -split "`r?`n")) {
            if ($line.Trim()) { Write-Host ("       " + $line.TrimEnd()) -ForegroundColor DarkGray }
        }
    }

    $Global:StepLog.Add([pscustomobject]@{
        Step     = $Name
        Status   = $status
        Errors   = $newErrors
        Seconds  = [Math]::Round($sw.Elapsed.TotalSeconds, 1)
        Detail   = if ($fatal) { $fatal.Exception.Message } else { '' }
    })
}

#Prints the end-of-run report. For a "one and done" tool this is the part that matters:
#you walk away, come back, and this tells you what actually landed.
#REWRITTEN for legibility. Same data, same tally - but each step now carries a proportional
#duration bar, so the expensive steps are obvious at a glance instead of having to read 37
#numbers. Box characters are restricted to the codepage-437 set (they render on a default
#console as well as a UTF-8 one); status is text rather than glyphs for the same reason.
#REWRITTEN for legibility, then again for the reveal. Same data, same tally - but each step
#carries a proportional duration bar so the expensive steps are obvious at a glance instead
#of having to read 37 numbers, and the whole thing draws in rather than appearing at once.
#Box characters are restricted to the codepage-437 set so they render on a default console
#as well as a UTF-8 one; status is a text tag rather than a glyph for the same reason.
#Every delay below is gated on $script:CanAnimate - piped or redirected output prints the
#identical summary instantly, with no cursor tricks and nothing lost.
#Prints the end-of-run report. For a "one and done" tool this is the part that matters:
#you walk away, come back, and this tells you what actually landed.
#Rows use dot leaders into the same bracket tags Invoke-Step prints while running, so the
#summary reads as a recap of the lines you just watched rather than a different format.
#Rule width is 70 to fit the longest step name (42 chars) plus the tag column without wrapping.
Function Write-RunSummary {
    $LBL = 46   #dot-leader column: longest step name is 42, leaving room for " . ."
    Write-Host ""
    Write-Color ("=" * 70) -ForeGroundColor DarkGray -BackGroundColor Black
    Write-Color "  RUN SUMMARY" -ForeGroundColor Cyan -BackGroundColor Black
    Write-Color ("=" * 70) -ForeGroundColor DarkGray -BackGroundColor Black

    foreach ($entry in $Global:StepLog) {
        $colour = switch ($entry.Status) {
            'OK'      { 'Green' }
            'PARTIAL' { 'Yellow' }
            default   { 'Red' }
        }
        #Same tag strings and the same PadRight(12) column Invoke-Step uses, so the brackets
        #line up with the run output directly above them.
        $tag = switch ($entry.Status) {
            'OK'      { '     OK  ' }
            'PARTIAL' { '  PARTIAL ' }
            default   { '   ERROR  ' }
        }

        #Dot leader: name, then alternating ". " out to the tag column. Trailing dots are
        #dimmer than the name so the eye follows the row without the dots shouting.
        $name = "  " + $entry.Step + " "
        $fill = $LBL - $name.Length
        if ($fill -lt 0) { $fill = 0 }
        $dots = ""
        for ($i = 0; $i -lt $fill; $i++) {
            if ($i % 2 -eq 0) { $dots += "." } else { $dots += " " }
        }

        Write-Color $name, $dots, '[', $tag.PadRight(12), ']', ("{0,7}s" -f $entry.Seconds) `
            -ForeGroundColor White, DarkGray, White, $colour, White, DarkGray `
            -BackGroundColor Black, Black, Black, Black, Black, Black
    }

    $ok      = @($Global:StepLog | Where-Object Status -eq 'OK').Count
    $partial = @($Global:StepLog | Where-Object Status -eq 'PARTIAL').Count
    $failed  = @($Global:StepLog | Where-Object Status -eq 'ERROR').Count

    Write-Color ("=" * 70) -ForeGroundColor DarkGray -BackGroundColor Black
    Write-Color "  $ok OK", "   $partial partial", "   $failed failed" `
        -ForeGroundColor Green, Yellow, Red -BackGroundColor Black, Black, Black
    Write-Color ("=" * 70) -ForeGroundColor DarkGray -BackGroundColor Black

    if ($failed -or $partial) {
        Write-Host ""
        Write-Host "Anything not marked OK is written to the transcript in $DebloatFolder" -ForegroundColor Yellow
    }
    Write-Host ""
}

#FRAGMENT 3: run under Windows PowerShell 5.1, not PowerShell 7.
#
#This script leans on Get-AppxPackage / Get-AppxProvisionedPackage / Remove-AppxPackage. From
#PowerShell 7.1 onward the Appx module will not import natively on Windows - it fails with
#"Operation is not supported on this platform (0x80131539)" and has to be loaded through the
#-UseWindowsPowerShell compatibility shim. So the existing self-elevate below, which relaunches
#powershell.exe explicitly, was right all along - that is Windows PowerShell 5.1, which is
#exactly where this needs to run. This just makes it deliberate instead of incidental: if you
#launch from pwsh, hand the script over to 5.1 rather than failing halfway through the debloat.
If ($PSVersionTable.PSEdition -eq 'Core') {
    Write-Color "This script needs Windows PowerShell 5.1 (the Appx cmdlets do not load in PowerShell 7). Relaunching there. . ." -ForegroundColor Yellow -BackgroundColor Black
    Start-Sleep 1
    $winPS = Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'
    If (Test-Path $winPS) {
        Start-Process $winPS -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
        Exit
    }
    Else {
        Write-Color "Could not find Windows PowerShell at $winPS - carrying on, but the debloat steps will probably fail." -ForegroundColor Red -BackgroundColor Black
        Start-Sleep 2
    }
}

# This will self elevate the script with a UAC prompt since this script needs to be run as an Administrator in order to function properly.
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Write-Color "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator and continue." -ForegroundColor Red -BackgroundColor Black
    Start-Sleep 1
    Write-Countdown -start 3 -delay 1000
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
}

#(second, duplicate definition of redundantColors removed - see the consolidated one above)
redundantColors

#no errors throughout
$ErrorActionPreference = 'silentlycontinue'
#Progress bars stay ON. They were briefly suppressed here and that was a mistake: the Appx and
#DISM cmdlets take minutes, and with no progress rendering the script looks hung even though it
#is working. The actual problem was never that progress renders - it is that several of those
#cmdlets never send their final "completed" record, so the blue banner stays on screen covering
#whatever prints next, including the closing countdown. Clear-ProgressBar handles that after
#each step instead. Keep the feedback, drop the wreckage.
$ProgressPreference = 'Continue'

$DebloatFolder = "C:\Temp\WindowsDebloat&Optimize"
If (Test-Path $DebloatFolder) {
}
Else {
    #Write-Host "The folder '$DebloatFolder' doesn't exist. This folder will be used for storing logs created after the script runs. Creating now." -ForegroundColor Yellow 
    #Start-Sleep 1
    New-Item -Path "$DebloatFolder" -ItemType Directory | Out-Null
    #Write-Host "The folder $DebloatFolder was successfully created." -ForegroundColor Green
}

Add-Type -AssemblyName PresentationCore, PresentationFramework

#This function finds any AppX/AppXProvisioned package and uninstalls it, except for Freshpaint, Windows Calculator, Windows Store, and Windows Photos.
#Also, to note - This does NOT remove essential system services/software/etc such as .NET framework installations, Cortana, Edge, etc.
#===============================================================================================
#  Invoke-AsSystem
#  Runs one block of PowerShell as NT AUTHORITY\SYSTEM via a transient scheduled task, hands
#  back whatever that block emitted, and always removes the task afterwards.
#
#  WHY THIS EXISTS: the DISM Appx provider needs WRITE access to
#  HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx. That key's ACL grants write to SYSTEM
#  and TrustedInstaller only - BUILTIN\Administrators gets KeyRead. On a healthy machine DISM
#  escalates past this by itself, but where that path is unavailable an elevated Administrator
#  gets a flat "Access is denied" from Get-AppxProvisionedPackage. Measured on this box:
#  as Administrator it fails; as SYSTEM it returns the full list of 35 provisioned packages.
#
#  WHY ONLY HERE: running the whole script as SYSTEM would be actively wrong. HKCU: would
#  resolve to SYSTEM's own profile hive, so every per-user privacy setting in Protect-Privacy
#  would apply to the wrong account and do nothing for the real user. Get-AppxPackage without
#  -AllUsers would enumerate SYSTEM's packages. Build-DesktopTools would write the .bat tools
#  and God Mode to C:\Windows\System32\config\systemprofile\Desktop. And a task running
#  as SYSTEM has no interactive console, so the banner, the spinners, the run summary and the
#  reboot prompt would all render to nowhere. Only the provisioned sweeps need SYSTEM, so only
#  they get it.
#
#  The task is named with a timestamp, registered, started, waited on, and unregistered in a
#  finally block so it cannot be left behind even if the payload throws.
#===============================================================================================
Function Invoke-AsSystem {
    param(
        [Parameter(Mandatory)][string]$Body,
        [int]$TimeoutSeconds = 300
    )

    $stamp    = Get-Date -Format 'yyyyMMddHHmmssfff'
    $taskName = "w10n11deb-system-$stamp"
    $payload  = Join-Path $DebloatFolder "systemhelper-$stamp.ps1"
    $resultF  = Join-Path $DebloatFolder "systemhelper-$stamp.out"
    $signalled = $false

    try {
        #Emit() is how the payload reports back - it appends to a file this side reads after.
        $header  = '$SystemHelperOut = ' + "'" + $resultF + "'" + [Environment]::NewLine
        $header += 'function Emit($m) { Add-Content -LiteralPath $SystemHelperOut -Value $m }' + [Environment]::NewLine
        $footer  = [Environment]::NewLine + "Emit '##SYSTEMHELPER-DONE##'"
        Set-Content -LiteralPath $payload -Value ($header + $Body + $footer) -Encoding UTF8

        $action    = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument ('-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "{0}"' -f $payload)
        $principal = New-ScheduledTaskPrincipal -UserId 'SYSTEM' -LogonType ServiceAccount -RunLevel Highest
        $settings  = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

        Register-ScheduledTask -TaskName $taskName -Action $action -Principal $principal -Settings $settings -Force -ErrorAction Stop | Out-Null
        Start-ScheduledTask -TaskName $taskName -ErrorAction Stop

        $deadline = (Get-Date).AddSeconds($TimeoutSeconds)
        while ((Get-Date) -lt $deadline) {
            Start-Sleep -Milliseconds 500
            if (Test-Path -LiteralPath $resultF) {
                if ((Get-Content -LiteralPath $resultF -ErrorAction SilentlyContinue) -match '##SYSTEMHELPER-DONE##') { $signalled = $true; break }
            }
        }
    }
    catch {
        Write-Host "  SYSTEM helper could not be started: $($_.Exception.Message)" -ForegroundColor Yellow
    }
    finally {
        try { Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction Stop } catch { }
        try { if (Test-Path -LiteralPath $payload) { [System.IO.File]::Delete($payload) } } catch { }
    }

    $lines = @()
    if (Test-Path -LiteralPath $resultF) {
        $lines = @(Get-Content -LiteralPath $resultF -ErrorAction SilentlyContinue | Where-Object { $_ -ne '##SYSTEMHELPER-DONE##' })
        try { [System.IO.File]::Delete($resultF) } catch { }
    }
    if (-not $signalled) {
        Write-Host "  SYSTEM helper did not report completion within $TimeoutSeconds seconds." -ForegroundColor Yellow
    }
    return $lines
}

Function DebloatAll {
    #Removes AppxPackages
    #Credit to /u/GavinEke for a modified version of my whitelist code
    #FIXED: both of these were single-quoted strings joined with '|' and handed straight to
    #-NotMatch as a regex. That broke them in two separate ways:
    #  1. '*Nvidia*' is a glob, not a regex. A leading '*' is a quantifier with nothing to
    #     repeat, so the pattern failed to compile and -NotMatch THREW. Where-Object turned
    #     that into a terminating error, which killed this entire function in ~0.2s on every
    #     single run - it never removed one package. DebloatBlacklist was doing all the work.
    #  2. The line-continuations sat inside single quotes, where a backtick is just a literal
    #     character - so six entries became "<backtick><newline>    Microsoft.BioEnrollment"
    #     and could never match. That left BioEnrollment (Windows Hello enrollment),
    #     HEIFImageExtension, ParentalControls and XGpuEjectDialog silently unprotected.
    #     Bug 1 masked bug 2: fixing only the glob would have exposed those four for the
    #     first time, so both had to be fixed together.
    #Now they are arrays, one entry per line, with the pattern built through [regex]::Escape()
    #so a stray metacharacter can never take this function down again. Matching is still
    #unanchored substring matching via -NotMatch - same entries, same intent, same behaviour.
    #'*Nvidia*' is now 'Nvidia', which is what the glob was reaching for. Two exact duplicates
    #dropped (Microsoft.ScreenSketch, Microsoft.XboxGamingOverlay) - no-ops in an alternation.
    $WhitelistedApps = @(
        'Microsoft.WindowsTerminal'
        'Microsoft.ScreenSketch'
        'Microsoft.Paint3D'
        'Microsoft.WindowsCalculator'
        'Microsoft.WindowsStore'
        'Microsoft.Windows.Photos'
        'CanonicalGroupLimited.UbuntuonWindows'
        'Microsoft.XboxGameCallableUI'
        'Microsoft.XboxGamingOverlay'
        'Microsoft.Xbox.TCUI'
        'Microsoft.XboxIdentityProvider'
        'Microsoft.MicrosoftStickyNotes'
        'Microsoft.MSPaint'
        'Microsoft.WindowsCamera'
        '.NET'
        'Framework'
        'Microsoft.HEIFImageExtension'
        'Microsoft.StorePurchaseApp'
        'Microsoft.VP9VideoExtensions'
        'Microsoft.WebMediaExtensions'
        'Microsoft.WebpImageExtension'
        'Microsoft.DesktopAppInstaller'
        'WindSynthBerry'
        'MIDIBerry'
        'Slack'
        #--- Kept by explicit choice for a gaming target.
        'Microsoft.GamingApp'
        'Microsoft.HEVCVideoExtension'
        'Microsoft.AV1VideoExtension'
        'Microsoft.MPEG2VideoExtension'
        'Microsoft.AVCEncoderVideoExtension'
        'Microsoft.RawImageExtension'
        'Microsoft.WindowsNotepad'
        'Microsoft.Paint'
        'Claude'
        #--- Accessibility: Voice Access, Live Captions, Speech Recognition, Text Input Host.
        'MicrosoftWindows.61869720.Voiess'
        'MicrosoftWindows.61869721.Livtop'
        'MicrosoftWindows.61869722.Speion'
        'MicrosoftWindows.61869836.InpApp'
    )
    #NonRemovable Apps that where getting attempted and the system would reject the uninstall, speeds up debloat and prevents 'initalizing' overlay when removing apps
    $NonRemovable = @(
        '1527c705-839a-4832-9118-54d4Bd6a0c89'
        'c5e2524a-ea46-4f67-841f-6a9465d9d515'
        'E2A4F912-2574-4A75-9BB0-0D023378592B'
        'F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE'
        'InputApp'
        'Microsoft.AAD.BrokerPlugin'
        'Microsoft.AccountsControl'
        'Microsoft.BioEnrollment'
        'Microsoft.CredDialogHost'
        'Microsoft.ECApp'
        'Microsoft.LockApp'
        'Microsoft.MicrosoftEdgeDevToolsClient'
        'Microsoft.MicrosoftEdge'
        'Microsoft.PPIProjection'
        'Microsoft.Win32WebViewHost'
        'Microsoft.Windows.Apprep.ChxApp'
        'Microsoft.Windows.AssignedAccessLockApp'
        'Microsoft.Windows.CapturePicker'
        'Microsoft.Windows.CloudExperienceHost'
        'Microsoft.Windows.ContentDeliveryManager'
        'Microsoft.Windows.Cortana'
        'Microsoft.Windows.NarratorQuickStart'
        'Microsoft.Windows.ParentalControls'
        'Microsoft.Windows.PeopleExperienceHost'
        'Microsoft.Windows.PinningConfirmationDialog'
        'Microsoft.Windows.SecHealthUI'
        'Microsoft.Windows.SecureAssessmentBrowser'
        'Microsoft.Windows.ShellExperienceHost'
        'Microsoft.Windows.XGpuEjectDialog'
        'Microsoft.XboxGameCallableUI'
        'Windows.CBSPreview'
        'windows.immersivecontrolpanel'
        'Windows.PrintDialog'
        'Microsoft.VCLibs.140.00'
        'Microsoft.Services.Store.Engagement'
        'Microsoft.UI.Xaml.2.0'
        'Nvidia'
        #--- STRUCTURAL PROTECTION. Everything above is a package name observed on one build.
        #--- These are FAMILY PREFIXES, so a component that does not exist yet - on a newer
        #--- build, or a different SKU - is still protected. This is what stops the sweep
        #--- deleting shell components it has never seen. Anything in these families that DOES
        #--- need removing is named explicitly in DebloatBlacklist instead, which runs after.
        'MicrosoftWindows.Client.'
        'Microsoft.NET.Native'
        'Microsoft.VCLibs'
        'Microsoft.Services.Store'
        #--- Found missing when the lists were tested against packages from other builds.
        'Microsoft.Windows.Search'
        'MicrosoftWindows.Client.LKG'
        'MicrosoftWindows.Client.AIX'
        'Microsoft.XboxGameOverlay'
        #--- Windows 11 shell + runtime components. The original list predates Win11 and used
        #--- Win10-era names, so a working DebloatAll would have deleted the Start Menu, File
        #--- Explorer and Windows Security. Verified against build 26200 with a live dry run.
        'Microsoft.Windows.StartMenuExperienceHost'
        'MicrosoftWindows.Client.Core'
        'MicrosoftWindows.Client.CBS'
        'MicrosoftWindows.Client.FileExp'
        'MicrosoftWindows.Client.OOBE'
        'MicrosoftWindows.Client.Photon'
        'Microsoft.UI.Xaml'
        'Microsoft.WindowsAppRuntime'
        'Microsoft.SecHealthUI'
        'Microsoft.AsyncTextService'
        'Microsoft.Windows.PrintQueueActionCenter'
        'Microsoft.Windows.OOBENetworkConnectionFlow'
        'Microsoft.Windows.OOBENetworkCaptivePortal'
        'Microsoft.ApplicationCompatibilityEnhancements'
    )
    #Built once here rather than re-joined for every package the pipeline sees.
    $WhitelistPattern    = ($WhitelistedApps | ForEach-Object { [regex]::Escape($_) }) -join '|'
    $NonRemovablePattern = ($NonRemovable    | ForEach-Object { [regex]::Escape($_) }) -join '|'

    #REWRITTEN: this function no longer REMOVES anything. It surveys and reports.
    #
    #It used to sweep - remove every package not on the whitelist. That produces a different
    #result on every machine, because the outcome is defined by what is ABSENT from a list and
    #the package set differs with each Windows build. Measured on a 26200 test machine: 17 of 17
    #removals came from the sweep and none from the explicit blacklist, so the removal set was
    #emergent rather than intended. On a build shipping different packages you would get
    #different removals, silently, with nothing naming them.
    #
    #Removal now happens ONLY in DebloatBlacklist, against packages named explicitly. Same list
    #in, same packages out, on any machine. That is the whole point.
    #
    #What this function does instead: report anything installed that is neither protected nor
    #on the removal list - i.e. packages this script has no opinion about. Those are what a new
    #Windows build shipped that nobody has catalogued yet. They are LEFT ALONE and written to a
    #file so the blacklist can be grown deliberately from real data rather than by guessing.
    Write-Host "Surveying installed packages. . ." -ForegroundColor Yellow

    $bl = Get-BlacklistPatterns
    $unknown = @()
    foreach ($pkg in (Get-AppxPackage)) {
        $protected = ($pkg.Name -match $WhitelistPattern) -or ($pkg.Name -match $NonRemovablePattern)
        if ($protected) { continue }
        $listed = $false
        foreach ($b in $bl) { if ($pkg.Name -like $b) { $listed = $true; break } }
        if (-not $listed) { $unknown += $pkg.Name }
    }
    $unknown = @($unknown | Sort-Object -Unique)

    if ($unknown.Count -eq 0) {
        Write-Host "  Every installed package is either protected or explicitly listed. Nothing unrecognised." -ForegroundColor Green
    }
    else {
        Write-Host "  $($unknown.Count) package(s) are neither protected nor on the removal list:" -ForegroundColor Cyan
        foreach ($u in $unknown) { Write-Host "      $u" -ForegroundColor DarkGray }
        Write-Host "  These were LEFT INSTALLED. Add any you want gone to the `$Bloatware list in" -ForegroundColor Cyan
        Write-Host "  DebloatBlacklist, then re-run. Nothing is removed on a guess." -ForegroundColor Cyan
        try {
            $rep = Join-Path $DebloatFolder ("unrecognised-packages-{0:yyyyMMdd-HHmmss}.txt" -f (Get-Date))
            $header = @(
                "Packages installed on $env:COMPUTERNAME that this script has no opinion about.",
                "Generated $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')  -  OS build $([System.Environment]::OSVersion.Version)",
                "These were NOT removed. Add wanted removals to the Bloatware list in DebloatBlacklist.",
                ""
            )
            Set-Content -LiteralPath $rep -Value ($header + $unknown) -Encoding UTF8
            Write-Host "  Written to $rep" -ForegroundColor DarkGray
        }
        catch { }
    }
}

#ADDED: this function was called in the main body but never actually defined anywhere in the
#file. With $ErrorActionPreference set to SilentlyContinue the CommandNotFound was swallowed
#and the script still printed "Whitelisted Apps have been re-added." - so anything DebloatAll
#stripped by accident never came back. Rebuilt from Sycnex's original, using the same
#re-register trick (credit to abulgatz) against the whitelist this script actually uses.
Function FixWhitelistedApps {
    Write-Host "Checking whitelisted apps and re-registering any that went missing. . ." -ForegroundColor Yellow

    #Keep this list in step with $WhitelistedApps in DebloatAll.
    $ToRestore = @(
        'Microsoft.WindowsCalculator'
        'Microsoft.WindowsStore'
        'Microsoft.Windows.Photos'
        'Microsoft.ScreenSketch'
        'Microsoft.MicrosoftStickyNotes'
        'Microsoft.WindowsTerminal'
        'Microsoft.Paint3D'
        'Microsoft.MSPaint'
        'Microsoft.WindowsCamera'
        'Microsoft.DesktopAppInstaller'
        'Microsoft.StorePurchaseApp'
    )

    foreach ($App in $ToRestore) {
        #Already present for the current user? Then there is nothing to do.
        if (Get-AppxPackage -Name $App -ErrorAction SilentlyContinue) { continue }

        #Still staged for some user on the box - re-register it from its install location.
        $Staged = Get-AppxPackage -AllUsers -Name $App -ErrorAction SilentlyContinue
        if (-not $Staged) {
            Write-Host "  $App is not staged on this machine - skipping." -ForegroundColor DarkGray
            continue
        }

        foreach ($Pkg in $Staged) {
            $Manifest = Join-Path $Pkg.InstallLocation 'AppXManifest.xml'
            if (-not (Test-Path $Manifest)) { continue }
            try {
                Add-AppxPackage -DisableDevelopmentMode -Register $Manifest -ErrorAction Stop
                Write-Host "  Restored $App" -ForegroundColor Green
            }
            catch {
                Write-Host "  Could not restore $App - $($_.Exception.Message)" -ForegroundColor Red
            }
        }
    }
}


#SINGLE SOURCE OF TRUTH for what this script removes.
#
#Pulled out of DebloatBlacklist so DebloatAll can read the same list when it surveys.
#Two copies of this list would drift, and a drift here means the survey reports a
#package as unrecognised while the remover deletes it - or the reverse. One list.
#
#EVERYTHING THIS SCRIPT REMOVES IS NAMED HERE. Nothing is removed for not being on
#some other list, which is what makes the result identical on every machine.
Function Get-BlacklistPatterns {
    return @(
        #Unnecessary Windows 10 AppX Apps
        #Extra
        #Sponsored Windows 10 AppX Apps
        #Add sponsored/featured apps to remove in the "*AppName*" format
        "*EclipseManager*"
        "*ActiproSoftwareLLC*"
        "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
        "*Duolingo-LearnLanguagesforFree*"
        "*PandoraMediaInc*"
        "*CandyCrush*"
        "*BubbleWitch3Saga*"
        "*Wunderlist*"
        "*Flipboard*"
        "*Twitter*"
        "*Facebook*"
        "*Spotify*"
        "*Minecraft*"
        "*Royal Revolt*"
        "*Sway*"
        "*Speed Test*"
        "*Dolby*"
        #ADDED: every package the whitelist sweep actually removed on a Windows 11 26200 test
        #machine, now named EXPLICITLY. This matters for consistency across machines: before
        #this, 17 of 17 removals came from the sweep (i.e. from NOT being on the whitelist)
        #and none from this list, so the outcome was defined by absence and changed with every
        #build. Naming them here means these specific packages are removed on any machine that
        #has them, regardless of what else that build ships.
        "*Clipchamp*"
        "*AIFabric*"
        "*BingSearch*"
        "*BingWeather*"
        "*BingNews*"
        "*OutlookForWindows*"
        "*PowerAutomateDesktop*"
        "*StartExperiencesApp*"
        "*Microsoft.Todos*"
        "*WidgetsPlatformRuntime*"
        "*Client.WebExperience*"
        "*DevHome*"
        "*YourPhone*"
        "*CrossDevice*"
        "*QuickAssist*"
        "*MSTeams*"
        "*AugLoop*"
        "*UndockedDevKit*"
        "*GetHelp*"
        "*Microsoft.People*"
        "*ZuneMusic*"
        "*ZuneVideo*"
        "*549981C3F5F10*"
        #Optional: Typically not removed but you can if you need to for some reason
        #"*Microsoft.Advertising.Xaml_10.1712.5.0_x64__8wekyb3d8bbwe*"
        #"*Microsoft.Advertising.Xaml_10.1712.5.0_x86__8wekyb3d8bbwe*"
        #"*Microsoft.BingWeather*"
        #"*Microsoft.MSPaint*"
        #"*Microsoft.MicrosoftStickyNotes*"
        #"*Microsoft.Windows.Photos*"
        #"*Microsoft.WindowsCalculator*"
        #"*Microsoft.WindowsStore*"
    )
}

Function DebloatBlacklist {

    #The list itself lives in Get-BlacklistPatterns so the survey in DebloatAll reads exactly
    #the same entries. One list, no drift.
    $Bloatware = Get-BlacklistPatterns
    #ADDED: the provisioned list is now fetched ONCE up front instead of being re-enumerated
    #inside the loop for every entry in $Bloatware - that was ~50 full DISM enumerations a run.
    #It is also fenced. Get-AppxProvisionedPackage needs write access to
    #HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx, which only SYSTEM and TrustedInstaller
    #hold. Where that path is unavailable it throws "Access is denied", and Where-Object turns
    #that into a terminating error - which used to abandon this entire function. Now the
    #per-user removal still runs and the step degrades to PARTIAL with a message you can act on.
    $provisioned = $null
    try {
        $provisioned = @(Get-AppxProvisionedPackage -Online -ErrorAction Stop)
    }
    catch {
        #FALLBACK: an elevated Administrator was refused write access to the Appx key. Retry the
        #same sweep as SYSTEM, which does hold it. $Error is deliberately NOT cleared on success:
        #a fallback having been needed is worth surfacing, so the step reports PARTIAL with the
        #detail rather than silently claiming a clean OK.
        Write-Host "  Provisioned sweep refused to Administrator - retrying as SYSTEM. . ." -ForegroundColor Yellow
        $names = ($Bloatware | ForEach-Object { $_.Replace("'", "''") }) -join "','"
        $body =
            '$bloat = @(''' + $names + ''')' + [Environment]::NewLine +
            'try {' + [Environment]::NewLine +
            '  $prov = @(Get-AppxProvisionedPackage -Online -ErrorAction Stop)' + [Environment]::NewLine +
            '  Emit ("enumerated " + $prov.Count + " provisioned packages")' + [Environment]::NewLine +
            '  foreach ($b in $bloat) {' + [Environment]::NewLine +
            '    foreach ($p in ($prov | Where-Object { $_.DisplayName -like $b })) {' + [Environment]::NewLine +
            '      try { Remove-AppxProvisionedPackage -Online -PackageName $p.PackageName -ErrorAction Stop; Emit ("removed " + $p.DisplayName) }' + [Environment]::NewLine +
            '      catch { Emit ("failed  " + $p.DisplayName + " : " + $_.Exception.Message) }' + [Environment]::NewLine +
            '    }' + [Environment]::NewLine +
            '  }' + [Environment]::NewLine +
            '}' + [Environment]::NewLine +
            'catch { Emit ("SYSTEM was also denied: " + $_.Exception.Message) }'
        $res = @(Invoke-AsSystem -Body $body)
        if ($res.Count) { foreach ($line in $res) { Write-Host "    $line" -ForegroundColor DarkGray } }
        else {
            Write-Host "  Provisioned sweep could not run at all. Per-user removal still happened," -ForegroundColor Yellow
            Write-Host "  but provisioned copies remain and this bloat WILL return for any new" -ForegroundColor Yellow
            Write-Host "  user profile created on this machine." -ForegroundColor Yellow
        }
    }

    foreach ($Bloat in $Bloatware) {
        Get-AppxPackage -Name $Bloat | Remove-AppxPackage
        if ($null -ne $provisioned) {
            $provisioned | Where-Object { $_.DisplayName -like $Bloat } | Remove-AppxProvisionedPackage -Online
        }
        Write-Host "Trying to remove $Bloat."
    }
}

Function Remove-Keys {
        
    #These are the registry keys that it will delete.
            
    $Keys = @(
            
        #Remove Background Tasks
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
            
        #Windows File
        "HKCR:\Extensions\ContractId\Windows.File\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            
        #Registry keys to delete if they aren't uninstalled by RemoveAppXPackage/RemoveAppXProvisionedPackage
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
            
        #Scheduled Tasks to delete
        "HKCR:\Extensions\ContractId\Windows.PreInstalledConfigTask\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
            
        #Windows Protocol Keys
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
               
        #Windows Share Target
        "HKCR:\Extensions\ContractId\Windows.ShareTarget\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
    )
        
    #This writes the output of each key it is removing and also removes the keys listed above.
    #FIXED: this used to announce "Removing <key>" for all ~18 keys and then call Remove-Item
    #blind. These are version-pinned to 2017-era package builds (10.0.15063, 17.7909.7600.0),
    #so on a 24H2 machine almost none of them exist - the log was pure noise. Now it only
    #speaks up about keys that are actually there.
    #REWRITTEN for speed. This loop used to call Test-Path against HKCR:\... for each key.
    #HKCR: is a MERGED view of HKLM\SOFTWARE\Classes and HKCU\SOFTWARE\Classes, and PowerShell's
    #registry provider reconciles that merge on every deep path resolution. Measured on this
    #machine: 12 SECONDS per Test-Path, 18 keys, ~216 seconds for a step that finds nothing.
    #That was the entire reason this step appeared to hang.
    #
    #Going through .NET directly against each hive skips the provider entirely:
    #    HKCR: provider ....... ~216,000 ms
    #    HKLM: provider ....... ~4,500 ms
    #    .NET OpenSubKey ......      2.3 ms   <- this
    #
    #Both hives are checked because that is what HKCR: was actually covering - a per-user
    #registration lives under HKCU\SOFTWARE\Classes and would otherwise be missed.
    $hives = @(
        @{ Name = 'HKLM'; Root = [Microsoft.Win32.Registry]::LocalMachine },
        @{ Name = 'HKCU'; Root = [Microsoft.Win32.Registry]::CurrentUser }
    )
    ForEach ($Key in $Keys) {
        $sub = 'SOFTWARE\Classes\' + ($Key -replace '^HKCR:\\', '')
        ForEach ($hive in $hives) {
            $probe = $null
            try { $probe = $hive.Root.OpenSubKey($sub) } catch { }
            if ($probe) {
                $probe.Close()
                Write-Host "Removing $($hive.Name)\$sub from registry"
                try { $hive.Root.DeleteSubKeyTree($sub) }
                catch { Write-Host "  could not remove it: $($_.Exception.Message)" -ForegroundColor DarkYellow }
            }
        }
    }
}

Function GameOptimizer {
	#This function Improves overall Game perferomance on the machine 
	#Unthrottles Network Perferomance
	Write-Host "Unthrottling Network Perferomance. . ." -ForegroundColor Yellow 
	$NetworkThrottle = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
	If (Test-Path $NetworkThrottle) {
		Set-ItemProperty $NetworkThrottle NetworkThrottlingIndex -Value 4294967295 -Type DWord 
        Write-Color "Network Has Been Unthrottled. . . " -ForegroundColor Green -BackgroundColor Black
		}
	#Unthrottles SystemResponsiveness
	Write-Host "Unthrottling System Responsiveness. . ." -ForegroundColor Yellow 
	$SysResponse = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
	If (Test-Path $SysResponse) {
    #CHANGED 0 -> 10. This is the percentage of CPU that MMCSS reserves for multimedia threads.
    #0 reserves nothing, which reads like the aggressive gaming choice and is how it is usually
    #shared - but it is also the documented cause of audio crackle and stutter under load, and
    #voice comms (Discord, TeamSpeak) run in that same scheduler class. 10 is the competitive
    #consensus: effectively all of the gaming benefit, without starving your comms mid-fight.
    Set-ItemProperty $SysResponse SystemResponsiveness -Value 10 -Type DWord -Force
        Write-Color "System Responsiveness Has Been Unthrottled. . . " -ForegroundColor Green -BackgroundColor Black
		}
	#Optimization for Games
	Write-Host "Optimizing Games. . ." -ForegroundColor Yellow 
	$GameOpti = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"
	If (Test-Path $GameOpti) {
		Set-ItemProperty $GameOpti -name "Affinity" -Value 0
		Set-ItemProperty $GameOpti -name "Background Only" -Value "False" -Type String 
		Set-ItemProperty $GameOpti -name "Clock Rate" -Value 10000
		Set-ItemProperty $GameOpti -name "GPU Priority" -Value 8
		Set-ItemProperty $GameOpti -name "Priority" -Value 6 -Type DWORD
		Set-ItemProperty $GameOpti -name "Scheduling Category" -Value "High" -Type String 
		Set-ItemProperty $GameOpti -name "SFIO Priority" -Value "High" -Type String 
        Write-Color "Games Have Been Optimized. . . " -ForegroundColor Green -BackgroundColor Black
	}
    #Disables GameDVR
    Write-Host "Disabling GameDVR. . ." -ForegroundColor Yellow 
    $GameDVR1 = "HKCU:\SYSTEM\GameConfigStore"
    $GameDVR2 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR"
    If (Test-Path $GameDVR1) {
        Set-ItemProperty $GameDVR1 GameDVR_Enabled -Value 0
        Set-ItemProperty $GameDVR1 GameDVR_FSEBehaviorMode -Value 2
    }
    If (Test-Path $GameDVR2) {
        Set-ItemProperty $GameDVR2 value -Value 0
    }
    Write-Color "GameDVR Has Been Disabled. . . " -ForegroundColor Green -BackgroundColor Black
}

Function UnparkCPU {
	#Unparks CPU
	Write-Host "Unparking CPU. . ." -ForegroundColor Yellow 
	$CPUunpark = "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583"
    $CPUunpark2 = "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00"
	If (Test-Path $CPUunpark) {
		Set-ItemProperty $CPUunpark ValueMax -Value 0
		Set-ItemProperty $CPUunpark ValueMin -Value 0
	}
    If (Test-Path $CPUunpark2) {
        Set-ItemProperty $CPUunpark2 ValueMax -Value 0
        Set-ItemProperty $CPUunpark2 ValueMin -Value 0
    }
    Write-Color "CPU Has Been Unparked. . . " -ForegroundColor Green -BackgroundColor Black
}

Function SystemClockSec {
    #Enable Display of seconds in system clock
    $SysClockS = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    If (Test-Path $SysClockS) {
        Set-ItemProperty $SysClockS ShowSecondsInSystemClock -Value 1
    }
}  

Function HSdisable {
    #Disable Hybrid Shutdown 
    $HybridShutdown = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
    Write-Host "Disabling Hybrid Shutdown" -ForegroundColor Yellow 
    If (Test-Path $HybridShutdown) {
        Set-ItemProperty $HybridShutdown hiberbootenabled -Value 0
    }
}

Function SystemOpti {
    #This does system omptimizations and some QoL changes.
    Write-Host "Beginning to Optimize System Performance. . ." -ForegroundColor Yellow
    $NUDdisable = "HKLM:\SYSTEM\CurrentControlSet\Services\Ndu"
    #$MemManage = "HKLM:\System\CurrentControlSet\Control\Session Manager\Memory Management"
    $Serializingg = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"
    $Mousegg = "HKCU:\Control Panel\Mouse"
    $Keyboardgg = "HKCU:\Control Panel\Keyboard"
    $ExplorerPathgg = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
    #FIXED: was "...\Control\Session", which does not exist.
    #Verified on a live 24H2 box: WaitToKillServiceTimeout lives directly under
    #HKLM:\SYSTEM\CurrentControlSet\Control as REG_SZ (Windows default "5000").
    #It is NOT under "Session Manager" - that key has no WaitToKill* values at all.
    $SessionPath = "HKLM:\SYSTEM\CurrentControlSet\Control"
    $Desktopgg = "HKCU:\Control Panel\Desktop"
    $Soundgg = "HKCU:\SOFTWARE\Microsoft\Multimedia\Audio"
    $WinBanAlloc = "HKLM:\Software\Policies\Microsoft\Windows"
    $WinBanAlloc2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Psched"

    #Changes clock sync to dynamic so everything uses the clock it wants not forced to one specific system clock
    Write-Host "Beginning to change Clock Sync. . ." -ForegroundColor Yellow
    #CHANGED from "bcdedit /set useplatformclock false" to deleting the value outright.
    #
    #This setting decides whether Windows forces the HPET as its primary timer source. Absent,
    #Windows runs its own selection at boot and picks the invariant TSC on any modern CPU - a
    #single RDTSC instruction, ~20ns. Setting it TRUE forces HPET, whose reads cross the bus to
    #the chipset at hundreds of ns; that is what every "disable HPET" guide is actually about.
    #
    #Setting it FALSE is not the same as absent. Absent means Windows decides every boot with
    #whatever logic that build ships. FALSE pins a constraint: it survives Windows upgrades that
    #improve that logic, and it removes the graceful fallback for the systems where the TSC is
    #not invariant. On most modern installs the value was never present at all, so setting it
    #false ADDS an entry where none existed. Deleting returns the machine to "Windows decides",
    #which is the actual goal.
    #
    #bcdedit errors when the value is not present - the common case on a clean install, and a
    #success for us. Routed through cmd with 2>nul so that expected noise never reaches $Error
    #and never turns a healthy step into a PARTIAL.
    $null = cmd /c "bcdedit /deletevalue useplatformclock 2>nul"
    bcdedit /set disabledynamictick yes
    Write-Color "Clock Sync has been changed. . . " -ForegroundColor Green -BackgroundColor Black
    #Tracking that isn't needed. 
    Write-Host "Disabling Network Usage Diagnostics. . ." -ForegroundColor Yellow 
    #FIXED: was Start=1. Service Start semantics are 0=Boot 1=System 2=Automatic 3=Manual 4=Disabled.
    #Ndu ships as 2 (Automatic); writing 1 made it start EARLIER, the opposite of "disabled".
    #4 is the disable value. Confirmed on a live box: DiagTrack (correctly disabled elsewhere in
    #this script) sits at Start=4, while Ndu had been left at 1 by previous runs.
    If (Test-Path $NUDdisable) {
        Set-ItemProperty $NUDdisable Start -Value 4 -Type DWord -Force
        Write-Color "Network Usage Diagnostics has been disabled. . . " -ForegroundColor Green -BackgroundColor Black
    }
    #speeds up boot
    Write-Host "Disabling Startup Delay. . ." -ForegroundColor Yellow
    #FIXED: the Serialize key does not exist on a clean install, so this Test-Path was always
    #false and the tweak never applied. Create it first, then write. Value 0 unchanged.
    If (-not (Test-Path $Serializingg)) {
        New-Item -Path $Serializingg -Force | Out-Null
    }
    If (Test-Path $Serializingg) {
        Set-ItemProperty $Serializingg StartupDelayInMSec -Value 0 -Type DWord -Force
        Write-Color "Startup Delay has been disabled. . . " -ForegroundColor Green -BackgroundColor Black
    }
    Write-Host "Beginning to optimize Applications. . ." -ForegroundColor Yellow 
    If (Test-Path $Desktopgg) {
        ###Decreases menus show delay time, it'll make the menus show faster upon clicking.
        ##Set-ItemProperty $Desktopgg MenuShowDelay -Value 10
        ###Reduces system waiting time before killing user processes when the user clicks on "End Task" button in Task Manager.
        ##Set-ItemProperty $Desktopgg HungAppTimeout -Value 1000
        #FIXED (type only - every value below is unchanged):
        #AutoEndTasks and WaitToKillAppTimeout are REG_SZ, not REG_DWORD. Written as DWORD
        #Windows ignores them. Evidence: MenuShowDelay in this same key is Windows-native and
        #is String, while the DWORDs here were the ones this script created on past runs.
        #LowLevelHooksTimeout genuinely is REG_DWORD, so it stays a DWord.
        #Forces Windows to automatically end user services when the user logs off or shuts down the computer. It'll prevent the "Closing apps and shutting down, This app is preventing shutdown" screen from appearing.
        Set-ItemProperty $Desktopgg AutoEndTasks -Value "1" -Type String -Force
        #Reduces system waiting time before killing user processes when the user logs off or shuts down the computer.
        Set-ItemProperty $Desktopgg WaitToKillAppTimeout -Value "2000" -Type String -Force
        #Reduces system waiting time before killing not responding services.
        Set-ItemProperty $Desktopgg LowLevelHooksTimeout -Value 1000 -Type DWord -Force
        Write-Color "Applications have been optimized. . . " -ForegroundColor Green -BackgroundColor Black
    }
    #QoL 
    Write-Host "Beginning to optimize your Mouse. . ." -ForegroundColor Yellow 
    If (Test-Path $Mousegg) {
        $Mousegg = "HKCU:\Control Panel\Mouse"
        #MouseHoverTime - Reduces popup delay time to show popup description faster when you move mouse cursor over an item.
        #Set-ItemProperty $Mousegg MouseHoverTime - 10 -Type String -Force
        #Disable Enhance Pointer Precision (Mouse Acceleration)
        Set-ItemProperty $Mousegg MouseSpeed -Value 0 -Force
        Set-ItemProperty $Mousegg MouseThreshold1 -Value 0 -Force
        Set-ItemProperty $Mousegg MouseThreshold2 -Value 0 -Force
        Write-Color "Mouse has been optimized. . . " -ForegroundColor Green -BackgroundColor Black
    }
    #QoL
    Write-Host "Beginning to optimize your Keyboard. . ." -ForegroundColor Yellow 
    If (Test-Path $Keyboardgg) {
        Set-ItemProperty $Keyboardgg KeyboardDelay -Value 0 -Force
        Set-ItemProperty $Keyboardgg KeyboardSpeed -Value 31 -Force
        Write-Color "Keyboard has been optimized. . . " -ForegroundColor Green -BackgroundColor Black
    }
    #QoL
    Write-Host "Beginning to optimize Sound settings. . ." -ForegroundColor Yellow 
    If (Test-Path $Soundgg) {
        $Soundgg = "HKCU:\SOFTWARE\Microsoft\Multimedia\Audio"
        #Set Communication in Sound Control Panel to "Do Nothing"
        Set-ItemProperty $Soundgg UserDuckingPreference -Value 3 -Type DWORD -Force
        Write-Color "Sound settings have been optimized. . . " -ForegroundColor Green -BackgroundColor Black
    }
    #QoL
    Write-Host "Beginning to optimize your Explorer. . ." -ForegroundColor Yellow 
    If (Test-Path $ExplorerPathgg) {
        #Disables the low disk space check so that you don't get the annoying low disk space notification in system tray.
        Set-ItemProperty $ExplorerPathgg NoLowDiskSpaceChecks -Value 1 -Type dword
        #Prevents Windows from wasting time in searching for a program which no longer exists in your system when you try to open its shortcut.
        Set-ItemProperty $ExplorerPathgg LinkResolveIgnoreLinkInfo -Value 1 -Type dword
        #Prevents Windows from searching for the disk drive to resolve a shortcut.  
        Set-ItemProperty $ExplorerPathgg NoResolveSearch -Value 1 -Type dword
        #Prevents Windows from using NTFS file system's tracking feature to resolve a shortcut.
        Set-ItemProperty $ExplorerPathgg NoResolveTrack -Value 1 -Type dword
        #Disables "Search on Internet" prompt in "Open with" window so that you can directly see available programs list.
        Set-ItemProperty $ExplorerPathgg NoInternetOpenWith -Value 1 -Type dword
        Write-Color "Explorer has been optimized. . . " -ForegroundColor Green -BackgroundColor Black
    }
    #Shutdown faster
    Write-Host "Beginning to optimize your Services. . ." -ForegroundColor Yellow 
    If (Test-Path $SessionPath) {
        #WaitToKillServiceTimeout - Reduces system waiting time before stopping services when the services are notified about shut down process.
        #FIXED: -Path and -Name were both missing, so "WaitToKillServiceTimeout" bound
        #positionally to -Path and the call could never do anything. Value 2000 unchanged.
        Set-ItemProperty -Path $SessionPath -Name WaitToKillServiceTimeout -Value 2000 -Type String -Force
        Write-Color "Services have been optimized. . . " -ForegroundColor Green -BackgroundColor Black
    }
    #Removes bandwith allocation for Windows which potentially increases download/upload as well as reduce ping
    Write-Host "Beginning to remove Bandwith allocation for Windows. . ."
    if (Test-Path $WinBanAlloc) {
        #FIXED: New-Item without -Force throws "A key in this path already exists" on every run
        #after the first. Invoke-Step counted that as a failed operation and reported the whole
        #step PARTIAL - which is exactly what it did on the last validation run. -Force makes it
        #idempotent; Out-Null keeps the returned key object off the console.
        New-Item -Path $WinBanAlloc -Name "Psched" -Force -ErrorAction SilentlyContinue | Out-Null
        Start-Sleep 1
        Set-ItemProperty $WinBanAlloc2 NonBestEffortLimit -Value 0 -Type dword 
        Write-Color "Bandwith allocation for Windows has been removed. . ."
    } 
}

Function AutoRunDis {
    #This Disables AutoRun
    Write-Host "Beginning to de-activate AutoRun. . ." -ForegroundColor Yellow
    $item = Get-Item `
        "REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\IniFileMapping\AutoRun.inf" `
        -ErrorAction SilentlyContinue
    if (-not $item) {
        $item = New-Item "REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\IniFileMapping\AutoRun.inf"
    }
    Set-ItemProperty $item.PSPath "(default)" "@SYS:DoesNotExist"
}

Function GenSysRestorePoint {
    #This generates a restore point that restores modified settings.
    #
    #FRAGMENT 3: the old body was a single bare Checkpoint-Computer call, and the main body
    #printed "A restore point has been created!" straight afterwards no matter what happened.
    #There are three separate ways that claim could be a lie:
    #
    #  1. System Restore can be switched off for C: entirely, in which case Checkpoint-Computer
    #     does nothing at all.
    #  2. Windows throttles restore points to one per 24 hours. The limit lives in
    #     SystemRestorePointCreationFrequency (minutes; absent means the 1440 default). A second
    #     run on the same day silently creates nothing.
    #  3. Checkpoint-Computer can fail outright and, under SilentlyContinue, say nothing.
    #
    #For a script that rewrites this much of the system, "you have a rollback point" needs to be
    #true rather than merely printed. So: make sure System Restore is on, lift the throttle for
    #exactly as long as it takes, put the throttle back, and then confirm a point really appeared.
    Write-Host "Creating a system restore point. . ." -ForegroundColor Yellow

    $SRKey       = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore'
    $FreqName    = 'SystemRestorePointCreationFrequency'
    $HadOriginal = $false
    $OriginalVal = $null

    try {
        #1. System Restore has to be enabled on the system drive or nothing else here matters.
        try {
            Enable-ComputerRestore -Drive "$env:SystemDrive\" -ErrorAction Stop
            Write-Host "  System Restore is enabled for $env:SystemDrive" -ForegroundColor Green
        }
        catch {
            Write-Host "  Could not enable System Restore on $env:SystemDrive - $($_.Exception.Message)" -ForegroundColor Red
        }

        #2. Lift the 24h throttle, remembering whether the value was there to begin with so it
        #   can be put back exactly as found rather than left at 0.
        if (-not (Test-Path $SRKey)) { New-Item -Path $SRKey -Force | Out-Null }
        $Existing = Get-ItemProperty -Path $SRKey -Name $FreqName -ErrorAction SilentlyContinue
        if ($null -ne $Existing) {
            $HadOriginal = $true
            $OriginalVal = $Existing.$FreqName
        }
        Set-ItemProperty -Path $SRKey -Name $FreqName -Value 0 -Type DWord -Force

        #3. Count what exists now, so we can prove a new one turned up.
        $Before = @(Get-ComputerRestorePoint -ErrorAction SilentlyContinue).Count

        Checkpoint-Computer -Description 'Before the powershell script' -RestorePointType MODIFY_SETTINGS -ErrorAction Stop

        $After = @(Get-ComputerRestorePoint -ErrorAction SilentlyContinue).Count
        if ($After -le $Before) {
            throw "Checkpoint-Computer reported no error, but the restore point count did not increase ($Before -> $After). Assume there is NO rollback point."
        }

        $Newest = Get-ComputerRestorePoint -ErrorAction SilentlyContinue | Select-Object -Last 1
        Write-Host "  Restore point #$($Newest.SequenceNumber) created: $($Newest.Description)" -ForegroundColor Green
    }
    finally {
        #Always hand the throttle back, including on the failure paths above.
        try {
            if ($HadOriginal) {
                Set-ItemProperty -Path $SRKey -Name $FreqName -Value $OriginalVal -Type DWord -Force
            }
            else {
                Remove-ItemProperty -Path $SRKey -Name $FreqName -ErrorAction SilentlyContinue
            }
        }
        catch { }
    }
}

Function NagleAlgoDis {
##  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{NIC-id}
##  There will be multiple NIC interfaces listed there, for example: {1660430C-B14A-4AC2-8F83-B653E83E8297}.
##  Find the correct one with your IP address listed. Under this {NIC-id} key, create a new DWORD value:
##  "TcpAckFrequency"=1 (DWORD value, not present by default interpreted as 2,
##  1=disable nagling, specifies number of outstanding ACKs before ignoring delayed ACK timer). 
##  For gaming performance, recommended is 1 (disable). 
##  For pure throughput and data streaming, you can experiment with small values over 2. 
##  Wifi performance may see a slight improvement with disabled TcpAckFrequency as well.
##  In the same location, add a new DWORD value:
##  TCPNoDelay=1 (DWORD, not present by default, 0 to enable Nagle's algorithm, 1 to disable)
##  To configure the ACK interval timeout (only has effect if nagling is enabled), find the following key:
##  TcpDelAckTicks=0  (DWORD value, not present by default interpreted as 2, 0=disable nagling, 1-6=100-600 ms). 
##  Note you can also set this to 1 to reduce the nagle effect from the default of 200ms without disabling it.
##  For Server Operating Systems that have Microsoft Message Queuing (MSMQ) installed,
##  or if you have the MSMQ registry hive present, also add TCPNoDelay to:
##  HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSMQ\Parameters
##  TCPNoDelay=1 (DWORD, not present by default, 0 to enable Nagle's algorithm, 1 to disable)
##  Note: Reportedly, disabling Nagle's algorithm can reduce the latency in many MMOs
##  like Diablo III and WoW (World of Warcraft) by almost half! Yes, it works with Windows 7 and Windows 8.    
    
    #This Disable's Nagle's Algorithm smile
    $TargetDHCPmask = "255.255.*"
    $InterfacePath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
    
    #FIXED (reporting, not behaviour): this probe is *expected* to come up empty - that is the
    #whole question it answers - but Get-ItemProperty -Name still records a non-terminating
    #error in $Error even under -ErrorAction SilentlyContinue. Invoke-Step clears $Error, runs
    #the step, then calls anything left behind a failed operation, so a completely healthy run
    #reported "Disabling Nagle's Algorithm ... PARTIAL - Property TcpAckFrequency does not
    #exist". The values were being written correctly the entire time (verified on the box:
    #TcpAckFrequency=1, TcpDelAckTicks=0, TCPNoDelay=1). Reading through the key's .GetValue()
    #returns $null for a missing value without raising anything, so the probe stops crying wolf.
    #FIXED (earlier): the body read $propertyname, but the parameter is $pspropertyname. The
    #undeclared variable was always empty, so -Name "" meant this always returned $false.
    #It only ever "worked" because the if and the if-not branches below run identical code.
    #Also accepts an array of names now, which is how the callers were already using it.
    Function RegistryValueExists($pspath, $pspropertyname) {
        $regkey = Get-Item -LiteralPath $pspath -ErrorAction SilentlyContinue
        if ($null -eq $regkey) { Return $false }
        foreach ($name in @($pspropertyname)) {
            if ($null -eq $regkey.GetValue($name)) { Return $false }
        }
        Return $true
    }
    
    foreach($item in Get-Childitem -LiteralPath $InterfacePath)
    {
        $Key = Get-ItemProperty $item.PSPath    
        
        if(([string]$key.DhcpSubnetMask -match $TargetDHCPmask) -OR ([string]$key.DhcpSubnetMaskOpt -match $TargetDHCPmask)) { 
            Write-Host "Interface: " $item.PSPath
            Write-Host "DHCP: " $key.DhcpSubnetMask "DHCP IP: " $key.DhcpIPAddress
            #CONSOLIDATED: this used to be two branches - "if exists" and "if not exists" -
            #whose bodies were byte-for-byte identical, so the check never changed the outcome.
            #One path now, with the check kept only to report which case we hit. Values unchanged:
            #TcpAckFrequency=1, TcpDelAckTicks=0, TCPNoDelay=1, exactly as documented above.
            if ([Boolean](RegistryValueExists $item.PSPath "TcpAckFrequency", "TcpDelAckTicks", "TCPNoDelay")) {
                Write-Host "TcpAckFrequency property was found and will be enabled." -ForegroundColor Green
            }
            else {
                Write-Host "TcpAckFrequency not found and will be created and enabled." -ForegroundColor Green
            }
            try
            {
                Set-ItemProperty -LiteralPath $item.PSPath -name "TcpAckFrequency" -Value 1 -Type DWORD -ea "Stop"
                Set-ItemProperty -LiteralPath $item.PSPath -name "TcpDelAckTicks" -Value 0 -Type DWORD -ea "Stop"
                Set-ItemProperty -LiteralPath $item.PSPath -name "TCPNoDelay" -Value 1 -Type DWORD -ea "Stop"
            }
            catch
            {
                Write-Host "Could not write Nagle values for this interface: $_" -ForegroundColor Red
            }
        }
    }    
}

#===============================================================================================
#  SECURITY + PRIVACY HARDENING
#  ADDED as one block. Everything here is additive - no existing step changes behaviour - and
#  each function gets its own Invoke-Step so the run summary reports them individually.
#  Deliberately NOT included, both wrong trade-offs for a gaming target:
#    - Controlled Folder Access: blocks unrecognised processes writing to Documents, which
#      breaks game saves until every title is allowlisted by hand.
#    - Memory Integrity / HVCI: measurable frame-time cost.
#  SmartScreen is left alone on purpose. This script has never disabled it and should not start.
#===============================================================================================

Function Set-RegValue {
    param([string]$Path, [string]$Name, $Value, [string]$Type = 'DWord')
    #Create-then-write, in that order, and it matters. Several paths below do not exist on a
    #clean install, and Set-ItemProperty against a missing key drops a record into $Error even
    #under -ErrorAction SilentlyContinue. Invoke-Step clears $Error, runs the step, and calls
    #whatever is left a failed operation - which is exactly how the Siuf feedback step spent
    #this whole time reporting PARTIAL while quietly doing nothing. New-Item needs -Force to
    #build intermediate keys: HKCU:\Software\Microsoft\Siuf does not exist either, so creating
    #Siuf\Rules in one shot fails without it. That single missing switch was the actual bug.
    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -Path $Path -Force -ErrorAction SilentlyContinue | Out-Null
    }
    New-ItemProperty -LiteralPath $Path -Name $Name -Value $Value -PropertyType $Type -Force -ErrorAction SilentlyContinue | Out-Null
}

Function Invoke-Silently {
    #Runs a probe whose FAILURE IS A VALID ANSWER, and keeps that failure out of $Error.
    #
    #Invoke-Step measures a step by clearing $Error, running it, and counting what is left.
    #That is the right model - it is why a failure inside a step surfaces as PARTIAL instead of
    #vanishing. But a probe asking "does this exist / does this driver support that" is EXPECTED
    #to fail, and -ErrorAction SilentlyContinue suppresses the MESSAGE while still recording the
    #error. So three separate healthy steps were reporting PARTIAL for doing exactly what they
    #should: the Reserved Storage state read, the NIC power-management capability check, and the
    #Ultimate Performance marker read. Each had its own copy of this count-and-trim logic.
    #
    #Only the probe passed in here is silenced. Anything else the step does reports normally -
    #that distinction matters, because an earlier inline version wrapped a whole block and would
    #have hidden a genuine failure.
    #
    #-AsBool returns success/failure instead of the value, for cmdlets that return nothing.
    param(
        [Parameter(Mandatory)][scriptblock]$Probe,
        [switch]$AsBool
    )
    $mark   = $Error.Count
    $ok     = $true
    $result = $null
    try { $result = & $Probe }
    catch { $ok = $false }
    if ($Error.Count -gt $mark) { $ok = $false }
    while ($Error.Count -gt $mark) { $Error.RemoveAt(0) }
    if ($AsBool) { return $ok }
    return $result
}

Function DisableSMBv1 {
    #SMBv1 is the EternalBlue / WannaCry transport. Microsoft stopped installing it by default in
    #2017 and nothing on a modern network needs it - file sharing negotiates SMB2/3.
    Write-Host "Disabling SMBv1. . ." -ForegroundColor Yellow
    try { Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force -ErrorAction Stop }
    catch { Write-Host "  SMB server config not available: $($_.Exception.Message)" -ForegroundColor DarkYellow }
    $feat = Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -ErrorAction SilentlyContinue
    if ($feat -and $feat.State -eq 'Enabled') {
        Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart -ErrorAction SilentlyContinue | Out-Null
        Write-Host "  SMB1Protocol feature disabled - completes on reboot." -ForegroundColor Green
    }
    else { Write-Host "  SMB1Protocol feature already off." -ForegroundColor Green }
    Set-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters' 'SMB1' 0
    #ADDED: block the silent fallback to unauthenticated guest SMB. That fallback is the setup
    #for rogue-share and relay attacks on an untrusted network, and nothing on a home LAN needs
    #it - a real share asks for real credentials.
    Set-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters' 'AllowInsecureGuestAuth' 0
    Write-Host "  Insecure guest auth blocked." -ForegroundColor Green
}

Function DisableLLMNRandNetBIOS {
    #LLMNR and NetBIOS name resolution broadcast "who is X?" to the whole local segment and trust
    #whoever answers first. On an untrusted network - a LAN party, an event, hotel wifi - that is
    #how a machine hands its hashed credentials to a stranger running Responder. DNS already
    #resolves every name these cover, so switching them off costs nothing on a normal network.
    Write-Host "Disabling LLMNR and NetBIOS name resolution. . ." -ForegroundColor Yellow
    Set-RegValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient' 'EnableMulticast' 0
    $ifaces = 'HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces'
    if (Test-Path -LiteralPath $ifaces) {
        $n = 0
        foreach ($i in Get-ChildItem -LiteralPath $ifaces -ErrorAction SilentlyContinue) {
            #2 = disable NetBIOS over TCP/IP on this interface
            Set-RegValue $i.PSPath 'NetbiosOptions' 2
            $n++
        }
        Write-Host "  NetBIOS-NS disabled on $n interface(s)." -ForegroundColor Green
    }

    #ADDED: mDNS is the third broadcast name-resolution protocol alongside LLMNR and NetBIOS-NS,
    #and it is abused the same way - anything on the segment can answer. Closing two of the three
    #doors is not much use, so this closes the third. Trade-off: local device discovery that
    #relies on mDNS/Bonjour (some printers, some cast targets) stops working.
    Set-RegValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient' 'EnableMDNS' 0
    Write-Host "  mDNS disabled." -ForegroundColor Green
}

Function HardenCredentialStorage {
    #WDigest can hold credentials in a reversible form inside LSASS. It exists for authentication
    #against pre-2008 servers and is dead weight on a home machine.
    Write-Host "Hardening credential storage. . ." -ForegroundColor Yellow
    Set-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest' 'UseLogonCredential' 0
    #RunAsPPL makes LSASS a protected process, which is what stops the standard credential-dumping
    #tools from reading it. Applies on reboot. Note: anything that legitimately injects into LSASS
    #(some enterprise SSO agents, a few smartcard middlewares) will stop working - none of which
    #is typical on a gaming build, but that is the trade being made here.
    Set-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' 'RunAsPPL' 1
    Write-Host "  WDigest off, LSA Protection armed (takes effect on reboot)." -ForegroundColor Green
}

Function DisablePowerShellV2 {
    #The v2 engine predates AMSI and script-block logging, so anything able to run
    #"powershell -version 2" gets an uninstrumented interpreter. Standard downgrade-attack step,
    #and nothing written this decade needs it.
    Write-Host "Removing the PowerShell v2 engine. . ." -ForegroundColor Yellow
    foreach ($fn in 'MicrosoftWindowsPowerShellV2Root', 'MicrosoftWindowsPowerShellV2') {
        $ft = Get-WindowsOptionalFeature -Online -FeatureName $fn -ErrorAction SilentlyContinue
        if ($ft -and $ft.State -eq 'Enabled') {
            Disable-WindowsOptionalFeature -Online -FeatureName $fn -NoRestart -ErrorAction SilentlyContinue | Out-Null
            Write-Host "  $fn disabled." -ForegroundColor Green
        }
        else { Write-Host "  $fn already off." -ForegroundColor Green }
    }
}

Function CompleteAutoRunHardening {
    #AutoRunDis already points AutoRun.inf at a section that does not exist, which neutralises the
    #file itself. This is the other half of the job: NoDriveTypeAutoRun = 255 tells Explorer to
    #ignore AutoRun on every drive class, so inserting media cannot trigger anything at all.
    #Verified missing on this box - the first layer was applied, this one never was.
    Write-Host "Completing AutoRun hardening. . ." -ForegroundColor Yellow
    Set-RegValue 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' 'NoDriveTypeAutoRun' 255
    Set-RegValue 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' 'NoAutorun' 1
}

Function EnableDoH {
    #Set-CloudFlareDNS already points the adapters at 1.1.1.1 / 1.0.0.1, but plain DNS is readable
    #by anyone on the path - the ISP included. This registers the encrypted templates for those
    #same resolvers so the queries ride over HTTPS instead. Runs after the network steps on
    #purpose. Fallback to UDP is left ON deliberately: if the resolver is ever unreachable over
    #HTTPS the machine still resolves names instead of dropping off the network entirely.
    Write-Host "Enabling DNS over HTTPS for the CloudFlare resolvers. . ." -ForegroundColor Yellow
    if (-not (Get-Command Add-DnsClientDohServerAddress -ErrorAction SilentlyContinue)) {
        Write-Host "  DoH cmdlets not present on this build - skipping." -ForegroundColor DarkYellow
        return
    }
    foreach ($ip in '1.1.1.1', '1.0.0.1') {
        $existing = Get-DnsClientDohServerAddress -ServerAddress $ip -ErrorAction SilentlyContinue
        if ($existing) {
            Set-DnsClientDohServerAddress -ServerAddress $ip -DohTemplate 'https://cloudflare-dns.com/dns-query' -AllowFallbackToUdp $true -AutoUpgrade $true -ErrorAction SilentlyContinue
        }
        else {
            Add-DnsClientDohServerAddress -ServerAddress $ip -DohTemplate 'https://cloudflare-dns.com/dns-query' -AllowFallbackToUdp $true -AutoUpgrade $true -ErrorAction SilentlyContinue
        }
        Write-Host "  $ip registered for DoH." -ForegroundColor Green
    }
}

Function DisableRecallAndAI {
    #Build 26100+ ships Recall, which snapshots the screen on a timer and indexes it. Whatever one
    #thinks of the feature, an always-on screen recorder is not something a gaming box needs, and
    #this is the supported policy switch rather than a hack.
    Write-Host "Disabling Recall / Windows AI data analysis. . ." -ForegroundColor Yellow
    Set-RegValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI' 'DisableAIDataAnalysis' 1
    Set-RegValue 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI' 'DisableAIDataAnalysis' 1
    Set-RegValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI' 'DisableClickToDo' 1
}

Function DisableActivityHistory {
    #Timeline / Activity History records what was opened and, with an account signed in, uploads
    #it. All three values are needed: the feed, local publishing, and the upload.
    Write-Host "Disabling Activity History and Timeline upload. . ." -ForegroundColor Yellow
    $p = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System'
    Set-RegValue $p 'EnableActivityFeed' 0
    Set-RegValue $p 'PublishUserActivities' 0
    Set-RegValue $p 'UploadUserActivities' 0
}

Function DisableCloudClipboard {
    #Cross-device clipboard sends whatever is copied - passwords included - through a Microsoft
    #account. Local clipboard history (Win+V) is deliberately LEFT ON: it never leaves the
    #machine and it is genuinely useful. Only the sync is switched off.
    Write-Host "Disabling cross-device clipboard sync. . ." -ForegroundColor Yellow
    Set-RegValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' 'AllowCrossDeviceClipboard' 0
}

Function LimitDeliveryOptimization {
    #The script already empties the Delivery Optimization cache folder, but that is housekeeping,
    #not policy - at the default setting the machine still uploads update content to strangers on
    #the internet. 1 = LAN peers only, which keeps the bandwidth saving at home without seeding
    #outward. 0 would disable peering altogether if that is preferred.
    Write-Host "Restricting Delivery Optimization to LAN peers. . ." -ForegroundColor Yellow
    Set-RegValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization' 'DODownloadMode' 1
}

#===============================================================================================
#  TIER A additions. Everything below is additive and low-risk; anything with a real trade-off
#  was deliberately left out (HAGS is hardware-dependent and can worsen frametimes, Windows
#  Script Host breaks some older installers, TLS 1.0/1.1 removal breaks some old launchers,
#  disabling Print Spooler breaks all printing). Those belong behind a prompt, not in here.
#===============================================================================================

Function DisableLegacyRemoteAccess {
    #Three pieces of remote-access surface with no use on a gaming desktop.
    #WPAD is the notable one: Web Proxy Auto-Discovery lets anything on the local network answer
    #"where is the proxy?" and become a man in the middle for HTTP. Disabling the WinHTTP
    #auto-proxy service closes that. NOTE: if this machine ever lives behind a corporate proxy
    #that relies on autodiscovery, this is the setting to put back.
    Write-Host "Disabling WPAD, Remote Assistance and Remote Registry. . ." -ForegroundColor Yellow
    #REMOVED: Set-Service on WinHttpAutoProxySvc. That service's DACL refuses configuration even
    #to an elevated Administrator - it returned "Access is denied" on every run and could never
    #have worked. WPAD is now blocked at name resolution instead, in BlocklistMNNSSM.
    Set-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance' 'fAllowToGetHelp' 0
    Set-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance' 'fAllowFullControl' 0
    try { Set-Service -Name RemoteRegistry -StartupType Disabled -ErrorAction Stop }
    catch { Write-Host "  RemoteRegistry: $($_.Exception.Message)" -ForegroundColor DarkYellow }
}

Function DisableTelemetryExtras {
    #Windows Error Reporting ships crash dumps - which can contain memory contents - to Microsoft.
    #The policy switch is used rather than disabling WerSvc, because some applications query the
    #service and behave badly when it is missing outright.
    Write-Host "Disabling error reporting, CEIP, Find My Device and settings sync. . ." -ForegroundColor Yellow
    Set-RegValue 'HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting' 'Disabled' 1
    Set-RegValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting' 'Disabled' 1
    Set-RegValue 'HKLM:\SOFTWARE\Microsoft\SQMClient\Windows' 'CEIPEnable' 0
    Set-RegValue 'HKLM:\SOFTWARE\Policies\Microsoft\FindMyDevice' 'AllowFindMyDevice' 0
    Set-RegValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\SettingSync' 'DisableSettingSync' 2
    Set-RegValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\SettingSync' 'DisableSettingSyncUserOverride' 1
}

Function RestrictBackgroundApps {
    #Fewer UWP apps ticking over in the background means fewer processes competing with a game.
    #DELIBERATELY NOT SET: LetAppsRunInBackground = 2, which force-denies background access to
    #every packaged app with no per-app override. That would also silence the Xbox app, which
    #this build keeps on purpose. The per-user global toggle below is reversible from Settings
    #and leaves individual apps controllable.
    Write-Host "Restricting background app access. . ." -ForegroundColor Yellow
    Set-RegValue 'HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications' 'GlobalUserDisabled' 1
    Set-RegValue 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' 'BackgroundAppGlobalToggle' 0
    #App diagnostics lets one packaged app read another's process information. No legitimate
    #use here, and it is a genuine information-disclosure path between apps.
    Set-RegValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' 'LetAppsGetDiagnosticInfo' 2
}

Function DisableCopilot {
    #Same posture as the Recall switch already in this script - an assistant wired into the shell
    #with cloud round-trips is not something a gaming build needs.
    Write-Host "Disabling Windows Copilot. . ." -ForegroundColor Yellow
    Set-RegValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot' 'TurnOffWindowsCopilot' 1
    Set-RegValue 'HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot' 'TurnOffWindowsCopilot' 1
    Set-RegValue 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' 'ShowCopilotButton' 0
}

Function HardenEdgeTelemetry {
    #Edge is in the NonRemovable list on purpose (removing it breaks WebView2, which a surprising
    #number of desktop apps rely on) - so it stays, and gets muzzled instead.
    Write-Host "Applying Edge telemetry policies. . ." -ForegroundColor Yellow
    $edge = 'HKLM:\SOFTWARE\Policies\Microsoft\Edge'
    Set-RegValue $edge 'MetricsReportingEnabled' 0
    Set-RegValue $edge 'PersonalizationReportingEnabled' 0
    Set-RegValue $edge 'UserFeedbackAllowed' 0
    Set-RegValue $edge 'DiagnosticData' 0
    Set-RegValue $edge 'SpotlightExperiencesAndRecommendationsEnabled' 0
    Set-RegValue $edge 'ShowRecommendationsEnabled' 0
    Set-RegValue $edge 'HideFirstRunExperience' 1
}

Function ReclaimDiskSpace {
    #Hibernation reserves a hiberfil.sys of roughly 40% of installed RAM. This script already
    #disables Fast Boot (hybrid shutdown), which is the main thing hiberfil exists to serve, so
    #turning hibernation off is consistent rather than a separate opinion. On a desktop with
    #32 GB that is about 13 GB back.
    Write-Host "Disabling hibernation. . ." -ForegroundColor Yellow
    try {
        powercfg -h off
        Write-Host "  hiberfil.sys released." -ForegroundColor Green
    }
    catch { Write-Host "  could not disable hibernation: $($_.Exception.Message)" -ForegroundColor DarkYellow }

    #REWRITTEN: the probe below is expected to fail on machines where Reserved Storage was never
    #enabled (a VM, or an image built without it), and that refusal IS the answer - not a fault.
    #Get-/Set-WindowsReservedStorageState still records into $Error even when caught, and
    #Invoke-Step counts anything left in $Error as a failed operation, so an entirely healthy
    #machine was reporting PARTIAL. The error count is captured before the probe and anything
    #this probe added is removed afterwards - the same reasoning as the RegistryValueExists fix
    #earlier in this file. Real failures elsewhere in the step are untouched.
    Write-Host "Disabling Reserved Storage. . ." -ForegroundColor Yellow
    #Only the PROBE is silenced. An earlier version wrapped the whole block, which meant a
    #genuine Set-WindowsReservedStorageState failure was swallowed along with the expected
    #"not available on this machine" - a real failure would have reported OK. It reports now.
    $rsState = Invoke-Silently { [string](Get-WindowsReservedStorageState -ErrorAction Stop).ReservedStorageState }
    if (-not $rsState) { $rsState = 'unavailable' }
    if ($rsState -eq 'Enabled') {
        try {
            Set-WindowsReservedStorageState -State Disabled -ErrorAction Stop
            Write-Host "  Reserved Storage disabled - roughly 7 GB returned." -ForegroundColor Green
        }
        catch { Write-Host "  Reserved Storage refused: $($_.Exception.Message)" -ForegroundColor DarkYellow }
    }
    else {
        Write-Host "  Reserved Storage is '$rsState' on this machine - nothing to disable." -ForegroundColor Green
    }
}

Function SetVisualEffectsPerformance {
    #VisualFXSetting 2 = "adjust for best performance". It switches off every animation, which is
    #what we want - but on its own it also kills font smoothing and the result looks genuinely
    #bad on a high-DPI panel. ClearType is explicitly put back afterwards.
    Write-Host "Setting visual effects to best performance. . ." -ForegroundColor Yellow
    Set-RegValue 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects' 'VisualFXSetting' 2
    Set-RegValue 'HKCU:\Control Panel\Desktop' 'FontSmoothing' '2' 'String'
    Set-RegValue 'HKCU:\Control Panel\Desktop' 'FontSmoothingType' 2
    Write-Host "  animations off, ClearType kept." -ForegroundColor Green
}

Function BlocklistMNNSSM {
    #Line 16344 is end of the blocklist
    #This function edits the system hostfile with Dan Pollocks BlockList as well as a few extra entries.
    $hostsloc = "C:\Windows\System32\Drivers\Etc\hosts"
    Write-Host "Grabbing hosts file" -ForegroundColor Yellow 

	    
    #FRAGMENT 2: the 13,446-line blocklist used to sit inline right here, which is why 89% of
    #this script was data wedged into the middle of a function. It now lives in the EMBEDDED
    #DATA region near the bottom of the file, assigned to $script:MNNSSMBlocklist. Same bytes,
    #same 12,942 entries - it is just no longer sitting between you and the logic.
    $MNNSSMBlocklist = $script:MNNSSMBlocklist

    #ADDED: sinkhole to 0.0.0.0 rather than 127.0.0.1. Pointing a blocked name at loopback makes
    #the machine open a connection to itself and sit through the failure; 0.0.0.0 is not a
    #routable destination so the stack drops it immediately. Same blocking, less work per lookup,
    #and no stray connections landing on whatever happens to be listening locally. Done as one
    #transform here instead of editing all 12,942 embedded lines, so the source data stays
    #byte-identical to what was published and this is a single line to revert.
    #The lookahead protects "127.0.0.1 localhost" and "127.0.0.1 localhost.localdomain", which
    #MUST stay on loopback - rewriting those to 0.0.0.0 would break local name resolution.
    $MNNSSMBlocklist = $MNNSSMBlocklist -replace '(?m)^127\.0\.0\.1(\s+)(?!localhost)', '0.0.0.0$1'

    #ADDED: WPAD hardening, done through the hosts file instead of the service. The usual advice
    #is to disable WinHttpAutoProxySvc, but that service's DACL refuses Set-Service even to an
    #elevated Administrator - measured, it returns "Access is denied" every time, so that call
    #could never have worked. WPAD only functions if the name "wpad" resolves, and sinkholing a
    #name is machinery this script already has. Same effect, and it actually succeeds.
    $MNNSSMBlocklist += [Environment]::NewLine + '0.0.0.0 wpad' +
                        [Environment]::NewLine + '0.0.0.0 wpad.localdomain' +
                        [Environment]::NewLine + '0.0.0.0 wpad.local' + [Environment]::NewLine
    if ([string]::IsNullOrWhiteSpace($MNNSSMBlocklist)) {
        Write-Host "The embedded hosts blocklist is missing - skipping the hosts edit." -ForegroundColor Red
        return
    }

    
    #REWRITTEN for safety. The old flow was:
    #    Clear-Content hosts   ->   Add-Content hosts
    #If the write failed, the hosts file was already empty and the catch printed
    #"hosts file left unmodified", which was not true. There was also no backup.
    #New flow: back up -> write to temp -> verify -> swap in -> restore on any failure.

    if (-not (Test-Path $hostsloc)) {
        Write-Host "hosts file not found at $hostsloc - skipping." -ForegroundColor Red
        return
    }

    #1. Back up the current hosts file before touching anything.
    $hostsBackup = Join-Path $DebloatFolder ("hosts.backup.{0:yyyyMMdd-HHmmss}" -f (Get-Date))
    try {
        Copy-Item -LiteralPath $hostsloc -Destination $hostsBackup -Force -ErrorAction Stop
        Write-Host "Backed up your existing hosts file to $hostsBackup" -ForegroundColor Green
    }
    catch {
        Write-Host "Could not back up the hosts file, so it will NOT be modified. Error: $_" -ForegroundColor Red
        return
    }

    #1b. FRAGMENT 3 - keep the genuinely original hosts file forever.
    #On a second run the "current" hosts file is the blocklist this script wrote last time, so
    #every timestamped backup after the first is a backup of our own work. This one is written
    #once and then never touched again, so whatever you had before this script ever ran stays
    #recoverable no matter how many times it runs.
    $hostsPristine = Join-Path $DebloatFolder 'hosts.original'
    if (-not (Test-Path -LiteralPath $hostsPristine)) {
        try {
            Copy-Item -LiteralPath $hostsloc -Destination $hostsPristine -Force -ErrorAction Stop
            Write-Host "Saved your pre-script hosts file to $hostsPristine (kept permanently)" -ForegroundColor Green
        }
        catch {
            Write-Host "Could not save the pristine hosts copy: $_" -ForegroundColor Yellow
        }
    }

    #1c. Once the hosts file is a 500 KB blocklist, each run's backup is 500 KB too. Keep the
    #five most recent timestamped ones; hosts.original is a different name and is never caught
    #by this filter, so it is never at risk.
    try {
        Get-ChildItem -LiteralPath $DebloatFolder -Filter 'hosts.backup.*' -ErrorAction Stop |
            Sort-Object LastWriteTime -Descending |
            Select-Object -Skip 5 |
            Remove-Item -Force -ErrorAction SilentlyContinue
    }
    catch { }

    #2. Stage the new content in a temp file first, so a failure never leaves hosts empty.
    #   UTF8 *without* BOM: a BOM can confuse the resolver, and plain ASCII would mangle the
    #   contributor names in Dan Pollock's credits block.
    $hostsTemp = Join-Path $env:TEMP ("hosts.staged.{0}" -f [guid]::NewGuid().ToString('N'))
    try {
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($hostsTemp, $MNNSSMBlocklist, $utf8NoBom)

        #3. Verify the staged file actually looks like the blocklist before trusting it.
        $stagedLines = @(Get-Content -LiteralPath $hostsTemp -ErrorAction Stop)
        $stagedHosts = @($stagedLines | Where-Object { $_ -match '^\s*(0\.0\.0\.0|127\.0\.0\.1)\s+\S' }).Count
        if ($stagedHosts -lt 100) {
            throw "Staged hosts file only had $stagedHosts entries, which looks wrong. Refusing to apply it."
        }

        #4. Swap it in. Only now does the real hosts file change.
        Copy-Item -LiteralPath $hostsTemp -Destination $hostsloc -Force -ErrorAction Stop
        Write-Host "hosts file updated with $stagedHosts blocklist entries." -ForegroundColor Green
    }
    catch {
        Write-Host "Error while editing the hosts file: $_" -ForegroundColor Red
        #Put the original back if we got far enough to disturb it.
        try {
            Copy-Item -LiteralPath $hostsBackup -Destination $hostsloc -Force -ErrorAction Stop
            Write-Host "Your original hosts file has been restored from the backup." -ForegroundColor Yellow
        }
        catch {
            Write-Host "COULD NOT RESTORE the hosts file. Your backup is safe at: $hostsBackup" -ForegroundColor Red
        }
    }
    finally {
        Remove-Item -LiteralPath $hostsTemp -Force -ErrorAction SilentlyContinue
    }
}

Function OSKDis {
    #Disable On Screen Keyboard
    Write-Host "Beginning to disable On Screen Keyboard. . ." -ForegroundColor Yellow 
    #FIXED: was "Authenitication" (typo) - that key does not exist, so Test-Path was always
    #false and this tweak never ran. Verified: ...\CurrentVersion\Authentication\LogonUI exists.
    $OSKloc = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI"
    If (Test-Path $OSKloc) {
        Set-ItemProperty $OSKloc -name "ShowTabletKeyboard" -Value 0
    }
}

Function AeroShakeDisable {
    #This disables shaking a window and minimizing everything
    Write-Host "Disabling Aero Shake. . ." -ForegroundColor Yellow 
    #FIXED: was "Current\Version" (split) - that path does not exist, so this wrote nowhere.
    #Verified: HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced exists.
    $AeroShakeloc = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    If (Test-Path $AeroShakeloc) {
        Set-ItemProperty $AeroShakeloc DisallowShaking -Value 1 -Type DWord -Force
    }
}



#REPLACES the old NetFullReset and NetResetLite, which were removed.
#
#Those two were seven lines of ipconfig/netsh each, and NetFullReset had a real problem: it
#ran "netsh int ip reset" and "netsh winsock reset" - both of which need a reboot to take
#effect - in the MIDDLE of the script, then carried on doing registry work on a half-reset
#stack. It also ran AFTER the DNS steps, so it could undo the CloudFlare DNS that had just
#been set. NetResetLite was never called by anything at all.
#
#Both are now superseded by net-reset-reboot.bat, which does the same job properly: it takes
#a full netsh backup first, saves and re-applies statically configured DNS servers around the
#reset, logs every step, and has a /verify mode for after the reboot.

Function Build-DesktopTools {
    #Writes the three .bat tools to the Desktop and creates God Mode.
    #The tool contents live in the EMBEDDED DATA region near the bottom of this file.
    $Desktop = [Environment]::GetFolderPath('Desktop')
    if ([string]::IsNullOrWhiteSpace($Desktop) -or -not (Test-Path -LiteralPath $Desktop)) {
        throw "Could not resolve the Desktop folder, so the tools were not written."
    }
    Write-Host "Writing tools to $Desktop" -ForegroundColor Yellow

    $Tools = @(
        @{ Name = 'cleanup_main.bat';     Content = $script:CleanupMainBat }
        @{ Name = 'net-reset-reboot.bat'; Content = $script:NetResetRebootBat }
        @{ Name = 'net-reset-lite.bat';   Content = $script:NetResetLiteBat }
    )

    foreach ($Tool in $Tools) {
        $Target = Join-Path $Desktop $Tool.Name

        if ([string]::IsNullOrWhiteSpace($Tool.Content)) {
            Write-Host "  $($Tool.Name) has no embedded content - skipping." -ForegroundColor Red
            continue
        }

        $Existed = Test-Path -LiteralPath $Target
        try {
            #cmd.exe is genuinely fragile about line endings - LF-only batch files break
            #goto/label parsing - so force CRLF regardless of how this .ps1 is stored.
            #All three tools are pure ASCII, so ASCII encoding is lossless and safest for cmd.
            $Body = $Tool.Content -replace "`r?`n", "`r`n"
            [System.IO.File]::WriteAllText($Target, $Body, [System.Text.Encoding]::ASCII)
            $Verb = if ($Existed) { 'Updated' } else { 'Created' }
            Write-Host "  $Verb $($Tool.Name)" -ForegroundColor Green
        }
        catch {
            Write-Host "  Failed to write $($Tool.Name) - $($_.Exception.Message)" -ForegroundColor Red
        }
    }

    #God Mode: a folder whose name ends in the Control Panel "All Tasks" CLSID. Windows sees
    #the GUID and renders the folder as a single flat list of every control panel task.
    #The text before the dot is just a label - "GodMode" is only convention.
    $GodModeName = 'GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}'
    $GodMode     = Join-Path $Desktop $GodModeName
    try {
        #.NET rather than New-Item: the braces in the CLSID are awkward for provider paths,
        #and CreateDirectory is naturally idempotent - it no-ops when the folder is there.
        [System.IO.Directory]::CreateDirectory($GodMode) | Out-Null
        Write-Host "  God Mode ready" -ForegroundColor Green
    }
    catch {
        Write-Host "  Failed to create God Mode - $($_.Exception.Message)" -ForegroundColor Red
    }
}

Function NetResetReboot {
    #Runs the net-reset-reboot.bat that Build-DesktopTools just wrote to the Desktop.
    #
    #The two flags matter:
    #  /y     skip the "are you sure" prompt AND the trailing pause, so it runs unattended
    #  /none  do NOT restart or shut down when it finishes
    #
    #/none is the important one. The .bat defaults to ENDACTION=ask, which pops a
    #"Restart now [R], shut down [S], or do nothing [N]?" choice, and /restart would reboot
    #in 15 seconds. Either would tear the machine down in the middle of this script. The
    #reboot stays where it belongs - the prompt at the very end, which the user chooses.
    #
    #Passing any argument at all also suppresses the .bat's own double-click menu.
    $Desktop = [Environment]::GetFolderPath('Desktop')
    $Bat     = Join-Path $Desktop 'net-reset-reboot.bat'

    if (-not (Test-Path -LiteralPath $Bat)) {
        throw "net-reset-reboot.bat is not on the Desktop - Build-DesktopTools must run first."
    }

    Write-Host "Running net-reset-reboot.bat /y /none (no reboot - that is saved for the end)" -ForegroundColor Yellow
    & $env:ComSpec /c "`"$Bat`" /y /none"
    $code = $LASTEXITCODE

    if ($code -ne 0) {
        throw "net-reset-reboot.bat exited with code $code - check the netreset-logs folder on your Desktop."
    }

    Write-Host "Network stack reset. A reboot is required before it takes effect." -ForegroundColor Green
    Write-Host "After rebooting you can run:  net-reset-reboot.bat /verify" -ForegroundColor Cyan
}

Function Set-CloudFlareDNS {
    #REPLACES two hardcoded steps:
    #    Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses "1.1.1.1","1.0.0.1"
    #    Set-DnsClientServerAddress -InterfaceAlias Wi-Fi    -ServerAddresses "1.1.1.1","1.0.0.1"
    #
    #Those assume the adapters are literally named "Ethernet" and "Wi-Fi". Real machines
    #rarely oblige. The box this was rewritten on has FIVE physical adapters named
    #Ethernet, Ethernet 2, Wi-Fi, Wi-Fi 3 and Wi-Fi 4 - and the only one actually connected
    #is "Ethernet" (a Realtek 5GbE), while "Ethernet 2" (Intel I226-V) sits disconnected.
    #Rename or reseat anything and the old code silently did nothing.
    #
    #-Physical is the other half of this, and it matters more than it looks: that same box
    #has two VMware virtual adapters sitting in state Up. Forcing 1.1.1.1 onto a VMnet
    #adapter breaks VM NAT/host-only networking. -Physical excludes VMware, Hyper-V,
    #VirtualBox and VPN adapters, so only real hardware gets touched.
    #
    #The DNS servers themselves are unchanged: CloudFlare 1.1.1.1 / 1.0.0.1, IPv4.
    $Adapters = @(Get-NetAdapter -Physical -ErrorAction SilentlyContinue |
                  Where-Object { $_.Status -eq 'Up' })

    if (-not $Adapters) {
        #Inside a VM the guest's NIC is emulated, and depending on the hypervisor it can report
        #as virtual - in which case -Physical returns nothing and the real adapter gets missed.
        #Fall back to any connected adapter that is not a HOST-side virtual switch. The name
        #filter is what keeps the original protection intact: on a real machine with VMware
        #installed but no network, this must still refuse to put 1.1.1.1 on VMnet1/VMnet8.
        $VirtualSwitch = 'VMnet|vEthernet|VirtualBox|Hyper-V Virtual|TAP-|Loopback|Bluetooth|WSL'
        $Adapters = @(Get-NetAdapter -ErrorAction SilentlyContinue | Where-Object {
            $_.Status -eq 'Up' -and
            $_.Name -notmatch $VirtualSwitch -and
            $_.InterfaceDescription -notmatch $VirtualSwitch
        })
        if ($Adapters) {
            Write-Host "  No physical adapter was up - falling back to connected non-switch adapters (normal inside a VM)." -ForegroundColor Yellow
        }
    }

    if (-not $Adapters) {
        throw "No connected network adapters found, so no DNS was changed."
    }

    foreach ($Adapter in $Adapters) {
        try {
            Set-DnsClientServerAddress -InterfaceIndex $Adapter.ifIndex `
                -ServerAddresses "1.1.1.1", "1.0.0.1" -ErrorAction Stop
            Write-Host "  $($Adapter.Name) -> 1.1.1.1 / 1.0.0.1  [$($Adapter.InterfaceDescription)]" -ForegroundColor Green
        }
        catch {
            Write-Host "  $($Adapter.Name) - failed: $($_.Exception.Message)" -ForegroundColor Red
        }
    }

    #Adapters that are present but not connected are reported, not touched. Setting DNS on a
    #disconnected NIC is harmless but pointless, and saying so makes the log honest.
    $Idle = @(Get-NetAdapter -Physical -ErrorAction SilentlyContinue |
              Where-Object { $_.Status -ne 'Up' })
    foreach ($Adapter in $Idle) {
        Write-Host "  $($Adapter.Name) skipped - status $($Adapter.Status)" -ForegroundColor DarkGray
    }
}

Function DisableDiagTrackService {
    #Disable and stop Diagnostics Tracking Service
    Set-Service "DiagTrack" -StartupType Disabled
    Stop-Service "DiagTrack"
}

Function DISMWinRepair {
    #This runs a system health check.
    #
    #FRAGMENT 3: this used to run "dism /online /cleanup-image /restorehealth" unconditionally,
    #every single time, which is 10-30 minutes of downloading replacement component files from
    #Windows Update. The thing is, the headline use case for this script is "I just reformatted"
    #- and a freshly installed image is healthy by definition, so that wait bought nothing at all.
    #
    #Check first, repair only if the check says there is something to repair.
    #
    #Repair-WindowsImage rather than parsing dism.exe's console output: it returns a real
    #ImageHealthState value (Healthy / Repairable / NonRepairable), so this does not break the
    #moment someone runs it on a non-English Windows.
    #
    #sfc /scannow still runs every time. It has no "check" mode, it is the faster of the two,
    #and it is the one that actually catches damaged system files - so it stays unconditional.
    Write-Host "Beginning to check the health of your System Image. . ." -ForegroundColor Yellow

    $NeedsRepair = $true
    try {
        $Health = Repair-WindowsImage -Online -CheckHealth -ErrorAction Stop
        Write-Host "  Component store reports: $($Health.ImageHealthState)" -ForegroundColor Cyan
        if ($Health.ImageHealthState -eq 'Healthy') { $NeedsRepair = $false }
    }
    catch {
        Write-Host "  Health check failed ($($_.Exception.Message)) - running the full repair to be safe." -ForegroundColor Yellow
    }

    if ($NeedsRepair) {
        Write-Host "Repairing system image (this is the slow one). . ." -ForegroundColor Yellow
        dism /online /cleanup-image /restorehealth
    }
    else {
        Write-Host "  Image is healthy - skipping /RestoreHealth." -ForegroundColor Green
    }

    Write-Host "Checking System Files. . ." -ForegroundColor Yellow
    sfc /scannow
    Write-Host "Checking Disk Health. . ." -ForegroundColor Yellow
    ##chkdsk /f /r | Read-Host "test y/n"
}

Function Protect-Privacy {
            
    #Disables Windows Feedback Experience
    Write-Host "Disabling Windows Feedback Experience program"  -ForegroundColor Yellow 
    $Advertising = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
    If (Test-Path $Advertising) {
        Set-ItemProperty $Advertising Enabled -Value 0 
    }
            
    #Stops Cortana from being used as part of your Windows Search Function
    Write-Host "Stopping Cortana from being used as part of your Windows Search Function" -ForegroundColor Yellow
    $Search = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    If (Test-Path $Search) {
        Set-ItemProperty $Search AllowCortana -Value 0 
    }

    #Disables Web Search in Start Menu
    Write-Host "Disabling Bing Search in Start Menu" -ForegroundColor Yellow 
    $WebSearch = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" 
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" BingSearchEnabled -Value 0 
    If (!(Test-Path $WebSearch)) {
        New-Item $WebSearch
    }
    Set-ItemProperty $WebSearch DisableWebSearch -Value 1 
            
    #Stops the Windows Feedback Experience from sending anonymous data
    Write-Host "Stopping the Windows Feedback Experience program" -ForegroundColor Yellow 
    $Period = "HKCU:\Software\Microsoft\Siuf\Rules"
    If (!(Test-Path $Period)) { 
        New-Item -Path $Period -Force -ErrorAction SilentlyContinue | Out-Null
    }
    Set-ItemProperty $Period PeriodInNanoSeconds -Value 0 

    #Prevents bloatware applications from returning and removes Start Menu suggestions               
    Write-Host "Adding Registry key to prevent bloatware apps from returning" -ForegroundColor Yellow 
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
    $registryOEM = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
    If (!(Test-Path $registryPath)) { 
        New-Item $registryPath
    }
    Set-ItemProperty $registryPath DisableWindowsConsumerFeatures -Value 1 

    If (!(Test-Path $registryOEM)) {
        New-Item $registryOEM
    }
    Set-ItemProperty $registryOEM  ContentDeliveryAllowed -Value 0 
    Set-ItemProperty $registryOEM  OemPreInstalledAppsEnabled -Value 0 
    Set-ItemProperty $registryOEM  PreInstalledAppsEnabled -Value 0 
    Set-ItemProperty $registryOEM  PreInstalledAppsEverEnabled -Value 0 
    Set-ItemProperty $registryOEM  SilentInstalledAppsEnabled -Value 0 
    Set-ItemProperty $registryOEM  SystemPaneSuggestionsEnabled -Value 0          
    
    #Preping mixed Reality Portal for removal    
    Write-Host "Setting Mixed Reality Portal value to 0 so that you can uninstall it in Settings" -ForegroundColor Yellow 
    $Holo = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic"    
    If (Test-Path $Holo) {
        Set-ItemProperty $Holo  FirstRunSucceeded -Value 0 
    }

    #Disables Wi-fi Sense
    Write-Host "Disabling Wi-Fi Sense" -ForegroundColor Yellow 
    $WifiSense1 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting"
    $WifiSense2 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots"
    $WifiSense3 = "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config"
    If (!(Test-Path $WifiSense1)) {
        New-Item $WifiSense1
    }
    Set-ItemProperty $WifiSense1  Value -Value 0 
    If (!(Test-Path $WifiSense2)) {
        New-Item $WifiSense2
    }
    Set-ItemProperty $WifiSense2  Value -Value 0 
    Set-ItemProperty $WifiSense3  AutoConnectAllowedOEM -Value 0 
        
    #Disables live tiles
    Write-Host "Disabling live tiles" -ForegroundColor Yellow 
    $Live = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"    
    If (!(Test-Path $Live)) {      
        New-Item $Live
    }
    Set-ItemProperty $Live  NoTileApplicationNotification -Value 1 
        
    #Turns off Data Collection via the AllowTelemtry key by changing it to 0
    Write-Host "Turning off Data Collection" -ForegroundColor Yellow 
    $DataCollection1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
    $DataCollection2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
    $DataCollection3 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection"    
    If (Test-Path $DataCollection1) {
        Set-ItemProperty $DataCollection1  AllowTelemetry -Value 0 
    }
    If (Test-Path $DataCollection2) {
        Set-ItemProperty $DataCollection2  AllowTelemetry -Value 0 
    }
    If (Test-Path $DataCollection3) {
        Set-ItemProperty $DataCollection3  AllowTelemetry -Value 0 
    }
    
    #Disabling Location Tracking
    Write-Host "Disabling Location Tracking" -ForegroundColor Yellow 
    $SensorState = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"
    $LocationConfig = "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration"
    If (!(Test-Path $SensorState)) {
        New-Item $SensorState
    }
    Set-ItemProperty $SensorState SensorPermissionState -Value 0 
    If (!(Test-Path $LocationConfig)) {
        New-Item $LocationConfig
    }
    Set-ItemProperty $LocationConfig Status -Value 0 
        
    #Disables People icon on Taskbar
    Write-Host "Disabling People icon on Taskbar" -ForegroundColor Yellow 
    $People = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
    If (Test-Path $People) {
        Set-ItemProperty $People -Name PeopleBand -Value 0
    }
        
    #Disables scheduled tasks that are considered unnecessary 
    Write-Host "Disabling scheduled tasks" -ForegroundColor Yellow 
    #KEPT ON PURPOSE: XblGameSaveTaskLogon and XblGameSaveTask drive Xbox Live game-save sync.
    #This build targets a gaming PC and keeps the Xbox app (Microsoft.GamingApp is whitelisted),
    #so disabling these would break save sync for Game Pass titles. Left enabled deliberately -
    #this is a decision, not an oversight. Do not "restore" these two lines.
    #Get-ScheduledTask  XblGameSaveTaskLogon | Disable-ScheduledTask
    #Get-ScheduledTask  XblGameSaveTask | Disable-ScheduledTask
    Get-ScheduledTask  Consolidator | Disable-ScheduledTask
    Get-ScheduledTask  UsbCeip | Disable-ScheduledTask
    Get-ScheduledTask  DmClient | Disable-ScheduledTask
    Get-ScheduledTask  DmClientOnScenarioDownload | Disable-ScheduledTask

    Write-Host "Stopping and disabling Diagnostics Tracking Service" -ForegroundColor Yellow 
    #Disabling the Diagnostics Tracking Service
    Stop-Service "DiagTrack"
    Set-Service "DiagTrack" -StartupType Disabled
}

Function DisableCortana {
    Write-Host "Disabling Cortana" -ForegroundColor Yellow 
    $Cortana1 = "HKCU:\SOFTWARE\Microsoft\Personalization\Settings"
    $Cortana2 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization"
    $Cortana3 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore"
    If (!(Test-Path $Cortana1)) {
        New-Item $Cortana1
    }
    Set-ItemProperty $Cortana1 AcceptedPrivacyPolicy -Value 0 
    If (!(Test-Path $Cortana2)) {
        New-Item $Cortana2
    }
    Set-ItemProperty $Cortana2 RestrictImplicitTextCollection -Value 1 
    Set-ItemProperty $Cortana2 RestrictImplicitInkCollection -Value 1 
    If (!(Test-Path $Cortana3)) {
        New-Item $Cortana3
    }
    Set-ItemProperty $Cortana3 HarvestContacts -Value 0    
}
 
Function Stop-EdgePDF {

    #Stops edge from taking over as the default .PDF viewer
    Write-Host "Stopping Edge from taking over as the default .PDF viewer" -ForegroundColor Yellow

    #FIXED: each of these was "New-ItemProperty <path> <name>" with no -PropertyType and no
    #-Value, and was guarded by a Get-ItemProperty test that throws rather than returning
    #$false when the property is missing. Both flags are REG_SZ empty strings, written with
    #-Force so a second run no longer errors on "already exists".
    #
    #REWRITTEN for speed, same cause as Remove-Keys. These paths went through the HKCR: drive,
    #which is a MERGED view of HKLM\SOFTWARE\Classes and HKCU\SOFTWARE\Classes; the provider
    #reconciles that merge on every single call. Nine provider operations in here cost 13.2
    #seconds on this machine - third-slowest step in the run, for setting four empty strings.
    #Going at the hives directly through .NET is effectively instant, and checking both hives
    #is exactly what the merged view was doing on our behalf.
    $subs  = @('.pdf', '.pdf\OpenWithProgids', '.pdf\OpenWithList')
    $hives = @(
        @{ Name = 'HKLM'; Root = [Microsoft.Win32.Registry]::LocalMachine },
        @{ Name = 'HKCU'; Root = [Microsoft.Win32.Registry]::CurrentUser }
    )
    $written = 0
    foreach ($sub in $subs) {
        $path = 'SOFTWARE\Classes\' + $sub
        foreach ($hive in $hives) {
            $key = $null
            #$true = open for write. Returns $null when the key is absent, which is the common
            #case for OpenWithProgids / OpenWithList and is not an error.
            try { $key = $hive.Root.OpenSubKey($path, $true) } catch { }
            if (-not $key) { continue }
            foreach ($Flag in @('NoOpenWith', 'NoStaticDefaultVerb')) {
                try {
                    $key.SetValue($Flag, '', [Microsoft.Win32.RegistryValueKind]::String)
                    $written++
                }
                catch {
                    Write-Host "  Could not set $Flag on $($hive.Name)\$path - $($_.Exception.Message)" -ForegroundColor Red
                }
            }
            $key.Close()
        }
    }
    Write-Host "  $written flag(s) written." -ForegroundColor Green

    #REMOVED: this block carried over from Sycnex's original and never did what its comment said.
    #    $Edge = "HKCR:\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_"
    #    Set-Item $Edge AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_
    #Set-Item on a registry key writes that key's (Default) value - it cannot rename a key. The
    #comment said "appends an underscore", but the path already ends in one, so at best it
    #stamped a string into a key that was already renamed. It was a no-op either way.
}

Function CheckDMWService {
    #make a write output for this function with -ForegroundColor Yellow
    Param([switch]$Debloat)
  
    If (Get-Service -Name dmwappushservice | Where-Object {$_.StartType -eq "Disabled"}) {
        Set-Service -Name dmwappushservice -StartupType Automatic
    }

    If (Get-Service -Name dmwappushservice | Where-Object {$_.Status -eq "Stopped"}) {
        Start-Service -Name dmwappushservice
    } 
}

Function Remove3dObjects {
    #Removes 3D Objects from the 'My Computer' submenu in explorer
    Write-Host "Removing 3D Objects from explorer 'My Computer' submenu" -ForegroundColor Yellow 
    $Objects32 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
    $Objects64 = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
    If (Test-Path $Objects32) {
        Remove-Item $Objects32 -Recurse 
    }
    If (Test-Path $Objects64) {
        Remove-Item $Objects64 -Recurse 
    }
}

Function HIGHPOWA {
    #Every generation of this script carried the same bug: the message said "Creating Ultimate
    #Performance" and then duplicated and activated 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c -
    #which is HIGH PERFORMANCE. Ultimate Performance is e9a42b02-d5df-448d-aa00-03f14749eb61.
    #Ultimate Performance was therefore never created on any machine this ever ran on.
    #
    #Ultimate Performance removes core parking entirely and drops P-state transition latency.
    #Worth having on a desktop that never leaves mains power.
    #
    #powercfg -duplicatescheme mints a NEW GUID on every call, so calling it repeatedly leaves a
    #pile of identical schemes. This detects an existing one first and only duplicates when
    #there is genuinely none.
    #
    #LANGUAGE-INDEPENDENT DETECTION. An earlier version matched the English string "Ultimate
    #Performance" in powercfg /list output. On a localised Windows that match fails, the
    #function silently falls back to High Performance, and the step still reports OK - the only
    #divergence in this script that gives a different result with no visible sign. Instead of
    #reading names, this snapshots the set of scheme GUIDs, duplicates, and takes whatever GUID
    #is new. GUIDs are the same in every language.
    $ultimateTemplate = 'e9a42b02-d5df-448d-aa00-03f14749eb61'
    $highPerf         = '8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c'

    function Get-SchemeGuids {
        $out = @()
        foreach ($line in (powercfg /list)) {
            $m = [regex]::Match($line, '([0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})')
            if ($m.Success) { $out += $m.Groups[1].Value.ToLower() }
        }
        return $out
    }

    #A scheme duplicated from the Ultimate template is recorded here on first creation, so later
    #runs recognise it without needing to read its name. Survives reboots; survives translation.
    $markerKey = 'HKLM:\SOFTWARE\w10n11deb'
    $marker    = $null
    #The marker key does not exist until the first successful run, so this read is EXPECTED to
    #fail on a clean machine - that absence is the answer, not a fault. The error still lands in
    #$Error though, and Invoke-Step counts it, which reported PARTIAL on an otherwise perfect
    #first run. Same trim as the Reserved Storage and NIC probes: record the count, read, remove
    #only what this read added. Real failures elsewhere in the step are untouched.
    #Absent until the first successful run - that absence is the answer, not a fault.
    $marker = Invoke-Silently { (Get-ItemProperty -Path $markerKey -Name 'UltimatePerfGuid' -ErrorAction Stop).UltimatePerfGuid }

    Write-Host "Setting the power plan. . ." -ForegroundColor Yellow
    $before = Get-SchemeGuids
    $guid   = $null

    $preexisting = $null
    foreach ($line in (powercfg /list)) {
        if ($line -match 'Ultimate Performance') {
            $m2 = [regex]::Match($line, '([0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})')
            if ($m2.Success) { $preexisting = $m2.Groups[1].Value }
        }
    }
    if ($marker -and ($before -contains $marker.ToLower())) {
        $guid = $marker
        Write-Host "  Ultimate Performance already present - not duplicating." -ForegroundColor Green
    }
    #MIGRATION / LAST RESORT: a scheme created by an older version of this script carries a
    #random GUID and no marker, so neither check above finds it. Fall back to matching the
    #English name - if it hits, record the GUID as the marker so this is the last time locale
    #matters on this machine. This is ONLY a fallback: on a localised Windows it misses and the
    #duplicate branch below runs, which is correct - it creates the scheme and records it.
    #Without this, upgrading to this version would duplicate a scheme that already exists.
    elseif ($before -contains $ultimateTemplate.ToLower()) {
        #Some builds expose the template scheme directly rather than requiring a duplicate.
        $guid = $ultimateTemplate
        Write-Host "  Ultimate Performance present as the built-in scheme." -ForegroundColor Green
    }
    elseif ($preexisting) {
        $guid = $preexisting
        Set-RegValue $markerKey 'UltimatePerfGuid' $guid 'String'
        Write-Host "  Ultimate Performance already present (adopted existing scheme) - not duplicating." -ForegroundColor Green
    }
    else {
        Write-Host "  Ultimate Performance not present - creating it once." -ForegroundColor Yellow
        $null = cmd /c "powercfg -duplicatescheme $ultimateTemplate 2>nul"
        Start-Sleep -Milliseconds 500
        $after = Get-SchemeGuids
        #Whatever GUID appeared is the new scheme. No name matching, no locale assumption.
        $diff = @($after | Where-Object { $before -notcontains $_ })
        if ($diff.Count -eq 1) {
            $guid = $diff[0]
            Set-RegValue $markerKey 'UltimatePerfGuid' $guid 'String'
        }
        elseif ($diff.Count -gt 1) {
            #Should not happen, but never guess which one - say so rather than pick blindly.
            Write-Host "  $($diff.Count) new schemes appeared - refusing to guess. Leaving the plan unchanged." -ForegroundColor DarkYellow
        }
    }

    if ($guid) {
        powercfg /setactive $guid
        Write-Host "  Active plan: Ultimate Performance ($guid)" -ForegroundColor Green
    }
    else {
        #Some SKUs will not create it at all. High Performance always exists, and saying so is
        #better than reporting success for something that did not happen.
        Write-Host "  Ultimate Performance unavailable on this build - using High Performance." -ForegroundColor DarkYellow
        powercfg /setactive $highPerf
    }
}

Function OptimizeLinkAndInputPower {
    #Power settings that cost latency rather than watts. All three are irrelevant on a desktop
    #that never leaves mains power, and all three show up as inconsistent frametimes or input
    #hitches rather than as lower average FPS - which is exactly what matters competitively.
    Write-Host "Disabling USB selective suspend, PCIe ASPM and NIC power saving. . ." -ForegroundColor Yellow

    #USB selective suspend: Windows powers down idle USB devices. When it suspends the mouse or
    #keyboard you get a perceptible hitch on the next input. This is the single most noticeable
    #one on the device you touch most.
    $usbSub  = '2a737441-1930-4402-8d77-b2bebba308a3'
    $usbSel  = '48e6b7a6-50f5-4782-a5d4-53bb8f07e226'
    $null = cmd /c "powercfg /setacvalueindex SCHEME_CURRENT $usbSub $usbSel 0 2>nul"
    $null = cmd /c "powercfg /setdcvalueindex SCHEME_CURRENT $usbSub $usbSel 0 2>nul"

    #PCIe Active State Power Management: lets the link to the GPU and NIC drop into low-power
    #states. Waking costs microseconds each time, and it happens constantly.
    $pciSub  = '501a4d13-42af-4429-9fd1-a8218c268e20'
    $aspm    = 'ee12f906-d277-404b-b6da-e5fa1a576df5'
    $null = cmd /c "powercfg /setacvalueindex SCHEME_CURRENT $pciSub $aspm 0 2>nul"
    $null = cmd /c "powercfg /setdcvalueindex SCHEME_CURRENT $pciSub $aspm 0 2>nul"

    #The plan has to be re-activated for index changes to take effect.
    $null = cmd /c "powercfg /setactive SCHEME_CURRENT 2>nul"
    Write-Host "  USB selective suspend and PCIe ASPM disabled." -ForegroundColor Green

    #"Allow the computer to turn off this device to save power" on the NIC - same class of
    #problem as USB suspend, on the adapter carrying your packets. Physical adapters only, so
    #VM/VPN/virtual adapters are left alone.
    #Not every driver exposes AllowComputerToTurnOffDevice - VMware's vmxnet3 does not, and
    #neither do some USB-tethered or virtual adapters. The cmdlet throwing there is the ANSWER
    #("this adapter has no such setting"), not a failure, but the caught exception still lands
    #in $Error and Invoke-Step counts it - which reported PARTIAL on an otherwise perfect run.
    #Error count is captured before the loop and anything this loop added is trimmed afterwards,
    #the same approach used for the Reserved Storage probe. Real failures elsewhere are untouched.
    $done = 0
    $seen = 0
    foreach ($nic in (Get-NetAdapter -Physical -ErrorAction SilentlyContinue | Where-Object { $_.Status -eq 'Up' })) {
        $seen++
        #A driver not exposing this is the ANSWER, not a failure - vmxnet3 does not, nor do some
        #USB-tethered adapters. -AsBool because the cmdlet returns nothing on success.
        if (Invoke-Silently -AsBool { Set-NetAdapterPowerManagement -Name $nic.Name -AllowComputerToTurnOffDevice Disabled -ErrorAction Stop }) { $done++ }
    }
    if ($seen -eq 0) {
        Write-Host "  No connected physical adapters found - nothing to change." -ForegroundColor Green
    }
    elseif ($done -eq 0) {
        Write-Host "  $seen adapter(s) found, none expose a power-saving setting - nothing to change." -ForegroundColor Green
    }
    else {
        Write-Host "  NIC power saving disabled on $done of $seen adapter(s)." -ForegroundColor Green
    }
}

Function TuneSchedulerAndTimer {
    Write-Host "Tuning the scheduler and timer resolution. . ." -ForegroundColor Yellow

    #Win32PrioritySeparation controls quantum length and the foreground priority boost.
    #Windows 11 ships 2. 0x26 (38) = short, variable quantums with a 3:1 foreground boost, so
    #the game in focus keeps the CPU longer against background work. One of the few scheduler
    #knobs that measurably steadies frametimes rather than just raising an average.
    Set-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl' 'Win32PrioritySeparation' 38

    #Windows 10 applied a 0.5ms timer resolution request globally once any process made one.
    #Windows 11 made it per-process, which quietly broke a lot of latency assumptions. This
    #restores the Windows 10 behaviour. Takes effect on reboot.
    Set-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel' 'GlobalTimerResolutionRequests' 1

    Write-Host "  Win32PrioritySeparation=38, GlobalTimerResolutionRequests=1 (reboot to apply)." -ForegroundColor Green
}

################################################################################################################################################################################################################################################################################################################################
################################################################################################################################################################################################################################################################################################################################
################################################################################################################################################################################################################################################################################################################################
################################################################################################################################################################################################################################################################################################################################
######################################################################################## JUICY STUFF DOWN HERE #################################################################################################################################################################################################################
################################################################################################################################################################################################################################################################################################################################
################################################################################################################################################################################################################################################################################################################################
################################################################################################################################################################################################################################################################################################################################
################################################################################################################################################################################################################################################################################################################################

#Hi :) you're beautiful
CleanMemoryy
Start-Sleep -Milliseconds 100
redundantColors
Start-Sleep 1
$Random = New-Object System.Random
#ADDED: the art itself is untouched - it is only captured into a variable here so that
#Write-Gradient can colour-cycle it per character instead of printing it flat. If the
#console cannot animate (redirected/piped output) Write-Gradient falls back to a plain
#Write-Host, so nothing is lost when this script is run non-interactively.
$bannerArt = "
888       888  d888   .d8888b.       .d8888b.           888       888  d888    d888  
888   o   888 d8888  d88P  Y88b     d88P  *88b          888   o   888 d8888   d8888  
888  d8b  888   888  888    888     Y88b. d88P          888  d8b  888   888     888  
888 d888b 888   888  888    888      *Y8888P*           888 d888b 888   888     888  
888d88888b888   888  888    888     .d88P88K.d88P       888d88888b888   888     888  
88888P Y88888   888  888    888     888*  Y888P*        88888P Y88888   888     888  
8888P   Y8888   888  Y88b  d88P     Y88b .d8888b        8888P   Y8888   888     888  
888P     Y888 8888888 *Y8888P*       *Y8888P* Y88b      888P     Y888 8888888 8888888
                                                                                     
                                                                                     
                                                                                     
8888888b.           888      888                   888         .d8888b.              
888  *Y88b          888      888                   888        d88P  *88b             
888    888          888      888                   888        Y88b. d88P             
888    888  .d88b.  88888b.  888  .d88b.   8888b.  888888      *Y8888P*              
888    888 d8P  Y8b 888 *88b 888 d88**88b     *88b 888        .d88P88K.d88P          
888    888 88888888 888  888 888 888  888 .d888888 888        888*  Y888P*           
888  .d88P Y8b.     888 d88P 888 Y88..88P 888  888 Y88b.      Y88b .d8888b           
8888888P*   *Y8888  88888P*  888  *Y88P*  *Y888888  *Y888      *Y8888P* Y88b         
                                                                                     
                                                                                     
                                                                                     
 .d88888b.           888    d8b               d8b                                    
d88P* *Y88b          888    Y8P               Y8P                                    
888     888          888                                                             
888     888 88888b.  888888 888 88888b.d88b.  888 88888888  .d88b.                   
888     888 888 *88b 888    888 888 *888 *88b 888    d88P  d8P  Y8b                  
888     888 888  888 888    888 888  888  888 888   d88P   88888888                  
Y88b. .d88P 888 d88P Y88b.  888 888  888  888 888  d88P    Y8b.                      
 *Y88888P*  88888P*   *Y888 888 888  888  888 888 88888888  *Y8888                   
            888                                                                      
            888                                                                      
            888                                                                       
" 
Write-Gradient -Text $bannerArt -Palette DarkCyan,Cyan,White,Cyan,DarkCyan,Blue -DelayMs 0
Start-Sleep 1
Write-Host " "
Write-Host "." -ForegroundColor Yellow 
Start-Sleep -milliseconds 250
Write-Host "." -ForegroundColor Yellow 
Start-Sleep -milliseconds 250
Write-Host "." -ForegroundColor Yellow 
Start-Sleep -milliseconds 250
Write-Host "." -ForegroundColor Yellow 
Start-Sleep -milliseconds 250
$table0 = "These are what the color's represent in the terminal" 
$table0 -split '' |
  ForEach-Object{
    Write-Host $_ -nonew -ForeGroundColor Cyan 
    Start-Sleep -milliseconds $(1 + $Random.Next(100))
}
$tabledottos = ". . . "
$tabledottos -split '' |
  ForEach-Object{
    Write-Host $_ -nonew -ForeGroundColor Cyan 
    Start-Sleep -milliseconds $(1 + $Random.Next(100))
}
Start-Sleep -Milliseconds 250
Write-Host ""
Start-Sleep -Milliseconds 250
Write-Color "Completed Proccess. . . ".PadRight(50), '[', '     OK  '.PadRight(12), ']' -ForeGroundColor Green, White, green, White -BackGroundColor Black, Black, Black, Black
Write-Color "Error will skip and continue. . . ".PadRight(50), '[' ,'   ERROR  '.PadRight(12), ']' -ForeGroundColor red, White, red, white -BackGroundColor Black, Black, Black, Black
Write-Color "System messages. . .".PadRight(50), '[', '   SYSTEM  '.PadRight(12), ']' -ForeGroundColor Yellow, White, Yellow, White -BackGroundColor Black, Black, Black, Black
Write-Color "Process. . .".PadRight(50), '[', '  PROCESS  '.PadLeft(12), ']' -ForeGroundColor Magenta, White, Magenta, White -BackGroundColor Black, Black, Black, Black
Write-Host " "
Start-Sleep 1
Write-Host "." -ForegroundColor Yellow 
Start-Sleep -milliseconds 250
Write-Host "." -ForegroundColor Yellow 
Start-Sleep -milliseconds 250
Write-Host "." -ForegroundColor Yellow 
Start-Sleep -milliseconds 250
Write-Host "." -ForegroundColor Yellow 
Start-Sleep -milliseconds 250
$scriptstartmessage = "Script is now starting"  
$scriptstartmessage -split '' |
  ForEach-Object{
    Write-Host $_ -nonew -ForeGroundColor Yellow
    Start-Sleep -milliseconds $(1 + $Random.Next(100))
}
$tabledottos1 = ". . . "
$tabledottos1 -split '' |
  ForEach-Object{
    Write-Host $_ -nonew -ForeGroundColor Yellow
    Start-Sleep -milliseconds $(1 + $Random.Next(100))
}
Start-Sleep -Milliseconds 250
Write-Host " "
Start-Sleep 1
Write-Host "." -ForegroundColor Yellow 
Start-Sleep -milliseconds 250
Write-Host "." -ForegroundColor Yellow 
Start-Sleep -milliseconds 250
Write-Host "." -ForegroundColor Yellow 
Start-Sleep -milliseconds 250
Write-Host "." -ForegroundColor Yellow 
Start-Sleep -milliseconds 250
$Debloatlogmessage = "A log of this script will be saved in a folder located in C:\Temp\WindowsDebloat&Optimize as a .txt file."  
$Debloatlogmessage -split '' |
  ForEach-Object{
    Write-Host $_ -nonew -ForeGroundColor Yellow
    Start-Sleep -milliseconds $(1 + $Random.Next(100))
}
Write-Host " "
Start-Sleep -Milliseconds 250
############################################################################################################################################
############################################################################################################################################
##
##   EMBEDDED DATA  -  nothing below here is logic, it is all payload.
##
##   FRAGMENT 2 moved the hosts blocklist out of the middle of BlocklistMNNSSM and
##   parked it here with the three .bat tools. Everything above this line is the
##   actual script; everything between here and MAIN is data the script writes out.
##
##     $MNNSSMBlocklist     Dan Pollock's hosts file          -> C:\Windows\System32\drivers\etc\hosts
##     $CleanupMainBat      cleanup_main.bat                 -> Desktop
##     $NetResetRebootBat   net-reset-reboot.bat             -> Desktop
##     $NetResetLiteBat     net-reset-lite.bat               -> Desktop
##
##   These are single-quoted here-strings on purpose: the .bat files are full of
##   %VAR% and !VAR! expansions that PowerShell must NOT touch.
##
############################################################################################################################################
############################################################################################################################################

#  Dan Pollock's hosts blocklist - https://someonewhocares.org/hosts/zero/
#  Author's own terms: free to copy and distribute for non-commercial uses, as
#  long as the original URL and attribution are included. Not a CC licence.
$script:MNNSSMBlocklist = @'
# This hosts file is brought to you by Dan Pollock and can be found at
# http://someonewhocares.org/hosts/zero/
# You are free to copy and distribute this file for non-commercial uses,
# as long the original URL and attribution is included. 
# 
# This hosts file is proudly sponsored by adguard.com. 
#
# See below for acknowledgements.

# Please forward any additions, corrections or comments by email to
# hosts@someonewhocares.org

# Last updated: Fri, 18 Sep 2026 at 19:29:33 GMT

# Use this file to prevent your computer from connecting to selected
# internet hosts. This is an easy and effective way to protect you from 
# many types of spyware, reduces bandwidth use, blocks certain pop-up 
# traps, prevents user tracking by way of "web bugs" embedded in spam,
# provides partial protection to IE from certain web-based exploits and
# blocks most advertising you would otherwise be subjected to on the 
# internet. 

# There is a version of this file that uses 127.0.0.1 instead of 0.0.0.0 
# available at http://someonewhocares.org/hosts/.
# On some machines the zero version may run minutely faster, however it
# may not be compatible with all systems. 

# This file must be saved as a text file with no extension. (This means
# that the file name should be exactly as below, without a ".txt" appended.)

# Let me repeat, the file should be named "hosts" NOT "hosts.txt".

# For Windows 9x and ME place this file at "C:\Windows\hosts"
# For NT, Win2K and XP use "C:\windows\system32\drivers\etc\hosts"
#                       or "C:\winnt\system32\drivers\etc\hosts"
# For Windows 7 and Vista use "C:\windows\system32\drivers\etc\hosts"
#			or "%systemroot%\system32\drivers\etc\hosts"
# For Windows 8 and Windows 10 use "C:\Windows\System32\drivers\etc\hosts"
# 		You may need to tell Windows Defender to ignore this path
# 		see: http://support.microsoft.com/kb/2764944
# You may have to use Notepad and "Run as Administrator"
#
# For Linux, Unix, or OS X place this file at "/etc/hosts" or on some
#    systems at "/private/etc/hosts". You will require root access to do
#    this. Saving this file to "~/hosts" will allow you to run something
#    like "sudo cp ~/hosts /etc/hosts".
# For OS/2 copy the file to "%ETC%\HOSTS" and in the CONFIG.SYS file,
#    ensure that the line "SET USE_HOSTS_FIRST=1" is included.
# For BeOS place it at "/boot/beos/etc/hosts"
# On a Netware system, the location is System\etc\hosts"
# For Macintosh (pre OS X) place it in the Mac System Folder or Preferences
#    folder and reboot. (something like HD:System Folder:Preferences:Hosts)
#    Alternatively you can save it elsewhere on your machine, then go to the 
#    TCP/IP control panel and click on "Select hosts file" to read it in.
#    ------------------
#    | As well, note that the format is different on old macs, so
#    | please visit http://someonewhocares.org/hosts/zero/mac/ for mac format
# For Android place the file at "/system/etc/hosts". You will need root
#   access on your device to do this.
#    ------------------
# To convert the hosts file to a set of Cisco IOS commands for Cisco routers
#   use this script by Jesse Baird:
#   http://jebaird.com/2012/12/21/hosts-to-ip-host-generating-blocked-hosts-from-a-host-file-for-a-cisco-router.html

# If there is a domain name you would rather never see, simply add a line
# that reads "0.0.0.0 machine.domain.tld". This will have the effect of
# redirecting any requests to that host to your own computer. For example
# this will prevent your browser from downloading banner ads, or sending
# your information back to a company.

#<localhost>
127.0.0.1	localhost
127.0.0.1	localhost.localdomain
255.255.255.255	broadcasthost
::1		localhost
127.0.0.1	local
::1		ip6-localhost ip6-loopback
fe00::0		ip6-localnet
ff00::0		ip6-mcastprefix
ff02::1		ip6-allnodes
ff02::2		ip6-allrouters
ff02::3		ip6-allhosts
#fe80::1%lo0	localhost
#</localhost>
#<other> #extra not included with Dan Pollocks blocklist afaik lazy to check at this point lol
0.0.0.0	a.ads1.msn.com
0.0.0.0	a.ads2.msn.com
0.0.0.0	ac3.msn.com
0.0.0.0	ads.msn.com
0.0.0.0	ads1.msn.com
0.0.0.0	b.ads1.msn.com
0.0.0.0	statsfe1.ws.microsoft.com
0.0.0.0	statsfe2.update.microsoft.com.akadns.net
0.0.0.0	statsfe2.ws.microsoft.com
0.0.0.0	watson.microsoft.com
0.0.0.0	a.rad.msn.com
0.0.0.0	ads2.msn.com
0.0.0.0	ads2.msn.com.c.footprint.net
0.0.0.0	b.rad.msn.com
0.0.0.0	c.msn.com
0.0.0.0	corpext.msitadfs.glbdns2.microsoft.com
0.0.0.0	fe2.update.microsoft.com.akadns.net
0.0.0.0	feedback.microsoft-hohm.com
0.0.0.0	flex.msn.com
0.0.0.0	g.msn.com
0.0.0.0	h1.msn.com
0.0.0.0	live.rads.msn.com
0.0.0.0	msnbot-207-46-194-33.search.msn.com
0.0.0.0	msnbot-65-55-108-23.search.msn.com
0.0.0.0	preview.msn.com
0.0.0.0	rad.msn.com
0.0.0.0	schemas.microsoft.akadns.net
0.0.0.0	settings-sandbox.data.glbdns2.microsoft.com
0.0.0.0	settings.data.glbdns2.microsoft.com
0.0.0.0	sls.update.microsoft.com.akadns.net
0.0.0.0	statsfe1.ws.microsoft.com.nsatc.net
0.0.0.0	statsfe2.ws.microsoft.com.nsatc.net
0.0.0.0	survey.watson.microsoft.com
0.0.0.0	vortex-sandbox.data.glbdns2.microsoft.com
0.0.0.0	vortex.data.glbdns2.microsoft.com
0.0.0.0	watson.microsoft.com.nsatc.net
#</other>

#<shortcut-examples>
# As well by specifying the ipaddress of a server, you can gain access
#   to some of your favourite sites with a single letter, instead of
#   using the whole domain name
# It is perhaps a better solution to use Favourites/Bookmarks instead.
#216.34.181.45   s        # slashdot.org
#74.125.127.105	g        # google.com
#</shortcut-examples>

#<hijack-sites>
# The sites ads234.com and ads345.com -- These sites hijack internet explorer 
# and redirect all requests through their servers. You may need to use spyware 
# removal programs such as SpyBotS&amp;D, AdAware or HijackThis to remove this 
# nasty parasite. It's possible that blocking these sites using a hosts file 
# may not work, in which case you should remove the following lines from this
# file and try the tools listed above immediately. Don't forget to reboot 
# after a scan.
0.0.0.0 ads234.com
0.0.0.0 ads345.com
0.0.0.0 www.ads234.com
0.0.0.0 www.ads345.com
#</hijack-sites>


#<spyware-sites>
# Spyware and user tracking
# By entering domains here, it will prevent certain companies from
# gathering information on your surfing habits. These servers do not
# necessarily serve ads, instead some are used by certain products to
# "phone home". Others use web cookies to gather statistics on surfing 
# habits. Among other uses, this is a common tactic by spammers, to 
# let them know that you have read your mail. 
# Uncomment (remove the #) the lines that you wish to block, as some
# may provide you with services you like.

#<maybe-spy>
#0.0.0.0 auto.search.msn.com  # Microsoft uses this server to redirect
                                # mistyped URLs to search engines. They
                                # log all such errors.
#0.0.0.0 sitefinder.verisign.com	# Verisign has joined the game 
#0.0.0.0 sitefinder-idn.verisign.com	# of trying to hijack mistyped
					# URLs to their site. 
					# May break iOS Game Center.

#0.0.0.0 s0.2mdn.net		# This may interfere with some streaming 
				# video on sites such as cbc.ca
#0.0.0.0 ad.doubleclick.net   # This may interefere with www.sears.com
				# and potentially other sites. 
0.0.0.0 media.fastclick.net	# Likewise, this may interfere with some
0.0.0.0 cdn.fastclick.net	# sites. 
#0.0.0.0 ebay.doubleclick.net		# may interfere with ebay
#0.0.0.0 google-analytics.com			# breaks some sites
#0.0.0.0 ssl.google-analytics.com
#0.0.0.0 www.google-analytics.l.google.com
#0.0.0.0 stat.livejournal.com		# There are reports that this may mess 
 					# up CSS on livejournal
#0.0.0.0 stats.surfaid.ihost.com	# This has been known cause 
					# problems with NPR.org
#0.0.0.0 www.google-analytics.com		# breaks some sites
#0.0.0.0 ads.imeem.com		# Seems to interfere with the functioning of imeem.com
#</maybe-spy>

#0.0.0.0 ci-mpsnare.iovation.com	# See http://www.codingthewheel.com/archives/online-gambling-privacy-iesnare
#0.0.0.0 ll.a.hulu.com	# Uncomment to block Hulu.
#0.0.0.0 metrics.ticketmaster.com	# interferes with logging in to ticketmaster.com
#0.0.0.0 nl.sitestat.com	# may interfere with duo.nl
#0.0.0.0 pro.hit.gemius.pl	# May interfere with some video sites
#0.0.0.0 s.youtube.com				# Blocking this will interfere with video watching history and may interfere with Google Podcasts
#0.0.0.0 services.krxd.net
#0.0.0.0 stats.channel4.com
#0.0.0.0 t2.hulu.com		# Uncomment to block Hulu.
#0.0.0.0 track.hulu.com	# Uncomment to block Hulu.
#0.0.0.0 webstat.channel4.com
#0.0.0.0 www.googletagservices.com		#interferes with techrepublic
0.0.0.0 006.free-counter.co.uk
0.0.0.0 006.freecounters.co.uk
0.0.0.0 0stats.com
0.0.0.0 123counter.mycomputer.com
0.0.0.0 123counter.superstats.com
0.0.0.0 1ca.cqcounter.com
0.0.0.0 1uk.cqcounter.com
0.0.0.0 1us.cqcounter.com
0.0.0.0 1xxx.cqcounter.com
0.0.0.0 20585485p.rfihub.com
0.0.0.0 3dns-1.adobe.com
0.0.0.0 3dns-2.adobe.com
0.0.0.0 3dns-3.adobe.com
0.0.0.0 3dns-4.adobe.com
0.0.0.0 3dns.adobe.com
0.0.0.0 4-counter.com
0.0.0.0 a-nj.1rx.io
0.0.0.0 a-ssl.ligatus.com
0.0.0.0 a.predictvideo.com
0.0.0.0 a.visualrevenue.com
0.0.0.0 abclnks.com
0.0.0.0 aboardamusement.com
0.0.0.0 abscbn.spinbox.net
0.0.0.0 activity.serving-sys.com	#eyeblaster.com
0.0.0.0 adadvisor.net
0.0.0.0 adapi.ragapa.com
0.0.0.0 adcounter.theglobeandmail.com
0.0.0.0 addfreestats.com
0.0.0.0 adelogs.adobe.com	#See http://www.theregister.co.uk/2014/10/07/adobe_digital_editions_4_caught_snooping_into_ebook_collections_of_users/
0.0.0.0 ademails.com
0.0.0.0 adlog.com.com # Used by Ziff Davis to serve 
  # ads and track users across 
  # the com.com family of sites
0.0.0.0 admin.iovation.com
0.0.0.0 adopt.specificclick.net
0.0.0.0 adpatrof.com
0.0.0.0 ads.tiscali.it
0.0.0.0 adtrack.appcpi.net
0.0.0.0 adult.foxcounter.com
0.0.0.0 affpool.com
0.0.0.0 alert.mac-notification.com
0.0.0.0 alpha.easy-hit-counters.com
0.0.0.0 amateur.xxxcounter.com
0.0.0.0 amer.rel.msn.com
0.0.0.0 an.mlb.com
0.0.0.0 analytics-ingress-global.bitmovin.com
0.0.0.0 analytics-static.ugc.bazaarvoice.com
0.0.0.0 analytics.foresee.com
0.0.0.0 analytics.global.sky.com
0.0.0.0 analytics.msnbc.msn.com
0.0.0.0 analytics.ooyala.com
0.0.0.0 analytics.prx.org
0.0.0.0 analytics.publitas.com
0.0.0.0 analytics.sleeknote.com
0.0.0.0 analytics.tiktok.com
0.0.0.0 anonymousdemographics.com
0.0.0.0 ant.conversive.nl
0.0.0.0 apac.rel.msn.com
0.0.0.0 api.adsymptotic.com
0.0.0.0 api.behavioralengine.com
0.0.0.0 api.bizographics.com
0.0.0.0 api.gameanalytics.com
0.0.0.0 api.infinario.com
0.0.0.0 api.intentiq.com
0.0.0.0 api.redshell.io
0.0.0.0 api.simpleanalytics.io
0.0.0.0 api.tumra.com
0.0.0.0 apiadapter.ad5track.com
0.0.0.0 apis.murdoog.com
0.0.0.0 app-analytics-v2.snapchat.com
0.0.0.0 app-analytics.snapchat.com
0.0.0.0 app.yesware.com
0.0.0.0 arbo.hit.gemius.pl
0.0.0.0 aus-mec-tracking.adalyser.com
0.0.0.0 aus-smv-tracking.adalyser.com
0.0.0.0 auspice.augur.io
0.0.0.0 b.stats.paypal.com
0.0.0.0 bam.nr-data.net
0.0.0.0 banner.0catch.com
0.0.0.0 banners.webcounter.com
0.0.0.0 be.sitestat.com
0.0.0.0 beacon-1.newrelic.com
0.0.0.0 beacon.krxd.net
0.0.0.0 beacon.scorecardresearch.com
0.0.0.0 belierlaine.com
0.0.0.0 benchemail.bmetrack.com
0.0.0.0 best-search.cc	#spyware
0.0.0.0 beta.easy-hit-counters.com
0.0.0.0 beta.easyhitcounters.com
0.0.0.0 bigdata.adfuture.cn
0.0.0.0 bigdata.adsunflower.com
0.0.0.0 bigdata.adups.com
0.0.0.0 bigdata.advmob.cn
0.0.0.0 bindedge.com
0.0.0.0 bindfast.com
0.0.0.0 biomagin.com
0.0.0.0 bkrtx.com
0.0.0.0 bleachbit.com
0.0.0.0 bluekai.com
0.0.0.0 bluestreak.com
0.0.0.0 brightroll.com
0.0.0.0 brucelead.com
0.0.0.0 bullionglidingscuttle.com
0.0.0.0 c.go-mpulse.net
0.0.0.0 c.statcounter.com
0.0.0.0 c.thecounter.de
0.0.0.0 c0.adalyser.com
0.0.0.0 c1.statcounter.com
0.0.0.0 c1.thecounter.de
0.0.0.0 c1.xxxcounter.com
0.0.0.0 c10.statcounter.com
0.0.0.0 c11.statcounter.com
0.0.0.0 c12.statcounter.com
0.0.0.0 c13.statcounter.com
0.0.0.0 c14.statcounter.com
0.0.0.0 c15.statcounter.com
0.0.0.0 c16.statcounter.com
0.0.0.0 c17.statcounter.com
0.0.0.0 c2.gostats.com
0.0.0.0 c2.thecounter.de
0.0.0.0 c2.xxxcounter.com
0.0.0.0 c3.adalyser.com
0.0.0.0 c3.gostats.com
0.0.0.0 c3.statcounter.com
0.0.0.0 c3.xxxcounter.com
0.0.0.0 c4.myway.com
0.0.0.0 c4.statcounter.com
0.0.0.0 c5.statcounter.com
0.0.0.0 c6.statcounter.com
0.0.0.0 c7.statcounter.com
0.0.0.0 c8.statcounter.com
0.0.0.0 c9.statcounter.com
0.0.0.0 ca.cqcounter.com
0.0.0.0 cashcounter.com
0.0.0.0 cb1.counterbot.com
0.0.0.0 ccleaner.fr
0.0.0.0 cdn-gl.imrworldwide.com
0.0.0.0 cdn-social.janrain.com
0.0.0.0 cdn.decibelinsight.net
0.0.0.0 cdn.doublepimpssl.com
0.0.0.0 cdn.simpleanalytics.io
0.0.0.0 cdn.taboolasyndication.com
0.0.0.0 cdn.zarget.com
0.0.0.0 cf.addthis.com
0.0.0.0 cgi.sexlist.com
0.0.0.0 cgicounter.onlinehome.de
0.0.0.0 cgicounter.puretec.de
0.0.0.0 ci-admin.iovation.com
0.0.0.0 cig-arrete.com
0.0.0.0 citrix.tradedoubler.com
0.0.0.0 cjt1.net
0.0.0.0 clckcloud.com
0.0.0.0 click.atdmt.com
0.0.0.0 click.icptrack.com
0.0.0.0 click.jve.net
0.0.0.0 click.payserve.com
0.0.0.0 click.silvercash.com
0.0.0.0 clickauditor.net
0.0.0.0 clickmeter.com
0.0.0.0 clicks.emarketmakers.com
0.0.0.0 clicks.m4n.nl
0.0.0.0 clicks.natwest.com
0.0.0.0 clicks.rbs.co.uk
0.0.0.0 clickspring.net	#used by a spyware product called PurityScan
0.0.0.0 clickstatsview.earnmoneycasinos.com
0.0.0.0 clicktrack.onlineemailmarketing.com
0.0.0.0 clicktrack.premium-shops.net
0.0.0.0 clicktracker.alloymarketing.com
0.0.0.0 clicktracks.webmetro.com
0.0.0.0 clit10.sextracker.com
0.0.0.0 clit13.sextracker.com
0.0.0.0 clit15.sextracker.com
0.0.0.0 clit2.sextracker.com
0.0.0.0 clit4.sextracker.com
0.0.0.0 clit6.sextracker.com
0.0.0.0 clit7.sextracker.com
0.0.0.0 clit8.sextracker.com
0.0.0.0 clit9.sextracker.com
0.0.0.0 clk.aboxdeal.com
0.0.0.0 clk.relestar.com
0.0.0.0 cnn.entertainment.printthis.clickability.com
0.0.0.0 cnt.xcounter.com
0.0.0.0 code.murdoog.com
0.0.0.0 collector.deepmetrix.com
0.0.0.0 connectionlead.com
0.0.0.0 connexity.net
0.0.0.0 convertro.com
0.0.0.0 convnjmp.basebanner.com
0.0.0.0 cookies.cmpnet.com
0.0.0.0 count.channeladvisor.com
0.0.0.0 count.paycounter.com
0.0.0.0 counter.123counts.com
0.0.0.0 counter.adultcheck.com
0.0.0.0 counter.adultrevenueservice.com
0.0.0.0 counter.advancewebhosting.com
0.0.0.0 counter.aport.ru
0.0.0.0 counter.avp2000.com
0.0.0.0 counter.bizland.com
0.0.0.0 counter.bloke.com
0.0.0.0 counter.clubnet.ro
0.0.0.0 counter.cnw.cz
0.0.0.0 counter.cz
0.0.0.0 counter.dreamhost.com
0.0.0.0 counter.execpc.com
0.0.0.0 counter.fateback.com
0.0.0.0 counter.gamespy.com
0.0.0.0 counter.hitslink.com
0.0.0.0 counter.hitslinks.com
0.0.0.0 counter.inetusa.com
0.0.0.0 counter.kaspersky.com
0.0.0.0 counter.letssingit.com
0.0.0.0 counter.mtree.com
0.0.0.0 counter.mycomputer.com
0.0.0.0 counter.nope.dk
0.0.0.0 counter.nowlinux.com
0.0.0.0 counter.rambler.ru
0.0.0.0 counter.search.bg
0.0.0.0 counter.sparklit.com
0.0.0.0 counter.superstats.com
0.0.0.0 counter.surfcounters.com
0.0.0.0 counter.topping.com.ua
0.0.0.0 counter.tripod.com
0.0.0.0 counter.w3open.com
0.0.0.0 counter.webmedia.pl
0.0.0.0 counter.xxxcool.com
0.0.0.0 counter.yadro.ru
0.0.0.0 counter1.bravenet.com
0.0.0.0 counter1.sextracker.be
0.0.0.0 counter1.sextracker.com
0.0.0.0 counter10.bravenet.com
0.0.0.0 counter10.sextracker.be
0.0.0.0 counter10.sextracker.com
0.0.0.0 counter11.bravenet.com
0.0.0.0 counter11.sextracker.be
0.0.0.0 counter11.sextracker.com
0.0.0.0 counter12.bravenet.com
0.0.0.0 counter12.sextracker.be
0.0.0.0 counter12.sextracker.com
0.0.0.0 counter13.bravenet.com
0.0.0.0 counter13.sextracker.be
0.0.0.0 counter13.sextracker.com
0.0.0.0 counter14.bravenet.com
0.0.0.0 counter14.sextracker.be
0.0.0.0 counter14.sextracker.com
0.0.0.0 counter15.bravenet.com
0.0.0.0 counter15.sextracker.be
0.0.0.0 counter15.sextracker.com
0.0.0.0 counter16.bravenet.com
0.0.0.0 counter16.sextracker.be
0.0.0.0 counter16.sextracker.com
0.0.0.0 counter17.bravenet.com
0.0.0.0 counter18.bravenet.com
0.0.0.0 counter19.bravenet.com
0.0.0.0 counter2.bravenet.com
0.0.0.0 counter2.freeware.de
0.0.0.0 counter2.hitslink.com
0.0.0.0 counter2.sextracker.be
0.0.0.0 counter2.sextracker.com
0.0.0.0 counter20.bravenet.com
0.0.0.0 counter21.bravenet.com
0.0.0.0 counter22.bravenet.com
0.0.0.0 counter23.bravenet.com
0.0.0.0 counter24.bravenet.com
0.0.0.0 counter25.bravenet.com
0.0.0.0 counter26.bravenet.com
0.0.0.0 counter27.bravenet.com
0.0.0.0 counter28.bravenet.com
0.0.0.0 counter29.bravenet.com
0.0.0.0 counter3.bravenet.com
0.0.0.0 counter3.sextracker.be
0.0.0.0 counter3.sextracker.com
0.0.0.0 counter30.bravenet.com
0.0.0.0 counter31.bravenet.com
0.0.0.0 counter32.bravenet.com
0.0.0.0 counter33.bravenet.com
0.0.0.0 counter34.bravenet.com
0.0.0.0 counter35.bravenet.com
0.0.0.0 counter36.bravenet.com
0.0.0.0 counter37.bravenet.com
0.0.0.0 counter38.bravenet.com
0.0.0.0 counter39.bravenet.com
0.0.0.0 counter4.bravenet.com
0.0.0.0 counter4.sextracker.be
0.0.0.0 counter4.sextracker.com
0.0.0.0 counter40.bravenet.com
0.0.0.0 counter41.bravenet.com
0.0.0.0 counter42.bravenet.com
0.0.0.0 counter43.bravenet.com
0.0.0.0 counter44.bravenet.com
0.0.0.0 counter45.bravenet.com
0.0.0.0 counter46.bravenet.com
0.0.0.0 counter47.bravenet.com
0.0.0.0 counter48.bravenet.com
0.0.0.0 counter49.bravenet.com
0.0.0.0 counter4all.dk
0.0.0.0 counter4u.de
0.0.0.0 counter5.bravenet.com
0.0.0.0 counter5.sextracker.be
0.0.0.0 counter5.sextracker.com
0.0.0.0 counter50.bravenet.com
0.0.0.0 counter6.bravenet.com
0.0.0.0 counter6.sextracker.be
0.0.0.0 counter6.sextracker.com
0.0.0.0 counter7.bravenet.com
0.0.0.0 counter7.sextracker.be
0.0.0.0 counter7.sextracker.com
0.0.0.0 counter8.bravenet.com
0.0.0.0 counter8.sextracker.be
0.0.0.0 counter8.sextracker.com
0.0.0.0 counter9.bravenet.com
0.0.0.0 counter9.sextracker.be
0.0.0.0 counter9.sextracker.com
0.0.0.0 counteraport.spylog.com
0.0.0.0 counterbot.com
0.0.0.0 countercrazy.com
0.0.0.0 counters.auctionhelper.com		# comment these 
0.0.0.0 counters.auctionwatch.com		# out to allow 
0.0.0.0 counters.auctiva.com			# tracking by
0.0.0.0 counters.honesty.com			# ebay users
0.0.0.0 cs.sexcounter.com
0.0.0.0 cw.nu
0.0.0.0 cyberduck.fr
0.0.0.0 cyseal.cyveillance.com
0.0.0.0 cz3.clickzs.com
0.0.0.0 cz6.clickzs.com
0.0.0.0 da.newstogram.com
0.0.0.0 dap.digitalgov.gov
0.0.0.0 data.coremetrics.com
0.0.0.0 data.murdoog.com
0.0.0.0 data.webads.co.nz
0.0.0.0 data2.perf.overture.com
0.0.0.0 dc43.s290.meetrics.net
0.0.0.0 dclk.themarker.com
0.0.0.0 dclk.themarketer.com
0.0.0.0 de-config.sensic.net
0.0.0.0 de.sitestat.com
0.0.0.0 de.tynt.com
0.0.0.0 def.dev-nano.com
0.0.0.0 didtheyreadit.com		# email bugs
0.0.0.0 digistats.westjet.com
0.0.0.0 dimeprice.com		# "spam bugs"
0.0.0.0 directads.mcafee.com
0.0.0.0 dkb01.webtrekk.net
0.0.0.0 dnsdelegation.io
0.0.0.0 dotcomsecrets.com
0.0.0.0 dpbolvw.net
0.0.0.0 dwclick.com
0.0.0.0 dyn.emetriq.de
0.0.0.0 e-2dj6wfk4ehd5afq.stats.esomniture.com
0.0.0.0 e-2dj6wfk4ggdzkbo.stats.esomniture.com
0.0.0.0 e-2dj6wfk4gkcpiep.stats.esomniture.com
0.0.0.0 e-2dj6wfk4skdpogo.stats.esomniture.com
0.0.0.0 e-2dj6wfkiakdjgcp.stats.esomniture.com
0.0.0.0 e-2dj6wfkiepczoeo.stats.esomniture.com
0.0.0.0 e-2dj6wfkikjd5glq.stats.esomniture.com
0.0.0.0 e-2dj6wfkiokc5odp.stats.esomniture.com
0.0.0.0 e-2dj6wfkiqjcpifp.stats.esomniture.com
0.0.0.0 e-2dj6wfkocjczedo.stats.esomniture.com
0.0.0.0 e-2dj6wfkokjajseq.stats.esomniture.com
0.0.0.0 e-2dj6wfkowkdjokp.stats.esomniture.com
0.0.0.0 e-2dj6wfkykpazskq.stats.esomniture.com
0.0.0.0 e-2dj6wflicocjklo.stats.esomniture.com
0.0.0.0 e-2dj6wfligpd5iap.stats.esomniture.com
0.0.0.0 e-2dj6wflikgdpodo.stats.esomniture.com
0.0.0.0 e-2dj6wflikiajslo.stats.esomniture.com
0.0.0.0 e-2dj6wflioldzoco.stats.esomniture.com
0.0.0.0 e-2dj6wfliwpczolp.stats.esomniture.com
0.0.0.0 e-2dj6wfloenczmkq.stats.esomniture.com
0.0.0.0 e-2dj6wflokmajedo.stats.esomniture.com
0.0.0.0 e-2dj6wfloqgc5mho.stats.esomniture.com
0.0.0.0 e-2dj6wfmysgdzobo.stats.esomniture.com
0.0.0.0 e-2dj6wgkigpcjedo.stats.esomniture.com
0.0.0.0 e-2dj6wgkisnd5abo.stats.esomniture.com
0.0.0.0 e-2dj6wgkoandzieq.stats.esomniture.com
0.0.0.0 e-2dj6wgkycpcpsgq.stats.esomniture.com
0.0.0.0 e-2dj6wgkyepajmeo.stats.esomniture.com
0.0.0.0 e-2dj6wgkyknd5sko.stats.esomniture.com
0.0.0.0 e-2dj6wgkyomdpalp.stats.esomniture.com
0.0.0.0 e-2dj6whkiandzkko.stats.esomniture.com
0.0.0.0 e-2dj6whkiepd5iho.stats.esomniture.com
0.0.0.0 e-2dj6whkiwjdjwhq.stats.esomniture.com
0.0.0.0 e-2dj6wjk4amd5mfp.stats.esomniture.com
0.0.0.0 e-2dj6wjk4kkcjalp.stats.esomniture.com
0.0.0.0 e-2dj6wjk4ukazebo.stats.esomniture.com
0.0.0.0 e-2dj6wjkosodpmaq.stats.esomniture.com
0.0.0.0 e-2dj6wjkouhd5eao.stats.esomniture.com
0.0.0.0 e-2dj6wjkowhd5ggo.stats.esomniture.com
0.0.0.0 e-2dj6wjkowjajcbo.stats.esomniture.com
0.0.0.0 e-2dj6wjkyandpogq.stats.esomniture.com
0.0.0.0 e-2dj6wjkycpdzckp.stats.esomniture.com
0.0.0.0 e-2dj6wjkyqmdzcgo.stats.esomniture.com
0.0.0.0 e-2dj6wjkysndzigp.stats.esomniture.com
0.0.0.0 e-2dj6wjl4qhd5kdo.stats.esomniture.com
0.0.0.0 e-2dj6wjlichdjoep.stats.esomniture.com
0.0.0.0 e-2dj6wjliehcjglp.stats.esomniture.com
0.0.0.0 e-2dj6wjlignajgaq.stats.esomniture.com
0.0.0.0 e-2dj6wjloagc5oco.stats.esomniture.com
0.0.0.0 e-2dj6wjlougazmao.stats.esomniture.com
0.0.0.0 e-2dj6wjlyamdpogo.stats.esomniture.com
0.0.0.0 e-2dj6wjlyckcpelq.stats.esomniture.com
0.0.0.0 e-2dj6wjlyeodjkcq.stats.esomniture.com
0.0.0.0 e-2dj6wjlygkd5ecq.stats.esomniture.com
0.0.0.0 e-2dj6wjmiekc5olo.stats.esomniture.com
0.0.0.0 e-2dj6wjmyehd5mfo.stats.esomniture.com
0.0.0.0 e-2dj6wjmyooczoeo.stats.esomniture.com
0.0.0.0 e-2dj6wjny-1idzkh.stats.esomniture.com
0.0.0.0 e-2dj6wjnyagcpkko.stats.esomniture.com
0.0.0.0 e-2dj6wjnyeocpcdo.stats.esomniture.com
0.0.0.0 e-2dj6wjnygidjskq.stats.esomniture.com
0.0.0.0 e-2dj6wjnyqkajabp.stats.esomniture.com
0.0.0.0 e-n.y-1shz2prbmdj6wvny-1sez2pra2dj6wjmyepdzadpwudj6x9ny-1seq-2-2.stats.esomniture.com
0.0.0.0 e-ny.a-1shz2prbmdj6wvny-1sez2pra2dj6wjny-1jcpgbowsdj6x9ny-1seq-2-2.stats.esomniture.com
0.0.0.0 e.crashlytics.com
0.0.0.0 easy-web-stats.com
0.0.0.0 ecestats.theglobeandmail.com
0.0.0.0 economisttestcollect.insightfirst.com
0.0.0.0 eds.ca.matchbox.maruhub.com
0.0.0.0 email.positionly.com
0.0.0.0 emea.rel.msn.com
0.0.0.0 engine.cmmeglobal.com
0.0.0.0 enoratraffic.com
0.0.0.0 environmentalgraffiti.uk.intellitxt.com
0.0.0.0 es.optimost.com
0.0.0.0 eu-track.inside-graph.com
0.0.0.0 eus.rubiconproject.com
0.0.0.0 exch.quantserve.com
0.0.0.0 extremereach.com
0.0.0.0 eztrck.com
0.0.0.0 fastcounter.com
0.0.0.0 fastcounter.linkexchange.net
0.0.0.0 fastcounter.linkexchange.nl
0.0.0.0 fastlane.rubiconproject.com
0.0.0.0 fastwebcounter.com
0.0.0.0 fdbdo.com
0.0.0.0 fi.sitestat.com
0.0.0.0 firebaselogging.googleapis.com
0.0.0.0 fl01.ct2.comclick.com
0.0.0.0 flixprice.com
0.0.0.0 flury-ycpi.gycpi.b.yahoodns.net
0.0.0.0 flycast.com
0.0.0.0 formalyzer.com
0.0.0.0 foxcounter.com
0.0.0.0 free.xxxcounter.com
0.0.0.0 freeinvisiblecounters.com
0.0.0.0 freerapid.fr
0.0.0.0 freestats.com
0.0.0.0 freewebcounter.com
0.0.0.0 fs10.fusestats.com
0.0.0.0 ft2.autonomycloud.com
0.0.0.0 gameanalysis.appcpi.net
0.0.0.0 gapl.hit.gemius.pl
0.0.0.0 gator.com
0.0.0.0 gbr-7stars-tracking.adalyser.com
0.0.0.0 gbr-carat-tracking.adalyser.com
0.0.0.0 gbr-mbww-tracking.adalyser.com
0.0.0.0 gbr-smv-tracking.adalyser.com
0.0.0.0 gbr-tbh-tracking.adalyser.com
0.0.0.0 gcounter.hosting4u.net
0.0.0.0 geocounter.net
0.0.0.0 gj.mmstat.com
0.0.0.0 goldstats.com
0.0.0.0 googfle.com
0.0.0.0 googletagservices.com
0.0.0.0 gostats.com
0.0.0.0 grafix.xxxcounter.com
0.0.0.0 gscounters.us1.gigya.com
0.0.0.0 gslbeacon.lijit.com
0.0.0.0 gtcc1.acecounter.com
0.0.0.0 hbopenbid.pubmatic.com
0.0.0.0 hc2.humanclick.com
0.0.0.0 highscanprotect.com
0.0.0.0 hit-counter.udub.com
0.0.0.0 hit.clickaider.com
0.0.0.0 hit10.hotlog.ru
0.0.0.0 hit2.hotlog.ru
0.0.0.0 hit37.chark.dk
0.0.0.0 hit37.chart.dk
0.0.0.0 hit39.chart.dk
0.0.0.0 hit5.hotlog.ru
0.0.0.0 hit8.hotlog.ru
0.0.0.0 hits.guardian.co.uk
0.0.0.0 hits.webstat.com
0.0.0.0 hst.tradedoubler.com
0.0.0.0 htm.freelogs.com
0.0.0.0 i.kissmetrics.com	# http://www.wired.com/epicenter/2011/07/undeletable-cookie/
0.0.0.0 ic.tynt.com
0.0.0.0 iccee.com
0.0.0.0 id.sputniknews.com
0.0.0.0 idm.hit.gemius.pl
0.0.0.0 ieplugin.com
0.0.0.0 iesnare.co.uk
0.0.0.0 iesnare.com		# See http://www.codingthewheel.com/archives/online-gambling-privacy-iesnare
0.0.0.0 ilead.itrack.it
0.0.0.0 images-aud.freshmeat.net
0.0.0.0 images-aud.slashdot.org
0.0.0.0 images-aud.sourceforge.net
0.0.0.0 images.dailydiscounts.com	# "spam bugs"
0.0.0.0 images1.paycounter.com
0.0.0.0 imp.clickability.com
0.0.0.0 impacts.alliancehub.com # "spam bugs"
0.0.0.0 impch.tradedoubler.com
0.0.0.0 impde.tradedoubler.com
0.0.0.0 impdk.tradedoubler.com
0.0.0.0 impes.tradedoubler.com
0.0.0.0 impfr.tradedoubler.com
0.0.0.0 impgb.tradedoubler.com
0.0.0.0 impie.tradedoubler.com
0.0.0.0 impit.tradedouble.com
0.0.0.0 impit.tradedoubler.com
0.0.0.0 impnl.tradedoubler.com
0.0.0.0 impno.tradedoubler.com
0.0.0.0 imprammp.taboola.com
0.0.0.0 impse.tradedoubler.com
0.0.0.0 in.paycounter.com
0.0.0.0 in.treasuredata.com
0.0.0.0 in.webcounter.cc
0.0.0.0 insightfirst.com
0.0.0.0 insightxe.looksmart.com
0.0.0.0 int.sitestat.com
0.0.0.0 intljs.rmtag.com
0.0.0.0 iovation.co.uk
0.0.0.0 iovation.com
0.0.0.0 iplogger.org
0.0.0.0 iprocollect.realmedia.com
0.0.0.0 istat.biz
0.0.0.0 izarc.fr
0.0.0.0 jdownloader.fr
0.0.0.0 jgoyk.cjt1.net
0.0.0.0 jkearns.freestats.com
0.0.0.0 js.cybermonitor.com
0.0.0.0 js.hs-analytics.net
0.0.0.0 js.revsci.net
0.0.0.0 justtrck.com
0.0.0.0 k.clarity.ms
0.0.0.0 kissmetrics.com
0.0.0.0 kqzyfj.com
0.0.0.0 kt4.kliptracker.com
0.0.0.0 lcprd1.samsungcloudsolution.net
0.0.0.0 lcprd2.samsungcloudsolution.net
0.0.0.0 leadpub.com
0.0.0.0 lin31.metriweb.be
0.0.0.0 linkcounter.com
0.0.0.0 linkcounter.pornosite.com
0.0.0.0 linktrack.bravenet.com
0.0.0.0 listen.audiohook.com
0.0.0.0 loadus.exelator.com
0.0.0.0 loc1.hitsprocessor.com
0.0.0.0 lockerdome.com
0.0.0.0 log.btopenworld.com
0.0.0.0 log999.goo.ne.jp
0.0.0.0 loga.xiti.com
0.0.0.0 logc1.xiti.com
0.0.0.0 logc146.xiti.com
0.0.0.0 logc22.xiti.com
0.0.0.0 logc31.xiti.com
0.0.0.0 logi6.xiti.com
0.0.0.0 logi7.xiti.com
0.0.0.0 logi8.xiti.com
0.0.0.0 logp3.xiti.com
0.0.0.0 logs.eresmas.com
0.0.0.0 logs.eresmas.net
0.0.0.0 logv14.xiti.com
0.0.0.0 logv17.xiti.com
0.0.0.0 logv18.xiti.com
0.0.0.0 logv21.xiti.com
0.0.0.0 logv25.xiti.com
0.0.0.0 logv27.xiti.com
0.0.0.0 logv29.xiti.com
0.0.0.0 logv32.xiti.com
0.0.0.0 logv4.xiti.com
0.0.0.0 lpcloudsvr302.com
0.0.0.0 lycoscollect.realmedia.com
0.0.0.0 m1.nedstatbasic.net
0.0.0.0 m1.webstats4u.com
0.0.0.0 mailcheckisp.biz	# "spam bugs"
0.0.0.0 mailfoogae.appspot.com	# Streak email tracker
0.0.0.0 mailtrack.me
0.0.0.0 marketaff.com
0.0.0.0 mature.xxxcounter.com
0.0.0.0 mbox5.offermatica.com
0.0.0.0 media.superstats.com
0.0.0.0 mediatrack.revenue.net
0.0.0.0 metric.infoworld.com
0.0.0.0 metric.nationalgeographic.com
0.0.0.0 metric.nwsource.com
0.0.0.0 metric.olivegarden.com
0.0.0.0 metric.starz.com
0.0.0.0 metrics.accuweather.com
0.0.0.0 metrics.al.com
0.0.0.0 metrics.att.com
0.0.0.0 metrics.brightcove.com
0.0.0.0 metrics.cbc.ca
0.0.0.0 metrics.cleveland.com
0.0.0.0 metrics.cnn.com
0.0.0.0 metrics.csmonitor.com
0.0.0.0 metrics.ctv.ca
0.0.0.0 metrics.dallasnews.com
0.0.0.0 metrics.elle.com
0.0.0.0 metrics.experts-exchange.com
0.0.0.0 metrics.gap.com
0.0.0.0 metrics.health.com
0.0.0.0 metrics.hrblock.com
0.0.0.0 metrics.ireport.com
0.0.0.0 metrics.kgw.com
0.0.0.0 metrics.ktvb.com
0.0.0.0 metrics.landolakes.com
0.0.0.0 metrics.lhj.com
0.0.0.0 metrics.mlive.com
0.0.0.0 metrics.mysanantonio.com
0.0.0.0 metrics.nba.com
0.0.0.0 metrics.nextgov.com
0.0.0.0 metrics.nfl.com
0.0.0.0 metrics.npr.org
0.0.0.0 metrics.oclc.org
0.0.0.0 metrics.oregonlive.com
0.0.0.0 metrics.philly.com
0.0.0.0 metrics.post-gazette.com
0.0.0.0 metrics.rottentomatoes.com
0.0.0.0 metrics.sephora.com
0.0.0.0 metrics.sun.com
0.0.0.0 metrics.theatlantic.com
0.0.0.0 metrics.thedailybeast.com
0.0.0.0 metrics.thefa.com
0.0.0.0 metrics.thefrisky.com
0.0.0.0 metrics.thenation.com
0.0.0.0 metrics.theweathernetwork.com
0.0.0.0 metrics.tmz.com
0.0.0.0 metrics.toyota.com
0.0.0.0 metrics.tulsaworld.com
0.0.0.0 metrics.washingtonpost.com
0.0.0.0 metrics.whitepages.com
0.0.0.0 metrics.womansday.com
0.0.0.0 metrics.yellowpages.com
0.0.0.0 metrics.yousendit.com
0.0.0.0 mktg.actonsoftware.com
0.0.0.0 mmstat.com
0.0.0.0 mng1.clickalyzer.com
0.0.0.0 mobile.webvisor.com
0.0.0.0 mononoteapp.firebaseio.com
0.0.0.0 monster.gostats.com
0.0.0.0 msn1.com
0.0.0.0 msnm.com
0.0.0.0 mt122.mtree.com
0.0.0.0 mtcount.channeladvisor.com
0.0.0.0 mtrcs.popcap.com
0.0.0.0 murdoog.com
0.0.0.0 mvtracker.com
0.0.0.0 mybbc-analytics.files.bbci.co.uk
0.0.0.0 nedstat.s0.nl
0.0.0.0 net-radar.com
0.0.0.0 nethit-free.nl
0.0.0.0 network.leadpub.com
0.0.0.0 neweggstats.com
0.0.0.0 nextgenstats.com
0.0.0.0 nht-2.extreme-dm.com
0.0.0.0 nl.nedstatbasic.net
0.0.0.0 noticias.life
0.0.0.0 notify.bugsnag.com
0.0.0.0 notify1.brucelead.com
0.0.0.0 o.addthis.com
0.0.0.0 objects.tremormedia.com
0.0.0.0 okcounter.com
0.0.0.0 omniture.theglobeandmail.com
0.0.0.0 omtrdc.net
0.0.0.0 one.123counters.com
0.0.0.0 open.oneplus.net
0.0.0.0 other.xxxcounter.com
0.0.0.0 ourtoolbar.com
0.0.0.0 p.addthis.com
0.0.0.0 p.bm23.com
0.0.0.0 p.reuters.com
0.0.0.0 pa-cd.com
0.0.0.0 passpport.com
0.0.0.0 paycounter.com
0.0.0.0 pei-ads.thesmokingjacket.com
0.0.0.0 pf.tradedoubler.com
0.0.0.0 photobox-tracking.adalyser.com
0.0.0.0 pings.blip.tv
0.0.0.0 pituitosus.com
0.0.0.0 pix02.revsci.net
0.0.0.0 pix03.revsci.net
0.0.0.0 pix04.revsci.net
0.0.0.0 pixel-geo.prfct.co
0.0.0.0 pixel.advertising.com
0.0.0.0 pixel.bilinmedia.net
0.0.0.0 pixel.invitemedia.com
0.0.0.0 pixel.staticworld.net
0.0.0.0 pixel.tapad.com
0.0.0.0 pixel.wp.com
0.0.0.0 pn2.adserver.yahoo.com
0.0.0.0 pointclicktrack.com
0.0.0.0 post.update.fbsbx.com
0.0.0.0 postclick.adcentriconline.com
0.0.0.0 postmedia.us.janrainsso.com
0.0.0.0 precisioncounter.com
0.0.0.0 printmail.biz
0.0.0.0 privacy-policy.truste.com
0.0.0.0 prof.estat.com
0.0.0.0 propeller-tracking.com
0.0.0.0 quantcast584928381.s.moatpixel.com
0.0.0.0 quantserve.com #: Ad Tracking, JavaScript, etc.
0.0.0.0 r1-t.trackedlink.net
0.0.0.0 redshell.io
0.0.0.0 rightmedia.net
0.0.0.0 rightstats.com
0.0.0.0 rmcentre.bigfilmproduction.com
0.0.0.0 rr1.xxxcounter.com
0.0.0.0 rr2.xxxcounter.com
0.0.0.0 rts.pgmediaserve.com
0.0.0.0 rts.phn.doublepimp.com
0.0.0.0 s-39.predictvideo.com
0.0.0.0 s.bl-1.com
0.0.0.0 s.clickability.com
0.0.0.0 s.go-mpulse.net
0.0.0.0 s.update.fbsbx.com 
0.0.0.0 s1-tracking.adalyser.com
0.0.0.0 s1.shinystat.it
0.0.0.0 s10.histats.com
0.0.0.0 s2.statcounter.com
0.0.0.0 s290.mxcdn.net
0.0.0.0 s3.hit.stat.pl
0.0.0.0 s4.histats.com
0.0.0.0 s4.shinystat.com
0.0.0.0 sact.atdmt.com
0.0.0.0 sc-analytics.appspot.com
0.0.0.0 sclk.org
0.0.0.0 scorecardresearch.com
0.0.0.0 scribe.twitter.com
0.0.0.0 scrooge.click10.com
0.0.0.0 scrooge.nbc11.com
0.0.0.0 scrooge.nbc4.com
0.0.0.0 scrooge.nbcsandiego.com
0.0.0.0 scrooge.newsnet5.com
0.0.0.0 scrooge.thedenverchannel.com
0.0.0.0 scrooge.theindychannel.com
0.0.0.0 scrooge.wesh.com
0.0.0.0 scrooge.wnbc.com
0.0.0.0 sdc.rbistats.com
0.0.0.0 sdkapi.netmera.com
0.0.0.0 se.sitestat.com
0.0.0.0 searchadv.com
0.0.0.0 secure-dcr.imrworldwide.com
0.0.0.0 secure-drm.imrworldwide.com
0.0.0.0 secure-gg.imrworldwide.com
0.0.0.0 secure-it.imrworldwide.com
0.0.0.0 secure-us.imrworldwide.com
0.0.0.0 secure.quantserve.com
0.0.0.0 server1.opentracker.net
0.0.0.0 server10.opentracker.net
0.0.0.0 server11.opentracker.net
0.0.0.0 server3.web-stat.com
0.0.0.0 service.bfast.com
0.0.0.0 service.maxymiser.net
0.0.0.0 sessions.bugsnag.com
0.0.0.0 sexcounter.com
0.0.0.0 seznam.hit.gemius.pl
0.0.0.0 showads.pubmatic.com
0.0.0.0 showcount.honest.com
0.0.0.0 sideshow.directtrack.com
0.0.0.0 siteimproveanalytics.com
0.0.0.0 sitestat.com
0.0.0.0 sitestats.tiscali.co.uk
0.0.0.0 smartstats.com
0.0.0.0 smetrics.att.com
0.0.0.0 smetrics.tesco.com
0.0.0.0 smetrics.washingtonpost.com
0.0.0.0 softcore.xxxcounter.com
0.0.0.0 softonic.it
0.0.0.0 solamor.com
0.0.0.0 songbird.fr
0.0.0.0 spinbox.versiontracker.com
0.0.0.0 spklds.com
0.0.0.0 ss.tiscali.it
0.0.0.0 st.sageanalyst.net
0.0.0.0 st1.hit.gemius.pl
0.0.0.0 stags.peer39.net
0.0.0.0 startup.mobile.webvisor.com
0.0.0.0 startup.mobile.yandex.net
0.0.0.0 stat.4u.pl
0.0.0.0 stat.alibaba.com
0.0.0.0 stat.netmonitor.fi
0.0.0.0 stat.onestat.com
0.0.0.0 stat.webmedia.pl
0.0.0.0 stat.www.fi
0.0.0.0 stat.yellowtracker.com
0.0.0.0 stat1.z-stat.com
0.0.0.0 stat3.cybermonitor.com
0.0.0.0 statcounter.com
0.0.0.0 static.audienceinsights.net
0.0.0.0 static.kibboko.com
0.0.0.0 static.smni.com		# Santa Monica - popunders
0.0.0.0 static.trackedweb.net
0.0.0.0 statistics.elsevier.nl
0.0.0.0 statistics.reedbusiness.nl
0.0.0.0 statistics.theonion.com
0.0.0.0 statistik-gallup.net
0.0.0.0 stats.24ways.org
0.0.0.0 stats.absol.co.za
0.0.0.0 stats.adlice.com
0.0.0.0 stats.adotube.com
0.0.0.0 stats.adultswim.com
0.0.0.0 stats.airfarewatchdog.com
0.0.0.0 stats.allliquid.com
0.0.0.0 stats.arrowos.net
0.0.0.0 stats.askmen.com
0.0.0.0 stats.bbc.co.uk
0.0.0.0 stats.becu.org
0.0.0.0 stats.big-boards.com
0.0.0.0 stats.blogoscoop.net
0.0.0.0 stats.buysellads.com
0.0.0.0 stats.cafepress.com
0.0.0.0 stats.canalblog.com
0.0.0.0 stats.cartoonnetwork.com
0.0.0.0 stats.clickability.com
0.0.0.0 stats.concierge.com
0.0.0.0 stats.datahjaelp.net
0.0.0.0 stats.dziennik.pl
0.0.0.0 stats.economist.com
0.0.0.0 stats.epicurious.com
0.0.0.0 stats.fairmont.com
0.0.0.0 stats.fastcompany.com
0.0.0.0 stats.foxcounter.com
0.0.0.0 stats.gamestop.com
0.0.0.0 stats.globesports.com
0.0.0.0 stats.groupninetyfour.com
0.0.0.0 stats.ign.com
0.0.0.0 stats.ilsemedia.nl
0.0.0.0 stats.independent.co.uk
0.0.0.0 stats.investors.com
0.0.0.0 stats.iwebtrack.com
0.0.0.0 stats.jippii.com
0.0.0.0 stats.ladotstats.nl
0.0.0.0 stats.ozguryazilim.com.tr
0.0.0.0 stats.paycounter.com
0.0.0.0 stats.popscreen.com
0.0.0.0 stats.resellerratings.com
0.0.0.0 stats.revenue.net
0.0.0.0 stats.superstats.com
0.0.0.0 stats.telegraph.co.uk
0.0.0.0 stats.thoughtcatalog.com
0.0.0.0 stats.townnews.com
0.0.0.0 stats.ultimate-webservices.com
0.0.0.0 stats.unionleader.com
0.0.0.0 stats.unipi.it
0.0.0.0 stats.vodpod.com
0.0.0.0 stats.wordpress.com
0.0.0.0 stats.wp.com
0.0.0.0 stats.www.ibm.com
0.0.0.0 stats1.clicktracks.com
0.0.0.0 stats1.corusradio.com
0.0.0.0 stats2.clicktracks.com
0.0.0.0 stats2.gourmet.com
0.0.0.0 stats2.newyorker.com
0.0.0.0 stats2.rte.ie
0.0.0.0 stats2.vanityfair.com
0.0.0.0 stats4all.com
0.0.0.0 stats5.lightningcast.com
0.0.0.0 stats6.lightningcast.net
0.0.0.0 statse.webtrendslive.com	# Fortune.com among others
0.0.0.0 stl.p.a1.traceworks.com
0.0.0.0 straighttangerine.cz.cc
0.0.0.0 stratus.campaign-image.com.cn
0.0.0.0 sugoicounter.com
0.0.0.0 superstats.com
0.0.0.0 sync.bfmio.com
0.0.0.0 sync.clickonometrics.pl
0.0.0.0 systweak.com
0.0.0.0 t.senaldos.com
0.0.0.0 t.senaluno.com
0.0.0.0 t.signaletre.com
0.0.0.0 t.signauxdeux.com # Another email opentracker from hubspot
0.0.0.0 t.update.fbsbx.com
0.0.0.0 t.yesware.com
0.0.0.0 tag.crsspxl.com
0.0.0.0 tags.bkrtx.com
0.0.0.0 targetnet.com
0.0.0.0 tates.freestats.com
0.0.0.0 tcookie.usatoday.com
0.0.0.0 tcr.tynt.com		# See http://daringfireball.net/2010/05/tynt_copy_paste_jerks
0.0.0.0 telecharger-openoffice.fr
0.0.0.0 tgpcounter.freethumbnailgalleries.com
0.0.0.0 the-counter.net
0.0.0.0 the.sextracker.com
0.0.0.0 themecounter.com
0.0.0.0 tipsurf.com
0.0.0.0 toolbarpartner.com
0.0.0.0 tools.spylog.ru
0.0.0.0 top.mail.ru
0.0.0.0 topstats.com
0.0.0.0 tour.SweetDiscreet.com
0.0.0.0 tour.xxxblackbook.com
0.0.0.0 tr.adinterax.com
0.0.0.0 track.adform.net
0.0.0.0 track.adrevolver.com
0.0.0.0 track.bannerbridge.net
0.0.0.0 track.brucelead.com
0.0.0.0 track.clearsender.com
0.0.0.0 track.construclique.com
0.0.0.0 track.did-it.com
0.0.0.0 track.dotsly.com
0.0.0.0 track.effiliation.com
0.0.0.0 track.eg-innovations.net
0.0.0.0 track.enviodemails.com
0.0.0.0 track.gaug.es
0.0.0.0 track.homestead.com
0.0.0.0 track.lfstmedia.com
0.0.0.0 track.mdirector.com
0.0.0.0 track.mdrctr.com
0.0.0.0 track.msadcenter.afgz.com
0.0.0.0 track.msadcenter.ajfy.com
0.0.0.0 track.msadcenter.ceio.com
0.0.0.0 track.msadcenter.cxtv.com
0.0.0.0 track.msadcenter.dgt.com
0.0.0.0 track.msadcenter.dxr.com
0.0.0.0 track.msadcenter.emee.com
0.0.0.0 track.msadcenter.eqq.com
0.0.0.0 track.msadcenter.hih.com
0.0.0.0 track.msadcenter.hlh.com
0.0.0.0 track.msadcenter.hnsl.com
0.0.0.0 track.msadcenter.igzr.com
0.0.0.0 track.msadcenter.iuf.com
0.0.0.0 track.msadcenter.iuh.com
0.0.0.0 track.msadcenter.jzz.com
0.0.0.0 track.msadcenter.kfgy.com
0.0.0.0 track.msadcenter.kfz.com
0.0.0.0 track.msadcenter.kkal.com
0.0.0.0 track.msadcenter.kpuo.com
0.0.0.0 track.msadcenter.krt.com
0.0.0.0 track.msadcenter.llu.com
0.0.0.0 track.msadcenter.ltp.com
0.0.0.0 track.msadcenter.lyv.com
0.0.0.0 track.msadcenter.lzwp.com
0.0.0.0 track.msadcenter.mjze.com
0.0.0.0 track.msadcenter.mur.com
0.0.0.0 track.msadcenter.nho.com
0.0.0.0 track.msadcenter.nyfg.com
0.0.0.0 track.msadcenter.oah.com
0.0.0.0 track.msadcenter.pcp.com
0.0.0.0 track.msadcenter.pszn.com
0.0.0.0 track.msadcenter.pwpn.com
0.0.0.0 track.msadcenter.qpz.com
0.0.0.0 track.msadcenter.qsvv.com
0.0.0.0 track.msadcenter.qymv.com
0.0.0.0 track.msadcenter.rfjq.com
0.0.0.0 track.msadcenter.sax.com
0.0.0.0 track.msadcenter.sgq.com
0.0.0.0 track.msadcenter.shy.com
0.0.0.0 track.msadcenter.szc.com
0.0.0.0 track.msadcenter.tnuw.com
0.0.0.0 track.msadcenter.toj.com
0.0.0.0 track.msadcenter.tux.com
0.0.0.0 track.msadcenter.usx.com
0.0.0.0 track.msadcenter.vbug.com
0.0.0.0 track.msadcenter.vcf.com
0.0.0.0 track.msadcenter.vrhe.com
0.0.0.0 track.msadcenter.wdm.com
0.0.0.0 track.msadcenter.wfm.com
0.0.0.0 track.msadcenter.wmd.com
0.0.0.0 track.msadcenter.wup.com
0.0.0.0 track.msadcenter.xda.com
0.0.0.0 track.msadcenter.xpp.com
0.0.0.0 track.msadcenter.xxx.com
0.0.0.0 track.msadcenter.xzwy.com
0.0.0.0 track.msadcenter.ybi.com
0.0.0.0 track.msadcenter.ytbp.com
0.0.0.0 track.msadcenter.zepw.com
0.0.0.0 track.msadcenter.zhv.com
0.0.0.0 track.msadcenter.zlx.com
0.0.0.0 track.msadcenter.zmmr.com
0.0.0.0 track.msadcenter.zul.com
0.0.0.0 track.msadcenter.zvjw.com
0.0.0.0 track.msadcenter.zzv.com
0.0.0.0 track.nifty.com
0.0.0.0 track.omg2.com
0.0.0.0 track.pplnk.com
0.0.0.0 track.publeadmedia.com
0.0.0.0 track.rediff.com
0.0.0.0 track.searchignite.com
0.0.0.0 track.vivid.com
0.0.0.0 track.webgains.com
0.0.0.0 track.xapads.com
0.0.0.0 track.zipalerts.com
0.0.0.0 track.ziprecruiter.com
0.0.0.0 track.zulumarketing.com
0.0.0.0 track12.offersbymail.com
0.0.0.0 tracker.bonnint.net
0.0.0.0 tracker.bt.uol.com.br
0.0.0.0 tracker.cl1.fidelizador.com
0.0.0.0 tracker.clicktrade.com
0.0.0.0 tracker.consumerpackage.net
0.0.0.0 tracker.coopt.com
0.0.0.0 tracker.hitmatic.com
0.0.0.0 tracker.mattel.com
0.0.0.0 tracker.netklix.com
0.0.0.0 tracker.remp.impresa.pt
0.0.0.0 tracker.tradedoubler.com
0.0.0.0 tracker1.leadiya.com
0.0.0.0 tracking-lealcobrancaspremium.p-email.net
0.0.0.0 tracking.10e20.com
0.0.0.0 tracking.3com.com
0.0.0.0 tracking.adalyser.com
0.0.0.0 tracking.adgoon.it
0.0.0.0 tracking.adjug.com
0.0.0.0 tracking.arxibs01.com
0.0.0.0 tracking.drsfostersmith.com
0.0.0.0 tracking.engagedigitalmedia.com
0.0.0.0 tracking.fanbridge.com
0.0.0.0 tracking.foxnews.com
0.0.0.0 tracking.gajmp.com
0.0.0.0 tracking.ibexnetwork.com
0.0.0.0 tracking.ilinkmd.com
0.0.0.0 tracking.imagewebdesign.fr
0.0.0.0 tracking.mailtracker.in
0.0.0.0 tracking.motleyfool.com
0.0.0.0 tracking.murdoog.com
0.0.0.0 tracking.myunidays.com
0.0.0.0 tracking.nesox.com
0.0.0.0 tracking.nmemails.com
0.0.0.0 tracking.oerug.com
0.0.0.0 tracking.pennystockpicks.net
0.0.0.0 tracking.percentmobile.com
0.0.0.0 tracking.publicidees.com
0.0.0.0 tracking.quisma.com
0.0.0.0 tracking.searchmarketing.com
0.0.0.0 tracking.stampready.net
0.0.0.0 tracking.summitmedia.co.uk
0.0.0.0 tracking.trafficjunky.net
0.0.0.0 tracking.trutv.com
0.0.0.0 tracking.vindicosuite.com
0.0.0.0 tracking.yohoads.com
0.0.0.0 trackit.vicotech.com
0.0.0.0 tracksurf.daooda.com
0.0.0.0 tradedoubler.com
0.0.0.0 tradedoubler.sonvideopro.com
0.0.0.0 traffic-stats.streamsolutions.co.uk
0.0.0.0 traffic.spot.im
0.0.0.0 trafficopen.com
0.0.0.0 trax.gamespot.com
0.0.0.0 trc.taboolasyndication.com
0.0.0.0 trcko.com
0.0.0.0 treasuredata.com
0.0.0.0 trk.cachemetracking.com
0.0.0.0 trk.kissmetrics.com
0.0.0.0 trk.securesmrt-dt.com
0.0.0.0 trk.tidaltv.com
0.0.0.0 true-counter.com
0.0.0.0 truehits1.gits.net.th
0.0.0.0 tynt.com
0.0.0.0 u.startup.mobile.webvisor.com
0.0.0.0 u1817.16.spylog.com
0.0.0.0 u3102.47.spylog.com
0.0.0.0 u3305.71.spylog.com
0.0.0.0 u3608.20.spylog.com
0.0.0.0 u4056.56.spylog.com
0.0.0.0 u432.77.spylog.com
0.0.0.0 u4396.79.spylog.com
0.0.0.0 u4443.84.spylog.com
0.0.0.0 u4556.11.spylog.com
0.0.0.0 u5234.87.spylog.com
0.0.0.0 u5234.98.spylog.com
0.0.0.0 u5687.48.spylog.com
0.0.0.0 u574.07.spylog.com
0.0.0.0 u604.41.spylog.com
0.0.0.0 u6762.46.spylog.com
0.0.0.0 u6905.71.spylog.com
0.0.0.0 u7748.16.spylog.com
0.0.0.0 u810.15.spylog.com
0.0.0.0 u920.31.spylog.com
0.0.0.0 u977.40.spylog.com
0.0.0.0 udc.msn.com
0.0.0.0 uip.semasio.net
0.0.0.0 uk.cqcounter.com
0.0.0.0 uk.sitestat.com
0.0.0.0 ultimatecounter.com
0.0.0.0 us.2.cqcounter.com
0.0.0.0 us.cqcounter.com
0.0.0.0 usa.nedstat.net
0.0.0.0 users.maxcluster.net
0.0.0.0 v1.nedstatbasic.net
0.0.0.0 v8.analytics.pinsightmedia.com
0.0.0.0 v8engine.pinsightmedia.com
0.0.0.0 v8push.pinsightmedia.com
0.0.0.0 valueclick.com
0.0.0.0 valueclick.net
0.0.0.0 velocecdn.com
0.0.0.0 video-stats.video.google.com
0.0.0.0 vidstat.taboola.com
0.0.0.0 vidstatb.taboola.com
0.0.0.0 vip.clickzs.com
0.0.0.0 vis.sexlist.com
0.0.0.0 visit.theglobeandmail.com # Visits to theglobeandmail.com
0.0.0.0 vitals.vercel-analytics.com
0.0.0.0 voken.eyereturn.com
0.0.0.0 vs.dmtracker.com
0.0.0.0 vsii.spinbox.net
0.0.0.0 w.nativery.com
0.0.0.0 w1.tcr112.tynt.com
0.0.0.0 warlog.info
0.0.0.0 wau.tynt.com
0.0.0.0 web4.realtracker.com
0.0.0.0 webbug.seatreport.com	# web bugs
0.0.0.0 webcounter.com
0.0.0.0 webcounter.goweb.de
0.0.0.0 webcounter.together.net
0.0.0.0 webtrends.thisis.co.uk
0.0.0.0 whentheyopened.com
0.0.0.0 wt.bankmillennium.pl
0.0.0.0 wtnj.worldnow.com
0.0.0.0 www-stats.unipi.it
0.0.0.0 www.0stats.com
0.0.0.0 www.123count.com
0.0.0.0 www.123counter.superstats.com
0.0.0.0 www.123stat.com
0.0.0.0 www.3dstats.com
0.0.0.0 www.adalyser.com
0.0.0.0 www.addfreecounter.com
0.0.0.0 www.addfreestats.com
0.0.0.0 www.addtoany.com
0.0.0.0 www.ademails.com
0.0.0.0 www.affiliatesuccess.net
0.0.0.0 www.bar.ry2002.02-ry014.snpr.hotmx.hair.zaam.net # In spam
0.0.0.0 www.belstat.nl
0.0.0.0 www.betcounter.com
0.0.0.0 www.bluestreak.com
0.0.0.0 www.buglife.com
0.0.0.0 www.c.thecounter.de
0.0.0.0 www.c1.thecounter.de
0.0.0.0 www.c2.thecounter.de
0.0.0.0 www.cig-arrete.com
0.0.0.0 www.clickclick.com
0.0.0.0 www.clickspring.net	#used by a spyware product called PurityScan
0.0.0.0 www.clixgalore.com
0.0.0.0 www.connectionlead.com
0.0.0.0 www.counter.bloke.com
0.0.0.0 www.counter.superstats.com
0.0.0.0 www.counter1.sextracker.be
0.0.0.0 www.counter10.sextracker.be
0.0.0.0 www.counter11.sextracker.be
0.0.0.0 www.counter12.sextracker.be
0.0.0.0 www.counter13.sextracker.be
0.0.0.0 www.counter14.sextracker.be
0.0.0.0 www.counter15.sextracker.be
0.0.0.0 www.counter16.sextracker.be
0.0.0.0 www.counter2.sextracker.be
0.0.0.0 www.counter3.sextracker.be
0.0.0.0 www.counter4.sextracker.be
0.0.0.0 www.counter4all.com
0.0.0.0 www.counter4all.de
0.0.0.0 www.counter5.sextracker.be
0.0.0.0 www.counter6.sextracker.be
0.0.0.0 www.counter7.sextracker.be
0.0.0.0 www.counter8.sextracker.be
0.0.0.0 www.counter9.sextracker.be
0.0.0.0 www.counterguide.com
0.0.0.0 www.cw.nu
0.0.0.0 www.dpbolvw.net
0.0.0.0 www.dwclick.com
0.0.0.0 www.easycounter.com
0.0.0.0 www.fastcounter.linkexchange.nl
0.0.0.0 www.formalyzer.com
0.0.0.0 www.foxcounter.com
0.0.0.0 www.freestats.com
0.0.0.0 www.fxcounters.com
0.0.0.0 www.gator.com
0.0.0.0 www.hitstats.co.uk
0.0.0.0 www.iccee.com
0.0.0.0 www.iesnare.co.uk
0.0.0.0 www.iesnare.com	# See http://www.codingthewheel.com/archives/online-gambling-privacy-iesnare
0.0.0.0 www.iovation.co.uk
0.0.0.0 www.iovation.com
0.0.0.0 www.jellycounter.com
0.0.0.0 www.kqzyfj.com
0.0.0.0 www.lansrv050.com
0.0.0.0 www.leadpub.com
0.0.0.0 www.linkcounter.com
0.0.0.0 www.megacounter.de
0.0.0.0 www.metareward.com		# web bugs in spam
0.0.0.0 www.mnbasd77.com
0.0.0.0 www.nedstat.com
0.0.0.0 www.nextgenstats.com
0.0.0.0 www.ntsearch.com
0.0.0.0 www.onestat.com
0.0.0.0 www.originalicons.com	# installs IE extension
0.0.0.0 www.paycounter.com
0.0.0.0 www.pointclicktrack.com
0.0.0.0 www.precisioncounter.com
0.0.0.0 www.printmail.biz
0.0.0.0 www.quantserve.com #: Ad Tracking, JavaScript, etc.
0.0.0.0 www.rightmedia.net
0.0.0.0 www.rightstats.com
0.0.0.0 www.searchadv.com
0.0.0.0 www.shockcounter.com
0.0.0.0 www.simplecounter.net
0.0.0.0 www.specificclick.com
0.0.0.0 www.specificpop.com
0.0.0.0 www.spklds.com
0.0.0.0 www.statcount.com
0.0.0.0 www.statcounter.com
0.0.0.0 www.statsession.com
0.0.0.0 www.stattrax.com
0.0.0.0 www.stiffnetwork.com
0.0.0.0 www.the-counter.net
0.0.0.0 www.toolbarcounter.com
0.0.0.0 www.tradedoubler.com
0.0.0.0 www.tradingtactics.win
0.0.0.0 www.trafficmagnet.net # web bugs in spam
0.0.0.0 www.trafic.ro
0.0.0.0 www.trendcounter.com
0.0.0.0 www.true-counter.com
0.0.0.0 www.tynt.com
0.0.0.0 www.ultimatecounter.com
0.0.0.0 www.v61.com
0.0.0.0 www.web-stat.com
0.0.0.0 www.webcounter.com
0.0.0.0 www.webstat.com
0.0.0.0 www.xxxcounter.com
0.0.0.0 www1.addfreestats.com
0.0.0.0 www1.counter.bloke.com
0.0.0.0 www1.tynt.com
0.0.0.0 www2.addfreestats.com
0.0.0.0 www2.counter.bloke.com
0.0.0.0 www2.pagecount.com
0.0.0.0 www3.addfreestats.com
0.0.0.0 www3.click-fr.com
0.0.0.0 www3.counter.bloke.com
0.0.0.0 www4.addfreestats.com
0.0.0.0 www4.counter.bloke.com
0.0.0.0 www5.addfreestats.com
0.0.0.0 www5.counter.bloke.com
0.0.0.0 www6.addfreestats.com
0.0.0.0 www6.click-fr.com
0.0.0.0 www6.counter.bloke.com
0.0.0.0 www7.addfreestats.com
0.0.0.0 www7.counter.bloke.com
0.0.0.0 www8.addfreestats.com
0.0.0.0 www8.counter.bloke.com
0.0.0.0 www9.counter.bloke.com
0.0.0.0 xcnn.com
0.0.0.0 xtrasizeoriginal.com.br
0.0.0.0 xxxcounter.com
0.0.0.0 xyz.freelogs.com
0.0.0.0 zc1.campaign-view.com.cn
0.0.0.0 zc1.maillist-manage.com.cn
0.0.0.0 zz.cqcounter.com
#</spyware-sites>
#<malware-sites>

# sites with known trojans, phishing, or other malware
0.0.0.0 0.nextyourcontent.com
0.0.0.0 00000.uno
0.0.0.0 05tz2e9.com
0.0.0.0 1-bmo-client-login.com
0.0.0.0 1-directshipmtdhlsexpress-order.help
0.0.0.0 10-letter-words.com
0.0.0.0 1001paixnidia.fr
0.0.0.0 105915624.com
0.0.0.0 10tide.com
0.0.0.0 1percent.fr
0.0.0.0 2.maaqkj.com
0.0.0.0 2006mindfreaklike.blogspot.com	# Facebook trojan
0.0.0.0 2023cradep0sit.com
0.0.0.0 20linutes.fr
0.0.0.0 20mlinutes.fr
0.0.0.0 237online.fr
0.0.0.0 247blinds.fr
0.0.0.0 2533542.cc
0.0.0.0 2g312kn32qfy-1323053341.cos.ap-bangkok.myqcloud.com
0.0.0.0 2roueselectrique.fr
0.0.0.0 2x1gratis.com
0.0.0.0 33.merivonview33.cc
0.0.0.0 3mfrances.fr
0.0.0.0 59-106-20-39.r-bl100.sakura.ne.jp
0.0.0.0 602.lazulya.com
0.0.0.0 69fcb79c002e689734cad7411fe0d2e2000.appwrite.network
0.0.0.0 6range.fr
0.0.0.0 6w1.sharedlinkconnect.com
0.0.0.0 75esession.fr
0.0.0.0 7frenchweb.fr
0.0.0.0 7zip.fr
0.0.0.0 8hj500ro4t7.groovepages.com
0.0.0.0 912.lazulya.com
0.0.0.0 a.kaytri.com
0.0.0.0 a.phormlabs.com
0.0.0.0 a.webwise.org
0.0.0.0 a15172379.alturo-server.de
0.0.0.0 aaam.fr
0.0.0.0 aac-lyon.fr
0.0.0.0 aalocine.fr
0.0.0.0 abchina.fr
0.0.0.0 abetterinternet.com
0.0.0.0 abrittel.fr
0.0.0.0 abrutel.fr
0.0.0.0 abruzzoinitaly.co.uk
0.0.0.0 abshop.fr
0.0.0.0 absolutewrite.fr
0.0.0.0 abyssmedia.fr
0.0.0.0 ac-crerteil.fr
0.0.0.0 ac-strasboourg.fr
0.0.0.0 ac-versdailles.fr
0.0.0.0 aca-languedoc.fr
0.0.0.0 acceptlnterac-email-transfer-online-2fasecure.com
0.0.0.0 account-review.com
0.0.0.0 accounts.secure-ua.website
0.0.0.0 accounts.ukr.net.ssl2.in
0.0.0.0 accrogers-overview.com
0.0.0.0 acessoires-electromenager.fr
0.0.0.0 acglgoa.com
0.0.0.0 acmen.fr
0.0.0.0 acnenomor.com
0.0.0.0 acrtsubmissions.com
0.0.0.0 acsentia.fr
0.0.0.0 activateprofile.info
0.0.0.0 activebeat.fr
0.0.0.0 aculo.fr
0.0.0.0 ad.g-content.bid
0.0.0.0 adblock.fr
0.0.0.0 addthis.fr
0.0.0.0 adebooks.fr
0.0.0.0 adef-residences.fr
0.0.0.0 adexchangetracker.com
0.0.0.0 adn.plxnt.com
0.0.0.0 adolfoqsalondmacha.standard.us-east-1.oortstorages.com
0.0.0.0 adquantum.fr
0.0.0.0 adshufffle.com
0.0.0.0 adwitty.com
0.0.0.0 aesthetist.org
0.0.0.0 africancasting.fr
0.0.0.0 agelocer.fr
0.0.0.0 agla.fr
0.0.0.0 agroeconom.kz
0.0.0.0 aide-pac-national.fr
0.0.0.0 ajouny.com
0.0.0.0 aktiv-mit-ms.fr
0.0.0.0 ale-gratka.pl
0.0.0.0 alert1dhlshipment.info
0.0.0.0 alexyu.fr
0.0.0.0 aliecpress.fr
0.0.0.0 aliexress.fr
0.0.0.0 aljamaa.fr
0.0.0.0 allhqpics.com				# Facebook trojan
0.0.0.0 allkpop.fr
0.0.0.0 allocnie.fr
0.0.0.0 allogarages.fr
0.0.0.0 allomine.fr
0.0.0.0 almaria.fr
0.0.0.0 alocdn.com
0.0.0.0 alojamientocentroleon.es
0.0.0.0 alphardgolf.fr
0.0.0.0 alphlauren.fr
0.0.0.0 alt-mk-sports.com
0.0.0.0 alzy.fr
0.0.0.0 amayaresorts.fr
0.0.0.0 americankitchen.fr
0.0.0.0 amocoeastco.com
0.0.0.0 ams1.ib.adnxs.com
0.0.0.0 ams2.rumourrubicon.com
0.0.0.0 ancree.fr
0.0.0.0 android.bigresource.com
0.0.0.0 androiddev.orkitra.com
0.0.0.0 andromedawallet.com
0.0.0.0 aneralflas.club
0.0.0.0 angers-radioloagie.fr
0.0.0.0 anian1.weebly.com
0.0.0.0 anouslab.cmail20.com
0.0.0.0 answerhub.com
0.0.0.0 antispywareexpert.com
0.0.0.0 antivirus-scanner.com
0.0.0.0 antoinettepoisson.fr
0.0.0.0 aosldz.com
0.0.0.0 apconsultantgroup.com
0.0.0.0 apel3.fr
0.0.0.0 api.inwemo.com
0.0.0.0 apoutong.com
0.0.0.0 app2.letslowbefast.life
0.0.0.0 appale.fr
0.0.0.0 appleld.apple.com.t5j2kdkc88dd2m423-verif.info
0.0.0.0 applez.fr
0.0.0.0 appraw.fr
0.0.0.0 apps-500star.com
0.0.0.0 apsu.fr
0.0.0.0 arbrever.fr
0.0.0.0 archeives-ouvertes.fr
0.0.0.0 archi-facile.fr
0.0.0.0 arcticblast.sa.com
0.0.0.0 area52.fr
0.0.0.0 aresweb.fr
0.0.0.0 argenta.fr
0.0.0.0 armsart.com
0.0.0.0 arrayshift.com
0.0.0.0 arteradio.fr
0.0.0.0 artissanat.fr
0.0.0.0 asd.is
0.0.0.0 asemblee-nationale.fr
0.0.0.0 asentia.fr
0.0.0.0 ashleyfires.fr
0.0.0.0 asianread.com
0.0.0.0 ask-coder.com
0.0.0.0 ask.webatall.com
0.0.0.0 askbot.com
0.0.0.0 askto.net
0.0.0.0 askubal.fr
0.0.0.0 assistcom.fr
0.0.0.0 assodigitale.fr
0.0.0.0 ast-grouope.fr
0.0.0.0 athenea.fr
0.0.0.0 atlanticon.fr
0.0.0.0 atlanticos.fr
0.0.0.0 atlasformrn.fr
0.0.0.0 atlauncher.fr
0.0.0.0 audacity.de
0.0.0.0 audacity.es
0.0.0.0 audacity.fr
0.0.0.0 audacity.it
0.0.0.0 audacity.pl
0.0.0.0 augi.fr
0.0.0.0 auirbnb.fr
0.0.0.0 auth0.vernovls.com
0.0.0.0 autheasywinformationreq.com
0.0.0.0 authscotia-signinscotia.com
0.0.0.0 auto-entrereneur.fr
0.0.0.0 autohipnose.com
0.0.0.0 automedik.fr
0.0.0.0 automobile-magasine.fr
0.0.0.0 autonewsinfo.fr
0.0.0.0 avatar.supearou.in
0.0.0.0 avilis.fr
0.0.0.0 avndrealouer.fr
0.0.0.0 avosstart.fr
0.0.0.0 avsvmcloud.com
0.0.0.0 avtec.fr
0.0.0.0 awuam.com
0.0.0.0 aymxv.com
0.0.0.0 azureus.es
0.0.0.0 b.doloaqywbvq.ru
0.0.0.0 b.webwise.org
0.0.0.0 b2b-update.appwrite.network
0.0.0.0 b8bsb.55002298.click
0.0.0.0 babouche-maroc.fr
0.0.0.0 bac-reunion.fr
0.0.0.0 backlusjumpdur.club
0.0.0.0 bactif.fr
0.0.0.0 badsender.fr
0.0.0.0 bagaboo-bags.fr
0.0.0.0 bagagescabine.fr
0.0.0.0 bannerbuzz.fr
0.0.0.0 bannersnack.fr
0.0.0.0 baselabo.heteml.net
0.0.0.0 baxtel.fr
0.0.0.0 bayyinah.fr
0.0.0.0 bbcode.fr
0.0.0.0 bdsm-fantaisie.fr
0.0.0.0 beauten.fr
0.0.0.0 beautylicieuse.fr
0.0.0.0 beautytemple.fr
0.0.0.0 beboncoin.fr
0.0.0.0 belambre.fr
0.0.0.0 bellybuttons.sa.com
0.0.0.0 benchmarkemail.fr
0.0.0.0 benefitsaccountreport.es
0.0.0.0 benefitsgov.info
0.0.0.0 benefitsorganic.com
0.0.0.0 bergeresdefrance.fr
0.0.0.0 berlinprotocols.shop
0.0.0.0 besacon.fr
0.0.0.0 bestblackhatforum.fr
0.0.0.0 bestoftoday.click
0.0.0.0 bestreview.site
0.0.0.0 bestwebpillplace.com
0.0.0.0 bestwesterne.fr
0.0.0.0 bestwing.org
0.0.0.0 bevilla.fr
0.0.0.0 bgre.kozow.com
0.0.0.0 bhyuu.com
0.0.0.0 biaritz.fr
0.0.0.0 biaugerme.fr
0.0.0.0 bighow.net
0.0.0.0 bioware.fr
0.0.0.0 biserka.xyz
0.0.0.0 bitcoin-upappl.com
0.0.0.0 bitcoinexchangemonero.com
0.0.0.0 bitcoinplus.com
0.0.0.0 bitsoin.fr
0.0.0.0 biucosmetics.fr
0.0.0.0 bizlawpoint.com
0.0.0.0 blablacam.fr
0.0.0.0 blackhat.be
0.0.0.0 bladdergenics.shop
0.0.0.0 blender3d.fr
0.0.0.0 blog.ivup.cn
0.0.0.0 bluepartner.fr
0.0.0.0 bluescreenalert.com
0.0.0.0 blw4-1.com
0.0.0.0 bnvxcfhdgf.blogspot.com.es
0.0.0.0 boardgamearena.fr
0.0.0.0 bobgear.fr
0.0.0.0 bodyfitness-epernon.fr
0.0.0.0 bodyhousse.fr
0.0.0.0 boneville.fr
0.0.0.0 bopstermedia56.com
0.0.0.0 bornprix.fr
0.0.0.0 bougyuestelecom.fr
0.0.0.0 boujois.fr
0.0.0.0 boursidirect.fr
0.0.0.0 bousedirect.fr
0.0.0.0 boutique-papillon.fr
0.0.0.0 bouygiestelecom.fr
0.0.0.0 bowlinvit.site
0.0.0.0 bpong.fr
0.0.0.0 bracabrac.fr
0.0.0.0 brainns.sa.com
0.0.0.0 breg.fr
0.0.0.0 breitbart.fr
0.0.0.0 breizh-ile.fr
0.0.0.0 bricolage-avec-robert.fr
0.0.0.0 bricolo-blogger.fr
0.0.0.0 brides4you.sa.com
0.0.0.0 bridgebase.fr
0.0.0.0 bridgemanstt.com
0.0.0.0 brightonclick.com
0.0.0.0 brokking.fr
0.0.0.0 brostyles.fr
0.0.0.0 brunga.at	# Facebook phishing attempt
0.0.0.0 bsugars.sa.com
0.0.0.0 bt.webwise.org
0.0.0.0 build.waikatocycleways.info
0.0.0.0 bulletwhiskey.sa.com
0.0.0.0 bundesanzeiger.fr
0.0.0.0 burley.fr
0.0.0.0 buyagift.fr
0.0.0.0 byowner.fr
0.0.0.0 c-martinique.fr
0.0.0.0 c-piscine.fr
0.0.0.0 c-rennes.fr
0.0.0.0 c.webwise.org
0.0.0.0 c0nforama.fr
0.0.0.0 c1i.su
0.0.0.0 ca-biepicardie.fr
0.0.0.0 ca-briepcardie.fr
0.0.0.0 ca-cantreloire.fr
0.0.0.0 ca-centtreloire.fr
0.0.0.0 ca-czntrefrance.fr
0.0.0.0 ca-languedo.fr
0.0.0.0 ca-nm.fr
0.0.0.0 ca-pac.fr
0.0.0.0 ca-touloue31.fr
0.0.0.0 ca-vb.fr
0.0.0.0 cablyshaw.com
0.0.0.0 caeauxfolies.fr
0.0.0.0 cafe-express.fr
0.0.0.0 cafecoc.com
0.0.0.0 cafhanoi.dorps.info
0.0.0.0 cafj.fr
0.0.0.0 cafranchecomte.fr
0.0.0.0 caisse-apargne.fr
0.0.0.0 callfor-articles.com
0.0.0.0 callfor-submissions.com
0.0.0.0 camaieur.fr
0.0.0.0 cambonanza.com
0.0.0.0 campaign.budgethyve.com
0.0.0.0 camping-la-bien-assise.fr
0.0.0.0 camping-oreedelocean.fr
0.0.0.0 camping-pinede.fr
0.0.0.0 campinglespins.fr
0.0.0.0 camplace.fr
0.0.0.0 campus-forprof.fr
0.0.0.0 canada.postcanadakxcif.top
0.0.0.0 canadapost-delivery-reshedule.com
0.0.0.0 canadapost-paymentservice.com
0.0.0.0 canadapost-postescanada.uwpackege.top
0.0.0.0 canadapost.helpdag.top
0.0.0.0 canadapost.postescanadad.xyz
0.0.0.0 canadapostarticle.com
0.0.0.0 canadaposteb.eu.cc
0.0.0.0 capital-invest-can.cropvita.sbs
0.0.0.0 capitalregionusa.fr
0.0.0.0 capostdelivery.com
0.0.0.0 carac-terres.fr
0.0.0.0 carrfefour.fr
0.0.0.0 cartoonnetworkarabic.fr
0.0.0.0 casmundo.fr
0.0.0.0 castelli-cycling.fr
0.0.0.0 castortama.fr
0.0.0.0 cbcare.fr
0.0.0.0 cbt5.sdalfurqanjember.sch.id
0.0.0.0 ccieurope.fr
0.0.0.0 ccs.north-kazakhstan.su
0.0.0.0 ccudl.com
0.0.0.0 cd-elec.fr
0.0.0.0 cd-sport.fr
0.0.0.0 cdn.jquery-uim.download
0.0.0.0 ce-marketing.fr
0.0.0.0 cebue.magmafurnace.top
0.0.0.0 celestia.es
0.0.0.0 celestia.fr
0.0.0.0 cellu-clean.fr
0.0.0.0 cengolio.fr
0.0.0.0 certifiedwinners.today
0.0.0.0 cesdeals.fr
0.0.0.0 cfjln.comfortykive.xyz
0.0.0.0 cguardai.com
0.0.0.0 chaisesprivee.fr
0.0.0.0 chaliehebdo.fr
0.0.0.0 challeges.fr
0.0.0.0 changduk26.com			# Facebook trojan
0.0.0.0 chatroll.fr
0.0.0.0 chch.fr
0.0.0.0 checkfreevideos.net
0.0.0.0 checkout360now.net
0.0.0.0 chelick.net				# Facebook trojan
0.0.0.0 chienvoyageur.fr
0.0.0.0 choisimoncode.fr
0.0.0.0 chrliehebdo.fr
0.0.0.0 chu-bordeau.fr
0.0.0.0 chu-morlaix.fr
0.0.0.0 cibc-oniinecibc.com
0.0.0.0 cibconline-login.com
0.0.0.0 cic-epargnrsalariale.fr
0.0.0.0 cicontents.biz
0.0.0.0 cifw.fr
0.0.0.0 ciiycode.com
0.0.0.0 cinediagonal.fr
0.0.0.0 cinemasouslesetoiles.fr
0.0.0.0 cinforama.fr
0.0.0.0 cioco-froll.com
0.0.0.0 circuitsdelegende.fr
0.0.0.0 claclasse.fr
0.0.0.0 claimcostcobenefits.com
0.0.0.0 clean-mobilephone.com
0.0.0.0 cleanchain.net
0.0.0.0 cleanmobilephone.com
0.0.0.0 click.get-answers-fast.com
0.0.0.0 clicktripz.com
0.0.0.0 climate-actionpayment.com
0.0.0.0 clonezilla.es
0.0.0.0 clonezilla.fr
0.0.0.0 cloudalert.shop
0.0.0.0 cltxhot.fun
0.0.0.0 cm076410.tw1.ru
0.0.0.0 cmcre.fr
0.0.0.0 cndpt.fr
0.0.0.0 cnhv.co
0.0.0.0 cnnews.fr
0.0.0.0 cnrfms.pro
0.0.0.0 cnt-jrs.com
0.0.0.0 cnt.statistic.date
0.0.0.0 codebiogblog.com
0.0.0.0 codeexplain.com
0.0.0.0 codegur.com
0.0.0.0 codelogic.fr
0.0.0.0 codeotel.com
0.0.0.0 coderexception.com
0.0.0.0 coin-have.com
0.0.0.0 coin-hive.com
0.0.0.0 coinerra.com
0.0.0.0 coinhive.com
0.0.0.0 coinimp.com
0.0.0.0 coldcertainchannel.com
0.0.0.0 coldpacific.com
0.0.0.0 colisismo.fr
0.0.0.0 collagenforwellnessandbeauty.com
0.0.0.0 collline.fr
0.0.0.0 coloradosoccerbuddies.acemlna.com
0.0.0.0 colssimo.fr
0.0.0.0 comfortykive.xyz
0.0.0.0 comineeis.vu
0.0.0.0 commax.fr
0.0.0.0 commdev.fr
0.0.0.0 compe-nickel.fr
0.0.0.0 completelove22.cc
0.0.0.0 compufixshop.com
0.0.0.0 comsss-56.com
0.0.0.0 con-trnroayl.online
0.0.0.0 conduit.com
0.0.0.0 confg.fr
0.0.0.0 confirm1509account4715.com
0.0.0.0 conseil-coaching-jardinage.fr
0.0.0.0 conseildentaire.fr
0.0.0.0 consorsbank.fr
0.0.0.0 consumerspanel.frge.io
0.0.0.0 cookeatshare.fr
0.0.0.0 coordino.com
0.0.0.0 cosi.iprive.net
0.0.0.0 cosmopolian.fr
0.0.0.0 cosmopolita.fr
0.0.0.0 costco-rewardsaccount1.com
0.0.0.0 costorama.fr
0.0.0.0 countrystore.fr
0.0.0.0 coupondio.fr
0.0.0.0 cp.forest-host.cc
0.0.0.0 cp.liferan.pro
0.0.0.0 cplelangues.fr
0.0.0.0 cra-arc-gc-ca.noads.biz
0.0.0.0 cra-documents.ca
0.0.0.0 cra-etransfer.online
0.0.0.0 crarefundsreview.com
0.0.0.0 crdp-strsbourg.fr
0.0.0.0 creativlonk.fr
0.0.0.0 creditmuteuel.fr
0.0.0.0 creditmutuel-epargesalariale.fr
0.0.0.0 criticals.sa.com
0.0.0.0 criticaltt.shop
0.0.0.0 critiquefilm.fr
0.0.0.0 croissieres.fr
0.0.0.0 crouslyon.fr
0.0.0.0 crpo.fr
0.0.0.0 crrect.sa.com
0.0.0.0 crypto-loot.com
0.0.0.0 ctmsapp.com
0.0.0.0 ctziogas.gr
0.0.0.0 cuder.fr
0.0.0.0 cullligan.fr
0.0.0.0 culturalfoundation.fr
0.0.0.0 cun.accountcare.cfd
0.0.0.0 curejoint.sa.com
0.0.0.0 cures.ru.com
0.0.0.0 customsoftwaredeveloper.com.au
0.0.0.0 cutesaucepuppy.com
0.0.0.0 cyber20.com
0.0.0.0 cyberpanel.fr
0.0.0.0 cyfe.fr
0.0.0.0 czr.customzonereview.com
0.0.0.0 d.phormlabs.com
0.0.0.0 d2o9ozfswytaqz.cloudfront.net
0.0.0.0 dahenie.accsvc.cfd
0.0.0.0 dailygame.fr
0.0.0.0 dailynewstonight.com
0.0.0.0 dartry.fr
0.0.0.0 data-ng28.com
0.0.0.0 datajobs.fr
0.0.0.0 davidhuynh.fr
0.0.0.0 db-z.fr
0.0.0.0 dbios.org
0.0.0.0 dd.l146.com
0.0.0.0 dealerconnection.fr
0.0.0.0 dealiveroo.fr
0.0.0.0 declarateenquiebra.cl
0.0.0.0 decompiler.fr
0.0.0.0 dejoyaux.fr
0.0.0.0 delamaisn.fr
0.0.0.0 delivery-change-reschedule6128.com
0.0.0.0 deloitteca.com
0.0.0.0 delphix.fr
0.0.0.0 deltarviews.bond
0.0.0.0 dentalfix.shop
0.0.0.0 denx.fr
0.0.0.0 department06.fr
0.0.0.0 deposit-cra2023.com
0.0.0.0 deposit-et-1interac.help
0.0.0.0 depositphotos.fr
0.0.0.0 depottool.bond
0.0.0.0 desertdreamtour.com
0.0.0.0 desfans.sportgroup.cl
0.0.0.0 details-update.com
0.0.0.0 devguardmap.org
0.0.0.0 dewinci.fr
0.0.0.0 dfnac.fr
0.0.0.0 dhauzja511.co.cc
0.0.0.0 dhl-closeariu.kaixuankio.cn
0.0.0.0 dhlmyorder82662-info-can.com
0.0.0.0 dig
0.0.0.0 digiclk.com
0.0.0.0 digicub.fr
0.0.0.0 digipote.fr
0.0.0.0 digipsote.fr
0.0.0.0 digitfoto.fr
0.0.0.0 din.prr.mybluehost.me
0.0.0.0 diomedia.fr
0.0.0.0 dirtmountainbike.fr
0.0.0.0 disneyholidays.fr
0.0.0.0 dldyjy.com
0.0.0.0 dns2.net1.it
0.0.0.0 dnythgt.com
0.0.0.0 docs.ukr.net.ssl2.in
0.0.0.0 dogry.fr
0.0.0.0 dogtrace.fr
0.0.0.0 domaine-voyance.fr
0.0.0.0 donforama.fr
0.0.0.0 dontacos.fr
0.0.0.0 dooror.com
0.0.0.0 doors.co.kr
0.0.0.0 dpflyingoncs.top
0.0.0.0 dragonfly-express.duckdns.org
0.0.0.0 dsbzk.comfortykive.xyz
0.0.0.0 dsfdsfxcfddsf.blob.core.windows.net
0.0.0.0 dtcc.fr
0.0.0.0 dveug.comfortykive.xyz
0.0.0.0 e-kern.fr
0.0.0.0 e-lords.fr
0.0.0.0 e-trn-incm.com
0.0.0.0 eaboiretes.com
0.0.0.0 easewave.digital
0.0.0.0 east.05tz2e9.com
0.0.0.0 easyflier.fr
0.0.0.0 easytic.fr
0.0.0.0 eauchan.fr
0.0.0.0 ecantal.fr
0.0.0.0 ecirque.fr
0.0.0.0 eckosport.fr
0.0.0.0 ecommercegoodies.com
0.0.0.0 edecideur.fr
0.0.0.0 edisk.ukr.net.ssl2.in
0.0.0.0 edmo.fr
0.0.0.0 education-securiter-routiere.fr
0.0.0.0 eeude.comfortykive.xyz
0.0.0.0 efreedom.net
0.0.0.0 ekomerco.fr
0.0.0.0 elboncoin.fr
0.0.0.0 electroslm.shop
0.0.0.0 elyses.fr
0.0.0.0 emagicone.fr
0.0.0.0 email.headers.digital
0.0.0.0 emperors.bunkerhilltradingco.info
0.0.0.0 emplpoi-store.fr
0.0.0.0 en.btc-trader-app.club
0.0.0.0 en.likefever.org			# Facebook trojan
0.0.0.0 enablement.joethecpa.info
0.0.0.0 enalytics.fr
0.0.0.0 endicia.fr
0.0.0.0 englishcentral.fr
0.0.0.0 entek.fr
0.0.0.0 entuduc.fr
0.0.0.0 eol1.egyptonline.com
0.0.0.0 eondershare.fr
0.0.0.0 equitaine.fr
0.0.0.0 erobot-pisicne.fr
0.0.0.0 erogames.fr
0.0.0.0 ertbaudet.fr
0.0.0.0 escplus.fr
0.0.0.0 eslprologmvp.com
0.0.0.0 eslprotourmvp.com
0.0.0.0 esmoutonsenrages.fr
0.0.0.0 espaceagazines.fr
0.0.0.0 espub.fr
0.0.0.0 et-1nt3rc.com
0.0.0.0 et-interac.etransfers1.com
0.0.0.0 et-mycostcorewards.info
0.0.0.0 etdeposit-interac.com
0.0.0.0 etransfer-23799.com
0.0.0.0 etribunaldunet.fr
0.0.0.0 etronella.bizneswarszawa.info
0.0.0.0 euriosport.fr
0.0.0.0 europr1.fr
0.0.0.0 eurospoprt.fr
0.0.0.0 eurostreaming.myproxy.help
0.0.0.0 eurostreaming.superproxy.lol
0.0.0.0 eviebot.fr
0.0.0.0 ewea.fr
0.0.0.0 exasked.com
0.0.0.0 exchangemarket.fr
0.0.0.0 executiveannualreward.im
0.0.0.0 exelformation.fr
0.0.0.0 exepdia.fr
0.0.0.0 exotic-wax.surge.sh
0.0.0.0 exparint.fr
0.0.0.0 expertland.net
0.0.0.0 expired-antiviruses.com
0.0.0.0 extrashop.fr
0.0.0.0 f-voyance.fr
0.0.0.0 f05098.privacy4browsers.com
0.0.0.0 f18085.privacy4browsers.com
0.0.0.0 fabhabitat.fr
0.0.0.0 facebbook.fr
0.0.0.0 facebook-repto1040s2.ahlamountada.com
0.0.0.0 facebookj.fr
0.0.0.0 faceboook-replyei0ki.montadalitihad.com
0.0.0.0 facemail.com
0.0.0.0 factorship.wcyrkdd.cn
0.0.0.0 fafarge.fr
0.0.0.0 faggotry.com
0.0.0.0 falkcoppercookware.fr
0.0.0.0 fanniemae.fr
0.0.0.0 fasola.fr
0.0.0.0 fclb.fr
0.0.0.0 fdoverbilled.com
0.0.0.0 fedex-rescheduel-date.com
0.0.0.0 fedex-rescheduel-delivery-date.com
0.0.0.0 fedgroceryrebate.com
0.0.0.0 fedi.6751242.cc
0.0.0.0 feedbackexplorer.com
0.0.0.0 femidignity.org
0.0.0.0 fengyixin.com
0.0.0.0 ferreirateixeira.adv.br
0.0.0.0 festicolor.fr
0.0.0.0 ffesm.fr
0.0.0.0 fichier-pdfr.fr
0.0.0.0 fido-team.com
0.0.0.0 figato.fr
0.0.0.0 files.ukr.net.ssl2.in
0.0.0.0 filezilla.fr
0.0.0.0 filosvybfimpsv.ru.gg
0.0.0.0 filter.mediacpc.com
0.0.0.0 filthycricket.com
0.0.0.0 find-your-profithere11.com
0.0.0.0 finessaweight.shop
0.0.0.0 firefox-updater.com
0.0.0.0 firstrowsports.fr
0.0.0.0 fit4form.fr
0.0.0.0 flashrasultats.fr
0.0.0.0 flexfone.fr
0.0.0.0 flightams.fr
0.0.0.0 fnactickets.fr
0.0.0.0 foiegras-groliere.fr
0.0.0.0 foreverprintco.com
0.0.0.0 formumactif.fr
0.0.0.0 fortress.anhcs.info
0.0.0.0 forumdread.com
0.0.0.0 forurm-candaulisme.fr
0.0.0.0 fourtuneo.fr
0.0.0.0 foutuneo.fr
0.0.0.0 foxoptic.fr
0.0.0.0 fqint.comfortykive.xyz
0.0.0.0 francebootball.fr
0.0.0.0 francelbleu.fr
0.0.0.0 frecnhweb.fr
0.0.0.0 free-box.fr
0.0.0.0 free.internetspeedtracker.com
0.0.0.0 free.propdfconverter.com
0.0.0.0 free.videodownloadconverter.com
0.0.0.0 freebos.fr
0.0.0.0 freecontent.bid
0.0.0.0 freedailydownload.com
0.0.0.0 freedon.fr
0.0.0.0 freelanced.fr
0.0.0.0 fref.fr
0.0.0.0 freighttools.live
0.0.0.0 frenchbweb.fr
0.0.0.0 frenesies.fr
0.0.0.0 fresh.sa.com
0.0.0.0 freshzz00.duckdns.org
0.0.0.0 frnafinance.fr
0.0.0.0 froancefootball.fr
0.0.0.0 froling.bee.pl
0.0.0.0 fromru.su
0.0.0.0 ftdownload.com
0.0.0.0 fu.golikeus.net			# Facebook trojan
0.0.0.0 funnysciencediscounts1.blogspot.com
0.0.0.0 fuzzy-afternoon.surge.sh
0.0.0.0 fwbdndyikloaxb68duujcfyudy.appwrite.network
0.0.0.0 g2play.fr
0.0.0.0 gabrielahlavack.samcart.com
0.0.0.0 gadgetsytecnologia.com
0.0.0.0 gagy.fr
0.0.0.0 gaiaherbs.fr
0.0.0.0 gambero3.cs.tin.it
0.0.0.0 game321.fr
0.0.0.0 gamejolt.fr
0.0.0.0 gamelights.ru
0.0.0.0 gamonic.fr
0.0.0.0 garde-d-enfants-ooreka.fr
0.0.0.0 gasasthe.freehostia.com
0.0.0.0 gautmont.fr
0.0.0.0 gazia.fr
0.0.0.0 gcn-1nterc.com
0.0.0.0 gdudh473-chersfeye483.landmarksfeed.su
0.0.0.0 gekowex.com
0.0.0.0 genuinepeople.cc
0.0.0.0 geolantis.fr
0.0.0.0 geopostcodes.fr
0.0.0.0 get-answers-fast.com
0.0.0.0 get24update.link4all.info
0.0.0.0 getdispadsshop.com
0.0.0.0 getnexuscard.com
0.0.0.0 gglcash4u.info	# twitter worm
0.0.0.0 gifii.fr
0.0.0.0 giftcard.cx
0.0.0.0 gigaonclick.com
0.0.0.0 gimp.es
0.0.0.0 girlownedbypolicelike.blogspot.com	# Facebook trojan
0.0.0.0 giulli.fr
0.0.0.0 glassjaw.fr
0.0.0.0 globaldrugsurvey.fr
0.0.0.0 glucont.shop
0.0.0.0 gmailapcq6.eblink5.com
0.0.0.0 go.deliverymodo.com
0.0.0.0 goggle.com
0.0.0.0 gondesss.albarikfabric.com
0.0.0.0 goobbe.com
0.0.0.0 goodreader.fr
0.0.0.0 goolgueule.fr
0.0.0.0 gorange.fr
0.0.0.0 gotinder.fr
0.0.0.0 gparted.fr
0.0.0.0 grandtheftwiki.fr
0.0.0.0 greatarcadehits.com
0.0.0.0 greeninst.com
0.0.0.0 greenshot.fr
0.0.0.0 greffetc-paris.fr
0.0.0.0 grooveshark.fr
0.0.0.0 grossiste3d.fr
0.0.0.0 groupeauto.fr
0.0.0.0 groupom.fr
0.0.0.0 growhairs.shop
0.0.0.0 gstscra.com
0.0.0.0 gtamoding.fr
0.0.0.0 gtiruto.shop
0.0.0.0 guangjiemiao.com
0.0.0.0 guidelon.fr
0.0.0.0 guiltygear.fr
0.0.0.0 guthealth.sa.com
0.0.0.0 gv-1nt3rc.com
0.0.0.0 gwene.com.slackware.alien.blog
0.0.0.0 gwklaser.fr
0.0.0.0 gyros.es
0.0.0.0 h9tkd.rdtk.io
0.0.0.0 habboss.fr
0.0.0.0 hackconsole.fr
0.0.0.0 hackerz.ir
0.0.0.0 hajoopteg.com
0.0.0.0 hakerzy.net
0.0.0.0 hakuba.janis.or.jp
0.0.0.0 handbrake.es
0.0.0.0 happyfresh.fr
0.0.0.0 hartamann.fr
0.0.0.0 hashing.win
0.0.0.0 hatdfg-rhgreh684.frge.io
0.0.0.0 hatrecord.ru				# Facebook trojan
0.0.0.0 hcg82f2b.com
0.0.0.0 headization.lexkd.cn
0.0.0.0 healpublic.best
0.0.0.0 healthit.live
0.0.0.0 hefever.fr
0.0.0.0 hellomobile.fr
0.0.0.0 helpmedb.com
0.0.0.0 hentavost.fr
0.0.0.0 heritagebathrooms.fr
0.0.0.0 heshun.com.tw
0.0.0.0 heuither.sbs
0.0.0.0 hfrni.comfortykive.xyz
0.0.0.0 hibody.fr
0.0.0.0 hie.li
0.0.0.0 hifa.fr
0.0.0.0 himicrosoft.com
0.0.0.0 hintonsfeetred.info
0.0.0.0 hiphip.fr
0.0.0.0 hireproplus.com
0.0.0.0 hirsch-ille.fr
0.0.0.0 hiteck.fr
0.0.0.0 hiuinder.beauty
0.0.0.0 hlhtylivs.shop
0.0.0.0 hlpurs.live
0.0.0.0 hlthiliv.shop
0.0.0.0 hltuup.za.com
0.0.0.0 hocolats-voisin.fr
0.0.0.0 homecaremovers-com-wp-admin-img-wp-ico.appwrite.network
0.0.0.0 hommetendance.fr
0.0.0.0 honeyburn.za.com
0.0.0.0 hostify.fr
0.0.0.0 hostiko.fr
0.0.0.0 hot24profit.life
0.0.0.0 hotchix.servepics.com
0.0.0.0 hotdesertknights.fr
0.0.0.0 hotel-leparc.fr
0.0.0.0 hotelboard.org
0.0.0.0 hoteldesventesantilles.fr
0.0.0.0 hotelissimo.fr
0.0.0.0 hotvideos.fr
0.0.0.0 houseofkids.fr
0.0.0.0 how-tosolve.com
0.0.0.0 howtobuildsoftware.com
0.0.0.0 hp.myway.com
0.0.0.0 hradware.fr
0.0.0.0 hsb-canada.com	# phishing site for hsbc.ca
0.0.0.0 https-ticketnotice.com
0.0.0.0 huffingtopost.fr
0.0.0.0 hunkemoeller.fr
0.0.0.0 hunkemuller.fr
0.0.0.0 hwgda.comfortykive.xyz
0.0.0.0 i.ua-passport.top
0.0.0.0 icecars.com
0.0.0.0 ichisushi.fr
0.0.0.0 iconfitness.fr
0.0.0.0 id-unconfirmeduser.frge.io
0.0.0.0 iedalo.fr
0.0.0.0 ieurope1.fr
0.0.0.0 ignitioncasino.fr
0.0.0.0 iledefrance-mutualite.fr
0.0.0.0 imagecenter.fr
0.0.0.0 imago-tv.fr
0.0.0.0 imotors.fr
0.0.0.0 in-aoke.com
0.0.0.0 inateck.fr
0.0.0.0 incuirfes.beauty
0.0.0.0 info-sectes.fr
0.0.0.0 infodjour.fr
0.0.0.0 infographicworld.fr
0.0.0.0 infopaypal.com
0.0.0.0 informereng.com
0.0.0.0 ingedus.fr
0.0.0.0 init-kqt.com
0.0.0.0 inkscape.es
0.0.0.0 inkscape.fr
0.0.0.0 innoveox.fr
0.0.0.0 inoreader.fr
0.0.0.0 inseee.fr
0.0.0.0 instabook.fr
0.0.0.0 install.myvideotab.com
0.0.0.0 installmac.com
0.0.0.0 instantstreetview.fr
0.0.0.0 intelcom-on.progressionlive.com
0.0.0.0 intelcomasfcmscta.com
0.0.0.0 interac-etransfer.net
0.0.0.0 interac1-ssl2.info
0.0.0.0 interacpayment-cra.com
0.0.0.0 interhomes.fr
0.0.0.0 interimairesssante.fr
0.0.0.0 internwise.fr
0.0.0.0 interpretation-reves.fr
0.0.0.0 intevry.fr
0.0.0.0 invelaconstructora.com
0.0.0.0 invite.gezinti.com
0.0.0.0 invited.blueconferencefield.com
0.0.0.0 ipi9.fr
0.0.0.0 iqmatrix.fr
0.0.0.0 irony.world
0.0.0.0 istartsurf.com
0.0.0.0 iswwwup.com
0.0.0.0 itbeginner.fr
0.0.0.0 itc.InsightTrailco.com
0.0.0.0 itprfft.sa.com
0.0.0.0 itssure.shop
0.0.0.0 ivgault.fr
0.0.0.0 ivoirmixdj.fr
0.0.0.0 izli.fr
0.0.0.0 jacques-brinat.fr
0.0.0.0 janezk.50webs.co
0.0.0.0 jardinonssolsvivant.fr
0.0.0.0 jasperrcorporation.com
0.0.0.0 jessieu.fr
0.0.0.0 jetem.fr
0.0.0.0 jeu-jeux.fr
0.0.0.0 jeupicard.fr
0.0.0.0 jobfreelance.fr
0.0.0.0 joincpd.com
0.0.0.0 joomlaworks.fr
0.0.0.0 joshan.fun
0.0.0.0 juegosdechicas.fr
0.0.0.0 juliettehasagun.fr
0.0.0.0 juliyea.sbs
0.0.0.0 jump.ewoss.net
0.0.0.0 juste.ru	# Twitter trojan
0.0.0.0 juventuis.fr
0.0.0.0 jzyygl.com
0.0.0.0 kabookk.fr
0.0.0.0 kanojo.fr
0.0.0.0 kantoexuziiv.com
0.0.0.0 kartables.fr
0.0.0.0 kaytri.com
0.0.0.0 keepass.com
0.0.0.0 keepass.fr
0.0.0.0 keepinfit.net
0.0.0.0 kevlaardiet.fr
0.0.0.0 keybinary.com
0.0.0.0 kiabo.fr
0.0.0.0 kiaby.fr
0.0.0.0 kiassure.fr
0.0.0.0 kicherchekoi.fr
0.0.0.0 kiclq.comfortykive.xyz
0.0.0.0 kirgo.at	# Facebook phishing attempt
0.0.0.0 kitchenmagic.fr
0.0.0.0 klefigaro.fr
0.0.0.0 kleinfelder.fr
0.0.0.0 kliniksam.com
0.0.0.0 klove.fr
0.0.0.0 klowns4phun.com
0.0.0.0 kluspro.com
0.0.0.0 konflow.com				# Facebook trojan
0.0.0.0 korodrogerie.fr
0.0.0.0 kosatec.fr
0.0.0.0 kplusd.far.ru
0.0.0.0 kpremium.com
0.0.0.0 krakragames.com
0.0.0.0 kuder.fr
0.0.0.0 kweiqox.beauty
0.0.0.0 l-histoire.fr
0.0.0.0 l.wl.co
0.0.0.0 l2.cuyouthmusic.com
0.0.0.0 la1dwne9cn5c.com
0.0.0.0 laatribune.fr
0.0.0.0 labanquepoqtale.fr
0.0.0.0 labanqueposttale.fr
0.0.0.0 laboiteorse.fr
0.0.0.0 lacentrrale.fr
0.0.0.0 lacetrale.fr
0.0.0.0 lactell.fr
0.0.0.0 ladepehe.fr
0.0.0.0 lagazette-dgi.fr
0.0.0.0 lagranderecr.fr
0.0.0.0 laiberation.fr
0.0.0.0 lajna.fr
0.0.0.0 laleh.itrc.ac.ir
0.0.0.0 lama-ole-nydahl.fr
0.0.0.0 lamlsace.fr
0.0.0.0 lamutellegenerale.fr
0.0.0.0 landing.aaroninjections.com
0.0.0.0 landingairquality.airlite.com
0.0.0.0 lank.ru
0.0.0.0 laphoceen.fr
0.0.0.0 laredoutee.fr
0.0.0.0 laredoutre.fr
0.0.0.0 lareplubliquedespyrenees.fr
0.0.0.0 larusse.fr
0.0.0.0 lasopabowl158.weebly.com
0.0.0.0 latribuen.fr
0.0.0.0 latrubune.fr
0.0.0.0 lavoixedunord.fr
0.0.0.0 laxifoot.fr
0.0.0.0 lbouyguestelecom.fr
0.0.0.0 lbrtry.com
0.0.0.0 lcastorama.fr
0.0.0.0 lcolissimo.fr
0.0.0.0 lcpr.fr
0.0.0.0 lcwkj.com
0.0.0.0 le-chineur.fr
0.0.0.0 le-recendement-et-moi.fr
0.0.0.0 le-recenement-et-moi.fr
0.0.0.0 le-tchat-bdsm.fr
0.0.0.0 leboncoan.fr
0.0.0.0 lebopncoin.fr
0.0.0.0 leelynx.fr
0.0.0.0 leficaro.fr
0.0.0.0 lefigarao.fr
0.0.0.0 lefigarop.fr
0.0.0.0 lefiogaro.fr
0.0.0.0 lefirgaro.fr
0.0.0.0 lefsechos.fr
0.0.0.0 legfigaro.fr
0.0.0.0 legrando.fr
0.0.0.0 leighties.fr
0.0.0.0 leket.fr
0.0.0.0 lemnode.fr
0.0.0.0 lemondde.fr
0.0.0.0 lemovnde.fr
0.0.0.0 leojblog.com
0.0.0.0 leomonde.fr
0.0.0.0 leparirien.fr
0.0.0.0 leparisein.fr
0.0.0.0 leparisin.fr
0.0.0.0 lepatisien.fr
0.0.0.0 lepoinf.fr
0.0.0.0 leponde.fr
0.0.0.0 leroymerln.fr
0.0.0.0 leroymrlin.fr
0.0.0.0 les-bagatelles.fr
0.0.0.0 les-crisis.fr
0.0.0.0 les-oncheres.fr
0.0.0.0 les-toiles-cinema.fr
0.0.0.0 lesecchos.fr
0.0.0.0 lesechoss.fr
0.0.0.0 lesindesradio.fr
0.0.0.0 lesmonde.fr
0.0.0.0 leuquipe.fr
0.0.0.0 levigilant.fr
0.0.0.0 lezboncoin.fr
0.0.0.0 lezpress.fr
0.0.0.0 lhycc.com
0.0.0.0 liberatiuon.fr
0.0.0.0 liberaztion.fr
0.0.0.0 liberland.fr
0.0.0.0 library.roadring.info
0.0.0.0 licasd.com
0.0.0.0 lieberation.fr
0.0.0.0 liemonde.fr
0.0.0.0 lien-social.fr
0.0.0.0 lifchnger.ru.com
0.0.0.0 lifefoot.fr
0.0.0.0 lifeofpie.fr
0.0.0.0 lifigaro.fr
0.0.0.0 lifsfer.shop
0.0.0.0 like.likewut.net
0.0.0.0 likeportal.com			# Facebook trojan
0.0.0.0 likespike.com				# Facebook trojan
0.0.0.0 likethis.mbosoft.com			# Facebook trojan
0.0.0.0 likethislist.biz			# Facebook trojan
0.0.0.0 lindependnant.fr
0.0.0.0 lindependnt.fr
0.0.0.0 lingintirejohny.club
0.0.0.0 lisaa.fr
0.0.0.0 listenonrepeat.fr
0.0.0.0 littleduck.fr
0.0.0.0 livesfoot.fr
0.0.0.0 livezfoot.fr
0.0.0.0 livhlthy.sa.com
0.0.0.0 livreral.fr
0.0.0.0 livrval.fr
0.0.0.0 livsffer.sa.com
0.0.0.0 livsfs.today
0.0.0.0 localo.fr
0.0.0.0 login.belladermaco.com
0.0.0.0 login.creditals-email.space
0.0.0.0 logitrave.fr
0.0.0.0 loirs.fr
0.0.0.0 lonaci.fr
0.0.0.0 longrich.fr
0.0.0.0 love-quest.blog
0.0.0.0 loytec.fr
0.0.0.0 lp.cleanmymac.online
0.0.0.0 lpoint.fr
0.0.0.0 lrpoint.fr
0.0.0.0 lrt7a.coldcertainchannel.com
0.0.0.0 lucklayed.info
0.0.0.0 lueway.fr
0.0.0.0 luminae.fr
0.0.0.0 luniko.fr
0.0.0.0 luxdiscount.zone
0.0.0.0 lyceebrequigny.fr
0.0.0.0 lyophililse.fr
0.0.0.0 m01.webwise.org
0.0.0.0 m02.webwise.org
0.0.0.0 maanageo.fr
0.0.0.0 mabtech.fr
0.0.0.0 mac-osx.message-warning.net
0.0.0.0 macfs.fr
0.0.0.0 madwell.fr
0.0.0.0 maewan.fr
0.0.0.0 magasine-omnicuiseur.fr
0.0.0.0 magento-analytics.com
0.0.0.0 magic-flight.fr
0.0.0.0 magicpayrecharge.com
0.0.0.0 maia-asso.fr
0.0.0.0 mail-en-marche.fr
0.0.0.0 mail.bangla.net
0.0.0.0 mail.cyberh.fr
0.0.0.0 mail.hallym.ac.kr
0.0.0.0 mail.imamu.edu.sa
0.0.0.0 mail.interq.or.jp
0.0.0.0 mail.ioc.ac.ru
0.0.0.0 mail.issas.ac.cn
0.0.0.0 mail.pmo.ac.cn
0.0.0.0 mail.siom.ac.cn
0.0.0.0 mail.tropmet.res.in
0.0.0.0 mail1.371.net
0.0.0.0 maillots-ffoot-actu.fr
0.0.0.0 mailofficeonline.shop
0.0.0.0 mailtrack.fr
0.0.0.0 main.exosrv.com
0.0.0.0 maisonstravaux.fr
0.0.0.0 maisonvalentina.fr
0.0.0.0 makeitmedia.fr
0.0.0.0 makerblog.fr
0.0.0.0 makesushi.fr
0.0.0.0 manage2-phone7alerts.com
0.0.0.0 mandialrelay.fr
0.0.0.0 mappyt.fr
0.0.0.0 marathondulacduder.fr
0.0.0.0 marble.travelhealthreport.info
0.0.0.0 marie-gerardmer.fr
0.0.0.0 marigo.redbacksburger.info
0.0.0.0 marinescence.fr
0.0.0.0 marketgameland.com
0.0.0.0 massage-v-almaty.kz
0.0.0.0 matcheendirect.fr
0.0.0.0 matchendirectr.fr
0.0.0.0 matchendiredt.fr
0.0.0.0 matchwomanreal.com
0.0.0.0 max-wangcai28.com
0.0.0.0 mbi3.kuicr.kyoto-u.ac.jp
0.0.0.0 mcleaks.fr
0.0.0.0 mdjdg.girlssohorny.net
0.0.0.0 media-match.com
0.0.0.0 mediaterre.fr
0.0.0.0 medicalhero.fr
0.0.0.0 mediterraneanroom.org
0.0.0.0 meetics.fr
0.0.0.0 melthy.fr
0.0.0.0 memecosmetic.fr
0.0.0.0 mes-bon-plans.fr
0.0.0.0 messagerie-lcl.fr
0.0.0.0 mesurelettre.fr
0.0.0.0 meta.osqa.net
0.0.0.0 metcoc5cm.clarent.com
0.0.0.0 meteof.fr
0.0.0.0 metrx.fr
0.0.0.0 meuble-bois-massif.fr
0.0.0.0 mgpl.fr
0.0.0.0 mguide-piscine.fr
0.0.0.0 mhhn.fr
0.0.0.0 michelinb2b.fr
0.0.0.0 microsoftsupport.xyz
0.0.0.0 mideal.fr
0.0.0.0 miercuri.gq
0.0.0.0 mightyfungi.fr
0.0.0.0 mije.fr
0.0.0.0 mikvr.comfortykive.xyz
0.0.0.0 mimikacooney.acemlnc.com
0.0.0.0 mindshareworld.fr
0.0.0.0 mineacraft.fr
0.0.0.0 minecraft-frannce.fr
0.0.0.0 minecraftfrance.fr
0.0.0.0 minecraftr.fr
0.0.0.0 minecraftt.fr
0.0.0.0 minefieald.fr
0.0.0.0 minemytraffic.com
0.0.0.0 minence.fr
0.0.0.0 minencraft.fr
0.0.0.0 miner.pr0gramm.com
0.0.0.0 minero-proxy-01.now.sh
0.0.0.0 minero-proxy-02.now.sh
0.0.0.0 minero-proxy-03.now.sh
0.0.0.0 minero.pw
0.0.0.0 minr.pw
0.0.0.0 mipay.fr
0.0.0.0 mipsa.ciae.ac.cn
0.0.0.0 mirillis.fr
0.0.0.0 missdiva.fr
0.0.0.0 missetam.fr
0.0.0.0 mk.wiremanse.hair
0.0.0.0 mlefigaro.fr
0.0.0.0 mlpoo11-secondary.z13.web.core.windows.net
0.0.0.0 mn.mn.co.cu
0.0.0.0 mnecraft.fr
0.0.0.0 mnutan.fr
0.0.0.0 mobevo.fr
0.0.0.0 mobile.parkandpay-ca.com
0.0.0.0 mobilesoft.fr
0.0.0.0 mobpushup.com
0.0.0.0 moddb.fr
0.0.0.0 mojn.com
0.0.0.0 momatyn.store
0.0.0.0 momentspa.fr
0.0.0.0 mon-conertisseur.fr
0.0.0.0 monbureaunumeriques.fr
0.0.0.0 moncialrelay.fr
0.0.0.0 mondespersistants.fr
0.0.0.0 mondialrealy.fr
0.0.0.0 mondiarelay.fr
0.0.0.0 moneuvre.fr
0.0.0.0 monkeyball.osa.pl
0.0.0.0 monopris.fr
0.0.0.0 monppaiement.fr
0.0.0.0 montig.fr
0.0.0.0 morning-croissant.fr
0.0.0.0 motoetloisir.fr
0.0.0.0 movies.701pages.com
0.0.0.0 moviestarpllanet.fr
0.0.0.0 movvx.accunit.cfd
0.0.0.0 mp3red.cc
0.0.0.0 mpappy.fr
0.0.0.0 mr-ginseng.fr
0.0.0.0 ms-shoponline.top
0.0.0.0 ms-shopplus.su
0.0.0.0 mshelp247.weebly.com
0.0.0.0 msssante.fr
0.0.0.0 msx.lumena.cfd
0.0.0.0 mughal.sobiratel.info
0.0.0.0 mundilite.fr
0.0.0.0 murcia-ban.es
0.0.0.0 musculaation.fr
0.0.0.0 muttuelle.fr
0.0.0.0 muwuo.comfortykive.xyz
0.0.0.0 mv0129.stream
0.0.0.0 mvspjwd.com
0.0.0.0 mx1.freemail.ne.jp
0.0.0.0 mybancoschiles.gets-it.net
0.0.0.0 mycaal.fr
0.0.0.0 mycnal.fr
0.0.0.0 mydreamday.fr
0.0.0.0 myedebred.fr
0.0.0.0 myhst2024.com
0.0.0.0 mylike.co.uk				# Facebook trojan
0.0.0.0 myornamenti.com
0.0.0.0 myprivateemails.com
0.0.0.0 myquiz.fr
0.0.0.0 myrogers-dashboard-signin.net
0.0.0.0 mytee.fr
0.0.0.0 mywifiext.fr
0.0.0.0 n1up.fr
0.0.0.0 nactx.com
0.0.0.0 naissaance.fr
0.0.0.0 nakshatra.northeastrail.info
0.0.0.0 nameketathar.pro
0.0.0.0 nantesmetrople.fr
0.0.0.0 nantilus.fr
0.0.0.0 natashyabaydesign.com
0.0.0.0 nathna.fr
0.0.0.0 naturephotographie.fr
0.0.0.0 nauf.fr
0.0.0.0 navegador.oi.com.br
0.0.0.0 navegador.telefonica.com.br
0.0.0.0 nbtp1.sa.com
0.0.0.0 ncore.ink
0.0.0.0 ncorecc.me
0.0.0.0 ncoremeghivo.net
0.0.0.0 ncsf.fr
0.0.0.0 ndl1pp1-a-fixed.sancharnet.in
0.0.0.0 neaclub.fr
0.0.0.0 needlepoint.fr
0.0.0.0 neko-scan.fr
0.0.0.0 neon-genesis-evangelion-online.fr
0.0.0.0 neowordprss.fr
0.0.0.0 netflix-memberships.com
0.0.0.0 netflix-updateinfo.com
0.0.0.0 netflix.apple-green.net
0.0.0.0 netflixca-updateprofilehelp.com
0.0.0.0 netflixe.kundensupport-kundensupport.de
0.0.0.0 new-ramboplay.com
0.0.0.0 new-vid-zone-1.blogspot.com.au
0.0.0.0 newouest.fr
0.0.0.0 newsmagic.net
0.0.0.0 newsquest.fr
0.0.0.0 nextbitcorp.com
0.0.0.0 nguyennghi.info
0.0.0.0 niche247.trade
0.0.0.0 nikeinc.fr
0.0.0.0 nimes-olympique.fr
0.0.0.0 nitricbast.shop
0.0.0.0 nnavigo.fr
0.0.0.0 noella-voyance.fr
0.0.0.0 nosdeoirs.fr
0.0.0.0 notepad2.com
0.0.0.0 novemberrainx.com
0.0.0.0 ns.cac.com.cn
0.0.0.0 ns.nint.ac.cn
0.0.0.0 ns1.multi.net.pk
0.0.0.0 ns1.webwise.org
0.0.0.0 ns2.webwise.org
0.0.0.0 ns2.xidian.edu.cn
0.0.0.0 nt.new-cars.com.es
0.0.0.0 ntralpenedhy.pro
0.0.0.0 nuclandary.qnfbfs.cn
0.0.0.0 nuitphilo-ens.fr
0.0.0.0 oclopes.fr
0.0.0.0 oechestra.fr
0.0.0.0 of3d.fr
0.0.0.0 ofdb.fr
0.0.0.0 office.officenet.co.kr
0.0.0.0 ofracosmetics.fr
0.0.0.0 ois.is
0.0.0.0 oix.com
0.0.0.0 oix.net
0.0.0.0 oj.likewut.net
0.0.0.0 okidata.fr
0.0.0.0 old.umcl.us
0.0.0.0 onclickprediction.com
0.0.0.0 ondialrelay.fr
0.0.0.0 onemanga.fr
0.0.0.0 onepager.fr
0.0.0.0 onilne.fr
0.0.0.0 online.analytiks.click
0.0.0.0 onlinewebfind.com
0.0.0.0 onyxboox.fr
0.0.0.0 oolo.fr
0.0.0.0 ooutube.fr
0.0.0.0 opcwdns.opcw.nl
0.0.0.0 openais.maricosnc.it
0.0.0.0 openinternetexchange.com
0.0.0.0 openinternetexchange.net
0.0.0.0 openoverflow.com
0.0.0.0 optionmodifycanitem.info
0.0.0.0 orange.npix.net
0.0.0.0 orangemali.fr
0.0.0.0 orangf.fr
0.0.0.0 orbit.benchmarx.info
0.0.0.0 ordersildenafil.com
0.0.0.0 ordremek.fr
0.0.0.0 orientationpour-tous.fr
0.0.0.0 orion.platino.gov.ve
0.0.0.0 orner.fr
0.0.0.0 orowy.comfortykive.xyz
0.0.0.0 ortange.fr
0.0.0.0 osonscomprendre.fr
0.0.0.0 osqa.com
0.0.0.0 osqa.net
0.0.0.0 ostalgie.fr
0.0.0.0 otsserver.com
0.0.0.0 outerinfo.com
0.0.0.0 ownpathway.digital
0.0.0.0 oyrfo.comfortykive.xyz
0.0.0.0 p.algovid.com
0.0.0.0 p.ttwitter.com
0.0.0.0 pa-voyance.fr
0.0.0.0 paalp.fr
0.0.0.0 pages-annuaire.fr
0.0.0.0 pages-perso-orange.fr
0.0.0.0 pagesjauenes.fr
0.0.0.0 pagesperso-ortange.fr
0.0.0.0 paincake.yoll.net
0.0.0.0 paintnet.es
0.0.0.0 paintnet.fr
0.0.0.0 pamini.fr
0.0.0.0 panimi.fr
0.0.0.0 pantaya.fr
0.0.0.0 paradise.homemortgageblog.info
0.0.0.0 paris-banlieue-meetinggame.fr
0.0.0.0 passport.acla.org.cn
0.0.0.0 passportindex.fr
0.0.0.0 payments-details.com
0.0.0.0 payplintelverify3.site
0.0.0.0 paysdepieces.fr
0.0.0.0 paytel.fr
0.0.0.0 paytrtrollsteamworkspace.myclickfunnels.com
0.0.0.0 pbworks.fr
0.0.0.0 pc-apps-kaiyunsports.com
0.0.0.0 pcblibraries.fr
0.0.0.0 pckgatups.bond
0.0.0.0 pclt.net
0.0.0.0 pdns.nudt.edu.cn
0.0.0.0 pearlfeet.fr
0.0.0.0 peircing-street.fr
0.0.0.0 penseedepascal.fr
0.0.0.0 peomod.fr
0.0.0.0 peoplefinders.fr
0.0.0.0 percantil.fr
0.0.0.0 peremiere.fr
0.0.0.0 perfecct.sa.com
0.0.0.0 performer.za.com
0.0.0.0 petra.nic.gov.jo
0.0.0.0 pexkr.comfortykive.xyz
0.0.0.0 pfepfe.cc
0.0.0.0 phising-initiative.fr
0.0.0.0 phorm.ch
0.0.0.0 phorm.co.uk
0.0.0.0 phorm.com
0.0.0.0 phorm.dk
0.0.0.0 phormchina.com
0.0.0.0 phormlabs.com
0.0.0.0 phpancake.com
0.0.0.0 pianolessons.fr
0.0.0.0 picture-uploads.com
0.0.0.0 pidoco.fr
0.0.0.0 piecediscount24.fr
0.0.0.0 pier-import.fr
0.0.0.0 pigredoben12.sytes.net
0.0.0.0 pigu.accbacknow.cfd
0.0.0.0 pillowpets.fr
0.0.0.0 pkia.fr
0.0.0.0 plagtracker.fr
0.0.0.0 plains.fr
0.0.0.0 planetside2.fr
0.0.0.0 planrecanpost1.info
0.0.0.0 plasticker.fr
0.0.0.0 platinmods.fr
0.0.0.0 playbaspresse.fr
0.0.0.0 playmobill.fr
0.0.0.0 playstogether.live
0.0.0.0 playzee.fr
0.0.0.0 plusjamaisdacne.fr
0.0.0.0 pocoty.fr
0.0.0.0 poemhunter.fr
0.0.0.0 poetryfoundation.fr
0.0.0.0 poetsofthefall.fr
0.0.0.0 pointerpointer.fr
0.0.0.0 polelemploi.fr
0.0.0.0 politiquemania.fr
0.0.0.0 poolin.fr
0.0.0.0 poonstwifterspick.work
0.0.0.0 portdusoleil.fr
0.0.0.0 posicionamientonatural.es
0.0.0.0 post-canada-delivery2023.com
0.0.0.0 post-canada-reschedule2024.com
0.0.0.0 post.mil-gov.space
0.0.0.0 postbox.mos.ru
0.0.0.0 postcanada.ship-express.info
0.0.0.0 postcanada.ship-priority.info
0.0.0.0 postecan-canpost.confrm942.link
0.0.0.0 postecan-canpost.updt491.link
0.0.0.0 postis.fr
0.0.0.0 poundporter.best
0.0.0.0 poweroff.pt
0.0.0.0 powertrfic.fr
0.0.0.0 ppoi.org
0.0.0.0 ppures.shop
0.0.0.0 pr-wealth.in
0.0.0.0 predictiondisplay.com
0.0.0.0 predictivadnetwork.com
0.0.0.0 premium-live-scan.com
0.0.0.0 premiumvideoupdates.com
0.0.0.0 pressealgerei.fr
0.0.0.0 pressesdesciences-po.fr
0.0.0.0 pressmedieda.info
0.0.0.0 prfcttit.za.com
0.0.0.0 priosante.fr
0.0.0.0 private-sportshop.fr
0.0.0.0 prk.roverinvolv.bid
0.0.0.0 pro-accesssoires.fr
0.0.0.0 probikesshop.fr
0.0.0.0 proclickpacket.com
0.0.0.0 profileconfirm.info
0.0.0.0 profilenetflix.com
0.0.0.0 profilenotice.info
0.0.0.0 profit-btc.org
0.0.0.0 proflashdata.com			# Facebook trojan
0.0.0.0 proidees.fr
0.0.0.0 projectpoi.com
0.0.0.0 promogrim.fr
0.0.0.0 promojustforyou.click
0.0.0.0 propitea.fr
0.0.0.0 propk.sa.com
0.0.0.0 provence-ouyillage.fr
0.0.0.0 provenfeedback.com
0.0.0.0 psycho-test.fr
0.0.0.0 ptagercity.fr
0.0.0.0 pub-251d6c694a0641dd9e95aeca9e3219e8.r2.dev
0.0.0.0 pullipstyle.fr
0.0.0.0 puppygames.fr
0.0.0.0 puppylover.fr
0.0.0.0 purchasingpower.fr
0.0.0.0 purepods.fr
0.0.0.0 purolatorkbtdh.eu.cc
0.0.0.0 pvt2202--deab86120ff311f1b0c142dde27851f2.web.val.run
0.0.0.0 qbittorrent.com
0.0.0.0 qdssy.balistrera.sbs
0.0.0.0 qevia.doubleclick.bond
0.0.0.0 qfsya.comfortykive.xyz
0.0.0.0 qouv.fr
0.0.0.0 quaidesbulles.fr
0.0.0.0 question2answer.com
0.0.0.0 questrade-pypip.com
0.0.0.0 quickchess.fr
0.0.0.0 quicksaledeal.su
0.0.0.0 quirinale.fr
0.0.0.0 qyh.co.ua
0.0.0.0 racingfamilyvillage.com
0.0.0.0 radio42.fr
0.0.0.0 randki-sex.com
0.0.0.0 rapid-glade-cde8.asoumare042024.workers.dev
0.0.0.0 raptp.fr
0.0.0.0 rb-on1in-sec.com
0.0.0.0 rbc-anth-ogrn.com
0.0.0.0 rbc-clientsupport1.com
0.0.0.0 reacherinst.com
0.0.0.0 realstar.fr
0.0.0.0 recettes-vegetariennes.fr
0.0.0.0 recevoirlatntn.fr
0.0.0.0 recover-subscription.com
0.0.0.0 redeastbay.com
0.0.0.0 redelivauthcentre.com
0.0.0.0 redelivercadpost.com
0.0.0.0 redelivtls.online
0.0.0.0 redf.fr
0.0.0.0 redircpapp.co.za
0.0.0.0 redline-boutique.fr
0.0.0.0 redrocks.fr
0.0.0.0 reductions-impots.fr
0.0.0.0 refund-int3rac.com
0.0.0.0 regclassboard.com
0.0.0.0 reliezvous.fr
0.0.0.0 renacious.nwwadq.cn
0.0.0.0 renov-landes.fr
0.0.0.0 rentacars.fr
0.0.0.0 rentamotorcycle.fr
0.0.0.0 resetcibc-logincibc.com
0.0.0.0 residence.bunkerhilltradingco.info
0.0.0.0 reskins.fr
0.0.0.0 restriia.shop
0.0.0.0 resulabi.fr
0.0.0.0 resultatspmu.fr
0.0.0.0 resumekeeper.com
0.0.0.0 retaildetail.fr
0.0.0.0 retrofuture.fr
0.0.0.0 return2025costco.com
0.0.0.0 rev-cvnada-dep.com
0.0.0.0 rezeptwelt.fr
0.0.0.0 rgp-ign.fr
0.0.0.0 rickrolling.com
0.0.0.0 rifec.co
0.0.0.0 rimnow.fr
0.0.0.0 ringcleas.sa.com
0.0.0.0 riosaladohp.com
0.0.0.0 robertgraham.fr
0.0.0.0 rockrose.fr
0.0.0.0 rocks.io
0.0.0.0 rockthebretzel.fr
0.0.0.0 rogers-wirelessphone.com
0.0.0.0 roivant.fr
0.0.0.0 rojadirectatv.fr
0.0.0.0 romdiscover.com
0.0.0.0 rootbuzz.com
0.0.0.0 rottentomatoes.fr
0.0.0.0 rrg2mrb.matchwomanreal.com
0.0.0.0 rrtougao.com
0.0.0.0 rtag.fr
0.0.0.0 rubgyrama.fr
0.0.0.0 ruchika29access55824.acemlna.com
0.0.0.0 runnerswolrd.fr
0.0.0.0 runtnc.net
0.0.0.0 russian-sex.com
0.0.0.0 ryther.fr
0.0.0.0 s.pubmine.com
0.0.0.0 s3-ap-southeast-1-amazonaws.com
0.0.0.0 s3-ap-southeast-2-amazonaws.com
0.0.0.0 s4d.in
0.0.0.0 safes.ru.com
0.0.0.0 saicmotor.fr
0.0.0.0 sajour.fr
0.0.0.0 salebestever.su
0.0.0.0 salezone.sa.com
0.0.0.0 sanbuzs.com
0.0.0.0 santanderbank.fr
0.0.0.0 saouryadi.in
0.0.0.0 sartoriz.fr
0.0.0.0 sbh9hu4trk.com
0.0.0.0 scei-concour.fr
0.0.0.0 schlaukopf.fr
0.0.0.0 sciencesetlavenir.fr
0.0.0.0 scoietegenerale.fr
0.0.0.0 scotiahelp-loginscotia.com
0.0.0.0 scotiaonline-verification.com
0.0.0.0 scottishstuff-online.com	# Canadian bank phishing site
0.0.0.0 scr-jiebaoscore.com
0.0.0.0 screenaddict.thewhizproducts.com
0.0.0.0 screencast-o-matic.fr
0.0.0.0 scribbens.fr
0.0.0.0 scribe.ttwitter.com
0.0.0.0 scure-royaibamk.com
0.0.0.0 scwharzkopf.fr
0.0.0.0 scyxj.comfortykive.xyz
0.0.0.0 sea.net.edu.cn
0.0.0.0 search.buzzdock.com
0.0.0.0 search.conduit.com
0.0.0.0 search.privitize.com
0.0.0.0 secret.xn--oogle-wmc.com
0.0.0.0 secretosdelagua.fr
0.0.0.0 secure-accept-e-transfer-interac.info
0.0.0.0 secure-fidosolutions.com
0.0.0.0 secure-royaibnk.com
0.0.0.0 securedeposit-et.com
0.0.0.0 securesweep.pro
0.0.0.0 securielite.com
0.0.0.0 security.schwab-5.click
0.0.0.0 securityscan.us
0.0.0.0 seebox.fr
0.0.0.0 seeques.com
0.0.0.0 seezeit.fr
0.0.0.0 segob.gob.mx
0.0.0.0 selarbiosites.fr
0.0.0.0 selfhtml.fr
0.0.0.0 seniului.v6.navy
0.0.0.0 sensahome.fr
0.0.0.0 sephor.fr
0.0.0.0 serff.fr
0.0.0.0 serv-canada2024.com
0.0.0.0 servpro.fr
0.0.0.0 setup-mydelivery-date6437-fedex.com
0.0.0.0 sgluco.shop
0.0.0.0 shapado.com
0.0.0.0 sharelink.fr
0.0.0.0 shiiva.fr
0.0.0.0 shoalike.fr
0.0.0.0 shop-pharmaccie.fr
0.0.0.0 shop.skin-safety.com
0.0.0.0 shopfix.fr
0.0.0.0 shopigo.fr
0.0.0.0 shopkeep.fr
0.0.0.0 shopsm.fr
0.0.0.0 shoptrends.fr
0.0.0.0 shrsgame.com
0.0.0.0 siexrlypbbvt.com
0.0.0.0 sig.tecnologicosucre.edu.ec
0.0.0.0 siliconf.fr
0.0.0.0 sinera.org
0.0.0.0 sinochem.fr
0.0.0.0 sinu24.de
0.0.0.0 sinu24.ee
0.0.0.0 siteliner.fr
0.0.0.0 sitesofa.za.com
0.0.0.0 sitrion.fr
0.0.0.0 sjgoodandcompany.com
0.0.0.0 slavyangrad.fr
0.0.0.0 slideboc.fr
0.0.0.0 sllate.fr
0.0.0.0 smartcart.fr
0.0.0.0 smicaval.fr
0.0.0.0 smile-angel.com
0.0.0.0 smosh.fr
0.0.0.0 snapsonthehouse.com
0.0.0.0 snscf.fr
0.0.0.0 sociagil.fr
0.0.0.0 societegernerale.fr
0.0.0.0 societergenerale.fr
0.0.0.0 sofaglobal.best
0.0.0.0 sofia.whatcaniseeinkiev.info
0.0.0.0 software-updates.co
0.0.0.0 software-wenc.co.cc
0.0.0.0 soidog.fr
0.0.0.0 solarswitch4all.com
0.0.0.0 solarwindow.fr
0.0.0.0 soloprodottiitaliani.fr
0.0.0.0 soluclim.fr
0.0.0.0 solutionscore.com
0.0.0.0 solveseek.com
0.0.0.0 sonatns.sonatrach.dz
0.0.0.0 songsar.com
0.0.0.0 soniksports.fr
0.0.0.0 soports.fr
0.0.0.0 sorbone.fr
0.0.0.0 sosohus.ink
0.0.0.0 speakplanet.fr
0.0.0.0 specialworld.com.au
0.0.0.0 speechpad.fr
0.0.0.0 speedycourse.fr
0.0.0.0 spotchannel02.com
0.0.0.0 srothuynguyen.com
0.0.0.0 ssephora.fr
0.0.0.0 stackoverflow.xyz
0.0.0.0 star-iptv.fr
0.0.0.0 starbuckssurvey.life
0.0.0.0 startmarket.su
0.0.0.0 stationpack.de
0.0.0.0 statutorjuihui.site
0.0.0.0 stay.decentralappps.com
0.0.0.0 steelbitepro24.com
0.0.0.0 stellarium.fr
0.0.0.0 steveberry.fr
0.0.0.0 stilnovo.fr
0.0.0.0 stopphoulplay.com
0.0.0.0 strategies360.fr
0.0.0.0 strrget.za.com
0.0.0.0 stswen.fr
0.0.0.0 studywithab.com
0.0.0.0 subcreation.fr
0.0.0.0 suddenplot.com
0.0.0.0 suenosurcolchones.com.ar.abakotest.com.ar
0.0.0.0 suicidaltendencies.fr
0.0.0.0 sumofus.fr
0.0.0.0 sunhe.jinr.ru
0.0.0.0 suocietegenerale.fr
0.0.0.0 supernaturalart.com
0.0.0.0 supportservice-dragonfly.duckdns.org
0.0.0.0 survarium.fr
0.0.0.0 susm0q6jys.com
0.0.0.0 sussi.cressoft.com.pk
0.0.0.0 suxap.comfortykive.xyz
0.0.0.0 suzukiauto.fr
0.0.0.0 sverd.net
0.0.0.0 swflightinfo.bond
0.0.0.0 swiftype.fr
0.0.0.0 swisslide.fr
0.0.0.0 sxthxf.com
0.0.0.0 sybonymo.fr
0.0.0.0 syngeta.fr
0.0.0.0 synthroid.fr
0.0.0.0 systadin.fr
0.0.0.0 systematixinfotech.fr
0.0.0.0 szfr.fr
0.0.0.0 tahoesup.com
0.0.0.0 tanieaukcje.com
0.0.0.0 taniezakupy.pl
0.0.0.0 taotaolm.com
0.0.0.0 tarbosau.bbqpitcleaners.info
0.0.0.0 tattooshaha.info			# Facebook trojan
0.0.0.0 tax-canada2023.co
0.0.0.0 tbebestknives.fr
0.0.0.0 teak.gen.tr
0.0.0.0 teamsport-philipp.fr
0.0.0.0 tearbelt.com
0.0.0.0 technicalconsumerreports.com
0.0.0.0 technocite.fr
0.0.0.0 technoit.fr
0.0.0.0 techques.com
0.0.0.0 telephone-voyance.fr
0.0.0.0 telephoner-voyance.fr
0.0.0.0 telpay.fr
0.0.0.0 tenispro.fr
0.0.0.0 terricole.fr
0.0.0.0 test.gutir.ru
0.0.0.0 test.ishvara-yoga.com
0.0.0.0 testbook.fr
0.0.0.0 textbrokr.fr
0.0.0.0 textion.g9y18u.cn
0.0.0.0 thailandtravel.live
0.0.0.0 thainationalparks.fr
0.0.0.0 thalasur.fr
0.0.0.0 thebestknifes.fr
0.0.0.0 thebestone.click
0.0.0.0 thebestwebpillplace.com
0.0.0.0 thechive.fr
0.0.0.0 thedatesafe.com			# Facebook trojan
0.0.0.0 themusicnetwork.co.uk
0.0.0.0 thenewswire.fr
0.0.0.0 thesciencequest.info
0.0.0.0 thesimsresource.fr
0.0.0.0 thetorrentz.fr
0.0.0.0 thickporter.sa.com
0.0.0.0 thislocalhost.com
0.0.0.0 thisone.online
0.0.0.0 thomasmore.fr
0.0.0.0 thunderbird.es
0.0.0.0 tibs.fr
0.0.0.0 ticketforchange.fr
0.0.0.0 ticketpayfee.com
0.0.0.0 ticketspy.fr
0.0.0.0 tiku.io
0.0.0.0 timberlande.fr
0.0.0.0 tip-leisusports.com
0.0.0.0 tiplanet.fr
0.0.0.0 tlio.forskningsnytt.info
0.0.0.0 tnews.day
0.0.0.0 toknowall.com
0.0.0.0 tomorrownewstoday.com	# I'm not sure what it does, but it seems to be associated with a phishing attempt on Facebook
0.0.0.0 toppillstore.com
0.0.0.0 toprxshopplace.com
0.0.0.0 topshoponline.ru
0.0.0.0 toptypeonlinetheclicks.icu
0.0.0.0 torjackan.info
0.0.0.0 totaldebrid.fr
0.0.0.0 tourismelenslievin.fr
0.0.0.0 tr-red.lamanoqueayuda.org
0.0.0.0 tradedealvip.su
0.0.0.0 tradeinn.fr
0.0.0.0 traffic-bam.link
0.0.0.0 traffic.adwitty.com
0.0.0.0 tranisere.fr
0.0.0.0 trauiqce.click
0.0.0.0 trevia.za.com
0.0.0.0 trifama.com
0.0.0.0 trioadvisor.fr
0.0.0.0 trk.arenachat.xyz
0.0.0.0 trk.wizzdeal.trade
0.0.0.0 trouveunfilm.fr
0.0.0.0 trovi.com
0.0.0.0 trstwcard.icu
0.0.0.0 truecrypt.fr
0.0.0.0 trusturl.top
0.0.0.0 tubero.ellystegge.info
0.0.0.0 tubr8.fr
0.0.0.0 tuniaf.com
0.0.0.0 turfomani.fr
0.0.0.0 tv-jiangnantiyu.com
0.0.0.0 tvshowslist.com
0.0.0.0 tweetdeck.fr
0.0.0.0 twitchindoor.best
0.0.0.0 twitpic.fr
0.0.0.0 tx.micro.net.pk
0.0.0.0 tx2returnhome.com
0.0.0.0 typewriter.fr
0.0.0.0 tyyvps.com
0.0.0.0 tzmqyj.com
0.0.0.0 u-pssud.fr
0.0.0.0 ua-consumerpanel.frge.io
0.0.0.0 ubuntu-fr.fr
0.0.0.0 udgth.comfortykive.xyz
0.0.0.0 ufpcdn.com
0.0.0.0 ui.chelepi.contractors
0.0.0.0 umgpjdlllhl.ru
0.0.0.0 un-ruly.fr
0.0.0.0 unetbootin.net
0.0.0.0 unetbootin.org
0.0.0.0 uni-littoral.fr
0.0.0.0 uniguide.fr
0.0.0.0 unitdotto.club
0.0.0.0 united-domaine.tech
0.0.0.0 univ-murs.fr
0.0.0.0 univ-paris-didero.fr
0.0.0.0 univ-pars1.fr
0.0.0.0 univ6lehavre.fr
0.0.0.0 univevry.fr
0.0.0.0 unme-asso.fr
0.0.0.0 unodieuxconnard.fr
0.0.0.0 update-expiry-notification-report.appwrite.network
0.0.0.0 updateauto.preparevideosafesystem4unow.space
0.0.0.0 uqz.com
0.0.0.0 urbact.fr
0.0.0.0 url3781.host.inreception.com
0.0.0.0 url9810.tokocrypto.com
0.0.0.0 urssff.fr
0.0.0.0 urzl.fr
0.0.0.0 usbf.fr
0.0.0.0 usdeeds.acemlna.com
0.0.0.0 users16.jabry.com
0.0.0.0 usoasopersbe.xyz
0.0.0.0 ut1-capitole.fr
0.0.0.0 ut1capitole.fr
0.0.0.0 utauniv-lyon2.fr
0.0.0.0 utenti.lycos.it
0.0.0.0 utrace.fr
0.0.0.0 van-city-sign-on.com
0.0.0.0 vc-login.com
0.0.0.0 vcarrefour.fr
0.0.0.0 vendhelpuous.pgvjmp.cn
0.0.0.0 venturead.com
0.0.0.0 verify.rambler-profile.site
0.0.0.0 versbaudet.fr
0.0.0.0 vfzzs.comfortykive.xyz
0.0.0.0 vgsnf.comfortykive.xyz
0.0.0.0 vi-improved.org
0.0.0.0 viad.fr
0.0.0.0 videoamp.com
0.0.0.0 videofitness.fr
0.0.0.0 videovor.fr
0.0.0.0 vieques.fr
0.0.0.0 viessman.fr
0.0.0.0 vietnamdiscovery.fr
0.0.0.0 viglink.fr
0.0.0.0 villepariis.fr
0.0.0.0 vinoscout.fr
0.0.0.0 vins-bourgorne.fr
0.0.0.0 viowyf.khaiafi.com
0.0.0.0 vip.fortunatetime.xyz
0.0.0.0 vipon.fr
0.0.0.0 virewin.com
0.0.0.0 viriginradio.fr
0.0.0.0 visana.fr
0.0.0.0 visualsonics.fr
0.0.0.0 vitemadose.fr
0.0.0.0 vivalife.fr
0.0.0.0 vivgilance.fr
0.0.0.0 vjpwe.comfortykive.xyz
0.0.0.0 vlc.de
0.0.0.0 voiciu.fr
0.0.0.0 voil-le-travail.fr
0.0.0.0 voipwise.fr
0.0.0.0 volksvagen.fr
0.0.0.0 volkswagens.fr
0.0.0.0 vs-wending.com
0.0.0.0 vxiframe.biz
0.0.0.0 w3facility.org
0.0.0.0 wagsandwhiskers.fr
0.0.0.0 wahm.fr
0.0.0.0 wait3sec.org
0.0.0.0 waldenfarms.com
0.0.0.0 wanadzoo.fr
0.0.0.0 wanatoo.fr
0.0.0.0 watch-netfiix.com
0.0.0.0 watchpro.fr
0.0.0.0 waterstudio.fr
0.0.0.0 waudeesestew.com
0.0.0.0 wealthsimple-dwvip.com
0.0.0.0 weapfuh.originalriver-tone.top
0.0.0.0 web.almestin.ru
0.0.0.0 webassembly.stream
0.0.0.0 webatic.fr
0.0.0.0 webmail.grahachemical.co.id
0.0.0.0 webmedic.fr
0.0.0.0 webnetra.entelnet.bo
0.0.0.0 webpaypal.com
0.0.0.0 webserv.mos.ru
0.0.0.0 webwikis.fr
0.0.0.0 webwise.com
0.0.0.0 webwise.net
0.0.0.0 webwise.org
0.0.0.0 weddinglovers.pl
0.0.0.0 wenda.io
0.0.0.0 west.05tz2e9.com
0.0.0.0 westerdayeol.site
0.0.0.0 wetter24.fr
0.0.0.0 wewillrocknow.com
0.0.0.0 wfflxx.com
0.0.0.0 wgdcjd8kxd.olijfgent.be
0.0.0.0 whiscas.fr
0.0.0.0 whiteenamel.fr
0.0.0.0 whqxzx.com
0.0.0.0 wikidevs.com
0.0.0.0 wileprefgurad.net
0.0.0.0 willysy.com
0.0.0.0 winns.fr
0.0.0.0 with-anbo.com
0.0.0.0 wizzshop.trade
0.0.0.0 wk4x5rdtoz2tn0.com
0.0.0.0 wnathan.fr
0.0.0.0 wolverineworldwide.fr
0.0.0.0 woodplans.sa.com
0.0.0.0 worldcommunitygrid.fr
0.0.0.0 worldwidefestival.fr
0.0.0.0 wpad # For reference: https://www.youtube.com/watch?v=uwsykPWa5Lc
0.0.0.0 wpcgt.comfortykive.xyz
0.0.0.0 wrontonshatbona.pro
0.0.0.0 ws05.crypto-loot.com
0.0.0.0 ws06.crypto-loot.com
0.0.0.0 ws07.crypto-loot.com
0.0.0.0 ws08.crypto-loot.com
0.0.0.0 ws09.crypto-loot.com
0.0.0.0 ws23.crypto-loot.com
0.0.0.0 ws24.crypto-loot.com
0.0.0.0 ws25.crypto-loot.com
0.0.0.0 ws42.crypto-loot.com
0.0.0.0 ws48.crypto-loot.com
0.0.0.0 ws49.crypto-loot.com
0.0.0.0 ws50.crypto-loot.com
0.0.0.0 wwnc.xyz
0.0.0.0 www.316ee.com
0.0.0.0 www.7zip.fr
0.0.0.0 www.991abc.com
0.0.0.0 www.a2uu36g43l.download
0.0.0.0 www.aaaddedbenifits.com
0.0.0.0 www.aagofwi.com
0.0.0.0 www.aaringtone.com
0.0.0.0 www.abetterinternet.com
0.0.0.0 www.abnehmenkabofit.de
0.0.0.0 www.aconchoe.com
0.0.0.0 www.activetrap.com
0.0.0.0 www.adacoustics.com
0.0.0.0 www.adblock.fr
0.0.0.0 www.adselector.com
0.0.0.0 www.adshufffle.com
0.0.0.0 www.aerodriftcore.uk
0.0.0.0 www.agreementnow.com
0.0.0.0 www.ahlie.com
0.0.0.0 www.airmedcarennetwork.com
0.0.0.0 www.airybotsh.pro
0.0.0.0 www.airypathsq.name
0.0.0.0 www.akundu.com
0.0.0.0 www.alexyastro.com
0.0.0.0 www.alittlelewd.com
0.0.0.0 www.allhqpics.com			# Facebook trojan
0.0.0.0 www.allinvideo.com
0.0.0.0 www.allscrabble.com
0.0.0.0 www.allstateproteectionplans.com
0.0.0.0 www.allusermanual.com
0.0.0.0 www.altunyapimarket.com
0.0.0.0 www.amerenallieshvac.com
0.0.0.0 www.americanresortresolutions.com
0.0.0.0 www.amintart.com
0.0.0.0 www.amomales.com
0.0.0.0 www.ampervid.com
0.0.0.0 www.anatol.com
0.0.0.0 www.anyik.com
0.0.0.0 www.apcort.com
0.0.0.0 www.apkfuuny.com
0.0.0.0 www.aplogia.com
0.0.0.0 www.appfoliio.com
0.0.0.0 www.aqualakefy.name
0.0.0.0 www.aramcom.space
0.0.0.0 www.arfrepuestos.com
0.0.0.0 www.argesmedia.com
0.0.0.0 www.arknasasbluecross.com
0.0.0.0 www.artdualdesign.com
0.0.0.0 www.artssets.com
0.0.0.0 www.asianread.com
0.0.0.0 www.assistdocklane.uk
0.0.0.0 www.atightschedule.com
0.0.0.0 www.atoztechnotricks.com
0.0.0.0 www.audacity.es
0.0.0.0 www.audacity.fr
0.0.0.0 www.audionoisereducer.com
0.0.0.0 www.auditprint.com
0.0.0.0 www.auto-runmz.com
0.0.0.0 www.autoaler.com
0.0.0.0 www.autoinkoopbedrijf.com
0.0.0.0 www.autotra.com
0.0.0.0 www.availablefiles.com
0.0.0.0 www.avemoo.com
0.0.0.0 www.azureus.es
0.0.0.0 www.azwomens.com
0.0.0.0 www.backingguitar.garden
0.0.0.0 www.bahartonu.com
0.0.0.0 www.baiakstyle.com
0.0.0.0 www.balassst.com
0.0.0.0 www.ballarddesighs.com
0.0.0.0 www.bandexperts.com
0.0.0.0 www.banghra.com
0.0.0.0 www.bankofcounty.com
0.0.0.0 www.banyotoptansatis.com
0.0.0.0 www.barjacity.com
0.0.0.0 www.basealloys.com
0.0.0.0 www.baseequip.com
0.0.0.0 www.bayareafyuerzk.com
0.0.0.0 www.bazarusmassazha.com
0.0.0.0 www.bbyjgkkdihiyxy.com
0.0.0.0 www.bcwars.net
0.0.0.0 www.be4life.ru
0.0.0.0 www.behdja.com
0.0.0.0 www.beheerflvsebox.com
0.0.0.0 www.bellamhair.com
0.0.0.0 www.bernoussiphone.com
0.0.0.0 www.bestlabour.com
0.0.0.0 www.bevisgame.com
0.0.0.0 www.bicyclefan.com
0.0.0.0 www.bigantstore.com
0.0.0.0 www.bigpremiere.com
0.0.0.0 www.bisselcommercial.com
0.0.0.0 www.bjseverlastingoils.com
0.0.0.0 www.blanknightsmfg.com
0.0.0.0 www.blazesemipvp.com
0.0.0.0 www.blender3d.fr
0.0.0.0 www.blogmaking.com
0.0.0.0 www.bloomifllowers.com
0.0.0.0 www.blueadvantagearkasas.com
0.0.0.0 www.bluecollarparanormal.com
0.0.0.0 www.blueridgecpp.com
0.0.0.0 www.bmrneswk.com
0.0.0.0 www.board-ly.com
0.0.0.0 www.bocastyle.com
0.0.0.0 www.bonuxsarrive.com
0.0.0.0 www.bookstadium.com
0.0.0.0 www.borocade.com
0.0.0.0 www.boysstrongly.living
0.0.0.0 www.brandsclothingco.com
0.0.0.0 www.breaksdown.lol
0.0.0.0 www.breakslavery.com
0.0.0.0 www.brghterimagelab.com
0.0.0.0 www.brightqz.com
0.0.0.0 www.brightstardv.pro
0.0.0.0 www.briidgeapp.com
0.0.0.0 www.briskappmu.name
0.0.0.0 www.briskshadeyv.com
0.0.0.0 www.brooksrunningdeals.com
0.0.0.0 www.bucahssana.com
0.0.0.0 www.builtinfo.com
0.0.0.0 www.bumerang.cc
0.0.0.0 www.buystables.com
0.0.0.0 www.bvcnle.cfd
0.0.0.0 www.cablyshaw.com
0.0.0.0 www.calmde.com
0.0.0.0 www.calmdockpb.name
0.0.0.0 www.calnanflack.com
0.0.0.0 www.cambonanza.com
0.0.0.0 www.camtory.com
0.0.0.0 www.canadianshawid.com
0.0.0.0 www.caothusohoc.com
0.0.0.0 www.caramail.com
0.0.0.0 www.careertake.com
0.0.0.0 www.carehigher.com
0.0.0.0 www.carolmassoterapia.com
0.0.0.0 www.casamaticoecu.com
0.0.0.0 www.casinorankerhub.com
0.0.0.0 www.casinostarluck.net
0.0.0.0 www.cassink.com
0.0.0.0 www.catabcde.com
0.0.0.0 www.catjre.com
0.0.0.0 www.cdinstagram.com
0.0.0.0 www.celestia.es
0.0.0.0 www.celestia.fr
0.0.0.0 www.cemerhealth.com
0.0.0.0 www.centeralbidding.com
0.0.0.0 www.checkdrivers.com
0.0.0.0 www.checkpics.com
0.0.0.0 www.chelick.net			# Facebook trojan
0.0.0.0 www.chichomods.com
0.0.0.0 www.chiefsale.com
0.0.0.0 www.chinesehollywood.com
0.0.0.0 www.cidadelobito.com
0.0.0.0 www.ciderbayoulg.pro
0.0.0.0 www.ciderglowcm.site
0.0.0.0 www.cidersunjt.com
0.0.0.0 www.cjkassociates.co.in
0.0.0.0 www.cjtest.com
0.0.0.0 www.claimedmoney.com
0.0.0.0 www.classeroom.com
0.0.0.0 www.cleanvvlife.com
0.0.0.0 www.cleanvvmagic.com
0.0.0.0 www.clearacreonline.com
0.0.0.0 www.clearalgorithm.com
0.0.0.0 www.clickrents.com
0.0.0.0 www.clipsfan.com
0.0.0.0 www.clonezilla.es
0.0.0.0 www.clonezilla.fr
0.0.0.0 www.cloudverge.uk
0.0.0.0 www.clovercraftshop.com
0.0.0.0 www.clubplanning.com
0.0.0.0 www.coconutsport.com
0.0.0.0 www.codeademy.com
0.0.0.0 www.coinimp.com
0.0.0.0 www.colleyvillepapershredding.com
0.0.0.0 www.combinebasic.com
0.0.0.0 www.comfortykive.xyz
0.0.0.0 www.commitlacrossecamps.com
0.0.0.0 www.commuteinfo.com
0.0.0.0 www.compacfurniture.com
0.0.0.0 www.complien.com
0.0.0.0 www.compufixshop.com
0.0.0.0 www.conclusioncompeting.bond
0.0.0.0 www.conservativedeeper.garden
0.0.0.0 www.consultingbyelevate.com
0.0.0.0 www.continuedlincoln.bond
0.0.0.0 www.controlpop.com
0.0.0.0 www.cookoven.com
0.0.0.0 www.coolrextintshop.com
0.0.0.0 www.corlythra.uk
0.0.0.0 www.corvettiortho.com
0.0.0.0 www.courtneydowns.com
0.0.0.0 www.cpatglobal.com
0.0.0.0 www.cpension.com
0.0.0.0 www.cprcar.com
0.0.0.0 www.cqwallpaper.com
0.0.0.0 www.creativesaftysupply.com
0.0.0.0 www.crediainternational.com
0.0.0.0 www.crowdnestfun.com
0.0.0.0 www.cruzresorts.com
0.0.0.0 www.crystalbranchtw.blog
0.0.0.0 www.ctlcai.com
0.0.0.0 www.dailyazure.com
0.0.0.0 www.damncheapguns.com
0.0.0.0 www.dangdangflow.com
0.0.0.0 www.danispiritualtherapist.com
0.0.0.0 www.darkrro.com
0.0.0.0 www.dartya.com
0.0.0.0 www.dayanitastore.com
0.0.0.0 www.daytonjaxx.com
0.0.0.0 www.dbcorporation.com
0.0.0.0 www.dealresponse.com
0.0.0.0 www.dealshaat.com
0.0.0.0 www.dealsrate.com
0.0.0.0 www.deashi.com
0.0.0.0 www.defailermu.com
0.0.0.0 www.dejamesertuvoz.com
0.0.0.0 www.dentistkids.com
0.0.0.0 www.deperiodista.com
0.0.0.0 www.desirymart.com
0.0.0.0 www.dewcoreaj.pro
0.0.0.0 www.dewwillowwj.site
0.0.0.0 www.diamondconnections.living
0.0.0.0 www.dictadosonline.com
0.0.0.0 www.didata.bw
0.0.0.0 www.diffuselec.com
0.0.0.0 www.digimininggame.com
0.0.0.0 www.digisubmission.com
0.0.0.0 www.digitalbigger.garden
0.0.0.0 www.digitalcoachpro.name
0.0.0.0 www.dinasauradventure.com
0.0.0.0 www.diperformancetransmissions.com
0.0.0.0 www.dkpmsa.cfd
0.0.0.0 www.dlinktour.com
0.0.0.0 www.doblectv.com
0.0.0.0 www.dorminvaders.com
0.0.0.0 www.downmass.com
0.0.0.0 www.drivegoals.com
0.0.0.0 www.dualeotruyenno.com
0.0.0.0 www.duotrader.com
0.0.0.0 www.dustinjonesgolfacademy.com
0.0.0.0 www.dutchoutlet.com
0.0.0.0 www.dymor.cfd
0.0.0.0 www.dynamictyres.com
0.0.0.0 www.dzzzsc.com
0.0.0.0 www.e-transfer-cra.com
0.0.0.0 www.eaglesfanclub.com
0.0.0.0 www.eamazondigital.com
0.0.0.0 www.edashealthcare.com
0.0.0.0 www.edwardmartino.com
0.0.0.0 www.ekkekkocapital.com
0.0.0.0 www.elanactivewear.com
0.0.0.0 www.elchavotortas.com
0.0.0.0 www.electrobell.com
0.0.0.0 www.elfralalo.com
0.0.0.0 www.eljaleomedellin.com
0.0.0.0 www.ellesalonhb.com
0.0.0.0 www.elmerdiner.com
0.0.0.0 www.emailspend.com
0.0.0.0 www.emprenderimportaperu.com
0.0.0.0 www.enargic.com
0.0.0.0 www.energiazoque.com
0.0.0.0 www.eqarati.com
0.0.0.0 www.eqinenow.com
0.0.0.0 www.eremplacementparts.com
0.0.0.0 www.erincranor.com
0.0.0.0 www.erspan.com
0.0.0.0 www.esjetonline.com
0.0.0.0 www.ethicsstore.com
0.0.0.0 www.europelinen.com
0.0.0.0 www.eventflavor.com
0.0.0.0 www.exactpharm.com
0.0.0.0 www.exambased.com
0.0.0.0 www.exceleratehelp.com
0.0.0.0 www.exoticainmotion.com
0.0.0.0 www.expolearn.com
0.0.0.0 www.exposhot.com
0.0.0.0 www.expressmails.com
0.0.0.0 www.exteriorteam.com
0.0.0.0 www.extrabrick.com
0.0.0.0 www.exvaro.cfd
0.0.0.0 www.faggotry.com
0.0.0.0 www.farmacyty.com
0.0.0.0 www.farnazinternational.com
0.0.0.0 www.faruvclight.com
0.0.0.0 www.fashiongown.com
0.0.0.0 www.feelimprove.bond
0.0.0.0 www.fenquavo.com
0.0.0.0 www.ferreteriamaracopa.com
0.0.0.0 www.feudlands.com
0.0.0.0 www.fhtmmeeting.com
0.0.0.0 www.filezilla.fr
0.0.0.0 www.financevd.com
0.0.0.0 www.findalgorithm.com
0.0.0.0 www.findalign.com
0.0.0.0 www.findlobster.com
0.0.0.0 www.fingertimer.com
0.0.0.0 www.firsttrchfed.com
0.0.0.0 www.fischereszter.hu
0.0.0.0 www.fixedshine.com
0.0.0.0 www.fixingfast.com
0.0.0.0 www.flaglergrill.com
0.0.0.0 www.flexibleadmin.com
0.0.0.0 www.fluffyappyp.com
0.0.0.0 www.fluidfiber.com
0.0.0.0 www.flydrivenest.com
0.0.0.0 www.fmoviehd.com
0.0.0.0 www.forexhelps.com
0.0.0.0 www.forexwood.com
0.0.0.0 www.formalcenter.com
0.0.0.0 www.fortunoxx.com
0.0.0.0 www.framermotionplayground.com
0.0.0.0 www.francesportisas-fr.com
0.0.0.0 www.frbonusjeux.com
0.0.0.0 www.freeaquarium.com
0.0.0.0 www.freecontent.bid
0.0.0.0 www.freedailydownload.com
0.0.0.0 www.fripta.com
0.0.0.0 www.froling.bee.pl
0.0.0.0 www.funkycovers.com
0.0.0.0 www.furcomics.com
0.0.0.0 www.futuredecide.com
0.0.0.0 www.futureowned.com
0.0.0.0 www.gadgetbonanzamarket.com
0.0.0.0 www.gaicodon.com
0.0.0.0 www.gaiis.com
0.0.0.0 www.gainwintz.com
0.0.0.0 www.gamelthae.com
0.0.0.0 www.gameltjae.com
0.0.0.0 www.gamemeltbe.com
0.0.0.0 www.gameqnt.com
0.0.0.0 www.gamersigns.com
0.0.0.0 www.gandiatv.com
0.0.0.0 www.gangtaylor.property
0.0.0.0 www.gavelandcap.com
0.0.0.0 www.gekkstoyou.com
0.0.0.0 www.gekorn.com
0.0.0.0 www.generaldocs.com
0.0.0.0 www.gentleshadeox.pro
0.0.0.0 www.getnexuscard.com
0.0.0.0 www.gezinti.com
0.0.0.0 www.ggdark.net
0.0.0.0 www.giadungnguyennhat.com
0.0.0.0 www.gifttifyagency.com
0.0.0.0 www.gildedrosens.name
0.0.0.0 www.gimp.es
0.0.0.0 www.githubuser.com
0.0.0.0 www.glassygrovefy.pro
0.0.0.0 www.globalbuffer.com
0.0.0.0 www.globlepoker.com
0.0.0.0 www.goggle.com
0.0.0.0 www.goldendoodlez.com
0.0.0.0 www.goldentopics.com
0.0.0.0 www.gooddeserve.skin
0.0.0.0 www.googdiy.com
0.0.0.0 www.gotorobeks.com
0.0.0.0 www.governmentaution.com
0.0.0.0 www.gparted.fr
0.0.0.0 www.gpolitico.com
0.0.0.0 www.gracefulmeaduu.online
0.0.0.0 www.gradedoctortutoring.com
0.0.0.0 www.grandtables.com
0.0.0.0 www.greatdeposit.com
0.0.0.0 www.greenshot.fr
0.0.0.0 www.greenvistazj.pro
0.0.0.0 www.griffinlist.com
0.0.0.0 www.griffscomedyclub.com
0.0.0.0 www.grocreyoutlet.com
0.0.0.0 www.groundofsuccess.com
0.0.0.0 www.grouphappy.com
0.0.0.0 www.growthbuilder.name
0.0.0.0 www.guaranteeservice.lat
0.0.0.0 www.guashastone.com
0.0.0.0 www.gwizacademy.com
0.0.0.0 www.haikuservices.com
0.0.0.0 www.hairapothecaryco.com
0.0.0.0 www.hajoopteg.com
0.0.0.0 www.hakerzy.net
0.0.0.0 www.handbrake.es
0.0.0.0 www.happystonezk.pro
0.0.0.0 www.hardlyterrible.bond
0.0.0.0 www.hashing.win
0.0.0.0 www.hauloot.com
0.0.0.0 www.healthcompeting.rest
0.0.0.0 www.helvax.cfd
0.0.0.0 www.helvora.help
0.0.0.0 www.herselfshame.homes
0.0.0.0 www.hiewa.com.my
0.0.0.0 www.higherteam.com
0.0.0.0 www.hindudirectory.com
0.0.0.0 www.hitchedbridalandformalwear.com
0.0.0.0 www.hits-football.com
0.0.0.0 www.hoabridal.com
0.0.0.0 www.hocxaydung.com
0.0.0.0 www.homininfossil.cfd
0.0.0.0 www.hotelsdetermine.bond
0.0.0.0 www.hotpanic.net
0.0.0.0 www.hourofscience.com
0.0.0.0 www.hoursales.com
0.0.0.0 www.hugesector.com
0.0.0.0 www.hunterspeed.com
0.0.0.0 www.hypeprop.com
0.0.0.0 www.hypetrust.com
0.0.0.0 www.ibenefi.com
0.0.0.0 www.icecars.com
0.0.0.0 www.iconatsbs.com
0.0.0.0 www.icygrovejn.com
0.0.0.0 www.icyhivemy.name
0.0.0.0 www.iejonline.com
0.0.0.0 www.iepelnazareno.com
0.0.0.0 www.iesaber.com
0.0.0.0 www.igameup.com
0.0.0.0 www.ilyasasseban.com
0.0.0.0 www.improvingthe.com
0.0.0.0 www.indexprofile.com
0.0.0.0 www.infopaypal.com
0.0.0.0 www.informecadastral.com
0.0.0.0 www.informereng.com
0.0.0.0 www.inkscape.es
0.0.0.0 www.inkscape.fr
0.0.0.0 www.inpicklenaton.com
0.0.0.0 www.instantcross.com
0.0.0.0 www.inventons.com
0.0.0.0 www.invitegame.com
0.0.0.0 www.iovenesweb.com
0.0.0.0 www.irlandalk.com
0.0.0.0 www.irony.world
0.0.0.0 www.isavs.com
0.0.0.0 www.itemtools.com
0.0.0.0 www.iwantclothing.com
0.0.0.0 www.jackpotcasinojeux.com
0.0.0.0 www.jacqueruth.com
0.0.0.0 www.janushnderson.com
0.0.0.0 www.jerseyoffers.com
0.0.0.0 www.jessicalonda.com
0.0.0.0 www.jeuxfortuna.com
0.0.0.0 www.jeuxjackpotcasino.com
0.0.0.0 www.jewishgame.com
0.0.0.0 www.jhsmiami.com
0.0.0.0 www.jjbenefitsguide.com
0.0.0.0 www.jnhjf.com
0.0.0.0 www.jobomg.com
0.0.0.0 www.joinclap.com
0.0.0.0 www.joinfx.net
0.0.0.0 www.jovareo.com
0.0.0.0 www.justdebug.com
0.0.0.0 www.jvidzaixian.com
0.0.0.0 www.jvzoo.com
0.0.0.0 www.kahramananas.com
0.0.0.0 www.karazah.com
0.0.0.0 www.kccreamation.com
0.0.0.0 www.keepass.com
0.0.0.0 www.keepass.fr
0.0.0.0 www.kencorporation.property
0.0.0.0 www.kesau.com
0.0.0.0 www.keybinary.com
0.0.0.0 www.khanomtour.com
0.0.0.0 www.kinderstampo.com
0.0.0.0 www.kindnations.com
0.0.0.0 www.kindwebdg.site
0.0.0.0 www.kingfreetube.com
0.0.0.0 www.kishangarhlawcollege.com
0.0.0.0 www.kittayaroyalbeauty.com
0.0.0.0 www.kiwicares.com
0.0.0.0 www.knowinteractive.com
0.0.0.0 www.knoxmenus.com
0.0.0.0 www.kobotausa.com
0.0.0.0 www.konceptseven.com
0.0.0.0 www.kpremium.com
0.0.0.0 www.kryzantor.uk
0.0.0.0 www.ksiargentina.com
0.0.0.0 www.lacocinany.com
0.0.0.0 www.lahoreautismcentre.com
0.0.0.0 www.lamaisonhind.com
0.0.0.0 www.lanaita.com
0.0.0.0 www.langleyantiques.com
0.0.0.0 www.launchbuffer.com
0.0.0.0 www.learngears.com
0.0.0.0 www.learningfound.com
0.0.0.0 www.learnnessy.com
0.0.0.0 www.learntechno.com
0.0.0.0 www.ledfaucetlight.com
0.0.0.0 www.leeucode.com
0.0.0.0 www.lemoncascadexq.name
0.0.0.0 www.lfsph.com
0.0.0.0 www.libanco.com
0.0.0.0 www.lightcontest.com
0.0.0.0 www.lightstylist.com
0.0.0.0 www.likeportal.com			# Facebook trojan
0.0.0.0 www.likespike.com			# Facebook trojan
0.0.0.0 www.likethis.mbosoft.com		# Facebook trojan
0.0.0.0 www.likethislist.biz			# Facebook trojan
0.0.0.0 www.listadegames.com
0.0.0.0 www.liveorigamirisk.com
0.0.0.0 www.livetickettv.com
0.0.0.0 www.loansfield.com
0.0.0.0 www.lockupouseburn.com
0.0.0.0 www.loginhunter.com
0.0.0.0 www.logoradar.com
0.0.0.0 www.logoswitch.com
0.0.0.0 www.lomalindasda.org			# Facebook trojan
0.0.0.0 www.lookimpression.beer
0.0.0.0 www.lostbestsgames.com
0.0.0.0 www.loveromantic.com
0.0.0.0 www.lowestincreases.bond
0.0.0.0 www.lunargrovefx.com
0.0.0.0 www.luxeforher.com
0.0.0.0 www.madnesscase.com
0.0.0.0 www.magento-analytics.com
0.0.0.0 www.maiecaffe.com
0.0.0.0 www.maillazy.com
0.0.0.0 www.makearestaurant.com
0.0.0.0 www.makeupglobal.com
0.0.0.0 www.manoces.waw.pl
0.0.0.0 www.markethelper.name
0.0.0.0 www.marketinghwy.com
0.0.0.0 www.massagetherapybyjuli.com
0.0.0.0 www.match3quests.com
0.0.0.0 www.matifi.com
0.0.0.0 www.mcclartyauto.com
0.0.0.0 www.mdarussellhobbs.com
0.0.0.0 www.meantvictim.lat
0.0.0.0 www.mediamindpolska.com
0.0.0.0 www.meecheck.com
0.0.0.0 www.meeseger.com
0.0.0.0 www.megapurchase.com
0.0.0.0 www.memorieson.com
0.0.0.0 www.mexdrugs.com
0.0.0.0 www.mightpays.lol
0.0.0.0 www.mikras.nl
0.0.0.0 www.mildpost.com
0.0.0.0 www.milgaard.com
0.0.0.0 www.milkycascadeut.site
0.0.0.0 www.minr.pw
0.0.0.0 www.miocardite.com
0.0.0.0 www.mixsorts.garden
0.0.0.0 www.miziko.com
0.0.0.0 www.modelsailboat.net
0.0.0.0 www.moncasinoonline.com
0.0.0.0 www.monkeyball.osa.pl
0.0.0.0 www.monkikitchen.com
0.0.0.0 www.monstervits.com
0.0.0.0 www.morvalent.uk
0.0.0.0 www.mostexchange.com
0.0.0.0 www.movielocks.com
0.0.0.0 www.mshelp247.weebly.com
0.0.0.0 www.msmithguitarstudio.com
0.0.0.0 www.msmpokergamer.com
0.0.0.0 www.msxzff.com
0.0.0.0 www.multiceps.com
0.0.0.0 www.myalegent07.com
0.0.0.0 www.mycitycue.com
0.0.0.0 www.mycolonialpenm.com
0.0.0.0 www.mycontentlocker.com
0.0.0.0 www.myexotel.com
0.0.0.0 www.myfavcouponstore.com
0.0.0.0 www.myfurnituresirplus.com
0.0.0.0 www.myguidedreaders.com
0.0.0.0 www.myhucadvantage.com
0.0.0.0 www.mylike.co.uk			# Facebook trojan
0.0.0.0 www.mylovecards.com
0.0.0.0 www.mynepalshop.com
0.0.0.0 www.myrosinase.com
0.0.0.0 www.myupstox.com
0.0.0.0 www.nabtapharma.com
0.0.0.0 www.nanohistory.com
0.0.0.0 www.naturalmovementz.com
0.0.0.0 www.nearestsalon.com
0.0.0.0 www.necklaceu.com
0.0.0.0 www.negativesphere.com
0.0.0.0 www.neonpack.com
0.0.0.0 www.neonracketpro.com
0.0.0.0 www.netnaiga.com
0.0.0.0 www.new2crypto.com
0.0.0.0 www.newshello.com
0.0.0.0 www.nextfeatures.com
0.0.0.0 www.nftnavigator.com
0.0.0.0 www.nigja.com
0.0.0.0 www.nnews.net
0.0.0.0 www.nobetsjustfun.com
0.0.0.0 www.noithatphanthinh.com
0.0.0.0 www.northvalesgrids.uk
0.0.0.0 www.nostalgicroses.com
0.0.0.0 www.notepad2.com
0.0.0.0 www.novemberrainx.com
0.0.0.0 www.novosantiago.com
0.0.0.0 www.nowreact.com
0.0.0.0 www.nu26.com
0.0.0.0 www.nuntioz.com
0.0.0.0 www.nursse.com
0.0.0.0 www.nwbidrtb.com
0.0.0.0 www.nzgamingworld.com
0.0.0.0 www.oakog.com
0.0.0.0 www.oakridgeflows.uk
0.0.0.0 www.objectopoly.info
0.0.0.0 www.occoquananimalhospital.com
0.0.0.0 www.officerreport.com
0.0.0.0 www.ofimaniaweb.com
0.0.0.0 www.ogopond.com
0.0.0.0 www.oilbasics.com
0.0.0.0 www.ointrest.com
0.0.0.0 www.oix.com
0.0.0.0 www.oletipmegroup.com
0.0.0.0 www.olimpgokart.com
0.0.0.0 www.oliviathemes.com
0.0.0.0 www.onlinebidnow.com
0.0.0.0 www.onlinehint.com
0.0.0.0 www.opalcasinohotel.com
0.0.0.0 www.opencharms.com
0.0.0.0 www.openinternetexchange.com
0.0.0.0 www.oppery.com
0.0.0.0 www.orangesalonboise.com
0.0.0.0 www.orchidfootspa.com
0.0.0.0 www.otsserver.com
0.0.0.0 www.outonixan.com
0.0.0.0 www.pagibigfundservicers.com
0.0.0.0 www.paidsecure.com
0.0.0.0 www.paidtheme.com
0.0.0.0 www.paintballpins.com
0.0.0.0 www.paintingoccasion.living
0.0.0.0 www.paintnet.es
0.0.0.0 www.paintnet.fr
0.0.0.0 www.palaceskateboard.com
0.0.0.0 www.paradisepcgames.com
0.0.0.0 www.paramutplus.com
0.0.0.0 www.parejaamateur.com
0.0.0.0 www.partilla.com
0.0.0.0 www.partsttown.com
0.0.0.0 www.paseyourself.com
0.0.0.0 www.pashcams.com
0.0.0.0 www.patelshop.com
0.0.0.0 www.paviro.cfd
0.0.0.0 www.payasyougocert.com
0.0.0.0 www.pcfixguide.help
0.0.0.0 www.pdrill.com
0.0.0.0 www.pdxsenior.com
0.0.0.0 www.peachysailwv.pro
0.0.0.0 www.pearlyappss.pro
0.0.0.0 www.pelistvseries.com
0.0.0.0 www.peopleesbancorp.com
0.0.0.0 www.pepernity.com
0.0.0.0 www.perimentu.com
0.0.0.0 www.pfsim.com
0.0.0.0 www.phantomluck.com
0.0.0.0 www.phonecex.com
0.0.0.0 www.phonenumberbook.com
0.0.0.0 www.phormlabs.com
0.0.0.0 www.photomagicapp.com
0.0.0.0 www.pickupclean.com
0.0.0.0 www.picture-uploads.com
0.0.0.0 www.pinbroksup.com
0.0.0.0 www.pintransup.com
0.0.0.0 www.pintravelup.com
0.0.0.0 www.pinuperblog.com
0.0.0.0 www.pinupspinup.com
0.0.0.0 www.pipepractice.world
0.0.0.0 www.pixquestion.com
0.0.0.0 www.play-fever.com
0.0.0.0 www.playbestnet.com
0.0.0.0 www.playnowse.com
0.0.0.0 www.playroyaluk.com
0.0.0.0 www.playtactics-hub.com
0.0.0.0 www.pluseconomy.com
0.0.0.0 www.ponhap.com
0.0.0.0 www.popshopeu.com
0.0.0.0 www.portaldimensional.com
0.0.0.0 www.portlanfleathergoods.com
0.0.0.0 www.portutopcas.com
0.0.0.0 www.postsavings.com
0.0.0.0 www.poukladanyswiat.com
0.0.0.0 www.ppoi.org
0.0.0.0 www.prabvisa.com
0.0.0.0 www.premiercountrymeats.com
0.0.0.0 www.premiumbrandszonalibre.com
0.0.0.0 www.presidency.site
0.0.0.0 www.prgwbn.cfd
0.0.0.0 www.primecrestnq.name
0.0.0.0 www.primitivecountrydecor.com
0.0.0.0 www.princessuppies.com
0.0.0.0 www.proctou.com
0.0.0.0 www.proflashdata.com			# Facebook trojan
0.0.0.0 www.promoskills.com
0.0.0.0 www.properrayam.pro
0.0.0.0 www.proxionet.com
0.0.0.0 www.proxygeni.com
0.0.0.0 www.pruialoatpmye.xyz
0.0.0.0 www.psychics-readings-for-free.com
0.0.0.0 www.ptcasinoonline.com
0.0.0.0 www.puppywoodshihtzu.com
0.0.0.0 www.purchaseproof.com
0.0.0.0 www.pure-glance.com
0.0.0.0 www.qateee.com
0.0.0.0 www.qbittorrent.com
0.0.0.0 www.qualitygamer.com
0.0.0.0 www.quartersnorth.lat
0.0.0.0 www.quarvions.com
0.0.0.0 www.quintaalegrealgarve.com
0.0.0.0 www.quintingwatches.com
0.0.0.0 www.quipla.com
0.0.0.0 www.quotling.com
0.0.0.0 www.rackusread.com
0.0.0.0 www.rajtoursdubai.com
0.0.0.0 www.randki-sex.com
0.0.0.0 www.randrongames.com
0.0.0.0 www.raremosssr.name
0.0.0.0 www.raspberryketoneslim.com
0.0.0.0 www.reachtaxi.com
0.0.0.0 www.readyviews.com
0.0.0.0 www.realdrjudy.com
0.0.0.0 www.reandrogames.com
0.0.0.0 www.reasearchverified.com
0.0.0.0 www.recallblog.com
0.0.0.0 www.regulationprofit.bond
0.0.0.0 www.rekonsise.com
0.0.0.0 www.relaxingcafe.com
0.0.0.0 www.reliaslearrning.com
0.0.0.0 www.reltar.com
0.0.0.0 www.renderfoest.com
0.0.0.0 www.rerminix.com
0.0.0.0 www.revivemore.com
0.0.0.0 www.rhemacorp.com
0.0.0.0 www.rickrolling.com
0.0.0.0 www.ricontools.com
0.0.0.0 www.rightchanges.com
0.0.0.0 www.risedirectly.living
0.0.0.0 www.riversidefr.com
0.0.0.0 www.rnleonard.com
0.0.0.0 www.rnodernssolution.com
0.0.0.0 www.robkellysurf.com
0.0.0.0 www.romanticdemands.bond
0.0.0.0 www.roofcoins.com
0.0.0.0 www.roundtopbooks.com
0.0.0.0 www.rplconnect.com
0.0.0.0 www.rtkmyz.cfd
0.0.0.0 www.rtpbolaslotjago.com
0.0.0.0 www.russian-sex.com
0.0.0.0 www.sailpirate.com
0.0.0.0 www.saintmc.com
0.0.0.0 www.salliemaebenefits.com
0.0.0.0 www.salttm.com
0.0.0.0 www.sandybellxb.site
0.0.0.0 www.sandybrookyt.name
0.0.0.0 www.santemama.com
0.0.0.0 www.sapiatinsurance.com
0.0.0.0 www.sauteenacoochee.com
0.0.0.0 www.scrapzoneauto.com
0.0.0.0 www.sealabour.living
0.0.0.0 www.securitymeyrics.com
0.0.0.0 www.securityplusproducts.com
0.0.0.0 www.securityscan.us
0.0.0.0 www.seedschaos.garden
0.0.0.0 www.sellpetrol.com
0.0.0.0 www.sellrubber.com
0.0.0.0 www.shinilchurch.net	# domain was hacked and had a trojan installed
0.0.0.0 www.shinyechogz.name
0.0.0.0 www.shootingeffectively.skin
0.0.0.0 www.shopvisitors.com
0.0.0.0 www.shrimahaveercollege.com
0.0.0.0 www.sidneyman.com
0.0.0.0 www.silebah.com
0.0.0.0 www.silentgateck.site
0.0.0.0 www.silhouetteamerican.com
0.0.0.0 www.silverboxcreativestudio.com
0.0.0.0 www.simplyartful.com
0.0.0.0 www.simplyhelper.com
0.0.0.0 www.sinera.org
0.0.0.0 www.sizecart.com
0.0.0.0 www.skibidihotel.com
0.0.0.0 www.skillmatchgame.com
0.0.0.0 www.skincareds.com
0.0.0.0 www.skyonlinegratis.com
0.0.0.0 www.slawdhaka.com
0.0.0.0 www.slidingdoorlocks.com
0.0.0.0 www.smashchampionsat.com
0.0.0.0 www.smionecare.com
0.0.0.0 www.smokyshadecj.name
0.0.0.0 www.smtnaraynicollege.com
0.0.0.0 www.snkido.com
0.0.0.0 www.snowhandball.com
0.0.0.0 www.snugbirdjq.blog
0.0.0.0 www.snurrlyspin.com
0.0.0.0 www.soctoni.com
0.0.0.0 www.softcarp.com
0.0.0.0 www.softmillon.com
0.0.0.0 www.softpebble.com
0.0.0.0 www.softwarebeginner.com
0.0.0.0 www.sohailpc.com
0.0.0.0 www.sonparks.skin
0.0.0.0 www.spectrumhomehealthinc.com
0.0.0.0 www.speesway.com
0.0.0.0 www.spiritentertainment.homes
0.0.0.0 www.spojrzenia.com
0.0.0.0 www.sporttile.com
0.0.0.0 www.ssdede.com
0.0.0.0 www.ssl2.in
0.0.0.0 www.stanthedonutman.com
0.0.0.0 www.startupsforstartups.com
0.0.0.0 www.statsff.com
0.0.0.0 www.steelbucks.com
0.0.0.0 www.stellarium.fr
0.0.0.0 www.stelop.com
0.0.0.0 www.stihil.com
0.0.0.0 www.stocksrate.com
0.0.0.0 www.stopphoulplay.com
0.0.0.0 www.stormhelix.uk
0.0.0.0 www.stricklyhouses.com
0.0.0.0 www.strongarchzu.com
0.0.0.0 www.studioorientbay.com
0.0.0.0 www.stylistnet.com
0.0.0.0 www.styxwise.com
0.0.0.0 www.subwayfast.com
0.0.0.0 www.suchnasty.skin
0.0.0.0 www.sumgaydigital.com
0.0.0.0 www.sunglassesfor.com
0.0.0.0 www.supereeego.com
0.0.0.0 www.supportnestframe.uk
0.0.0.0 www.supportwindowlane.uk
0.0.0.0 www.susanhaggarphotography.com
0.0.0.0 www.svipfulishipin.com
0.0.0.0 www.swallowwire.sa.com
0.0.0.0 www.sweetdominique.com
0.0.0.0 www.sweetdreamiu.com
0.0.0.0 www.sweetiesecrets.com
0.0.0.0 www.tanger.com.br
0.0.0.0 www.tattnexa.tattoo
0.0.0.0 www.tattooshaha.info			# Facebook trojan
0.0.0.0 www.teacherblogit.com
0.0.0.0 www.teafortune.com
0.0.0.0 www.techadvisorpro.name
0.0.0.0 www.technocost.com
0.0.0.0 www.technygrow.com
0.0.0.0 www.techyscope.com
0.0.0.0 www.tenantbackgronudsearch.com
0.0.0.0 www.teresinaapartment.com
0.0.0.0 www.texasmyxoomenergy.com
0.0.0.0 www.textdynamics.com
0.0.0.0 www.thecollectiverd.com
0.0.0.0 www.thedatesafe.com			# Facebook trojan
0.0.0.0 www.thefriday.net
0.0.0.0 www.thegioibaove.com
0.0.0.0 www.thelaferianews.com
0.0.0.0 www.themesets.com
0.0.0.0 www.theprimeindia.com
0.0.0.0 www.thermature.com
0.0.0.0 www.thesecuredtrader.com
0.0.0.0 www.theskinnyschool.com
0.0.0.0 www.thisplanet.net
0.0.0.0 www.thunderbird.es
0.0.0.0 www.ticketspiket.com
0.0.0.0 www.timelyworks.com
0.0.0.0 www.tinkfrog.com
0.0.0.0 www.tiompanalley.com
0.0.0.0 www.tntadfacts.com
0.0.0.0 www.topluckystars.com
0.0.0.0 www.topopulentwin.com
0.0.0.0 www.totalencomenda.com
0.0.0.0 www.toysmetaverse.com
0.0.0.0 www.tradesasa.com
0.0.0.0 www.tradewinning.com
0.0.0.0 www.traficsigntest.com
0.0.0.0 www.transcet.com
0.0.0.0 www.travelrushzone.com
0.0.0.0 www.trucktirehotline.com
0.0.0.0 www.truecrypt.fr
0.0.0.0 www.trueshelterju.pro
0.0.0.0 www.trustaddons.com
0.0.0.0 www.ttcgg.com
0.0.0.0 www.tuningcentar.com
0.0.0.0 www.tuscanypointevillas.com
0.0.0.0 www.tvccpt.com
0.0.0.0 www.tvrails.com
0.0.0.0 www.tvshowslist.com
0.0.0.0 www.ultimarerewards.com
0.0.0.0 www.ultratemps.com
0.0.0.0 www.unclaimedbaggag.com
0.0.0.0 www.underobviously.garden
0.0.0.0 www.unetbootin.net
0.0.0.0 www.unetbootin.org
0.0.0.0 www.upgradebasic.com
0.0.0.0 www.upi6.pillsstore-c.com		# Facebook trojan
0.0.0.0 www.uqz.com
0.0.0.0 www.urldelivery.com
0.0.0.0 www.utgzlogin.com
0.0.0.0 www.vacnleefarpels.com
0.0.0.0 www.vbttech.com
0.0.0.0 www.vebprostopinup.com
0.0.0.0 www.vecchiopools.com
0.0.0.0 www.ventilationdirec.com
0.0.0.0 www.venturead.com
0.0.0.0 www.vetmanevi.com
0.0.0.0 www.videolove.clanteam.com
0.0.0.0 www.videonhadat.com
0.0.0.0 www.videostan.ru
0.0.0.0 www.vipnac.com
0.0.0.0 www.visitigangels.com
0.0.0.0 www.vkvmotion.com
0.0.0.0 www.vnailssanclemente.com
0.0.0.0 www.volvce.com
0.0.0.0 www.voolat.com
0.0.0.0 www.walkhelp.net
0.0.0.0 www.wantsfly.com
0.0.0.0 www.wapersab.com
0.0.0.0 www.wardhotels.com
0.0.0.0 www.warrenmovers.net
0.0.0.0 www.watchesnew.com
0.0.0.0 www.waterchalk.com
0.0.0.0 www.waterchamber.com
0.0.0.0 www.webassembly.stream
0.0.0.0 www.webdesignmetric.com
0.0.0.0 www.webdevotee.com
0.0.0.0 www.webmicrostores.com
0.0.0.0 www.webontwerp.com
0.0.0.0 www.webpartition.com
0.0.0.0 www.websrruss.com
0.0.0.0 www.webwise.com
0.0.0.0 www.webwise.org
0.0.0.0 www.weknow.ac
0.0.0.0 www.wewillrocknow.com
0.0.0.0 www.wezelco.com
0.0.0.0 www.wgmarketingdigital.com
0.0.0.0 www.whatsappvido.com
0.0.0.0 www.whiskeyallys.com
0.0.0.0 www.white-dock.net
0.0.0.0 www.wholesaleorganix.com
0.0.0.0 www.wifimarfixhotspot.com
0.0.0.0 www.wildriderfuns.com
0.0.0.0 www.wildroostli.com
0.0.0.0 www.willysy.com
0.0.0.0 www.winecrazydesigns.com
0.0.0.0 www.wingfoilmargarita.com
0.0.0.0 www.winlottofrequently.com
0.0.0.0 www.wiseknows.bond
0.0.0.0 www.wjldfm.com
0.0.0.0 www.wontake.skin
0.0.0.0 www.woodycrystaljo.name
0.0.0.0 www.workschat.com
0.0.0.0 www.wraploans.com
0.0.0.0 www.wrestlewebnews.com
0.0.0.0 www.wwwhwgo.com
0.0.0.0 www.wwwmyboostnow.com
0.0.0.0 www.wwwpaipal.com
0.0.0.0 www.wwwtsg.com
0.0.0.0 www.xandermaker.com
0.0.0.0 www.xdesimbi.com
0.0.0.0 www.xtremetechcr.com
0.0.0.0 www.yellowquartzkr.name
0.0.0.0 www.yendermsoul.com
0.0.0.0 www.yesyouvan.com
0.0.0.0 www.yixiudn.com
0.0.0.0 www.ylgj789.com
0.0.0.0 www.yoolyes.com
0.0.0.0 www.yottacash.com
0.0.0.0 www.youfiletor.com
0.0.0.0 www.yreta.com
0.0.0.0 www.zenithvault.uk
0.0.0.0 www.zephyrvineky.online
0.0.0.0 www.zippylakeri.name
0.0.0.0 www1-van-city-signon.com
0.0.0.0 wyoutube.fr
0.0.0.0 xcdkb.comfortykive.xyz
0.0.0.0 xen-media.com
0.0.0.0 xmssxx.com
0.0.0.0 xn--80afden1bnch4a.xn--p1ai
0.0.0.0 xn--oogle-wmc.com
0.0.0.0 xpx7heciz9.com
0.0.0.0 xxlargepop.com
0.0.0.0 yachtingmagazine.fr
0.0.0.0 yama.myfixhub.cfd
0.0.0.0 yanteaviation.com
0.0.0.0 ycapital.fr
0.0.0.0 yev.moviesdirectpro.com
0.0.0.0 yexex.comfortykive.xyz
0.0.0.0 ykjure.com
0.0.0.0 ykocr.comfortykive.xyz
0.0.0.0 yllvye.com
0.0.0.0 ymail-activate1.bugs3.com
0.0.0.0 yogamagazine.fr
0.0.0.0 you-fm.fr
0.0.0.0 youcanoptout.com
0.0.0.0 youmakeashion.fr
0.0.0.0 yourdailytrailer.yournewtab.com
0.0.0.0 yourhlth.ru.com
0.0.0.0 yourmailservice.com
0.0.0.0 yourofficialsurveysplace.store
0.0.0.0 youvisit.fr
0.0.0.0 yrwap.cn
0.0.0.0 yummie.fr
0.0.0.0 yves-rocker.fr
0.0.0.0 yyanluo.com
0.0.0.0 z3.skdfoiqwjelmdkfser.ru
0.0.0.0 zalanado.fr
0.0.0.0 zalandon.fr
0.0.0.0 zb1.zeroredirect1.com
0.0.0.0 zealous-push.surge.sh
0.0.0.0 zendictees.fr
0.0.0.0 zenigameblinger.org
0.0.0.0 zettapetta.com
0.0.0.0 zhunhesh.com
0.0.0.0 zimmernroofingservices.com
0.0.0.0 zip.er.cz
0.0.0.0 zjchao.com
0.0.0.0 zjgaoergao.com
0.0.0.0 ztriskl.divisionfair.homes
0.0.0.0 zzhc.vnet.cn
0.0.0.0 zzkwg.comfortykive.xyz
#</malware-sites>

#<doubleclick-sites>

#0.0.0.0 pubads.g.doubleclick.net	#interferes with video on cwtv.com
0.0.0.0 ad-emea.doubleclick.net
0.0.0.0 ad-g.doubleclick.net
0.0.0.0 ad.ae.doubleclick.net
0.0.0.0 ad.be.doubleclick.net
0.0.0.0 ad.br.doubleclick.net
0.0.0.0 ad.de.doubleclick.net
0.0.0.0 ad.dk.doubleclick.net
0.0.0.0 ad.doubleclick.net
0.0.0.0 ad.es.doubleclick.net
0.0.0.0 ad.fi.doubleclick.net
0.0.0.0 ad.fr.doubleclick.net
0.0.0.0 ad.it.doubleclick.net
0.0.0.0 ad.jp.doubleclick.net
0.0.0.0 ad.mo.doubleclick.net
0.0.0.0 ad.n2434.doubleclick.net
0.0.0.0 ad.nl.doubleclick.net
0.0.0.0 ad.no.doubleclick.net
0.0.0.0 ad.nz.doubleclick.net
0.0.0.0 ad.pl.doubleclick.net
0.0.0.0 ad.se.doubleclick.net
0.0.0.0 ad.sg.doubleclick.net
0.0.0.0 ad.uk.doubleclick.net
0.0.0.0 ad.ve.doubleclick.net
0.0.0.0 ad.za.doubleclick.net
0.0.0.0 ad2.doubleclick.net
0.0.0.0 adclick.g.doubleclick.net
0.0.0.0 cm.g.doubleclick.net
0.0.0.0 creative.cc-dt.com
0.0.0.0 doubleclick.com
0.0.0.0 doubleclick.de
0.0.0.0 doubleclick.net
0.0.0.0 feedads.g.doubleclick.net
0.0.0.0 fls.doubleclick.net
0.0.0.0 googleads.g.doubleclick.net
0.0.0.0 iv.doubleclick.net
0.0.0.0 m.2mdn.net
0.0.0.0 m.doubleclick.net
0.0.0.0 m1.2mdn.net
0.0.0.0 n479ad.doubleclick.net
0.0.0.0 pagead.l.doubleclick.net
0.0.0.0 pagead46.l.doubleclick.net
0.0.0.0 stats.g.doubleclick.net
0.0.0.0 stats.l.doubleclick.net
0.0.0.0 ukrpts.net
#</doubleclick-sites>

#<intellitxt-sites>

0.0.0.0 contactmusic.uk.intellitxt.com
0.0.0.0 ferrago.uk.intellitxt.com
0.0.0.0 freedownloadcenter.uk.intellitxt.com
0.0.0.0 gadgets.fosfor.se.intellitxt.com
0.0.0.0 images.intellitxt.com
0.0.0.0 k.intellitxt.com
0.0.0.0 maccity.it.intellitxt.com
0.0.0.0 macuser.uk.intellitxt.com
0.0.0.0 macworld.uk.intellitxt.com
0.0.0.0 metro.uk.intellitxt.com
0.0.0.0 monstersandcritics.uk.intellitxt.com
0.0.0.0 moviesonline.ca.intellitxt.com
0.0.0.0 newcarnet.uk.intellitxt.com
0.0.0.0 newlaunches.uk.intellitxt.com
0.0.0.0 pcadvisor.uk.intellitxt.com
0.0.0.0 pcgameshardware.de.intellitxt.com
0.0.0.0 physorg.uk.intellitxt.com
0.0.0.0 playfuls.uk.intellitxt.com
0.0.0.0 pocketlint.uk.intellitxt.com
0.0.0.0 pspcave.uk.intellitxt.com
0.0.0.0 softpedia.uk.intellitxt.com
0.0.0.0 splashnews.uk.intellitxt.com
0.0.0.0 wi-fitechnology.uk.intellitxt.com
#</intellitxt-sites>

#<red-sheriff-sites>

# Red Sheriff and imrworldwide.com  -- server side tracking
#0.0.0.0 secure-au.imrworldwide.com
0.0.0.0 fe-au.imrworldwide.com
0.0.0.0 fe1-au.imrworldwide.com
0.0.0.0 fe2-au.imrworldwide.com
0.0.0.0 fe3-au.imrworldwide.com
0.0.0.0 imrworldwide.com
0.0.0.0 lycos-eu.imrworldwide.com
0.0.0.0 ninemsn.imrworldwide.com
0.0.0.0 rc-au.imrworldwide.com
0.0.0.0 redsheriff.com
0.0.0.0 secure-jp.imrworldwide.com
0.0.0.0 secure-nz.imrworldwide.com
0.0.0.0 secure-uk.imrworldwide.com
0.0.0.0 secure-za.imrworldwide.com
0.0.0.0 server-au.imrworldwide.com
0.0.0.0 server-br.imrworldwide.com
0.0.0.0 server-by.imrworldwide.com
0.0.0.0 server-de.imrworldwide.com
0.0.0.0 server-dk.imrworldwide.com
0.0.0.0 server-ee.imrworldwide.com
0.0.0.0 server-fi.imrworldwide.com
0.0.0.0 server-fr.imrworldwide.com
0.0.0.0 server-hk.imrworldwide.com
0.0.0.0 server-it.imrworldwide.com
0.0.0.0 server-jp.imrworldwide.com
0.0.0.0 server-lt.imrworldwide.com
0.0.0.0 server-lv.imrworldwide.com
0.0.0.0 server-no.imrworldwide.com
0.0.0.0 server-nz.imrworldwide.com
0.0.0.0 server-oslo.imrworldwide.com
0.0.0.0 server-pl.imrworldwide.com
0.0.0.0 server-ru.imrworldwide.com
0.0.0.0 server-se.imrworldwide.com
0.0.0.0 server-sg.imrworldwide.com
0.0.0.0 server-stockh.imrworldwide.com
0.0.0.0 server-ua.imrworldwide.com
0.0.0.0 server-uk.imrworldwide.com
0.0.0.0 server-us.imrworldwide.com
0.0.0.0 telstra.imrworldwide.com
0.0.0.0 www.redsheriff.com
#</red-sheriff-sites>

#<cydoor-sites>

# cydoor -- server side tracking
0.0.0.0 cydoor.com
0.0.0.0 j.2004cms.com
0.0.0.0 jbaventures.cjt1.net
0.0.0.0 jbeet.cjt1.net
0.0.0.0 jbit.cjt1.net
0.0.0.0 jcollegehumor.cjt1.net
0.0.0.0 jdownloadacc.cjt1.net
0.0.0.0 jgen1.cjt1.net
0.0.0.0 jgen10.cjt1.net
0.0.0.0 jgen11.cjt1.net
0.0.0.0 jgen12.cjt1.net
0.0.0.0 jgen13.cjt1.net
0.0.0.0 jgen14.cjt1.net
0.0.0.0 jgen15.cjt1.net
0.0.0.0 jgen16.cjt1.net
0.0.0.0 jgen17.cjt1.net
0.0.0.0 jgen18.cjt1.net
0.0.0.0 jgen19.cjt1.net
0.0.0.0 jgen2.cjt1.net
0.0.0.0 jgen20.cjt1.net
0.0.0.0 jgen21.cjt1.net
0.0.0.0 jgen22.cjt1.net
0.0.0.0 jgen23.cjt1.net
0.0.0.0 jgen24.cjt1.net
0.0.0.0 jgen25.cjt1.net
0.0.0.0 jgen26.cjt1.net
0.0.0.0 jgen27.cjt1.net
0.0.0.0 jgen28.cjt1.net
0.0.0.0 jgen29.cjt1.net
0.0.0.0 jgen3.cjt1.net
0.0.0.0 jgen30.cjt1.net
0.0.0.0 jgen31.cjt1.net
0.0.0.0 jgen32.cjt1.net
0.0.0.0 jgen33.cjt1.net
0.0.0.0 jgen34.cjt1.net
0.0.0.0 jgen35.cjt1.net
0.0.0.0 jgen36.cjt1.net
0.0.0.0 jgen37.cjt1.net
0.0.0.0 jgen38.cjt1.net
0.0.0.0 jgen39.cjt1.net
0.0.0.0 jgen4.cjt1.net
0.0.0.0 jgen40.cjt1.net
0.0.0.0 jgen41.cjt1.net
0.0.0.0 jgen42.cjt1.net
0.0.0.0 jgen43.cjt1.net
0.0.0.0 jgen44.cjt1.net
0.0.0.0 jgen45.cjt1.net
0.0.0.0 jgen46.cjt1.net
0.0.0.0 jgen47.cjt1.net
0.0.0.0 jgen48.cjt1.net
0.0.0.0 jgen49.cjt1.net
0.0.0.0 jgen5.cjt1.net
0.0.0.0 jgen6.cjt1.net
0.0.0.0 jgen7.cjt1.net
0.0.0.0 jgen8.cjt1.net
0.0.0.0 jgen9.cjt1.net
0.0.0.0 jhumour.cjt1.net
0.0.0.0 jmbi58.cjt1.net
0.0.0.0 jnova.cjt1.net
0.0.0.0 jpirate.cjt1.net
0.0.0.0 jsandboxer.cjt1.net
0.0.0.0 jumcna.cjt1.net
0.0.0.0 jwebbsense.cjt1.net
0.0.0.0 www.cydoor.com
#</cydoor-sites>

#<2o7-sites>

# 2o7.net -- server side tracking
#0.0.0.0 appleglobal.112.2o7.net	#breaks apple.com
#0.0.0.0 applestoreus.112.2o7.net	#breaks apple.com
0.0.0.0 102.112.2o7.net
0.0.0.0 102.122.2o7.net
0.0.0.0 112.2o7.net
0.0.0.0 122.2o7.net
0.0.0.0 192.168.112.2o7.net
0.0.0.0 2o7.net
0.0.0.0 actforvictory.112.2o7.net
0.0.0.0 adbrite.112.2o7.net
0.0.0.0 adbrite.122.2o7.net
0.0.0.0 aehistory.112.2o7.net
0.0.0.0 aetv.112.2o7.net
0.0.0.0 agamgreetingscom.112.2o7.net
0.0.0.0 allbritton.122.2o7.net
0.0.0.0 americanbaby.112.2o7.net
0.0.0.0 ancestrymsn.112.2o7.net
0.0.0.0 ancestryuki.112.2o7.net
0.0.0.0 and.co.uk.102.122.2o7.net
0.0.0.0 angiba.112.2o7.net
0.0.0.0 angmar.112.2o7.net
0.0.0.0 angtr.112.2o7.net
0.0.0.0 angts.112.2o7.net
0.0.0.0 angvac.112.2o7.net
0.0.0.0 anm.112.2o7.net
0.0.0.0 aolcareers.122.2o7.net
0.0.0.0 aoldlama.122.2o7.net
0.0.0.0 aoljournals.122.2o7.net
0.0.0.0 aolnsnews.122.2o7.net
0.0.0.0 aolpf.122.2o7.net
0.0.0.0 aolpolls.112.2o7.net
0.0.0.0 aolpolls.122.2o7.net
0.0.0.0 aolsearch.122.2o7.net
0.0.0.0 aolsvc.122.2o7.net
0.0.0.0 aoltmz.122.2o7.net
0.0.0.0 aolturnercnnmoney.112.2o7.net
0.0.0.0 aolturnercnnmoney.122.2o7.net
0.0.0.0 aolturnersi.122.2o7.net
0.0.0.0 aolukglobal.122.2o7.net
0.0.0.0 aolwinamp.122.2o7.net
0.0.0.0 aolwpaim.112.2o7.net
0.0.0.0 aolwpicq.122.2o7.net
0.0.0.0 aolwpmq.112.2o7.net
0.0.0.0 aolwpmqnoban.112.2o7.net
0.0.0.0 apdigitalorg.112.2o7.net
0.0.0.0 apdigitalorgovn.112.2o7.net
0.0.0.0 apnonline.112.2o7.net
0.0.0.0 atlassian.122.2o7.net
0.0.0.0 autobytel.112.2o7.net
0.0.0.0 autoweb.112.2o7.net
0.0.0.0 bbcnewscouk.112.2o7.net
0.0.0.0 bellca.112.2o7.net
0.0.0.0 bellglobemediapublishing.122.2o7.net
0.0.0.0 bellglovemediapublishing.122.2o7.net
0.0.0.0 bellserviceeng.112.2o7.net
0.0.0.0 betterhg.112.2o7.net
0.0.0.0 bhgmarketing.112.2o7.net
0.0.0.0 bidentonrccom.122.2o7.net
0.0.0.0 biwwltvcom.112.2o7.net
0.0.0.0 biwwltvcom.122.2o7.net
0.0.0.0 blackpress.122.2o7.net
0.0.0.0 bnkr8dev.112.2o7.net
0.0.0.0 bntbcstglobal.112.2o7.net
0.0.0.0 bosecom.112.2o7.net
0.0.0.0 brightcove.112.2o7.net
0.0.0.0 bulldog.122.2o7.net
0.0.0.0 businessweekpoc.112.2o7.net
0.0.0.0 bzresults.122.2o7.net
0.0.0.0 cablevision.112.2o7.net
0.0.0.0 canwest.112.2o7.net
0.0.0.0 canwestcom.112.2o7.net
0.0.0.0 canwestglobal.112.2o7.net
0.0.0.0 capcityadvcom.112.2o7.net
0.0.0.0 capcityadvcom.122.2o7.net
0.0.0.0 careers.112.2o7.net
0.0.0.0 cartoonnetwork.122.2o7.net
0.0.0.0 cbaol.112.2o7.net
0.0.0.0 cbc.122.2o7.net
0.0.0.0 cbcca.112.2o7.net
0.0.0.0 cbcca.122.2o7.net
0.0.0.0 cbcincinnatienquirer.112.2o7.net
0.0.0.0 cbmsn.112.2o7.net
0.0.0.0 cbs.112.2o7.net
0.0.0.0 cbsncaasports.112.2o7.net
0.0.0.0 cbsnfl.112.2o7.net
0.0.0.0 cbspgatour.112.2o7.net
0.0.0.0 cbsspln.112.2o7.net
0.0.0.0 ccrbudgetca.112.2o7.net
0.0.0.0 ccrgaviscom.112.2o7.net
0.0.0.0 cfrfa.112.2o7.net
0.0.0.0 chicagosuntimes.122.2o7.net
0.0.0.0 chumtv.122.2o7.net
0.0.0.0 classifiedscanada.112.2o7.net
0.0.0.0 classmatescom.112.2o7.net
0.0.0.0 cmpglobalvista.112.2o7.net
0.0.0.0 cnetasiapacific.122.2o7.net
0.0.0.0 cnetaustralia.122.2o7.net
0.0.0.0 cneteurope.122.2o7.net
0.0.0.0 cnetnews.112.2o7.net
0.0.0.0 cnetzdnet.112.2o7.net
0.0.0.0 cnhienid.122.2o7.net
0.0.0.0 cnhimcalesternews.122.2o7.net
0.0.0.0 cnhipicayuneitemv.112.2o7.net
0.0.0.0 cnhitribunestar.122.2o7.net
0.0.0.0 cnhitribunestara.122.2o7.net
0.0.0.0 cnhregisterherald.122.2o7.net
0.0.0.0 cnn.122.2o7.net
0.0.0.0 computerworldcom.112.2o7.net
0.0.0.0 condenast.112.2o7.net
0.0.0.0 coxnetmasterglobal.112.2o7.net
0.0.0.0 coxpalmbeachpost.112.2o7.net
0.0.0.0 csoonlinecom.112.2o7.net
0.0.0.0 ctvcrimelibrary.112.2o7.net
0.0.0.0 ctvsmokinggun.112.2o7.net
0.0.0.0 cxociocom.112.2o7.net
0.0.0.0 denverpost.112.2o7.net
0.0.0.0 diginet.112.2o7.net
0.0.0.0 digitalhomediscountptyltd.122.2o7.net
0.0.0.0 disccglobal.112.2o7.net
0.0.0.0 disccstats.112.2o7.net
0.0.0.0 dischannel.112.2o7.net
0.0.0.0 divx.112.2o7.net
0.0.0.0 dixonslnkcouk.112.2o7.net
0.0.0.0 dogpile.112.2o7.net
0.0.0.0 donval.112.2o7.net
0.0.0.0 dowjones.122.2o7.net
0.0.0.0 dreammates.112.2o7.net
0.0.0.0 eaeacom.112.2o7.net
0.0.0.0 eagamesuk.112.2o7.net
0.0.0.0 earthlnkpsplive.122.2o7.net
0.0.0.0 ebay1.112.2o7.net
0.0.0.0 ebaynonreg.112.2o7.net
0.0.0.0 ebayreg.112.2o7.net
0.0.0.0 ebayus.112.2o7.net
0.0.0.0 ebcom.112.2o7.net
0.0.0.0 ectestlampsplus1.112.2o7.net
0.0.0.0 edietsmain.112.2o7.net
0.0.0.0 edmundsinsideline.112.2o7.net
0.0.0.0 edsa.112.2o7.net
0.0.0.0 ehg-moma.hitbox.com.112.2o7.net
0.0.0.0 emc.122.2o7.net
0.0.0.0 employ22.112.2o7.net
0.0.0.0 employ26.112.2o7.net
0.0.0.0 employment.112.2o7.net
0.0.0.0 enterprisenewsmedia.122.2o7.net
0.0.0.0 epost.122.2o7.net
0.0.0.0 ewsnaples.112.2o7.net
0.0.0.0 ewstcpalm.112.2o7.net
0.0.0.0 examinercom.122.2o7.net
0.0.0.0 execulink.112.2o7.net
0.0.0.0 expedia.ca.112.2o7.net
0.0.0.0 expedia4.112.2o7.net
0.0.0.0 f2ncracker.112.2o7.net
0.0.0.0 f2nsmh.112.2o7.net
0.0.0.0 f2ntheage.112.2o7.net
0.0.0.0 faceoff.112.2o7.net
0.0.0.0 fbkmnr.112.2o7.net
0.0.0.0 forbesattache.112.2o7.net
0.0.0.0 forbesauto.112.2o7.net
0.0.0.0 forbesautos.112.2o7.net
0.0.0.0 forbescom.112.2o7.net
0.0.0.0 ford.112.2o7.net
0.0.0.0 foxcom.112.2o7.net
0.0.0.0 foxsimpsons.112.2o7.net
0.0.0.0 georgewbush.112.2o7.net
0.0.0.0 georgewbushcom.112.2o7.net
0.0.0.0 gettyimages.122.2o7.net
0.0.0.0 gjfastcompanycom.112.2o7.net
0.0.0.0 gmchevyapprentice.112.2o7.net
0.0.0.0 gmhummer.112.2o7.net
0.0.0.0 gntbcstglobal.112.2o7.net
0.0.0.0 gntbcstkxtv.112.2o7.net
0.0.0.0 gntbcstwtsp.112.2o7.net
0.0.0.0 gpaper104.112.2o7.net
0.0.0.0 gpaper105.112.2o7.net
0.0.0.0 gpaper107.112.2o7.net
0.0.0.0 gpaper108.112.2o7.net
0.0.0.0 gpaper109.112.2o7.net
0.0.0.0 gpaper110.112.2o7.net
0.0.0.0 gpaper111.112.2o7.net
0.0.0.0 gpaper112.112.2o7.net
0.0.0.0 gpaper113.112.2o7.net
0.0.0.0 gpaper114.112.2o7.net
0.0.0.0 gpaper115.112.2o7.net
0.0.0.0 gpaper116.112.2o7.net
0.0.0.0 gpaper117.112.2o7.net
0.0.0.0 gpaper118.112.2o7.net
0.0.0.0 gpaper119.112.2o7.net
0.0.0.0 gpaper120.112.2o7.net
0.0.0.0 gpaper121.112.2o7.net
0.0.0.0 gpaper122.112.2o7.net
0.0.0.0 gpaper123.112.2o7.net
0.0.0.0 gpaper124.112.2o7.net
0.0.0.0 gpaper125.112.2o7.net
0.0.0.0 gpaper126.112.2o7.net
0.0.0.0 gpaper127.112.2o7.net
0.0.0.0 gpaper128.112.2o7.net
0.0.0.0 gpaper129.112.2o7.net
0.0.0.0 gpaper131.112.2o7.net
0.0.0.0 gpaper132.112.2o7.net
0.0.0.0 gpaper133.112.2o7.net
0.0.0.0 gpaper138.112.2o7.net
0.0.0.0 gpaper139.112.2o7.net
0.0.0.0 gpaper140.112.2o7.net
0.0.0.0 gpaper141.112.2o7.net
0.0.0.0 gpaper142.112.2o7.net
0.0.0.0 gpaper144.112.2o7.net
0.0.0.0 gpaper145.112.2o7.net
0.0.0.0 gpaper147.112.2o7.net
0.0.0.0 gpaper149.112.2o7.net
0.0.0.0 gpaper151.112.2o7.net
0.0.0.0 gpaper154.112.2o7.net
0.0.0.0 gpaper156.112.2o7.net
0.0.0.0 gpaper157.112.2o7.net
0.0.0.0 gpaper158.112.2o7.net
0.0.0.0 gpaper162.112.2o7.net
0.0.0.0 gpaper164.112.2o7.net
0.0.0.0 gpaper166.112.2o7.net
0.0.0.0 gpaper167.112.2o7.net
0.0.0.0 gpaper169.112.2o7.net
0.0.0.0 gpaper170.112.2o7.net
0.0.0.0 gpaper171.112.2o7.net
0.0.0.0 gpaper172.112.2o7.net
0.0.0.0 gpaper173.112.2o7.net
0.0.0.0 gpaper174.112.2o7.net
0.0.0.0 gpaper176.112.2o7.net
0.0.0.0 gpaper177.112.2o7.net
0.0.0.0 gpaper180.112.2o7.net
0.0.0.0 gpaper183.112.2o7.net
0.0.0.0 gpaper184.112.2o7.net
0.0.0.0 gpaper191.112.2o7.net
0.0.0.0 gpaper192.112.2o7.net
0.0.0.0 gpaper193.112.2o7.net
0.0.0.0 gpaper194.112.2o7.net
0.0.0.0 gpaper195.112.2o7.net
0.0.0.0 gpaper196.112.2o7.net
0.0.0.0 gpaper197.112.2o7.net
0.0.0.0 gpaper198.112.2o7.net
0.0.0.0 gpaper202.112.2o7.net
0.0.0.0 gpaper204.112.2o7.net
0.0.0.0 gpaper205.112.2o7.net
0.0.0.0 gpaper212.112.2o7.net
0.0.0.0 gpaper214.112.2o7.net
0.0.0.0 gpaper219.112.2o7.net
0.0.0.0 gpaper223.112.2o7.net
0.0.0.0 harpo.122.2o7.net
0.0.0.0 hchrmain.112.2o7.net
0.0.0.0 heavycom.112.2o7.net
0.0.0.0 heavycom.122.2o7.net
0.0.0.0 homesclick.112.2o7.net
0.0.0.0 hostdomainpeople.112.2o7.net
0.0.0.0 hostdomainpeopleca.112.2o7.net
0.0.0.0 hostpowermedium.112.2o7.net
0.0.0.0 hpglobal.112.2o7.net
0.0.0.0 hphqglobal.112.2o7.net
0.0.0.0 hphqsearch.112.2o7.net
0.0.0.0 infomart.ca.112.2o7.net
0.0.0.0 infospace.com.112.2o7.net
0.0.0.0 intelcorpcim.112.2o7.net
0.0.0.0 intelglobal.112.2o7.net
0.0.0.0 ivillageglobal.112.2o7.net
0.0.0.0 jijsonline.122.2o7.net
0.0.0.0 jitmj4.122.2o7.net
0.0.0.0 johnlewis.112.2o7.net
0.0.0.0 journalregistercompany.122.2o7.net
0.0.0.0 kddi.122.2o7.net
0.0.0.0 krafteurope.112.2o7.net
0.0.0.0 ktva.112.2o7.net
0.0.0.0 ladieshj.112.2o7.net
0.0.0.0 laptopmag.122.2o7.net
0.0.0.0 laxnws.112.2o7.net
0.0.0.0 laxprs.112.2o7.net
0.0.0.0 laxpsd.112.2o7.net
0.0.0.0 ldsfch.112.2o7.net
0.0.0.0 leeenterprises.112.2o7.net
0.0.0.0 lenovo.112.2o7.net
0.0.0.0 logoworksdev.112.2o7.net
0.0.0.0 losu.112.2o7.net
0.0.0.0 mailtribune.112.2o7.net
0.0.0.0 maxim.122.2o7.net
0.0.0.0 maxvr.112.2o7.net
0.0.0.0 mdamarillo.112.2o7.net
0.0.0.0 mdjacksonville.112.2o7.net
0.0.0.0 mdtopeka.112.2o7.net
0.0.0.0 mdwardmore.112.2o7.net
0.0.0.0 mdwsavannah.112.2o7.net
0.0.0.0 medbroadcast.112.2o7.net
0.0.0.0 mediabistrocom.112.2o7.net
0.0.0.0 mediamatters.112.2o7.net
0.0.0.0 meetupcom.112.2o7.net
0.0.0.0 metacafe.122.2o7.net
0.0.0.0 metro.co.uk.102.122.2o7.net
0.0.0.0 mgjournalnow.112.2o7.net
0.0.0.0 mgtbo.112.2o7.net
0.0.0.0 mgtimesdispatch.112.2o7.net
0.0.0.0 mgwsls.112.2o7.net
0.0.0.0 mgwspa.112.2o7.net
0.0.0.0 microsoftconsumermarketing.112.2o7.net
0.0.0.0 microsofteup.112.2o7.net
0.0.0.0 microsoftwindows.112.2o7.net
0.0.0.0 midala.112.2o7.net
0.0.0.0 midar.112.2o7.net
0.0.0.0 midsen.112.2o7.net
0.0.0.0 mlbastros.112.2o7.net
0.0.0.0 mlbcolorado.112.2o7.net
0.0.0.0 mlbcom.112.2o7.net
0.0.0.0 mlbglobal.112.2o7.net
0.0.0.0 mlbglobal08.112.2o7.net
0.0.0.0 mlbhouston.112.2o7.net
0.0.0.0 mlbstlouis.112.2o7.net
0.0.0.0 mlbtoronto.112.2o7.net
0.0.0.0 mmsshopcom.112.2o7.net
0.0.0.0 mnfidnahub.112.2o7.net
0.0.0.0 mngidmn.112.2o7.net
0.0.0.0 mngirockymtnnews.112.2o7.net
0.0.0.0 mngislctrib.112.2o7.net
0.0.0.0 mngiyrkdr.112.2o7.net
0.0.0.0 mseuppremain.112.2o7.net
0.0.0.0 msnmercom.112.2o7.net
0.0.0.0 msnportal.112.2o7.net
0.0.0.0 mtvn.112.2o7.net
0.0.0.0 mtvu.112.2o7.net
0.0.0.0 mxmacromedia.112.2o7.net
0.0.0.0 myfamilyancestry.112.2o7.net
0.0.0.0 nasdaq.122.2o7.net
0.0.0.0 natgeoeditco.112.2o7.net
0.0.0.0 natgeoeditcom.112.2o7.net
0.0.0.0 natgeonews.112.2o7.net
0.0.0.0 natgeongmcom.112.2o7.net
0.0.0.0 nationalpost.112.2o7.net
0.0.0.0 nba.112.2o7.net
0.0.0.0 neber.112.2o7.net
0.0.0.0 netrp.112.2o7.net
0.0.0.0 netsdartboards.122.2o7.net
0.0.0.0 newsinteractive.112.2o7.net
0.0.0.0 newstimeslivecom.112.2o7.net
0.0.0.0 nike.112.2o7.net
0.0.0.0 nikeplus.112.2o7.net
0.0.0.0 nmanchorage.112.2o7.net
0.0.0.0 nmbrampton.112.2o7.net
0.0.0.0 nmcommancomedia.112.2o7.net
0.0.0.0 nmfresno.112.2o7.net
0.0.0.0 nmhiltonhead.112.2o7.net
0.0.0.0 nmkawartha.112.2o7.net
0.0.0.0 nmminneapolis.112.2o7.net
0.0.0.0 nmmississauga.112.2o7.net
0.0.0.0 nmnandomedia.112.2o7.net
0.0.0.0 nmraleigh.112.2o7.net
0.0.0.0 nmrockhill.112.2o7.net
0.0.0.0 nmsacramento.112.2o7.net
0.0.0.0 nmtoronto.112.2o7.net
0.0.0.0 nmtricity.112.2o7.net
0.0.0.0 nmyork.112.2o7.net
0.0.0.0 novellcom.112.2o7.net
0.0.0.0 nytbglobe.112.2o7.net
0.0.0.0 nytglobe.112.2o7.net
0.0.0.0 nythglobe.112.2o7.net
0.0.0.0 nytimesglobal.112.2o7.net
0.0.0.0 nytimesnonsampled.112.2o7.net
0.0.0.0 nytimesnoonsampled.112.2o7.net
0.0.0.0 nytmembercenter.112.2o7.net
0.0.0.0 nytrflorence.112.2o7.net
0.0.0.0 nytrgadsden.112.2o7.net
0.0.0.0 nytrgainseville.112.2o7.net
0.0.0.0 nytrhendersonville.112.2o7.net
0.0.0.0 nytrhouma.112.2o7.net
0.0.0.0 nytrlakeland.112.2o7.net
0.0.0.0 nytrsantarosa.112.2o7.net
0.0.0.0 nytrsarasota.112.2o7.net
0.0.0.0 nytrwilmington.112.2o7.net
0.0.0.0 nyttechnology.112.2o7.net
0.0.0.0 omniture.112.2o7.net
0.0.0.0 omnitureglobal.112.2o7.net
0.0.0.0 onlineindigoca.112.2o7.net
0.0.0.0 oracle.112.2o7.net
0.0.0.0 oraclecom.112.2o7.net
0.0.0.0 overstock.com.112.2o7.net
0.0.0.0 overturecomvista.112.2o7.net
0.0.0.0 paypal.112.2o7.net
0.0.0.0 poacprod.122.2o7.net
0.0.0.0 poconorecordcom.112.2o7.net
0.0.0.0 projectorpeople.112.2o7.net
0.0.0.0 publicationsunbound.112.2o7.net
0.0.0.0 pulharktheherald.112.2o7.net
0.0.0.0 pulpantagraph.112.2o7.net
0.0.0.0 rckymtnnws.112.2o7.net
0.0.0.0 recordnetcom.112.2o7.net
0.0.0.0 recordonlinecom.112.2o7.net
0.0.0.0 rey3935.112.2o7.net
0.0.0.0 rezrezwhistler.112.2o7.net
0.0.0.0 riptownmedia.122.2o7.net
0.0.0.0 rncgopcom.122.2o7.net
0.0.0.0 roxio.112.2o7.net
0.0.0.0 salesforce.122.2o7.net
0.0.0.0 santacruzsentinel.112.2o7.net
0.0.0.0 sciamglobal.112.2o7.net
0.0.0.0 scrippsbathvert.112.2o7.net
0.0.0.0 scrippsfoodnet.112.2o7.net
0.0.0.0 scrippswfts.112.2o7.net
0.0.0.0 scrippswxyz.112.2o7.net
0.0.0.0 seacoastonlinecom.112.2o7.net
0.0.0.0 searscom.112.2o7.net
0.0.0.0 smibs.112.2o7.net
0.0.0.0 smwww.112.2o7.net
0.0.0.0 sonycorporate.122.2o7.net
0.0.0.0 sonyglobal.112.2o7.net
0.0.0.0 southcoasttoday.112.2o7.net
0.0.0.0 spiketv.112.2o7.net
0.0.0.0 stpetersburgtimes.122.2o7.net
0.0.0.0 suncom.112.2o7.net
0.0.0.0 sunglobal.112.2o7.net
0.0.0.0 sunonesearch.112.2o7.net
0.0.0.0 survey.112.2o7.net
0.0.0.0 sympmsnsports.112.2o7.net
0.0.0.0 techreview.112.2o7.net
0.0.0.0 thestar.122.2o7.net
0.0.0.0 thestardev.122.2o7.net
0.0.0.0 thinkgeek.112.2o7.net
0.0.0.0 timebus2.112.2o7.net
0.0.0.0 timecom.112.2o7.net
0.0.0.0 timeew.122.2o7.net
0.0.0.0 timefortune.112.2o7.net
0.0.0.0 timehealth.112.2o7.net
0.0.0.0 timeofficepirates.122.2o7.net
0.0.0.0 timepeople.122.2o7.net
0.0.0.0 timepopsci.122.2o7.net
0.0.0.0 timerealsimple.112.2o7.net
0.0.0.0 timewarner.122.2o7.net
0.0.0.0 tmsscion.112.2o7.net
0.0.0.0 tmstoyota.112.2o7.net
0.0.0.0 tnttv.112.2o7.net
0.0.0.0 torstardigital.122.2o7.net
0.0.0.0 travidiathebrick.112.2o7.net
0.0.0.0 tribuneinteractive.122.2o7.net
0.0.0.0 usatoday1.112.2o7.net
0.0.0.0 usnews.122.2o7.net
0.0.0.0 usun.112.2o7.net
0.0.0.0 vanns.112.2o7.net
0.0.0.0 verisignwildcard.112.2o7.net
0.0.0.0 verisonwildcard.112.2o7.net
0.0.0.0 vh1com.112.2o7.net
0.0.0.0 viaatomvideo.112.2o7.net
0.0.0.0 viacomedycentralrl.112.2o7.net
0.0.0.0 viagametrailers.112.2o7.net
0.0.0.0 viamtvcom.112.2o7.net
0.0.0.0 viasyndimedia.112.2o7.net
0.0.0.0 viavh1com.112.2o7.net
0.0.0.0 viay2m.112.2o7.net
0.0.0.0 vintacom.112.2o7.net
0.0.0.0 viralvideo.112.2o7.net
0.0.0.0 walmartcom.112.2o7.net
0.0.0.0 westjet.112.2o7.net
0.0.0.0 wileydumcom.112.2o7.net
0.0.0.0 wmg.112.2o7.net
0.0.0.0 wmgmulti.112.2o7.net
0.0.0.0 workopolis.122.2o7.net
0.0.0.0 wpni.112.2o7.net
0.0.0.0 xhealthmobiletools.112.2o7.net
0.0.0.0 youtube.112.2o7.net
0.0.0.0 yrkeve.112.2o7.net
0.0.0.0 ziffdavisglobal.112.2o7.net
0.0.0.0 ziffdavispennyarcade.112.2o7.net
#</2o7-sites>

#<oewabox-sites>

# oewabox.at -- 'Austrian Webanalysis Society'
0.0.0.0 1000ps.oewabox.at
0.0.0.0 afinder.oewabox.at
0.0.0.0 alphalux.oewabox.at
0.0.0.0 apodir.oewabox.at
0.0.0.0 arboe.oewabox.at
0.0.0.0 aschreib.oewabox.at
0.0.0.0 ascout24.oewabox.at
0.0.0.0 atvplus.oewabox.at
0.0.0.0 audi4e.oewabox.at
0.0.0.0 austria.oewabox.at
0.0.0.0 automobi.oewabox.at
0.0.0.0 automoto.oewabox.at
0.0.0.0 babyf.oewabox.at
0.0.0.0 bazar.oewabox.at
0.0.0.0 bdb.oewabox.at
0.0.0.0 bliga.oewabox.at
0.0.0.0 buschen.oewabox.at
0.0.0.0 car4you.oewabox.at
0.0.0.0 cinplex.oewabox.at
0.0.0.0 derstand.oewabox.at
0.0.0.0 dispatcher.oewabox.at
0.0.0.0 docfind.oewabox.at
0.0.0.0 doodle.oewabox.at
0.0.0.0 drei.oewabox.at
0.0.0.0 dropkick.oewabox.at
0.0.0.0 enerweb.oewabox.at
0.0.0.0 falstaff.oewabox.at
0.0.0.0 fanrep.oewabox.at
0.0.0.0 fflotte.oewabox.at
0.0.0.0 fitges.oewabox.at
0.0.0.0 fondprof.oewabox.at
0.0.0.0 fratz.oewabox.at
0.0.0.0 fscout24.oewabox.at
0.0.0.0 gamesw.oewabox.at
0.0.0.0 geizhals.oewabox.at
0.0.0.0 gillout.oewabox.at
0.0.0.0 gkueche.oewabox.at
0.0.0.0 gmx.oewabox.at
0.0.0.0 gofem.oewabox.at
0.0.0.0 heute.oewabox.at
0.0.0.0 immobili.oewabox.at
0.0.0.0 immosuch.oewabox.at
0.0.0.0 indumag.oewabox.at
0.0.0.0 induweb.oewabox.at
0.0.0.0 issges.oewabox.at
0.0.0.0 jobwohn.oewabox.at
0.0.0.0 karriere.oewabox.at
0.0.0.0 kinder.oewabox.at
0.0.0.0 kinowelt.oewabox.at
0.0.0.0 krone.oewabox.at
0.0.0.0 kronehit.oewabox.at
0.0.0.0 landwirt.oewabox.at
0.0.0.0 liportal.oewabox.at
0.0.0.0 mamilade.oewabox.at
0.0.0.0 manntv.oewabox.at
0.0.0.0 medpop.oewabox.at
0.0.0.0 megaplex.oewabox.at
0.0.0.0 metropol.oewabox.at
0.0.0.0 mmarkt.oewabox.at
0.0.0.0 monitor.oewabox.at
0.0.0.0 motorl.oewabox.at
0.0.0.0 msn.oewabox.at
0.0.0.0 newsnetw.oewabox.at
0.0.0.0 nickde.oewabox.at
0.0.0.0 noen.oewabox.at
0.0.0.0 notori.oewabox.at
0.0.0.0 oe24.oewabox.at
0.0.0.0 oeamtc.oewabox.at
0.0.0.0 oewa.oewabox.at
0.0.0.0 ooen.oewabox.at
0.0.0.0 orf.oewabox.at
0.0.0.0 parent.oewabox.at
0.0.0.0 radioat.oewabox.at
0.0.0.0 rtl.oewabox.at
0.0.0.0 salzburg.oewabox.at
0.0.0.0 schlager.oewabox.at
0.0.0.0 sdo.oewabox.at
0.0.0.0 seibli.oewabox.at
0.0.0.0 servustv.oewabox.at
0.0.0.0 skip.oewabox.at
0.0.0.0 skysport.oewabox.at
0.0.0.0 smedizin.oewabox.at
0.0.0.0 sms.oewabox.at
0.0.0.0 solidbau.oewabox.at
0.0.0.0 speising.oewabox.at
0.0.0.0 sportat.oewabox.at
0.0.0.0 ssl-compass.oewabox.at
0.0.0.0 ssl-geizhals.oewabox.at
0.0.0.0 ssl-helpgvat.oewabox.at
0.0.0.0 ssl-karriere.oewabox.at
0.0.0.0 ssl-msn.oewabox.at
0.0.0.0 ssl-top.oewabox.at
0.0.0.0 ssl-uspgvat.oewabox.at
0.0.0.0 ssl-willhab.oewabox.at
0.0.0.0 ssl-wko.oewabox.at
0.0.0.0 starchat.oewabox.at
0.0.0.0 sunny.oewabox.at
0.0.0.0 super.oewabox.at
0.0.0.0 supermed.oewabox.at
0.0.0.0 svpro7.oewabox.at
0.0.0.0 szene1.oewabox.at
0.0.0.0 tagpress.oewabox.at
0.0.0.0 tele.oewabox.at
0.0.0.0 tennis.oewabox.at
0.0.0.0 tips.oewabox.at
0.0.0.0 tirolcom.oewabox.at
0.0.0.0 top.oewabox.at
0.0.0.0 tramarkt.oewabox.at
0.0.0.0 tripwolf.oewabox.at
0.0.0.0 uncut.oewabox.at
0.0.0.0 unimed.oewabox.at
0.0.0.0 uwz.oewabox.at
0.0.0.0 vcm.oewabox.at
0.0.0.0 via.oewabox.at
0.0.0.0 viacom.oewabox.at
0.0.0.0 warda.oewabox.at
0.0.0.0 webprog.oewabox.at
0.0.0.0 wfussb.oewabox.at
0.0.0.0 wienerz.oewabox.at
0.0.0.0 wiengvat.oewabox.at
0.0.0.0 willhab.oewabox.at
0.0.0.0 wirtvlg.oewabox.at
0.0.0.0 woche.oewabox.at
0.0.0.0 wohnnet.oewabox.at
0.0.0.0 zfm.oewabox.at
#</oewabox-sites>

#<pegasus-spyware-sites>

# Pegasus spyware sites.
0.0.0.0 24-7clinic.com
0.0.0.0 365redirect.co
0.0.0.0 a-redirect.com
0.0.0.0 a-resolver.com
0.0.0.0 accomodation-tastes.net
0.0.0.0 accountcanceled.com
0.0.0.0 accountnotify.com
0.0.0.0 accounts.mx
0.0.0.0 accountsections.com
0.0.0.0 active-folders.com
0.0.0.0 actu24.online
0.0.0.0 ad-generator.net
0.0.0.0 ad-switcher.com
0.0.0.0 addresstimeframe.com
0.0.0.0 adscreator.net
0.0.0.0 adsload.co
0.0.0.0 advert-time.com
0.0.0.0 advert-track.com
0.0.0.0 afriquenouvelle.com
0.0.0.0 agilityprocessing.net
0.0.0.0 alignmentdisabled.net
0.0.0.0 apiapple.com
0.0.0.0 appleleaveit.co
0.0.0.0 appointments-online.com
0.0.0.0 arabnews365.com
0.0.0.0 asrarrarabiya.com
0.0.0.0 assembled-battery.com
0.0.0.0 authenticangry.com
0.0.0.0 authenticated-origin.com
0.0.0.0 av-scanner.com
0.0.0.0 babies-bottles.com
0.0.0.0 balancewreckpoint.com
0.0.0.0 bankportal.net
0.0.0.0 baramije.net
0.0.0.0 bargainservice.online
0.0.0.0 bdaynotes.com
0.0.0.0 beanbounce.net
0.0.0.0 becomeiguana.com
0.0.0.0 bestcandyever.com
0.0.0.0 bestfoods.co
0.0.0.0 bestheadphones4u.com
0.0.0.0 beststores4u.com
0.0.0.0 bestsushiever.com
0.0.0.0 bigseatsout.net
0.0.0.0 biscuit-taste.net
0.0.0.0 bitanalysis.net
0.0.0.0 black-bricks.net
0.0.0.0 blackwhitebags.com
0.0.0.0 blindlydivision.com
0.0.0.0 blockedsituation.net
0.0.0.0 blogreseller.net
0.0.0.0 boldconclusion.com
0.0.0.0 bottlehere.com
0.0.0.0 boxes-mix.net
0.0.0.0 brand-tech.net
0.0.0.0 breaking-news.co
0.0.0.0 breakingnewsasia.com
0.0.0.0 bubblesmoke.net
0.0.0.0 bubblesweetcake.com
0.0.0.0 buildingcarpet.com
0.0.0.0 buildyourdata.com
0.0.0.0 bulksender.info
0.0.0.0 bulktheft.com
0.0.0.0 bullgame.net
0.0.0.0 bustimer.net
0.0.0.0 butterdogchange.com
0.0.0.0 cablegirls.net
0.0.0.0 calculatesymbols.com
0.0.0.0 cars-to-buy.com
0.0.0.0 cashandlife.com
0.0.0.0 cdnwa.com
0.0.0.0 centersession.com
0.0.0.0 cheapapartmentsaroundme.com
0.0.0.0 chickenwaves.com
0.0.0.0 chubaka.org
0.0.0.0 clickrighthere.online
0.0.0.0 clicktrack247.com
0.0.0.0 clients-access.com
0.0.0.0 closefly.com
0.0.0.0 cloudads.net
0.0.0.0 cloudbiggest.com
0.0.0.0 clubloading.net
0.0.0.0 clubsforus.net
0.0.0.0 cnn-africa.co
0.0.0.0 coffee2go.org
0.0.0.0 colorfulnotebooks.com
0.0.0.0 colorsoflife.online
0.0.0.0 connecting-to.com
0.0.0.0 contacting-customer.com
0.0.0.0 contentsbycase.com
0.0.0.0 crownsafe.net
0.0.0.0 cryptocurrecny.com
0.0.0.0 cryptokoinz.com
0.0.0.0 dashboardprompt.com
0.0.0.0 data-formula.com
0.0.0.0 deal4unow.com
0.0.0.0 designednetwork.com
0.0.0.0 devicer.co
0.0.0.0 dhcpserver.net
0.0.0.0 diagram-shape.com
0.0.0.0 diaspora-news.com
0.0.0.0 discountads.net
0.0.0.0 displaytag.net
0.0.0.0 dns-analytics.com
0.0.0.0 dns-upload.com
0.0.0.0 dnsclocknow.com
0.0.0.0 dnslogs.net
0.0.0.0 dnsmachinefork.com
0.0.0.0 dnsprotector.net
0.0.0.0 doitformom.com
0.0.0.0 domain-control.net
0.0.0.0 domainloading.net
0.0.0.0 domainport.net
0.0.0.0 domains-resolver.net
0.0.0.0 domesticwindow.com
0.0.0.0 dowhatyouneed.com
0.0.0.0 downgradeproduct.com
0.0.0.0 dramatic-challenge.com
0.0.0.0 dynamic-dns.net
0.0.0.0 e-loading.biz
0.0.0.0 easy-pay.info
0.0.0.0 effectivespeech.net
0.0.0.0 emonitoring-paczki.pl
0.0.0.0 enoughtoday.org
0.0.0.0 estatearea.net
0.0.0.0 exchangenerate.com
0.0.0.0 existingpass.com
0.0.0.0 expiredsession.com
0.0.0.0 exploreemail.net
0.0.0.0 externalprivacy.com
0.0.0.0 extractsight.com
0.0.0.0 extrahoney.net
0.0.0.0 eyestoip.com
0.0.0.0 fallround.com
0.0.0.0 familyabroad.net
0.0.0.0 fashion-online.net
0.0.0.0 fashioncontainer.net
0.0.0.0 fatpop.net
0.0.0.0 fb-accounts.com
0.0.0.0 fbsecurity.co
0.0.0.0 feature-publish.net
0.0.0.0 feelbonesbag.com
0.0.0.0 feeltrail.com
0.0.0.0 fetchlink.net
0.0.0.0 files-downloads.com
0.0.0.0 findgoodfood.co
0.0.0.0 fitness-for-ever.com
0.0.0.0 foodeveryhour.com
0.0.0.0 formattingcells.com
0.0.0.0 forward-page.com
0.0.0.0 forward5costume.com
0.0.0.0 free247downloads.com
0.0.0.0 freedominfo.net
0.0.0.0 freeshoemoon.com
0.0.0.0 functionalcover.com
0.0.0.0 funintheuk.com
0.0.0.0 gadgetproof.net
0.0.0.0 getoutofyourmind.com
0.0.0.0 getpoints.net
0.0.0.0 glassesofwine.com
0.0.0.0 glasstaken.com
0.0.0.0 glittercases.net
0.0.0.0 global-redirect.net
0.0.0.0 globalnews247.net
0.0.0.0 good-games.org
0.0.0.0 goroskop.co
0.0.0.0 gossipsbollywoods.com
0.0.0.0 greensmallcanvas.com
0.0.0.0 greenwatermovement.com
0.0.0.0 growstart.net
0.0.0.0 halal-place.com
0.0.0.0 handcraftedformat.com
0.0.0.0 hatsampledc.com
0.0.0.0 health-club.online
0.0.0.0 healthykids-food.com
0.0.0.0 heavy-flood.com
0.0.0.0 hillsaround.com
0.0.0.0 hitrafficip.com
0.0.0.0 hmizat.co
0.0.0.0 holdstory.com
0.0.0.0 holecatorange.com
0.0.0.0 homeishere.co
0.0.0.0 host-redirect.net
0.0.0.0 hotinfosource.com
0.0.0.0 housesfurniture.com
0.0.0.0 htmlmetrics.com
0.0.0.0 httpaccess.com
0.0.0.0 humblebenefit.com
0.0.0.0 icrcworld.com
0.0.0.0 in-weather.com
0.0.0.0 in2date.com
0.0.0.0 inbox-messages.net
0.0.0.0 industry-specialist.com
0.0.0.0 ineediscounts.com
0.0.0.0 infospress.com
0.0.0.0 investormanage.net
0.0.0.0 ipjackets.com
0.0.0.0 islamiyaat.com
0.0.0.0 jeeyarworld.com
0.0.0.0 judgeauthority.com
0.0.0.0 kaidee.info
0.0.0.0 khaleejtimes.online
0.0.0.0 kingdom-news.com
0.0.0.0 knowseminar.com
0.0.0.0 last-chainleash.net
0.0.0.0 latest-songs.com
0.0.0.0 lawlowvat.net
0.0.0.0 layerprotect.com
0.0.0.0 layoutfill.com
0.0.0.0 leavehomego.com
0.0.0.0 letyoufall.com
0.0.0.0 levelsteelwhite.com
0.0.0.0 lifenoonkid.com
0.0.0.0 link-crawler.com
0.0.0.0 link-scan.net
0.0.0.0 lizzardsnail.com
0.0.0.0 loading-domain.com
0.0.0.0 loading-page.net
0.0.0.0 loading-url.net
0.0.0.0 loadthatpage.com
0.0.0.0 lowervalues.com
0.0.0.0 maghrebfoot.com
0.0.0.0 magicalipone.com
0.0.0.0 mainredirecter.com
0.0.0.0 maphonortea.com
0.0.0.0 mapupdatezone.com
0.0.0.0 martinipicnic.com
0.0.0.0 mealrentyard.com
0.0.0.0 medical-updates.com
0.0.0.0 medicalcircle.net
0.0.0.0 merchant-businesses.com
0.0.0.0 mergeandcenter.com
0.0.0.0 mobilebrowsing.net
0.0.0.0 monawa3ate.org
0.0.0.0 mondaymornings.co
0.0.0.0 morning-maps.com
0.0.0.0 motivation-go.com
0.0.0.0 mozillaname.com
0.0.0.0 multiplecurrencies.com
0.0.0.0 mybrightidea.co
0.0.0.0 mygummyjelly.com
0.0.0.0 myheartbuild.com
0.0.0.0 mylovelypet.net
0.0.0.0 nation-news.com
0.0.0.0 net-protector.com
0.0.0.0 netvisualizer.com
0.0.0.0 networkinfo.org
0.0.0.0 networkingproperty.com
0.0.0.0 neutralpages.com
0.0.0.0 newandfresh.com
0.0.0.0 newandroidapps.net
0.0.0.0 newarrivals.club
0.0.0.0 newip-info.com
0.0.0.0 news-flash.net
0.0.0.0 news-news.co
0.0.0.0 newscurrent.info
0.0.0.0 newsofgames.com
0.0.0.0 newworld-news.com
0.0.0.0 noextramoney.com
0.0.0.0 nomorewarnow.com
0.0.0.0 normal-strength.com
0.0.0.0 normalseason.com
0.0.0.0 nouvelles247.com
0.0.0.0 novosti247.com
0.0.0.0 now-online.net
0.0.0.0 nsoqa.com
0.0.0.0 offspringperform.net
0.0.0.0 old-glasses.net
0.0.0.0 online-loading.com
0.0.0.0 onlycart.net
0.0.0.0 onlytoday.biz
0.0.0.0 openingquestion.org
0.0.0.0 opera-van.com
0.0.0.0 operatingnews.com
0.0.0.0 opposedarrangement.net
0.0.0.0 optionstoreplace.com
0.0.0.0 orange-updates.com
0.0.0.0 ourorder.info
0.0.0.0 page-host.net
0.0.0.0 page-info.com
0.0.0.0 pageisloading.net
0.0.0.0 pageredirect.co
0.0.0.0 pageupdate.co
0.0.0.0 painting-walls.com
0.0.0.0 pastesbin.com
0.0.0.0 permalinking.com
0.0.0.0 pleaseusenew.net
0.0.0.0 popagency.net
0.0.0.0 port-connection.com
0.0.0.0 portredirect.net
0.0.0.0 posta.news
0.0.0.0 pourcentfilers.com
0.0.0.0 poweredlock.com
0.0.0.0 pprocessor.net
0.0.0.0 practicehazard.com
0.0.0.0 presidentialagent.com
0.0.0.0 preventadmission.com
0.0.0.0 primarystrike.net
0.0.0.0 projectgoals.net
0.0.0.0 quitmyjob.xyz
0.0.0.0 randomlane.net
0.0.0.0 rapidredirecting.com
0.0.0.0 readirectly.com
0.0.0.0 reception-desk.net
0.0.0.0 recordinglamping.com
0.0.0.0 redemptionphrase.com
0.0.0.0 redirect-connection.com
0.0.0.0 redirect-link.com
0.0.0.0 redirect-net.com
0.0.0.0 redirect-protocol.com
0.0.0.0 redirect-systems.com
0.0.0.0 redirect-tunnel.net
0.0.0.0 redirect2url.net
0.0.0.0 redirectchannel.net
0.0.0.0 redirectcheck.net
0.0.0.0 redirectconnection.net
0.0.0.0 redirecteur.net
0.0.0.0 redirecting-url.com
0.0.0.0 redirectit.net
0.0.0.0 redirectload.com
0.0.0.0 redirectnet.net
0.0.0.0 redirectprotocol.net
0.0.0.0 redirectshare.com
0.0.0.0 redstarnews.net
0.0.0.0 regionews.net
0.0.0.0 related-ads.com
0.0.0.0 reload-url.com
0.0.0.0 reload-url.net
0.0.0.0 reloading-page1.com
0.0.0.0 reloadinput.com
0.0.0.0 reloadpage.net
0.0.0.0 rentalindustries.com
0.0.0.0 reservationszone.com
0.0.0.0 restaurantsstar.com
0.0.0.0 revoke-dashboard.com
0.0.0.0 roadwide.net
0.0.0.0 robotscan.net
0.0.0.0 rosesforus.com
0.0.0.0 sabafon.info
0.0.0.0 safe-mondays.net
0.0.0.0 saltyapplepie.com
0.0.0.0 sec-checker.com
0.0.0.0 secretgirlfriend.net
0.0.0.0 securedloading.com
0.0.0.0 securedlogin.org
0.0.0.0 securisurf.com
0.0.0.0 send2url.com
0.0.0.0 sendhtml.net
0.0.0.0 sendingurl.com
0.0.0.0 sendingurl.net
0.0.0.0 servingshade.com
0.0.0.0 severalheroes.com
0.0.0.0 shortredirect.com
0.0.0.0 signpetition.co
0.0.0.0 simplycode.co
0.0.0.0 skillsforest.net
0.0.0.0 smoothurl.com
0.0.0.0 sms-sending.net
0.0.0.0 smscentro.com
0.0.0.0 smser.net
0.0.0.0 somuchrain.com
0.0.0.0 speedservicenow.com
0.0.0.0 spiritualbrakes.com
0.0.0.0 sportssaint.net
0.0.0.0 sportupdates.info
0.0.0.0 sslbind.com
0.0.0.0 standartsheet.com
0.0.0.0 standstock.net
0.0.0.0 starreturned.com
0.0.0.0 startupsservices.net
0.0.0.0 stopsms.biz
0.0.0.0 storelive.co
0.0.0.0 sunrise-brink.net
0.0.0.0 sunsetdnsnow.com
0.0.0.0 superlinks4u.com
0.0.0.0 sweet-water.org
0.0.0.0 syncingprocess.com
0.0.0.0 systemtrees.com
0.0.0.0 t-support.net
0.0.0.0 takemallelectric.com
0.0.0.0 techhelping.net
0.0.0.0 telangana-news24.com
0.0.0.0 telecom-info.com
0.0.0.0 thainews.asia
0.0.0.0 thankstossl.com
0.0.0.0 theappanalytics.com
0.0.0.0 thecoffeeilove.com
0.0.0.0 theredirect.net
0.0.0.0 thesimplestairs.com
0.0.0.0 tibetnews365.net
0.0.0.0 timelesscelebrity.com
0.0.0.0 timeofflife.com
0.0.0.0 tobepure.com
0.0.0.0 todaysdeals4u.com
0.0.0.0 toggletools.com
0.0.0.0 tookcheckout.com
0.0.0.0 topadblocker.net
0.0.0.0 tradeexchanging.com
0.0.0.0 transfer-rate.com
0.0.0.0 transferkeep.com
0.0.0.0 transferlights.com
0.0.0.0 travelight.online
0.0.0.0 trendsymbol.net
0.0.0.0 trialvariable.net
0.0.0.0 trianglerank.net
0.0.0.0 turkishairines.info
0.0.0.0 unonoticias.net
0.0.0.0 unsubscribed.co
0.0.0.0 unusualneighbor.com
0.0.0.0 updateapps.net
0.0.0.0 updating-link.com
0.0.0.0 updating-url.com
0.0.0.0 updating-url.net
0.0.0.0 updatingpage.com
0.0.0.0 updatingwebpage.com
0.0.0.0 url-hoster.com
0.0.0.0 url-redirect.com
0.0.0.0 url2all.net
0.0.0.0 urlconnection.net
0.0.0.0 urlpage-redirect.com
0.0.0.0 urlpush.net
0.0.0.0 urlredirect.net
0.0.0.0 urlregistrar.net
0.0.0.0 urlreload.net
0.0.0.0 urlscanner.net
0.0.0.0 urlsync.com
0.0.0.0 urlupdates.com
0.0.0.0 urlviaweb.com
0.0.0.0 utensils.pro
0.0.0.0 vanillaandcream.com
0.0.0.0 vault-encryption.com
0.0.0.0 vider-image.com
0.0.0.0 viedechretien.org
0.0.0.0 viewstracker.com
0.0.0.0 vipmasajes.com
0.0.0.0 waitingtoload.com
0.0.0.0 wasted-nights.com
0.0.0.0 weatherapi.co
0.0.0.0 web-check.co
0.0.0.0 web-domain.net
0.0.0.0 web-hoster.co
0.0.0.0 web-loading.net
0.0.0.0 web-page.co
0.0.0.0 web-scanner.co
0.0.0.0 web-spider.net
0.0.0.0 web-url.net
0.0.0.0 webadv.co
0.0.0.0 webpageupdate.co
0.0.0.0 webprotector.co
0.0.0.0 webprotocol.net
0.0.0.0 webresourcer.com
0.0.0.0 websiteconnecting.com
0.0.0.0 websiteeco.com
0.0.0.0 websitereconnecting.com
0.0.0.0 websitetosubmit.com
0.0.0.0 webstrings.net
0.0.0.0 websupporter.co
0.0.0.0 webupdater.net
0.0.0.0 whats-new.org
0.0.0.0 whatsapp-app.com
0.0.0.0 whatsappsupport.net
0.0.0.0 whereismybonus.com
0.0.0.0 winter-balance.com
0.0.0.0 wishdownget.com
0.0.0.0 wonderfulinsights.com
0.0.0.0 wordstore.net
0.0.0.0 working-online.net
0.0.0.0 xchange4u.net
0.0.0.0 xtremelivesupport.com
0.0.0.0 youintelligence.com
0.0.0.0 youliehow.com
0.0.0.0 yourbestclothes.com
0.0.0.0 yummyfoodallover.com
#</pegasus-spyware-sites>

#<ad-sites>
#<maybe-ads>
#0.0.0.0 adfarm.mediaplex.com		# may interfere with ebay
#0.0.0.0 ads.msn.com			#This may cause problems with zone.msn.com
#0.0.0.0 ak.imgfarm.com		# may cause problems with iwon.com
#0.0.0.0 click.linksynergy.com
#0.0.0.0 global.msads.net		#This may cause problems with zone.msn.com
#0.0.0.0 lads.myspace.com		# blocks myspace media/video players
#0.0.0.0 refer.ccbill.com		#affiliate program, to add it back, remove the #
#0.0.0.0 rmads.msn.com			#This may cause problems with zone.msn.com
#0.0.0.0 www.apmebf.com		#qksrv
#0.0.0.0 www.tkqlhce.com		#qksrv
#0.0.0.0 ad.ca.doubleclick.net	#intereferes with video on globeandmail.com
#0.0.0.0 transfer.go.com		#may interfere with Disney websites
#</maybe-ads>

# ads
 
#0.0.0.0 aax-eu.amazon-adsystem.com 	# may interfere with Amazon ad preferences
#0.0.0.0 s.amazon-adsystem.com	# may interfere with Amazon ad preferences
0.0.0.0 0101011.com
0.0.0.0 0427d7.se
0.0.0.0 0d79ed.r.axf8.net
0.0.0.0 0pn.ru
0.0.0.0 0qizz.super-promo.hoxo.info
0.0.0.0 1.allyes.com.cn
0.0.0.0 10.im.cz
0.0.0.0 104231.dtiblog.com
0.0.0.0 1097834592.rsc.cdn77.org
0.0.0.0 10fbb07a4b0.se
0.0.0.0 121media.com
0.0.0.0 123.fluxads.com
0.0.0.0 123plays.com
0.0.0.0 15.basebanner.com
0.0.0.0 15.taboola.com
0.0.0.0 1l-view.mail.ru
0.0.0.0 2.marketbanker.com
0.0.0.0 2.speedknow.co
0.0.0.0 207-87-18-203.wsmg.digex.net
0.0.0.0 2468.go2cloud.org
0.0.0.0 247playz.com
0.0.0.0 247support.adtech.fr
0.0.0.0 247support.adtech.us
0.0.0.0 24ora.eu
0.0.0.0 24ratownik.hit.gemius.pl
0.0.0.0 24trk.com
0.0.0.0 25184.hittail.com
0.0.0.0 2819.linux2.testsider.dk
0.0.0.0 2975c.v.fwmrm.net
0.0.0.0 2leep.com
0.0.0.0 2perc.info
0.0.0.0 321cba.com
0.0.0.0 32red.it
0.0.0.0 33across-match.dotomi.com
0.0.0.0 360ads.com
0.0.0.0 3fns.com
0.0.0.0 411playz.com
0.0.0.0 4c28d6.r.axf8.net
0.0.0.0 4qinvite.4q.iperceptions.com
0.0.0.0 4th3d48.com
0.0.0.0 6159.genieessp.com
0.0.0.0 6kup12tgxx.com
0.0.0.0 7500.com
0.0.0.0 76.a.boom.ro
0.0.0.0 7adpower.com
0.0.0.0 7bpeople.com
0.0.0.0 7xc4n.com
0.0.0.0 820.joomsearch.com
0.0.0.0 829331534d183e7d1f6a-8d91cc88b27b979d0ea53a10ce8855ec.r96.cf5.rackcdn.com
0.0.0.0 85103.hittail.com
0.0.0.0 8574dnj3yzjace8c8io6zr9u3n.hop.clickbank.net
0.0.0.0 888casino.com
0.0.0.0 961.com
0.0.0.0 9cd76b4462bb.com
0.0.0.0 AUSpolice.com
0.0.0.0 BRApolice.com
0.0.0.0 COMpolice.com
0.0.0.0 COMpolice.net
0.0.0.0 CYPpolice.com
0.0.0.0 EGYpolice.com
0.0.0.0 ETHpolice.com
0.0.0.0 GEOpolice.com
0.0.0.0 INDpolice.com
0.0.0.0 LUXpolice.com
0.0.0.0 LUXpolice.net
0.0.0.0 PAKpolice.com
0.0.0.0 USApolice.com
0.0.0.0 a-ads.com
0.0.0.0 a-blog.eu
0.0.0.0 a.1nimo.com
0.0.0.0 a.ad.playstation.net
0.0.0.0 a.adorika.net
0.0.0.0 a.adready.com
0.0.0.0 a.adroll.com
0.0.0.0 a.ads1.msn.com
0.0.0.0 a.ads2.msn.com
0.0.0.0 a.adstome.com
0.0.0.0 a.adtng.com
0.0.0.0 a.applvn.com
0.0.0.0 a.baidu.com
0.0.0.0 a.blesk.cz
0.0.0.0 a.boom.ro
0.0.0.0 a.cctv.com
0.0.0.0 a.centrum.cz
0.0.0.0 a.cntv.cn
0.0.0.0 a.denik.cz
0.0.0.0 a.dynad.net
0.0.0.0 a.iprima.cz
0.0.0.0 a.kerg.net
0.0.0.0 a.libertystmedia.com
0.0.0.0 a.ligatus.com
0.0.0.0 a.ligatus.de
0.0.0.0 a.mktw.net
0.0.0.0 a.o333o.com
0.0.0.0 a.prisacom.com
0.0.0.0 a.rad.live.com
0.0.0.0 a.rad.msn.com
0.0.0.0 a.slunecnice.cz
0.0.0.0 a.spolecznosci.net
0.0.0.0 a.ss34.on9mail.com
0.0.0.0 a.total-media.net
0.0.0.0 a.tribalfusion.com
0.0.0.0 a.triggit.com
0.0.0.0 a.twiago.com
0.0.0.0 a.websponsors.com
0.0.0.0 a2.mediagra.com
0.0.0.0 a3.suntimes.com
0.0.0.0 a7cleaner.com
0.0.0.0 aa.agkn.com
0.0.0.0 aa.tweakers.nl
0.0.0.0 aaa-architecten.nl
0.0.0.0 aaa-arcobaleno.it
0.0.0.0 aads.treehugger.com
0.0.0.0 aan.amazon.com
0.0.0.0 aarth.net
0.0.0.0 aax-cpm.amazon-adsystem.com
0.0.0.0 aax-us-east.amazon-adsystem.com
0.0.0.0 aax-us-pdx.amazon-adsystem.com
0.0.0.0 aax.amazon-adsystem.com
0.0.0.0 ab.tweakers.nl
0.0.0.0 ab913aa797e78b3.com
0.0.0.0 abi83-schramberg.de
0.0.0.0 abourselfi.com
0.0.0.0 abseckw.adtlgc.com
0.0.0.0 ac.atpanel.com
0.0.0.0 ac.rnm.ca
0.0.0.0 ac.tynt.com
0.0.0.0 academy-internet.net
0.0.0.0 acceptable.a-ads.com
0.0.0.0 acces.streaming-direct.co
0.0.0.0 accessfreevpn.com
0.0.0.0 accountprotection.xyz
0.0.0.0 achetezfacile.com
0.0.0.0 acs.56.com
0.0.0.0 acs.agent.56.com
0.0.0.0 acs.agent.v-56.com
0.0.0.0 action.mathtag.com
0.0.0.0 action.media6degrees.com
0.0.0.0 actiondesk.com
0.0.0.0 actionflash.com
0.0.0.0 actionsplash.com
0.0.0.0 acvs.mediaonenetwork.net
0.0.0.0 acvsrv.mediaonenetwork.net
0.0.0.0 ad-411.com
0.0.0.0 ad-audit.tubemogul.com
0.0.0.0 ad-balancer.net
0.0.0.0 ad-clicks.com
0.0.0.0 ad-delivery.net
0.0.0.0 ad-feeds.com
0.0.0.0 ad-flow.com
0.0.0.0 ad-gbn.com
0.0.0.0 ad-indicator.com
0.0.0.0 ad-mediation.tuanguwen.com
0.0.0.0 ad-plus.cn
0.0.0.0 ad-score.com
0.0.0.0 ad-server.co.za
0.0.0.0 ad-serverparc.nl
0.0.0.0 ad-souk.com
0.0.0.0 ad-sponsor.com
0.0.0.0 ad-srv.net
0.0.0.0 ad-u.com
0.0.0.0 ad-vice.biz
0.0.0.0 ad.103092804.com
0.0.0.0 ad.23blogs.com
0.0.0.0 ad.360yield.com
0.0.0.0 ad.3dnews.ru
0.0.0.0 ad.71i.de
0.0.0.0 ad.abcnews.com
0.0.0.0 ad.aboutwebservices.com
0.0.0.0 ad.adition.de
0.0.0.0 ad.adition.net
0.0.0.0 ad.adnet.biz
0.0.0.0 ad.adnet.de
0.0.0.0 ad.adnetwork.com.br
0.0.0.0 ad.adnetwork.net
0.0.0.0 ad.adorika.com
0.0.0.0 ad.adriver.ru
0.0.0.0 ad.adsmart.net
0.0.0.0 ad.adsrvr.org
0.0.0.0 ad.adtegrity.net
0.0.0.0 ad.adverticum.net
0.0.0.0 ad.advertstream.com
0.0.0.0 ad.adview.pl
0.0.0.0 ad.afilo.pl
0.0.0.0 ad.afy11.net
0.0.0.0 ad.agilemedia.jp
0.0.0.0 ad.allyes.cn
0.0.0.0 ad.amgdgt.com
0.0.0.0 ad.aquamediadirect.com
0.0.0.0 ad.auditude.com
0.0.0.0 ad.bannerbank.ru
0.0.0.0 ad.bnmla.com
0.0.0.0 ad.cctv.com
0.0.0.0 ad.cibleclick.com
0.0.0.0 ad.clickotmedia.com
0.0.0.0 ad.cooks.com
0.0.0.0 ad.dc2.adtech.de
0.0.0.0 ad.deviantart.com
0.0.0.0 ad.directmirror.com
0.0.0.0 ad.directrev.com
0.0.0.0 ad.dnoticias.pt
0.0.0.0 ad.doganburda.com
0.0.0.0 ad.doublemax.net
0.0.0.0 ad.duga.jp
0.0.0.0 ad.e-kolay.net
0.0.0.0 ad.egloos.com
0.0.0.0 ad.ekonomikticaret.com
0.0.0.0 ad.eporner.com
0.0.0.0 ad.ettoday.net
0.0.0.0 ad.eurosport.com
0.0.0.0 ad.filmweb.pl
0.0.0.0 ad.firstadsolution.com
0.0.0.0 ad.floq.jp
0.0.0.0 ad.flux.com
0.0.0.0 ad.fout.jp
0.0.0.0 ad.funpic.de
0.0.0.0 ad.garantiarkadas.com
0.0.0.0 ad.gazeta.pl
0.0.0.0 ad.ghfusion.com
0.0.0.0 ad.goo.ne.jp
0.0.0.0 ad.gr.doubleclick.net
0.0.0.0 ad.groupon.be
0.0.0.0 ad.groupon.co.uk
0.0.0.0 ad.groupon.com
0.0.0.0 ad.groupon.de
0.0.0.0 ad.groupon.fr
0.0.0.0 ad.groupon.net
0.0.0.0 ad.groupon.nl
0.0.0.0 ad.groupon.pl
0.0.0.0 ad.hankooki.com
0.0.0.0 ad.horvitznewspapers.net
0.0.0.0 ad.icasthq.com
0.0.0.0 ad.iconadserver.com
0.0.0.0 ad.iloveinterracial.com
0.0.0.0 ad.insightexpressai.com
0.0.0.0 ad.ir.ru
0.0.0.0 ad.jamba.net
0.0.0.0 ad.jamster.ca
0.0.0.0 ad.jokeroo.com
0.0.0.0 ad.kataweb.it
0.0.0.0 ad.kau.li
0.0.0.0 ad.krutilka.ru
0.0.0.0 ad.land.to
0.0.0.0 ad.leadbolt.net
0.0.0.0 ad.lgappstv.com
0.0.0.0 ad.linkexchange.com
0.0.0.0 ad.linkstorms.com
0.0.0.0 ad.linksynergy.com
0.0.0.0 ad.livere.co.kr
0.0.0.0 ad.lyricswire.com
0.0.0.0 ad.mail.ru
0.0.0.0 ad.mangareader.net
0.0.0.0 ad.mastermedia.ru
0.0.0.0 ad.media-servers.net
0.0.0.0 ad.moscowtimes.ru
0.0.0.0 ad.my.doubleclick.net
0.0.0.0 ad.ne.com
0.0.0.0 ad.net
0.0.0.0 ad.network60.com
0.0.0.0 ad.nicovideo.jp
0.0.0.0 ad.nozonedata.com
0.0.0.0 ad.ntvmsnbc.com
0.0.0.0 ad.ohmynews.com
0.0.0.0 ad.ourgame.com
0.0.0.0 ad.pandora.tv
0.0.0.0 ad.parom.hu
0.0.0.0 ad.partis.si
0.0.0.0 ad.pickple.net
0.0.0.0 ad.pravda.ru
0.0.0.0 ad.premiumonlinemedia.com
0.0.0.0 ad.propellerads.com
0.0.0.0 ad.prv.pl
0.0.0.0 ad.qq.com
0.0.0.0 ad.qyer.com
0.0.0.0 ad.realist.gen.tr
0.0.0.0 ad.realmcdn.net
0.0.0.0 ad.reklamport.com
0.0.0.0 ad.repubblica.it
0.0.0.0 ad.ru.doubleclick.net
0.0.0.0 ad.search.ch
0.0.0.0 ad.sensismediasmart.com
0.0.0.0 ad.sensismediasmart.com.au
0.0.0.0 ad.slashgear.com
0.0.0.0 ad.smartclip.net
0.0.0.0 ad.sxp.smartclip.net
0.0.0.0 ad.thetyee.ca
0.0.0.0 ad.thewheelof.com
0.0.0.0 ad.thisav.com
0.0.0.0 ad.trafficmp.com
0.0.0.0 ad.turn.com
0.0.0.0 ad.tv2.no
0.0.0.0 ad.usatoday.com
0.0.0.0 ad.userporn.com
0.0.0.0 ad.valuecalling.com
0.0.0.0 ad.weplayer.cc
0.0.0.0 ad.where.com
0.0.0.0 ad.wsod.com
0.0.0.0 ad.yadro.ru
0.0.0.0 ad.yemeksepeti.com
0.0.0.0 ad.yieldmanager.com
0.0.0.0 ad.zaman.com
0.0.0.0 ad.zanox.com
0.0.0.0 ad.zodera.hu
0.0.0.0 ad0.haynet.com
0.0.0.0 ad01.focalink.com
0.0.0.0 ad01.mediacorpsingapore.com
0.0.0.0 ad02.focalink.com
0.0.0.0 ad03.focalink.com
0.0.0.0 ad04.focalink.com
0.0.0.0 ad05.focalink.com
0.0.0.0 ad06.focalink.com
0.0.0.0 ad07.focalink.com
0.0.0.0 ad08.focalink.com
0.0.0.0 ad09.focalink.com
0.0.0.0 ad1.bannerbank.ru
0.0.0.0 ad1.checkm8.com
0.0.0.0 ad1.emediate.dk
0.0.0.0 ad1.gamezone.com
0.0.0.0 ad1.hotel.com
0.0.0.0 ad1.lbn.ru
0.0.0.0 ad1.popcap.com
0.0.0.0 ad10.bannerbank.ru
0.0.0.0 ad10.checkm8.com
0.0.0.0 ad10.focalink.com
0.0.0.0 ad101com.adbureau.net
0.0.0.0 ad10digital.checkm8.com
0.0.0.0 ad11.bannerbank.ru
0.0.0.0 ad11.checkm8.com
0.0.0.0 ad11.focalink.com
0.0.0.0 ad11digital.checkm8.com
0.0.0.0 ad12.bannerbank.ru
0.0.0.0 ad12.checkm8.com
0.0.0.0 ad12.focalink.com
0.0.0.0 ad12digital.checkm8.com
0.0.0.0 ad13.checkm8.com
0.0.0.0 ad13.focalink.com
0.0.0.0 ad131m.adk2.co
0.0.0.0 ad13digital.checkm8.com
0.0.0.0 ad14.checkm8.com
0.0.0.0 ad14.focalink.com
0.0.0.0 ad14digital.checkm8.com
0.0.0.0 ad15.checkm8.com
0.0.0.0 ad15.focalink.com
0.0.0.0 ad15digital.checkm8.com
0.0.0.0 ad16.checkm8.com
0.0.0.0 ad16.focalink.com
0.0.0.0 ad16digital.checkm8.com
0.0.0.0 ad17.checkm8.com
0.0.0.0 ad17.focalink.com
0.0.0.0 ad17digital.checkm8.com
0.0.0.0 ad18.checkm8.com
0.0.0.0 ad18.focalink.com
0.0.0.0 ad18digital.checkm8.com
0.0.0.0 ad19.checkm8.com
0.0.0.0 ad19.focalink.com
0.0.0.0 ad19digital.checkm8.com
0.0.0.0 ad1digital.checkm8.com
0.0.0.0 ad2.adecn.com
0.0.0.0 ad2.bannerbank.ru
0.0.0.0 ad2.bannerhost.ru
0.0.0.0 ad2.checkm8.com
0.0.0.0 ad2.cooks.com
0.0.0.0 ad2.firehousezone.com
0.0.0.0 ad2.gammae.com
0.0.0.0 ad2.hotel.com
0.0.0.0 ad2.lbn.ru
0.0.0.0 ad2.nationalreview.com
0.0.0.0 ad2.pl
0.0.0.0 ad2.zophar.net
0.0.0.0 ad20.checkm8.com
0.0.0.0 ad20.net
0.0.0.0 ad20digital.checkm8.com
0.0.0.0 ad21.checkm8.com
0.0.0.0 ad21digital.checkm8.com
0.0.0.0 ad22.checkm8.com
0.0.0.0 ad22digital.checkm8.com
0.0.0.0 ad23.checkm8.com
0.0.0.0 ad23digital.checkm8.com
0.0.0.0 ad24.checkm8.com
0.0.0.0 ad24digital.checkm8.com
0.0.0.0 ad25.checkm8.com
0.0.0.0 ad25digital.checkm8.com
0.0.0.0 ad26.checkm8.com
0.0.0.0 ad26digital.checkm8.com
0.0.0.0 ad27.checkm8.com
0.0.0.0 ad27digital.checkm8.com
0.0.0.0 ad28.checkm8.com
0.0.0.0 ad28digital.checkm8.com
0.0.0.0 ad29.checkm8.com
0.0.0.0 ad29digital.checkm8.com
0.0.0.0 ad2digital.checkm8.com
0.0.0.0 ad2games.com
0.0.0.0 ad3.adfarm1.adition.com
0.0.0.0 ad3.bannerbank.ru
0.0.0.0 ad3.checkm8.com
0.0.0.0 ad3.eu
0.0.0.0 ad3.lbn.ru
0.0.0.0 ad3.nationalreview.com
0.0.0.0 ad30.checkm8.com
0.0.0.0 ad30digital.checkm8.com
0.0.0.0 ad31.checkm8.com
0.0.0.0 ad31digital.checkm8.com
0.0.0.0 ad32.checkm8.com
0.0.0.0 ad32digital.checkm8.com
0.0.0.0 ad33.checkm8.com
0.0.0.0 ad33digital.checkm8.com
0.0.0.0 ad34.checkm8.com
0.0.0.0 ad34digital.checkm8.com
0.0.0.0 ad35.checkm8.com
0.0.0.0 ad35digital.checkm8.com
0.0.0.0 ad36.checkm8.com
0.0.0.0 ad36digital.checkm8.com
0.0.0.0 ad37.checkm8.com
0.0.0.0 ad37digital.checkm8.com
0.0.0.0 ad38.checkm8.com
0.0.0.0 ad38digital.checkm8.com
0.0.0.0 ad39.checkm8.com
0.0.0.0 ad39digital.checkm8.com
0.0.0.0 ad3digital.checkm8.com
0.0.0.0 ad4.adfarm1.adition.com
0.0.0.0 ad4.bannerbank.ru
0.0.0.0 ad4.checkm8.com
0.0.0.0 ad4.lbn.ru
0.0.0.0 ad4.speedbit.com
0.0.0.0 ad40.checkm8.com
0.0.0.0 ad40digital.checkm8.com
0.0.0.0 ad41.atlas.cz
0.0.0.0 ad41.checkm8.com
0.0.0.0 ad41digital.checkm8.com
0.0.0.0 ad42.checkm8.com
0.0.0.0 ad42digital.checkm8.com
0.0.0.0 ad43.checkm8.com
0.0.0.0 ad43digital.checkm8.com
0.0.0.0 ad44.checkm8.com
0.0.0.0 ad44digital.checkm8.com
0.0.0.0 ad45.checkm8.com
0.0.0.0 ad45digital.checkm8.com
0.0.0.0 ad46.checkm8.com
0.0.0.0 ad46digital.checkm8.com
0.0.0.0 ad47.checkm8.com
0.0.0.0 ad47digital.checkm8.com
0.0.0.0 ad48.checkm8.com
0.0.0.0 ad48digital.checkm8.com
0.0.0.0 ad49.checkm8.com
0.0.0.0 ad49digital.checkm8.com
0.0.0.0 ad4digital.checkm8.com
0.0.0.0 ad4game.com
0.0.0.0 ad4partners.com
0.0.0.0 ad5.bannerbank.ru
0.0.0.0 ad5.checkm8.com
0.0.0.0 ad5.lbn.ru
0.0.0.0 ad50.checkm8.com
0.0.0.0 ad50digital.checkm8.com
0.0.0.0 ad5digital.checkm8.com
0.0.0.0 ad6.bannerbank.ru
0.0.0.0 ad6.checkm8.com
0.0.0.0 ad6.horvitznewspapers.net
0.0.0.0 ad6digital.checkm8.com
0.0.0.0 ad6media.fr
0.0.0.0 ad7.bannerbank.ru
0.0.0.0 ad7.checkm8.com
0.0.0.0 ad7digital.checkm8.com
0.0.0.0 ad8.adfarm1.adition.com
0.0.0.0 ad8.bannerbank.ru
0.0.0.0 ad8.checkm8.com
0.0.0.0 ad8digital.checkm8.com
0.0.0.0 ad9.bannerbank.ru
0.0.0.0 ad9.checkm8.com
0.0.0.0 ad9digital.checkm8.com
0.0.0.0 adagiobanner.s3.amazonaws.com
0.0.0.0 adaos-ads.net
0.0.0.0 adap.tv
0.0.0.0 adapd.com
0.0.0.0 adashx.ut.taobao.com
0.0.0.0 adashx4ae.ut.taobao.com
0.0.0.0 adb.fling.com
0.0.0.0 adb.wp.pl
0.0.0.0 adbers.com
0.0.0.0 adbg.hit.gemius.pl
0.0.0.0 adbit.co
0.0.0.0 adblade.com
0.0.0.0 adblockanalytics.com
0.0.0.0 adbot.theonion.com
0.0.0.0 adbrite.com
0.0.0.0 adbucks.brandreachsys.com
0.0.0.0 adc2.adcentriconline.com
0.0.0.0 adc3-launch.adcolony.com
0.0.0.0 adcanadian.com
0.0.0.0 adcarem.co
0.0.0.0 adcash.com
0.0.0.0 adcast.deviantart.com
0.0.0.0 adcentric.randomseed.com
0.0.0.0 adcentriconline.com
0.0.0.0 adclick.hit.gemius.pl
0.0.0.0 adclient-af.lp.uol.com.br
0.0.0.0 adcode.adengage.com
0.0.0.0 adconscious.com
0.0.0.0 adcontent.gamespy.com
0.0.0.0 adcontent.reedbusiness.com
0.0.0.0 adcontroller.unicast.com
0.0.0.0 adcovery.com
0.0.0.0 adcycle.footymad.net
0.0.0.0 add.f5haber.com
0.0.0.0 addelivery.thestreet.com
0.0.0.0 addserver.mtv.com.tr
0.0.0.0 addstock.co.uk
0.0.0.0 addthis.com
0.0.0.0 addthiscdn.com
0.0.0.0 ade.wooboo.com.cn
0.0.0.0 adecn.com
0.0.0.0 adengine.rt.ru
0.0.0.0 adexc.net
0.0.0.0 adexchangegate.com
0.0.0.0 adexchangeprediction.com
0.0.0.0 adexpansion.com
0.0.0.0 adexprt.com
0.0.0.0 adexprt.me
0.0.0.0 adexprts.com
0.0.0.0 adext.inkclub.com
0.0.0.0 adfactor.nl
0.0.0.0 adfarm1.adition.com
0.0.0.0 adforce.adtech.fr
0.0.0.0 adforce.adtech.us
0.0.0.0 adform.com
0.0.0.0 adfusion.com
0.0.0.0 adgardener.com
0.0.0.0 adgraphics.theonion.com
0.0.0.0 adguanggao.eee114.com
0.0.0.0 adhearus.com
0.0.0.0 adhese.be
0.0.0.0 adhese.com
0.0.0.0 adhese.nieuwsblad.be
0.0.0.0 adhitzads.com
0.0.0.0 adhref.pl
0.0.0.0 adidm.idmnet.pl
0.0.0.0 adimage.asia1.com.sg
0.0.0.0 adimage.blm.net
0.0.0.0 adimages.earthweb.com
0.0.0.0 adimages.go.com
0.0.0.0 adimages.mp3.com
0.0.0.0 adimages.omroepzeeland.nl
0.0.0.0 adimg.activeadv.net
0.0.0.0 adimg.com.com
0.0.0.0 adin.bigpoint.com
0.0.0.0 adipics.com
0.0.0.0 adireland.com
0.0.0.0 adition.com
0.0.0.0 adjmps.com
0.0.0.0 adjuggler.net
0.0.0.0 adjuggler.yourdictionary.com
0.0.0.0 adkontekst.pl
0.0.0.0 adm.265g.com
0.0.0.0 adm.baidu.com
0.0.0.0 adm.funshion.com
0.0.0.0 adm.fwmrm.net
0.0.0.0 adm.shinobi.jp
0.0.0.0 adm.xmfish.com
0.0.0.0 adman.freeze.com
0.0.0.0 adman.gr
0.0.0.0 adman.se
0.0.0.0 admanage.com
0.0.0.0 admanager.btopenworld.com
0.0.0.0 admanager.collegepublisher.com
0.0.0.0 admarkt.marktplaats.nl
0.0.0.0 admatch-syndication.mochila.com
0.0.0.0 admatcher.videostrip.com
0.0.0.0 admd.yam.com
0.0.0.0 admedia.com
0.0.0.0 admedia.wsod.com
0.0.0.0 admeld.com
0.0.0.0 admerize.be
0.0.0.0 admez.com
0.0.0.0 admin.digitalacre.com
0.0.0.0 admin.hotkeys.com
0.0.0.0 admonkey.dapper.net
0.0.0.0 adms.physorg.com
0.0.0.0 adn.ebay.com
0.0.0.0 adn.zone-telechargement.com
0.0.0.0 adnet.asahi.com
0.0.0.0 adnet.biz
0.0.0.0 adnet.com
0.0.0.0 adnet.de
0.0.0.0 adnetwork.nextgen.net
0.0.0.0 adnetwork.rovicorp.com
0.0.0.0 adnetworkperformance.com
0.0.0.0 adnxs.com
0.0.0.0 adnxs.revsci.net
0.0.0.0 ado.pro-market.net
0.0.0.0 adobe-sync.dotomi.com
0.0.0.0 adobe.tt.omtrdc.net
0.0.0.0 adobee.com
0.0.0.0 adocean.pl
0.0.0.0 adonline.e-kolay.net
0.0.0.0 adopt.euroclick.com
0.0.0.0 adopt.precisead.com
0.0.0.0 adotube.com
0.0.0.0 adp.gazeta.pl
0.0.0.0 adpepper.dk
0.0.0.0 adping.qq.com
0.0.0.0 adprovider.adlure.net
0.0.0.0 adpulse.ads.targetnet.com
0.0.0.0 adq.nextag.com
0.0.0.0 adrazzi.com
0.0.0.0 adriver.ru
0.0.0.0 adroll.com
0.0.0.0 adrotator.se
0.0.0.0 adrunnr.com
0.0.0.0 ads-a.juicyads.com
0.0.0.0 ads-d.viber.com
0.0.0.0 ads-de.spray.net
0.0.0.0 ads-game-187f4.firebaseapp.com
0.0.0.0 ads-rm.looksmart.com
0.0.0.0 ads-rolandgarros.com
0.0.0.0 ads-roularta.adhese.com
0.0.0.0 ads-stats.com
0.0.0.0 ads-t.ru
0.0.0.0 ads.5ci.lt
0.0.0.0 ads.7days.ae
0.0.0.0 ads.abs-cbn.com
0.0.0.0 ads.accelerator-media.com
0.0.0.0 ads.aceweb.net
0.0.0.0 ads.ad-center.com
0.0.0.0 ads.ad4game.com
0.0.0.0 ads.adamoads.com
0.0.0.0 ads.adap.tv
0.0.0.0 ads.adaptv.advertising.com
0.0.0.0 ads.adbroker.de
0.0.0.0 ads.adcorps.com
0.0.0.0 ads.addesktop.com
0.0.0.0 ads.addynamix.com
0.0.0.0 ads.adengage.com
0.0.0.0 ads.adfox.ru
0.0.0.0 ads.adgoto.com
0.0.0.0 ads.adhall.com
0.0.0.0 ads.adhostingsolutions.com
0.0.0.0 ads.adk2.com
0.0.0.0 ads.admarvel.com
0.0.0.0 ads.admaximize.com
0.0.0.0 ads.adroar.com
0.0.0.0 ads.adsag.com
0.0.0.0 ads.adsbookie.com
0.0.0.0 ads.adshareware.net
0.0.0.0 ads.adsinimages.com
0.0.0.0 ads.adsonar.com
0.0.0.0 ads.adsrvmedia.com
0.0.0.0 ads.adsrvmedia.net
0.0.0.0 ads.adtegrity.net
0.0.0.0 ads.adtiger.de
0.0.0.0 ads.adultfriendfinder.com
0.0.0.0 ads.advance.net
0.0.0.0 ads.adverline.com
0.0.0.0 ads.adviva.net
0.0.0.0 ads.adworldnetwork.com
0.0.0.0 ads.adxpansion.com
0.0.0.0 ads.adxpose.com
0.0.0.0 ads.aerserv.com
0.0.0.0 ads.affiliates.match.com
0.0.0.0 ads.ahds.ac.uk
0.0.0.0 ads.al.com
0.0.0.0 ads.albawaba.com
0.0.0.0 ads.allsites.com
0.0.0.0 ads.allvertical.com
0.0.0.0 ads.almasdarnews.com
0.0.0.0 ads.amazingmedia.com
0.0.0.0 ads.amgdgt.com
0.0.0.0 ads.ami-admin.com
0.0.0.0 ads.apartmenttherapy.com
0.0.0.0 ads.api.vungle.com
0.0.0.0 ads.apn.co.nz
0.0.0.0 ads.apn.co.za
0.0.0.0 ads.araba.com
0.0.0.0 ads.aroundtherings.com
0.0.0.0 ads.as4x.tmcs.net
0.0.0.0 ads.as4x.tmcs.ticketmaster.com
0.0.0.0 ads.aspalliance.com
0.0.0.0 ads.aspentimes.com
0.0.0.0 ads.associatedcontent.com
0.0.0.0 ads.astalavista.us
0.0.0.0 ads.auctionads.com
0.0.0.0 ads.auctioncity.co.nz
0.0.0.0 ads.auctions.yahoo.com
0.0.0.0 ads.avazu.net
0.0.0.0 ads.aws.viber.com
0.0.0.0 ads.azjmp.com
0.0.0.0 ads.b10f.jp
0.0.0.0 ads.baazee.com
0.0.0.0 ads.bangkokpost.co.th
0.0.0.0 ads.bauerpublishing.com
0.0.0.0 ads.bbcworld.com
0.0.0.0 ads.bcnewsgroup.com
0.0.0.0 ads.beeb.com
0.0.0.0 ads.beliefnet.com
0.0.0.0 ads.belointeractive.com
0.0.0.0 ads.betweendigital.com
0.0.0.0 ads.bfast.com
0.0.0.0 ads.bianca.com
0.0.0.0 ads.bidclix.com
0.0.0.0 ads.bidstreamserver.com
0.0.0.0 ads.biggerboat.com
0.0.0.0 ads.bizhut.com
0.0.0.0 ads.bizx.info
0.0.0.0 ads.blixem.nl
0.0.0.0 ads.blog.com
0.0.0.0 ads.blogherads.com
0.0.0.0 ads.bloomberg.com
0.0.0.0 ads.bluemountain.com
0.0.0.0 ads.bonnint.net
0.0.0.0 ads.brabys.com
0.0.0.0 ads.brand.net
0.0.0.0 ads.buscape.com.br
0.0.0.0 ads.businessclick.com
0.0.0.0 ads.businessweek.com
0.0.0.0 ads.camrecord.com
0.0.0.0 ads.cardea.se
0.0.0.0 ads.carocean.co.uk
0.0.0.0 ads.casinocity.com
0.0.0.0 ads.catholic.org
0.0.0.0 ads.cavello.com
0.0.0.0 ads.cbc.ca
0.0.0.0 ads.cc-dt.com
0.0.0.0 ads.cdn.viber.com
0.0.0.0 ads.cdnow.com
0.0.0.0 ads.centraliprom.com
0.0.0.0 ads.cgchannel.com
0.0.0.0 ads.chalomumbai.com
0.0.0.0 ads.champs-elysees.com
0.0.0.0 ads.chipcenter.com
0.0.0.0 ads.chumcity.com
0.0.0.0 ads.cineville.nl
0.0.0.0 ads.cleveland.com
0.0.0.0 ads.clickability.com
0.0.0.0 ads.clickad.com.pl
0.0.0.0 ads.clickagents.com
0.0.0.0 ads.clubzone.com
0.0.0.0 ads.cluster01.oasis.zmh.zope.net
0.0.0.0 ads.cnixon.com
0.0.0.0 ads.cnngo.com
0.0.0.0 ads.cobrad.com
0.0.0.0 ads.collegclub.com
0.0.0.0 ads.collegemix.com
0.0.0.0 ads.com.com
0.0.0.0 ads.contactmusic.com
0.0.0.0 ads.contentabc.com
0.0.0.0 ads.coopson.com
0.0.0.0 ads.corusradionetwork.com
0.0.0.0 ads.courierpostonline.com
0.0.0.0 ads.crakmedia.com
0.0.0.0 ads.crapville.com
0.0.0.0 ads.creative-serving.com
0.0.0.0 ads.crosscut.com
0.0.0.0 ads.ctvdigital.net
0.0.0.0 ads.currantbun.com
0.0.0.0 ads.cvut.cz
0.0.0.0 ads.cybersales.cz
0.0.0.0 ads.dada.it
0.0.0.0 ads.ddj.com
0.0.0.0 ads.democratandchronicle.com
0.0.0.0 ads.dennisnet.co.uk
0.0.0.0 ads.designboom.com
0.0.0.0 ads.designtaxi.com
0.0.0.0 ads.desmoinesregister.com
0.0.0.0 ads.detelefoongids.nl
0.0.0.0 ads.deviantart.com
0.0.0.0 ads.digital-digest.com
0.0.0.0 ads.digitalacre.com
0.0.0.0 ads.digitalcaramel.com
0.0.0.0 ads.digitalmedianet.com
0.0.0.0 ads.digitalpoint.com
0.0.0.0 ads.dimcab.com
0.0.0.0 ads.directionsmag.com
0.0.0.0 ads.dk
0.0.0.0 ads.domeus.com
0.0.0.0 ads.dotomi.com
0.0.0.0 ads.drf.com
0.0.0.0 ads.e-planning.net
0.0.0.0 ads.ecircles.com
0.0.0.0 ads.economist.com
0.0.0.0 ads.einmedia.com
0.0.0.0 ads.eircom.net
0.0.0.0 ads.enliven.com
0.0.0.0 ads.erotism.com
0.0.0.0 ads.espn.adsonar.com
0.0.0.0 ads.eu.msn.com
0.0.0.0 ads.examiner.net
0.0.0.0 ads.exosrv.com
0.0.0.0 ads.expekt.com
0.0.0.0 ads.fairfax.com.au
0.0.0.0 ads.fayettevillenc.com
0.0.0.0 ads.fileindexer.com
0.0.0.0 ads.filmup.com
0.0.0.0 ads.first-response.be
0.0.0.0 ads.flashgames247.com
0.0.0.0 ads.fling.com
0.0.0.0 ads.floridatoday.com
0.0.0.0 ads.fool.com
0.0.0.0 ads.forbes.net
0.0.0.0 ads.fortunecity.com
0.0.0.0 ads.fox.com
0.0.0.0 ads.foxnews.com
0.0.0.0 ads.fredericksburg.com
0.0.0.0 ads.freebannertrade.com
0.0.0.0 ads.freeskreen.com
0.0.0.0 ads.freshmeat.net
0.0.0.0 ads.friendfinder.com
0.0.0.0 ads.fuckingmachines.com
0.0.0.0 ads.game.net
0.0.0.0 ads.gamecity.net
0.0.0.0 ads.gamecopyworld.no
0.0.0.0 ads.gamespyid.com
0.0.0.0 ads.garga.biz
0.0.0.0 ads.glispa.com
0.0.0.0 ads.globo.com
0.0.0.0 ads.gmodules.com
0.0.0.0 ads.gold
0.0.0.0 ads.golfweek.com
0.0.0.0 ads.gorillanation.com
0.0.0.0 ads.gplusmedia.com
0.0.0.0 ads.granadamedia.com
0.0.0.0 ads.greenbaypressgazette.com
0.0.0.0 ads.greenvilleonline.com
0.0.0.0 ads.guardian.co.uk
0.0.0.0 ads.guardianunlimited.co.uk
0.0.0.0 ads.haberler.com
0.0.0.0 ads.harpers.org
0.0.0.0 ads.hbv.de
0.0.0.0 ads.he.valueclick.net
0.0.0.0 ads.hearstmags.com
0.0.0.0 ads.heartlight.org
0.0.0.0 ads.heraldnet.com
0.0.0.0 ads.heroldonline.com
0.0.0.0 ads.hitcents.com
0.0.0.0 ads.hollandsentinel.com
0.0.0.0 ads.hollywood.com
0.0.0.0 ads.hulu.com.edgesuite.net
0.0.0.0 ads.i-am-bored.com
0.0.0.0 ads.icq.com
0.0.0.0 ads.ign.com
0.0.0.0 ads.illuminatednation.com
0.0.0.0 ads.indeed.com
0.0.0.0 ads.indiatimes.com
0.0.0.0 ads.indya.com
0.0.0.0 ads.indystar.com
0.0.0.0 ads.inetinteractive.com
0.0.0.0 ads.infi.net
0.0.0.0 ads.injersey.com
0.0.0.0 ads.intellicast.com
0.0.0.0 ads.intergi.com
0.0.0.0 ads.internic.co.il
0.0.0.0 ads.ipowerweb.com
0.0.0.0 ads.ireport.com
0.0.0.0 ads.isoftmarketing.com
0.0.0.0 ads.itv.com
0.0.0.0 ads.iwon.com
0.0.0.0 ads.jetpackdigital.com
0.0.0.0 ads.jewcy.com
0.0.0.0 ads.jimworld.com
0.0.0.0 ads.jokaroo.com
0.0.0.0 ads.jossip.com
0.0.0.0 ads.jpost.com
0.0.0.0 ads.juicyads.com
0.0.0.0 ads.keywordblocks.com
0.0.0.0 ads.koreanfriendfinder.com
0.0.0.0 ads.ksl.com
0.0.0.0 ads.kure.tv
0.0.0.0 ads.lfstmedia.com
0.0.0.0 ads.link4ads.com
0.0.0.0 ads.linktracking.net
0.0.0.0 ads.linuxjournal.com
0.0.0.0 ads.live365.com
0.0.0.0 ads.lmmob.com
0.0.0.0 ads.lucidmedia.com
0.0.0.0 ads.lycos.com
0.0.0.0 ads.lzjl.com
0.0.0.0 ads.madisonavenue.com
0.0.0.0 ads.magnetic.is
0.0.0.0 ads.mail3x.com
0.0.0.0 ads.mariuana.it
0.0.0.0 ads.mcafee.com
0.0.0.0 ads.mdchoice.com
0.0.0.0 ads.mediaforge.com
0.0.0.0 ads.mediamayhemcorp.com
0.0.0.0 ads.mediaodyssey.com
0.0.0.0 ads.mediaturf.net
0.0.0.0 ads.mefeedia.com
0.0.0.0 ads.megaproxy.com
0.0.0.0 ads.metblogs.com
0.0.0.0 ads.metropolis.co.jp
0.0.0.0 ads.mgnetwork.com
0.0.0.0 ads.mindsetnetwork.com
0.0.0.0 ads.mircx.com
0.0.0.0 ads.mlive.com
0.0.0.0 ads.mm.ap.org
0.0.0.0 ads.mofos.com
0.0.0.0 ads.mopub.com
0.0.0.0 ads.morningstar.com
0.0.0.0 ads.mouseplanet.com
0.0.0.0 ads.movieweb.com
0.0.0.0 ads.mozilla.org
0.0.0.0 ads.mp.mydas.mobi
0.0.0.0 ads.mp3searchy.com
0.0.0.0 ads.mtv.uol.com.br
0.0.0.0 ads.multimania.lycos.fr
0.0.0.0 ads.mustangworks.com
0.0.0.0 ads.mycricket.com
0.0.0.0 ads.mysimon.com
0.0.0.0 ads.mytelus.com
0.0.0.0 ads.nationalreview.com
0.0.0.0 ads.nerve.com
0.0.0.0 ads.netbul.com
0.0.0.0 ads.networkwcs.net
0.0.0.0 ads.networldmedia.net
0.0.0.0 ads.neudesicmediagroup.com
0.0.0.0 ads.newgrounds.com
0.0.0.0 ads.newsint.co.uk
0.0.0.0 ads.newsminerextra.com
0.0.0.0 ads.newsobserver.com
0.0.0.0 ads.newsquest.co.uk
0.0.0.0 ads.newtention.net
0.0.0.0 ads.nexage.com
0.0.0.0 ads.nicovideo.jp
0.0.0.0 ads.ninemsn.com.au
0.0.0.0 ads.nola.com
0.0.0.0 ads.northjersey.com
0.0.0.0 ads.novem.pl
0.0.0.0 ads.novinhagostosa10.com
0.0.0.0 ads.ntadvice.com
0.0.0.0 ads.nyi.net
0.0.0.0 ads.nyootv.com
0.0.0.0 ads.nytimes.com
0.0.0.0 ads.o2.pl
0.0.0.0 ads.ole.com
0.0.0.0 ads.omaha.com
0.0.0.0 ads.online.ie
0.0.0.0 ads.onvertise.com
0.0.0.0 ads.open.pl
0.0.0.0 ads.opensubtitles.org
0.0.0.0 ads.oregonlive.com
0.0.0.0 ads.osdn.com
0.0.0.0 ads.panoramtech.net
0.0.0.0 ads.paper.li
0.0.0.0 ads.parrysound.com
0.0.0.0 ads.paxnet.co.kr
0.0.0.0 ads.peel.com
0.0.0.0 ads.pennyweb.com
0.0.0.0 ads.people.com.cn
0.0.0.0 ads.persgroep.net
0.0.0.0 ads.phillyburbs.com
0.0.0.0 ads.phpclasses.org
0.0.0.0 ads.pitchforkmedia.com
0.0.0.0 ads.pittsburghlive.com
0.0.0.0 ads.pixiq.com
0.0.0.0 ads.planet-f1.com
0.0.0.0 ads.pni.com
0.0.0.0 ads.pno.net
0.0.0.0 ads.poconorecord.com
0.0.0.0 ads.pof.com
0.0.0.0 ads.pointroll.com
0.0.0.0 ads.premiumnetwork.net
0.0.0.0 ads.pressdemo.com
0.0.0.0 ads.pricescan.com
0.0.0.0 ads.prisacom.com
0.0.0.0 ads.pro-market.net
0.0.0.0 ads.pro-market.net.edgesuite.net
0.0.0.0 ads.profitsdeluxe.com
0.0.0.0 ads.profootballtalk.com
0.0.0.0 ads.program3.com
0.0.0.0 ads.prospect.org
0.0.0.0 ads.pruc.org
0.0.0.0 ads.pubmatic.com
0.0.0.0 ads.queendom.com
0.0.0.0 ads.ratemyprofessors.com
0.0.0.0 ads.rcgroups.com
0.0.0.0 ads.rdstore.com
0.0.0.0 ads.realcities.com
0.0.0.0 ads.realmedia.de
0.0.0.0 ads.rediff.com
0.0.0.0 ads.register.com
0.0.0.0 ads.reklamatik.com
0.0.0.0 ads.reklamlar.net
0.0.0.0 ads.revenue.net
0.0.0.0 ads.revsci.net
0.0.0.0 ads.roanoke.com
0.0.0.0 ads.roiserver.com
0.0.0.0 ads.rondomondo.com
0.0.0.0 ads.rootzoo.com
0.0.0.0 ads.rubiconproject.com
0.0.0.0 ads.ruralpress.com
0.0.0.0 ads.sacbee.com
0.0.0.0 ads.satyamonline.com
0.0.0.0 ads.scabee.com
0.0.0.0 ads.scifi.com
0.0.0.0 ads.scorecardresearch.com
0.0.0.0 ads.scott-sports.com
0.0.0.0 ads.scottusa.com
0.0.0.0 ads.servebom.com
0.0.0.0 ads.servenobid.com
0.0.0.0 ads.sexier.com
0.0.0.0 ads.sfusion.com
0.0.0.0 ads.shiftdelete.net
0.0.0.0 ads.shizmoo.com
0.0.0.0 ads.shovtvnet.com
0.0.0.0 ads.showtvnet.com
0.0.0.0 ads.simpli.fi
0.0.0.0 ads.simtel.com
0.0.0.0 ads.simtel.net
0.0.0.0 ads.sl.interpals.net
0.0.0.0 ads.smartclick.com
0.0.0.0 ads.smartclicks.com
0.0.0.0 ads.smartclicks.net
0.0.0.0 ads.smowtion.com
0.0.0.0 ads.snowball.com
0.0.0.0 ads.socialtheater.com
0.0.0.0 ads.space.com
0.0.0.0 ads.specificclick.com
0.0.0.0 ads.specificmedia.com
0.0.0.0 ads.spilgames.com
0.0.0.0 ads.spintrade.com
0.0.0.0 ads.spymac.net
0.0.0.0 ads.stackoverflow.com
0.0.0.0 ads.starbanner.com
0.0.0.0 ads.stephensmedia.com
0.0.0.0 ads.stileproject.com
0.0.0.0 ads.stoiximan.gr
0.0.0.0 ads.sumotorrent.com
0.0.0.0 ads.sup.com
0.0.0.0 ads.superonline.com
0.0.0.0 ads.swiftnews.com
0.0.0.0 ads.tbs.com
0.0.0.0 ads.technoratimedia.com
0.0.0.0 ads.techvibes.com
0.0.0.0 ads.techweb.com
0.0.0.0 ads.telecinco.es
0.0.0.0 ads.thecoolhunter.net
0.0.0.0 ads.thecrimson.com
0.0.0.0 ads.thefrisky.com
0.0.0.0 ads.theindependent.com
0.0.0.0 ads.themoneytizer.com
0.0.0.0 ads.theolympian.com
0.0.0.0 ads.thestar.com
0.0.0.0 ads.timesunion.com
0.0.0.0 ads.tmcs.net
0.0.0.0 ads.tnt.tv
0.0.0.0 ads.toronto.com
0.0.0.0 ads.townhall.com
0.0.0.0 ads.tracfonewireless.com
0.0.0.0 ads.track.net
0.0.0.0 ads.traderonline.com
0.0.0.0 ads.traffichaus.com
0.0.0.0 ads.trafficjunky.net
0.0.0.0 ads.treehugger.com
0.0.0.0 ads.trinitymirror.co.uk
0.0.0.0 ads.tripod.com
0.0.0.0 ads.tripod.lycos.co.uk
0.0.0.0 ads.tripod.lycos.de
0.0.0.0 ads.tripod.lycos.es
0.0.0.0 ads.tromaville.com
0.0.0.0 ads.trutv.com
0.0.0.0 ads.tw.adsonar.com
0.0.0.0 ads.uigc.net
0.0.0.0 ads.ukclimbing.com
0.0.0.0 ads.ultimatesurrender.com
0.0.0.0 ads.undertone.com
0.0.0.0 ads.uproar.com
0.0.0.0 ads.urbandictionary.com
0.0.0.0 ads.usatoday.com
0.0.0.0 ads.v3.com
0.0.0.0 ads.v3exchange.com
0.0.0.0 ads.vaildaily.com
0.0.0.0 ads.valuead.com
0.0.0.0 ads.vegas.com
0.0.0.0 ads.veloxia.com
0.0.0.0 ads.ventivmedia.com
0.0.0.0 ads.veoh.com
0.0.0.0 ads.viber.com
0.0.0.0 ads.videoadvertising.com
0.0.0.0 ads.vidoomy.com
0.0.0.0 ads.virginislandsdailynews.com
0.0.0.0 ads.virtualcountries.com
0.0.0.0 ads.waframedia1.com
0.0.0.0 ads.waps.cn
0.0.0.0 ads.wapx.cn
0.0.0.0 ads.weather.ca
0.0.0.0 ads.web.de
0.0.0.0 ads.web21.com
0.0.0.0 ads.webfeat.com
0.0.0.0 ads.webheat.com
0.0.0.0 ads.webhosting.info
0.0.0.0 ads.webindia123.com
0.0.0.0 ads.webmd.com
0.0.0.0 ads.webnet.advance.net
0.0.0.0 ads.winsite.com
0.0.0.0 ads.worldstarhiphop.com
0.0.0.0 ads.x17online.com
0.0.0.0 ads.xbox-scene.com
0.0.0.0 ads.xtra.ca
0.0.0.0 ads.xtra.co.nz
0.0.0.0 ads.xtramsn.co.nz
0.0.0.0 ads.yahoo.com
0.0.0.0 ads.yap.yahoo.com
0.0.0.0 ads.yimg.com
0.0.0.0 ads.yimg.com.edgesuite.net
0.0.0.0 ads.yldmgrimg.net
0.0.0.0 ads.youtube.com
0.0.0.0 ads.zamunda.se
0.0.0.0 ads.zynga.com
0.0.0.0 ads01.com
0.0.0.0 ads01.focalink.com
0.0.0.0 ads02.focalink.com
0.0.0.0 ads03.focalink.com
0.0.0.0 ads04.focalink.com
0.0.0.0 ads05.focalink.com
0.0.0.0 ads06.focalink.com
0.0.0.0 ads07.focalink.com
0.0.0.0 ads08.focalink.com
0.0.0.0 ads09.focalink.com
0.0.0.0 ads1.admedia.ro
0.0.0.0 ads1.advance.net
0.0.0.0 ads1.ami-admin.com
0.0.0.0 ads1.destructoid.com
0.0.0.0 ads1.erotism.com
0.0.0.0 ads1.jev.co.za
0.0.0.0 ads1.msads.net
0.0.0.0 ads1.msn.com
0.0.0.0 ads1.performancingads.com
0.0.0.0 ads1.realcities.com
0.0.0.0 ads1.revenue.net
0.0.0.0 ads1.updated.com
0.0.0.0 ads10.console.adtarget.com.tr
0.0.0.0 ads10.focalink.com
0.0.0.0 ads10.speedbit.com
0.0.0.0 ads106.console.adtarget.com.tr
0.0.0.0 ads108.console.adtarget.com.tr
0.0.0.0 ads11.console.adtarget.com.tr
0.0.0.0 ads11.focalink.com
0.0.0.0 ads110.console.adtarget.com.tr
0.0.0.0 ads114.console.adtarget.com.tr
0.0.0.0 ads115.console.adtarget.com.tr
0.0.0.0 ads119.console.adtarget.com.tr
0.0.0.0 ads12.console.adtarget.com.tr
0.0.0.0 ads12.focalink.com
0.0.0.0 ads128.console.adtarget.com.tr
0.0.0.0 ads129.console.adtarget.com.tr
0.0.0.0 ads13.console.adtarget.com.tr
0.0.0.0 ads13.focalink.com
0.0.0.0 ads130.console.adtarget.com.tr
0.0.0.0 ads13000.cpmoz.com
0.0.0.0 ads135.console.adtarget.com.tr
0.0.0.0 ads136.console.adtarget.com.tr
0.0.0.0 ads137.console.adtarget.com.tr
0.0.0.0 ads138.console.adtarget.com.tr
0.0.0.0 ads139.console.adtarget.com.tr
0.0.0.0 ads14.focalink.com
0.0.0.0 ads140.console.adtarget.com.tr
0.0.0.0 ads145.console.adtarget.com.tr
0.0.0.0 ads146.console.adtarget.com.tr
0.0.0.0 ads15.focalink.com
0.0.0.0 ads151.console.adtarget.com.tr
0.0.0.0 ads152.console.adtarget.com.tr
0.0.0.0 ads153.console.adtarget.com.tr
0.0.0.0 ads154.console.adtarget.com.tr
0.0.0.0 ads155.console.adtarget.com.tr
0.0.0.0 ads156.console.adtarget.com.tr
0.0.0.0 ads157.console.adtarget.com.tr
0.0.0.0 ads158.console.adtarget.com.tr
0.0.0.0 ads159.console.adtarget.com.tr
0.0.0.0 ads16.advance.net
0.0.0.0 ads16.focalink.com
0.0.0.0 ads160.console.adtarget.com.tr
0.0.0.0 ads163.console.adtarget.com.tr
0.0.0.0 ads17.focalink.com
0.0.0.0 ads18.console.adtarget.com.tr
0.0.0.0 ads18.focalink.com
0.0.0.0 ads19.focalink.com
0.0.0.0 ads1a.depositfiles.com
0.0.0.0 ads2-adnow.com
0.0.0.0 ads2.advance.net
0.0.0.0 ads2.clearchannel.com
0.0.0.0 ads2.clickad.com
0.0.0.0 ads2.collegclub.com
0.0.0.0 ads2.collegeclub.com
0.0.0.0 ads2.contentabc.com
0.0.0.0 ads2.gamecity.net
0.0.0.0 ads2.haber3.com
0.0.0.0 ads2.msn.com
0.0.0.0 ads2.opensubtitles.org
0.0.0.0 ads2.osdn.com
0.0.0.0 ads2.pittsburghlive.com
0.0.0.0 ads2.realcities.com
0.0.0.0 ads2.revenue.net
0.0.0.0 ads2.weblogssl.com
0.0.0.0 ads2.zeusclicks.com
0.0.0.0 ads20.console.adtarget.com.tr
0.0.0.0 ads20.focalink.com
0.0.0.0 ads201.console.adtarget.com.tr
0.0.0.0 ads202.console.adtarget.com.tr
0.0.0.0 ads203.console.adtarget.com.tr
0.0.0.0 ads206.console.adtarget.com.tr
0.0.0.0 ads21.focalink.com
0.0.0.0 ads210.console.adtarget.com.tr
0.0.0.0 ads214.console.adtarget.com.tr
0.0.0.0 ads215.console.adtarget.com.tr
0.0.0.0 ads216.console.adtarget.com.tr
0.0.0.0 ads217.console.adtarget.com.tr
0.0.0.0 ads218.console.adtarget.com.tr
0.0.0.0 ads219.console.adtarget.com.tr
0.0.0.0 ads22.focalink.com
0.0.0.0 ads22.host-cdn.net
0.0.0.0 ads23.focalink.com
0.0.0.0 ads24.console.adtarget.com.tr
0.0.0.0 ads24.focalink.com
0.0.0.0 ads24.net
0.0.0.0 ads240.console.adtarget.com.tr
0.0.0.0 ads241.console.adtarget.com.tr
0.0.0.0 ads244.console.adtarget.com.tr
0.0.0.0 ads25.focalink.com
0.0.0.0 ads250.console.adtarget.com.tr
0.0.0.0 ads256.console.adtarget.com.tr
0.0.0.0 ads257.console.adtarget.com.tr
0.0.0.0 ads258.console.adtarget.com.tr
0.0.0.0 ads259.console.adtarget.com.tr
0.0.0.0 ads28.console.adtarget.com.tr
0.0.0.0 ads29.console.adtarget.com.tr
0.0.0.0 ads2ads.net
0.0.0.0 ads2srv.com
0.0.0.0 ads3.advance.net
0.0.0.0 ads3.freebannertrade.com
0.0.0.0 ads3.gamecity.net
0.0.0.0 ads3.haber3.com
0.0.0.0 ads3.realcities.com
0.0.0.0 ads30.console.adtarget.com.tr
0.0.0.0 ads31.console.adtarget.com.tr
0.0.0.0 ads32.console.adtarget.com.tr
0.0.0.0 ads36.console.adtarget.com.tr
0.0.0.0 ads360.com
0.0.0.0 ads37.console.adtarget.com.tr
0.0.0.0 ads38.console.adtarget.com.tr
0.0.0.0 ads4.advance.net
0.0.0.0 ads4.console.adtarget.com.tr
0.0.0.0 ads4.gamecity.net
0.0.0.0 ads4.realcities.com
0.0.0.0 ads40.console.adtarget.com.tr
0.0.0.0 ads42.console.adtarget.com.tr
0.0.0.0 ads43.console.adtarget.com.tr
0.0.0.0 ads44.console.adtarget.com.tr
0.0.0.0 ads46.console.adtarget.com.tr
0.0.0.0 ads47.console.adtarget.com.tr
0.0.0.0 ads48.console.adtarget.com.tr
0.0.0.0 ads4cheap.com
0.0.0.0 ads4homes.com
0.0.0.0 ads5.advance.net
0.0.0.0 ads5.console.adtarget.com.tr
0.0.0.0 ads5.fxdepo.com
0.0.0.0 ads50.console.adtarget.com.tr
0.0.0.0 ads51.console.adtarget.com.tr
0.0.0.0 ads54.console.adtarget.com.tr
0.0.0.0 ads55.console.adtarget.com.tr
0.0.0.0 ads56.console.adtarget.com.tr
0.0.0.0 ads58.console.adtarget.com.tr
0.0.0.0 ads59.console.adtarget.com.tr
0.0.0.0 ads6.advance.net
0.0.0.0 ads6.gamecity.net
0.0.0.0 ads7.advance.net
0.0.0.0 ads7.console.adtarget.com.tr
0.0.0.0 ads7.gamecity.net
0.0.0.0 ads7.speedbit.com
0.0.0.0 ads8.com
0.0.0.0 ads8.console.adtarget.com.tr
0.0.0.0 ads80.com
0.0.0.0 adsadmin.corusradionetwork.com
0.0.0.0 adsatt.abcnews.starwave.com
0.0.0.0 adsatt.espn.go.com
0.0.0.0 adsatt.espn.starwave.com
0.0.0.0 adsbb.dfiles.eu
0.0.0.0 adscendmedia.com
0.0.0.0 adscholar.com
0.0.0.0 adsclick.qq.com
0.0.0.0 adsdaq.com
0.0.0.0 adsearch.adkontekst.pl
0.0.0.0 adsearch.pl
0.0.0.0 adsearch.wp.pl
0.0.0.0 adserv.bravenet.com
0.0.0.0 adserv.lwmn.net
0.0.0.0 adserv.maineguide.com
0.0.0.0 adserv.mywebtimes.com
0.0.0.0 adserv.postbulletin.com
0.0.0.0 adserv.quality-channel.de
0.0.0.0 adserv.usps.com
0.0.0.0 adserv001.adtech.fr
0.0.0.0 adserv001.adtech.us
0.0.0.0 adserv002.adtech.fr
0.0.0.0 adserv002.adtech.us
0.0.0.0 adserv003.adtech.fr
0.0.0.0 adserv003.adtech.us
0.0.0.0 adserv004.adtech.fr
0.0.0.0 adserv004.adtech.us
0.0.0.0 adserv005.adtech.fr
0.0.0.0 adserv005.adtech.us
0.0.0.0 adserv006.adtech.fr
0.0.0.0 adserv006.adtech.us
0.0.0.0 adserv007.adtech.fr
0.0.0.0 adserv007.adtech.us
0.0.0.0 adserv008.adtech.fr
0.0.0.0 adserv008.adtech.us
0.0.0.0 adserv2.bravenet.com
0.0.0.0 adserve.adtoll.com
0.0.0.0 adserve.city-ad.com
0.0.0.0 adserve.ehpub.com
0.0.0.0 adserve.gossipgirls.com
0.0.0.0 adserve.mizzenmedia.com
0.0.0.0 adserve.podaddies.com
0.0.0.0 adserve.profit-smart.com
0.0.0.0 adserve.shopzilla.com
0.0.0.0 adserve.viaarena.com
0.0.0.0 adserve5.nikkeibp.co.jp
0.0.0.0 adserver-2.ig.com.br
0.0.0.0 adserver-4.ig.com.br
0.0.0.0 adserver-5.ig.com.br
0.0.0.0 adserver-espnet.sportszone.net
0.0.0.0 adserver-images.adikteev.com
0.0.0.0 adserver-us.adtech.advertising.com
0.0.0.0 adserver.100free.com
0.0.0.0 adserver.3digit.de
0.0.0.0 adserver.71i.de
0.0.0.0 adserver.abv.bg
0.0.0.0 adserver.adreactor.com
0.0.0.0 adserver.adremedy.com
0.0.0.0 adserver.ads360.com
0.0.0.0 adserver.adtech.de
0.0.0.0 adserver.adtech.fr
0.0.0.0 adserver.adtech.us
0.0.0.0 adserver.adtechus.com
0.0.0.0 adserver.adultfriendfinder.com
0.0.0.0 adserver.advertist.com
0.0.0.0 adserver.affiliatemg.com
0.0.0.0 adserver.airmiles.ca
0.0.0.0 adserver.aol.fr
0.0.0.0 adserver.archant.co.uk
0.0.0.0 adserver.betandwin.de
0.0.0.0 adserver.bizland-inc.net
0.0.0.0 adserver.bluereactor.com
0.0.0.0 adserver.cams.com
0.0.0.0 adserver.cantv.net
0.0.0.0 adserver.cebu-online.com
0.0.0.0 adserver.chickclick.com
0.0.0.0 adserver.click4cash.de
0.0.0.0 adserver.clundressed.com
0.0.0.0 adserver.co.il
0.0.0.0 adserver.colleges.com
0.0.0.0 adserver.com
0.0.0.0 adserver.corusradionetwork.com
0.0.0.0 adserver.creative-asia.com
0.0.0.0 adserver.creativeinspire.com
0.0.0.0 adserver.dayrates.com
0.0.0.0 adserver.dbusiness.com
0.0.0.0 adserver.developersnetwork.com
0.0.0.0 adserver.digitoday.com
0.0.0.0 adserver.directforce.com
0.0.0.0 adserver.dnps.com
0.0.0.0 adserver.dotmusic.com
0.0.0.0 adserver.emulation64.com
0.0.0.0 adserver.exoticads.com
0.0.0.0 adserver.filefront.com
0.0.0.0 adserver.friendfinder.com
0.0.0.0 adserver.gameparty.net
0.0.0.0 adserver.gorillanation.com
0.0.0.0 adserver.gr
0.0.0.0 adserver.harktheherald.com
0.0.0.0 adserver.hellasnet.gr
0.0.0.0 adserver.hg-computer.de
0.0.0.0 adserver.home.pl
0.0.0.0 adserver.hostinteractive.com
0.0.0.0 adserver.humanux.com
0.0.0.0 adserver.hwupgrade.it
0.0.0.0 adserver.icmedienhaus.de
0.0.0.0 adserver.ign.com
0.0.0.0 adserver.infotiger.com
0.0.0.0 adserver.intentiq.com
0.0.0.0 adserver.interfree.it
0.0.0.0 adserver.inwind.it
0.0.0.0 adserver.ision.de
0.0.0.0 adserver.isonews.com
0.0.0.0 adserver.janes.com
0.0.0.0 adserver.janes.net
0.0.0.0 adserver.janes.org
0.0.0.0 adserver.juicyads.com
0.0.0.0 adserver.killeraces.com
0.0.0.0 adserver.kimia.es
0.0.0.0 adserver.kylemedia.com
0.0.0.0 adserver.lanacion.com.ar
0.0.0.0 adserver.legacy-network.com
0.0.0.0 adserver.libero.it
0.0.0.0 adserver.linktrader.co.uk
0.0.0.0 adserver.livejournal.com
0.0.0.0 adserver.lostreality.com
0.0.0.0 adserver.lunarpages.com
0.0.0.0 adserver.lycos.co.jp
0.0.0.0 adserver.magazyn.pl
0.0.0.0 adserver.matchcraft.com
0.0.0.0 adserver.merc.com
0.0.0.0 adserver.mindshare.de
0.0.0.0 adserver.mobsmith.com
0.0.0.0 adserver.myownemail.com
0.0.0.0 adserver.netcreators.nl
0.0.0.0 adserver.ngz-network.de
0.0.0.0 adserver.nydailynews.com
0.0.0.0 adserver.nzoom.com
0.0.0.0 adserver.o2.pl
0.0.0.0 adserver.omroepzeeland.nl
0.0.0.0 adserver.onwisconsin.com
0.0.0.0 adserver.passion.com
0.0.0.0 adserver.phatmax.net
0.0.0.0 adserver.phillyburbs.com
0.0.0.0 adserver.pl
0.0.0.0 adserver.planet-multiplayer.de
0.0.0.0 adserver.portal.pl
0.0.0.0 adserver.portalofevil.com
0.0.0.0 adserver.pressboard.ca
0.0.0.0 adserver.proteinos.com
0.0.0.0 adserver.radio-canada.ca
0.0.0.0 adserver.ro
0.0.0.0 adserver.sandbox.cxad.cxense.com
0.0.0.0 adserver.sanomawsoy.fi
0.0.0.0 adserver.sextracker.com
0.0.0.0 adserver.sharewareonline.com
0.0.0.0 adserver.sl.kharkov.ua
0.0.0.0 adserver.smashtv.com
0.0.0.0 adserver.snowball.com
0.0.0.0 adserver.softonic.com
0.0.0.0 adserver.soloserver.com
0.0.0.0 adserver.swiatobrazu.pl
0.0.0.0 adserver.te.pt
0.0.0.0 adserver.terra.com.br
0.0.0.0 adserver.terra.es
0.0.0.0 adserver.theknot.com
0.0.0.0 adserver.theonering.net
0.0.0.0 adserver.thirty4.com
0.0.0.0 adserver.thisislondon.co.uk
0.0.0.0 adserver.track-star.com
0.0.0.0 adserver.trader.ca
0.0.0.0 adserver.trafficsyndicate.com
0.0.0.0 adserver.tweakers.net
0.0.0.0 adserver.twitpic.com
0.0.0.0 adserver.ugo.nl
0.0.0.0 adserver.van.net
0.0.0.0 adserver.virginmedia.com
0.0.0.0 adserver.virtuous.co.uk
0.0.0.0 adserver.webads.co.uk
0.0.0.0 adserver.webads.nl
0.0.0.0 adserver.wietforum.nl
0.0.0.0 adserver.x3.hu
0.0.0.0 adserver.yahoo.com
0.0.0.0 adserver.zeads.com
0.0.0.0 adserver1-images.backbeatmedia.com
0.0.0.0 adserver1.adtech.com.tr
0.0.0.0 adserver1.backbeatmedia.com
0.0.0.0 adserver1.hookyouup.com
0.0.0.0 adserver1.mediainsight.de
0.0.0.0 adserver1.sonymusiceurope.com
0.0.0.0 adserver1.wmads.com
0.0.0.0 adserver2.atman.pl
0.0.0.0 adserver2.creative.com
0.0.0.0 adserver2.mediainsight.de
0.0.0.0 adserver9.contextad.com
0.0.0.0 adserversolutions.com
0.0.0.0 adservice.google.ca
0.0.0.0 adservice.google.co.za
0.0.0.0 adservice.google.com
0.0.0.0 adservice.google.com.au
0.0.0.0 adservice.google.cz
0.0.0.0 adservice.google.nl
0.0.0.0 adseu.novem.pl
0.0.0.0 adsfac.eu
0.0.0.0 adsfac.net
0.0.0.0 adsfac.us
0.0.0.0 adsfile.qq.com
0.0.0.0 adsgroup.qq.com
0.0.0.0 adshmct.qq.com
0.0.0.0 adshmmsg.qq.com
0.0.0.0 adsinimages.com
0.0.0.0 adsino24.com
0.0.0.0 adslvfile.qq.com
0.0.0.0 adslvseed.qq.com
0.0.0.0 adsm.soush.com
0.0.0.0 adsmart.co.uk
0.0.0.0 adsmart.com
0.0.0.0 adsmart.net
0.0.0.0 adsmetadata.startappservice.com
0.0.0.0 adsniper.ru
0.0.0.0 adsoftware.com
0.0.0.0 adsoldier.com
0.0.0.0 adsomenoise.cdn01.rambla.be
0.0.0.0 adson.awempire.com
0.0.0.0 adsonar.com
0.0.0.0 adsp.ciner.com.tr
0.0.0.0 adsp.haberturk.com
0.0.0.0 adspaces.ero-advertising.com
0.0.0.0 adspirit.net
0.0.0.0 adsqqclick.qq.com
0.0.0.0 adsrevenue.net
0.0.0.0 adsrich.qq.com
0.0.0.0 adsrv.dispatch.com
0.0.0.0 adsrv.hpg.com.br
0.0.0.0 adsrv.iol.co.za
0.0.0.0 adsrv.lua.pl
0.0.0.0 adsrv.me
0.0.0.0 adsrv.tuscaloosanews.com
0.0.0.0 adsrv.wilmingtonstar.com
0.0.0.0 adsrv2.wilmingtonstar.com
0.0.0.0 adsrvr.com
0.0.0.0 adsrvr.org
0.0.0.0 adssl01.adtech.fr
0.0.0.0 adssl01.adtech.us
0.0.0.0 adssl02.adtech.fr
0.0.0.0 adssl02.adtech.us
0.0.0.0 adsspace.net
0.0.0.0 adstest.reklamstore.com
0.0.0.0 adstextview.qq.com
0.0.0.0 adstil.indiatimes.com
0.0.0.0 adstogo.com
0.0.0.0 adstome.com
0.0.0.0 adstract.adk2x.com
0.0.0.0 adstream.cardboardfish.com
0.0.0.0 adsupplyads.net
0.0.0.0 adsvidsdouble.com
0.0.0.0 adsview.qq.com
0.0.0.0 adsview2.qq.com
0.0.0.0 adswakeup.com
0.0.0.0 adswizz-match.dotomi.com
0.0.0.0 adsxyz.com
0.0.0.0 adsyndication.msn.com
0.0.0.0 adsynergy.com
0.0.0.0 adsys.townnews.com
0.0.0.0 adtag.cc
0.0.0.0 adtag.msn.ca
0.0.0.0 adtag.sympatico.ca
0.0.0.0 adtaily.com
0.0.0.0 adtaily.pl
0.0.0.0 adtech.com
0.0.0.0 adtech.de
0.0.0.0 adtech.panthercustomer.com
0.0.0.0 adtechus.com
0.0.0.0 adtegrity.spinbox.net
0.0.0.0 adtext.pl
0.0.0.0 adthru.com
0.0.0.0 adtigerpl.adspirit.net
0.0.0.0 adtlgc.com
0.0.0.0 adtotal.pl
0.0.0.0 adtracking.vinden.nl
0.0.0.0 adtrader.com
0.0.0.0 adtrak.net
0.0.0.0 adultadworld.com
0.0.0.0 adv-mydarkness.ggcorp.me
0.0.0.0 adv-op2.joygames.me
0.0.0.0 adv.adgates.com
0.0.0.0 adv.adview.pl
0.0.0.0 adv.bbanner.it
0.0.0.0 adv.gazeta.pl
0.0.0.0 adv.lampsplus.com
0.0.0.0 adv.merlin.co.il
0.0.0.0 adv.publy.net
0.0.0.0 adv.strategy.it
0.0.0.0 adv.virgilio.it
0.0.0.0 adv.webmd.com
0.0.0.0 adv.wp.pl
0.0.0.0 advconversion.com
0.0.0.0 adveng.hiasys.com
0.0.0.0 adver.pengyou.com
0.0.0.0 advert.bayarea.com
0.0.0.0 advert.uloz.to
0.0.0.0 advertere.zamunda.net
0.0.0.0 adverteren.vakmedianet.nl
0.0.0.0 adverterenbijnh.nl
0.0.0.0 adverterenbijsbs.nl
0.0.0.0 advertise.com
0.0.0.0 advertisement.avosapps.us
0.0.0.0 advertising.aol.com
0.0.0.0 advertising.bbcworldwide.com
0.0.0.0 advertising.civitai.com
0.0.0.0 advertising.hiasys.com
0.0.0.0 advertising.illinimedia.com
0.0.0.0 advertising.online-media24.de
0.0.0.0 advertising.paltalk.com
0.0.0.0 advertising.wellpack.fr
0.0.0.0 advertisingbay.com
0.0.0.0 advertpro.investorvillage.com
0.0.0.0 advertpro.sitepoint.com
0.0.0.0 adverts.ecn.co.uk
0.0.0.0 adverts.freeloader.com
0.0.0.0 advertstream.com
0.0.0.0 advice-ads-cdn.vice.com
0.0.0.0 adview.pl
0.0.0.0 adviva.net
0.0.0.0 advmaker.ru
0.0.0.0 advplace.com
0.0.0.0 advserver.xyz
0.0.0.0 advt.webindia123.com
0.0.0.0 advzilla.com
0.0.0.0 adw.sapo.pt
0.0.0.0 adx.adform.net
0.0.0.0 adx.groupstate.com
0.0.0.0 adx.hendersonvillenews.com
0.0.0.0 adx.starnewsonline.com
0.0.0.0 adx.theledger.com
0.0.0.0 adxpose.com
0.0.0.0 adzerk.net
0.0.0.0 adzone.ro
0.0.0.0 afdyfxfrwbfy.com
0.0.0.0 afe.specificclick.net
0.0.0.0 afe2.specificclick.net
0.0.0.0 aff.promodeals.nl
0.0.0.0 aff.ringtonepartner.com
0.0.0.0 aff3.gittigidiyor.com
0.0.0.0 affiliate-fr.com
0.0.0.0 affiliate.2mdn.net
0.0.0.0 affiliate.a4dtracker.com
0.0.0.0 affiliate.baazee.com
0.0.0.0 affiliate.exabytes.com.my
0.0.0.0 affiliate.googleusercontent.com
0.0.0.0 affiliate.mlntracker.com
0.0.0.0 affiliates.arvixe.com
0.0.0.0 affiliates.eblastengine.com
0.0.0.0 affiliates.genealogybank.com
0.0.0.0 affiliates.globat.com
0.0.0.0 affiliation-france.com
0.0.0.0 affimg.pop6.com
0.0.0.0 afform.co.uk
0.0.0.0 affpartners.com
0.0.0.0 affrh2023.com
0.0.0.0 afftrack001.com
0.0.0.0 afftracking.justanswer.com
0.0.0.0 afilo.pl
0.0.0.0 afp.qiyi.com
0.0.0.0 afunnygames.com
0.0.0.0 agisdayra.com
0.0.0.0 agkn.com
0.0.0.0 agriturismoilcascinone.com
0.0.0.0 agt.net
0.0.0.0 ahzahg6ohb.com
0.0.0.0 ajanlom-magamat.com
0.0.0.0 ajcclassifieds.com
0.0.0.0 ak.buyservices.com
0.0.0.0 ak.maxserving.com
0.0.0.0 ak.sail-horizon.com
0.0.0.0 aka-cdn-ns.adtech.de
0.0.0.0 aka-cdn-ns.adtechus.com
0.0.0.0 aka-cdn.adtechus.com
0.0.0.0 aka.ms-ads.co
0.0.0.0 akaads-espn.starwave.com
0.0.0.0 akamai.invitemedia.com
0.0.0.0 ako.cc
0.0.0.0 aksdk-images.adikteev.com
0.0.0.0 aktiv-blog.com
0.0.0.0 alexanderjonesi.com
0.0.0.0 alfa-tel.sk
0.0.0.0 all.orfr.adgtw.orangeads.fr
0.0.0.0 alliance.adbureau.net
0.0.0.0 allkindlecloud.com
0.0.0.0 alternativhirek.blogspot.hu
0.0.0.0 alxsite.com
0.0.0.0 amazon-adsystem.com
0.0.0.0 amazon-tam-match.dotomi.com
0.0.0.0 amch.questionmarket.com
0.0.0.0 amobil.online
0.0.0.0 amplify.outbrain.com
0.0.0.0 amplifypixel.outbrain.com
0.0.0.0 amrytt.adk2x.com
0.0.0.0 ams1-ib.adnxs.com
0.0.0.0 ams1-mobile.adnxs.com
0.0.0.0 ams2.rumourobey.com
0.0.0.0 amusun.com
0.0.0.0 an.tacoda.net
0.0.0.0 an.yandex.ru
0.0.0.0 analysis.fc2.com
0.0.0.0 analytics.kwebsoft.com
0.0.0.0 analytics.onesearch.id
0.0.0.0 analytics.percentmobile.com
0.0.0.0 analytics.rayjump.com
0.0.0.0 analytics.services.kirra.nl
0.0.0.0 analytics.shareaholic.com
0.0.0.0 analytics.spotta.nl
0.0.0.0 analytics.verizonenterprise.com
0.0.0.0 analytics.vodafone.co.uk
0.0.0.0 analyzer51.fc2.com
0.0.0.0 andr0id.traffic-smart.com
0.0.0.0 anephangja.com
0.0.0.0 anepszava.com
0.0.0.0 anetit.tradedoubler.com
0.0.0.0 angeldonationblog.com
0.0.0.0 ankieta-online.pl
0.0.0.0 annuaire-autosurf.com
0.0.0.0 anonymous-net.com
0.0.0.0 anonymousstats.keefox.org
0.0.0.0 anrtx.tacoda.net
0.0.0.0 antyweb.push-ad.com
0.0.0.0 anycast.dt.adsafeprotected.com
0.0.0.0 ap.lijit.com
0.0.0.0 ap.read.mediation.pns.ap.orangeads.fr
0.0.0.0 apex-ad.com
0.0.0.0 api-public.addthis.com
0.0.0.0 api-s2s.taboola.com
0.0.0.0 api.adcalls.nl
0.0.0.0 api.addthis.com
0.0.0.0 api.adlure.net
0.0.0.0 api.affinesystems.com
0.0.0.0 api.airpush.com
0.0.0.0 api.content-ad.net
0.0.0.0 api.content.ad
0.0.0.0 api.linkgist.com
0.0.0.0 api.linkz.net
0.0.0.0 api.mixpanel.com
0.0.0.0 api.optnmnstr.com
0.0.0.0 api.sagent.io
0.0.0.0 api.shoppingminds.net
0.0.0.0 api.taboola.com
0.0.0.0 api.uprivaladserver.net
0.0.0.0 api.viglink.com
0.0.0.0 api.vodus.com
0.0.0.0 api.zhy333.com
0.0.0.0 apnx-match.dotomi.com
0.0.0.0 aporasal.net
0.0.0.0 app-measurement.com
0.0.0.0 app.datafastguru.info
0.0.0.0 app.monetizze.com.br
0.0.0.0 app.scanscout.com
0.0.0.0 app1.letitbefaster.website
0.0.0.0 app1.letmacworkfaster.site
0.0.0.0 app2.downloadmacsoft.world
0.0.0.0 app2.letitbefaster.website
0.0.0.0 app2.letmacwork.world
0.0.0.0 app2.letmacworkfaster.site
0.0.0.0 app3.letitbefaster.website
0.0.0.0 app3.letmacwork.world
0.0.0.0 app3.makeitworkfaster.life
0.0.0.0 app4.kromtech.net
0.0.0.0 app4.letitbefaster.website
0.0.0.0 app4.letslowbefast.life
0.0.0.0 app5.fastermac.tech
0.0.0.0 app5.letitbefaster.website
0.0.0.0 appdatum.com
0.0.0.0 appdev.addthis.com
0.0.0.0 appfixing.space
0.0.0.0 applicationpremium70.club
0.0.0.0 applyfix.tech
0.0.0.0 appnexus.com
0.0.0.0 appodeal.com
0.0.0.0 apps-blue.com
0.0.0.0 apps-cloud.xyz
0.0.0.0 apps5.oingo.com
0.0.0.0 appswiss.ch
0.0.0.0 apx.moatads.com
0.0.0.0 arbomedia.pl
0.0.0.0 arcadia1998.web.fc2.com
0.0.0.0 archifaktura.hu
0.0.0.0 arena.altitudeplatform.com
0.0.0.0 aritzal.com
0.0.0.0 arsconsole.global-intermedia.com
0.0.0.0 art-offer.com
0.0.0.0 as.adwise.bg
0.0.0.0 as.casalemedia.com
0.0.0.0 as.sexad.net
0.0.0.0 as.vs4entertainment.com
0.0.0.0 as.webmd.com
0.0.0.0 as1.inoventiv.com
0.0.0.0 as1image1.adshuffle.com
0.0.0.0 as1image2.adshuffle.com
0.0.0.0 asa.tynt.com
0.0.0.0 asb.tynt.com
0.0.0.0 ash.creativecdn.com
0.0.0.0 ashow.pcpop.com
0.0.0.0 ask-gps.ru
0.0.0.0 asklots.com
0.0.0.0 asm2.z1.adserver.com
0.0.0.0 asm3.z1.adserver.com
0.0.0.0 asmedia.adsupplyssl.com
0.0.0.0 assets.adnuntius.com
0.0.0.0 assets.applovin.com
0.0.0.0 assets.igapi.com
0.0.0.0 assets.kromtech.net
0.0.0.0 assets.percentmobile.com
0.0.0.0 assoc-amazon.com
0.0.0.0 assostudiosrl.it
0.0.0.0 asv.nuggad.net
0.0.0.0 at-adserver.alltop.com
0.0.0.0 at.m1.nedstatbasic.net
0.0.0.0 atdmt.com
0.0.0.0 atemda.com
0.0.0.0 athena-ads.wikia.com
0.0.0.0 atout-energie-69.com
0.0.0.0 au.ads.link4ads.com
0.0.0.0 au.adserver.yahoo.com
0.0.0.0 auction.unityads.unity3d.com
0.0.0.0 aud.pubmatic.com
0.0.0.0 audicat.net
0.0.0.0 audio-pa-service.de
0.0.0.0 aureate.com
0.0.0.0 aussiemethod.com
0.0.0.0 autocontext.begun.ru
0.0.0.0 automotive-offer.com
0.0.0.0 auxin-box.com
0.0.0.0 avidnewssource.com
0.0.0.0 avilagtitkai.com
0.0.0.0 avpa.javalobby.org
0.0.0.0 avworld.activehosted.com
0.0.0.0 avworld.lt.acemlnc.com
0.0.0.0 axp.zedo.com
0.0.0.0 azcentra.app.ur.gcion.com
0.0.0.0 azoaltou.com
0.0.0.0 azoogleads.com
0.0.0.0 aztbeszelik.com
0.0.0.0 b.adexchangemachine.com
0.0.0.0 b.ads2.msn.com
0.0.0.0 b.am15.net
0.0.0.0 b.codeonclick.com
0.0.0.0 b.grabo.bg
0.0.0.0 b.liquidustv.com
0.0.0.0 b.myspace.com
0.0.0.0 b.rad.live.com
0.0.0.0 b.rad.msn.com
0.0.0.0 b.recwwcc5.info
0.0.0.0 b1fe8a95ae27823.com
0.0.0.0 b34rightym.com
0.0.0.0 b400393baba7cd476a3.com
0.0.0.0 babanetwork.adk2x.com
0.0.0.0 babycenter.tt.omtrdc.net
0.0.0.0 bacskateszov.hu
0.0.0.0 badults.se
0.0.0.0 baiduccdn1.com
0.0.0.0 bak-home.com
0.0.0.0 bak0-store.com
0.0.0.0 balkanwide-assistance.rs
0.0.0.0 bamulat.blogspot.hu
0.0.0.0 banery.netart.pl
0.0.0.0 banery.onet.pl
0.0.0.0 banki.onet.pl
0.0.0.0 bankofamerica.tt.omtrdc.net
0.0.0.0 banner.betwwts.com
0.0.0.0 banner.boostbox.com.br
0.0.0.0 banner.cdpoker.com
0.0.0.0 banner.clubdicecasino.com
0.0.0.0 banner.coza.com
0.0.0.0 banner.diamondclubcasino.com
0.0.0.0 banner.easyspace.com
0.0.0.0 banner.media-system.de
0.0.0.0 banner.monacogoldcasino.com
0.0.0.0 banner.newyorkcasino.com
0.0.0.0 banner.northsky.com
0.0.0.0 banner.oddcast.com
0.0.0.0 banner.orb.net
0.0.0.0 banner.piratos.de
0.0.0.0 banner.playgatecasino.com
0.0.0.0 banner.rbc.ru
0.0.0.0 banner.relcom.ru
0.0.0.0 banner.ringofon.com
0.0.0.0 banner.techarp.com
0.0.0.0 banner1.pornhost.com
0.0.0.0 bannerads.anytimenews.com
0.0.0.0 bannerads.de
0.0.0.0 bannerads.zwire.com
0.0.0.0 bannerconnect.net
0.0.0.0 bannerhost.egamingonline.com
0.0.0.0 bannerimages.0catch.com
0.0.0.0 bannerpower.com
0.0.0.0 banners.adgoto.com
0.0.0.0 banners.adultfriendfinder.com
0.0.0.0 banners.affiliatefuel.com
0.0.0.0 banners.affiliatefuture.com
0.0.0.0 banners.aftrk.com
0.0.0.0 banners.blogads.com
0.0.0.0 banners.bol.se
0.0.0.0 banners.celebritybling.com
0.0.0.0 banners.img.uol.com.br
0.0.0.0 banners.ims.nl
0.0.0.0 banners.iop.org
0.0.0.0 banners.ipotd.com
0.0.0.0 banners.ksl.com
0.0.0.0 banners.linkbuddies.com
0.0.0.0 banners.nbcupromotes.com
0.0.0.0 banners.nextcard.com
0.0.0.0 banners.passion.com
0.0.0.0 banners.pennyweb.com
0.0.0.0 banners.resultonline.com
0.0.0.0 banners.sextracker.com
0.0.0.0 banners.tribute.ca
0.0.0.0 banners.unibet.com
0.0.0.0 banners.valuead.com
0.0.0.0 banners.videosecrets.com
0.0.0.0 banners.webmasterplan.com
0.0.0.0 banners.wunderground.com
0.0.0.0 banners.zbs.ru
0.0.0.0 banners3.spacash.com
0.0.0.0 bannersurvey.biz
0.0.0.0 bannerus1.axelsfun.com
0.0.0.0 bannerus3.axelsfun.com
0.0.0.0 banniere.reussissonsensemble.fr
0.0.0.0 bans.bride.ru
0.0.0.0 banstex.com
0.0.0.0 bansys.onzin.com
0.0.0.0 bar.baidu.com
0.0.0.0 barnesandnoble.bfast.com
0.0.0.0 baskidunyasi.net
0.0.0.0 bb.crwdcntrl.net
0.0.0.0 bbcdn.delivery.reklamz.com
0.0.0.0 bbcdn.go.eu.bbelements.com
0.0.0.0 bbcdn.go.pl.bbelements.com
0.0.0.0 bbelements.com
0.0.0.0 bbnaut.bbelements.com
0.0.0.0 bcp.crwdcntrl.net
0.0.0.0 bdnad1.bangornews.com
0.0.0.0 bdv.bidvertiser.com
0.0.0.0 be.ads.justpremium.com
0.0.0.0 beachfront-match.dotomi.com
0.0.0.0 beacon-3.newrelic.com
0.0.0.0 beaconin2.notinote.me
0.0.0.0 beap.gemini.yahoo.com
0.0.0.0 bell.adcentriconline.com
0.0.0.0 benimreklam.com
0.0.0.0 bespokeshirtsmail.com
0.0.0.0 best2017games.com
0.0.0.0 best2019-games-web1.com
0.0.0.0 best2020-games-web1.com
0.0.0.0 bestadbid.com
0.0.0.0 bestaryua.com
0.0.0.0 bestmmo2018.com
0.0.0.0 bestorican.com
0.0.0.0 bestwatersystems.net
0.0.0.0 bet-at-home.com
0.0.0.0 beta.hotkeys.com
0.0.0.0 betclic.com
0.0.0.0 bfast.com
0.0.0.0 bgrel.bonedmilfs.com
0.0.0.0 bicoinsprofit.com
0.0.0.0 bid.contextweb.com
0.0.0.0 bid.openx.net
0.0.0.0 bid.underdog.media
0.0.0.0 bidclix.net
0.0.0.0 bidsystem.com
0.0.0.0 bidtraffic.com
0.0.0.0 bidvertiser.com
0.0.0.0 bigads.guj.de
0.0.0.0 bigbrandpromotions.com
0.0.0.0 bigbrandrewards.com
0.0.0.0 bigfreelotto.com
0.0.0.0 biggestgiftrewards.com
0.0.0.0 bill.agent.56.com
0.0.0.0 bill.agent.v-56.com
0.0.0.0 billing.speedboink.com
0.0.0.0 bimg.abv.bg
0.0.0.0 bitburg.adtech.fr
0.0.0.0 bitburg.adtech.us
0.0.0.0 bitcast-d.bitgravity.com
0.0.0.0 bitcoadz.io
0.0.0.0 bitmedia.io
0.0.0.0 bitonclick.com
0.0.0.0 bitraffic.com
0.0.0.0 biz-offer.com
0.0.0.0 biz5.sandai.net
0.0.0.0 bizad.nikkeibp.co.jp
0.0.0.0 bizalmas.com
0.0.0.0 bizographics.com
0.0.0.0 bizony.eu
0.0.0.0 bl.wavecdn.de
0.0.0.0 blackbass.mx
0.0.0.0 blackqpid.org.uk
0.0.0.0 blockchaintop.nl
0.0.0.0 blog.addthis.com
0.0.0.0 blog.br0vvnn.io
0.0.0.0 blogads.com
0.0.0.0 blogvertising.pl
0.0.0.0 bloodsugarberry.com
0.0.0.0 bloodsugrs.shop
0.0.0.0 blu.mobileads.msn.com
0.0.0.0 blueconic.net
0.0.0.0 bluediamondoffers.com
0.0.0.0 blueeyesintelligence.org
0.0.0.0 bm.alimama.cn
0.0.0.0 bmgiventures.com
0.0.0.0 bmvip.alimama.cn
0.0.0.0 bn.bfast.com
0.0.0.0 bnmgr.adinjector.net
0.0.0.0 bnrs.ilm.ee
0.0.0.0 bodelen.com
0.0.0.0 boksy.dir.onet.pl
0.0.0.0 boksy.onet.pl
0.0.0.0 bongacams.com
0.0.0.0 bookpdf.services
0.0.0.0 bootsstation-reiherhals.de
0.0.0.0 boroskola.info
0.0.0.0 boskrut.com
0.0.0.0 bosmafamily.nl
0.0.0.0 box-en.com
0.0.0.0 bp.adkmob.com
0.0.0.0 bp.specificclick.net
0.0.0.0 br.adserver.yahoo.com
0.0.0.0 br.naked.com
0.0.0.0 braccom.ch
0.0.0.0 brandsurveypanel.com
0.0.0.0 brandveiligheidsexperts.nl
0.0.0.0 bravo.israelinfo.ru
0.0.0.0 bravospots.com
0.0.0.0 breakthroughtrend.com
0.0.0.0 brekus.org
0.0.0.0 broadcast.piximedia.fr
0.0.0.0 brokertraffic.com
0.0.0.0 browser-tools.systems
0.0.0.0 browsergames2018.com
0.0.0.0 browsergames2019.com
0.0.0.0 browserprotecter.com
0.0.0.0 browsesentinel.com
0.0.0.0 brxfinance.com
0.0.0.0 bs.serving-sys.com
0.0.0.0 bs.url.tw
0.0.0.0 bsnj.eyeblaster.akadns.net
0.0.0.0 btbuyerapp.com
0.0.0.0 budapest1873.net
0.0.0.0 buf.lemonde.fr
0.0.0.0 bufetgarrigosa.com
0.0.0.0 bumerangshowsites.hurriyet.com.tr
0.0.0.0 bundasnovinhas.com
0.0.0.0 buresova-obrazy.wz.cz
0.0.0.0 burns.adtech.fr
0.0.0.0 burns.adtech.us
0.0.0.0 bus-offer.com
0.0.0.0 buttcandy.com
0.0.0.0 buttons.googlesyndication.com
0.0.0.0 buzzadnetwork.com
0.0.0.0 buzzonclick.com
0.0.0.0 bwp.lastfm.com.com
0.0.0.0 c.actiondesk.com
0.0.0.0 c.ad6media.fr
0.0.0.0 c.adexchangemachine.com
0.0.0.0 c.admob.com
0.0.0.0 c.adroll.com
0.0.0.0 c.adsco.re
0.0.0.0 c.amazon-adsystem.com
0.0.0.0 c.anytrx.com
0.0.0.0 c.ar.msn.com
0.0.0.0 c.at.msn.com
0.0.0.0 c.be.msn.com
0.0.0.0 c.bebi.com
0.0.0.0 c.br.msn.com
0.0.0.0 c.ca.msn.com
0.0.0.0 c.casalemedia.com
0.0.0.0 c.cl.msn.com
0.0.0.0 c.codeonclick.com
0.0.0.0 c.company-target.com
0.0.0.0 c.de.msn.com
0.0.0.0 c.dk.msn.com
0.0.0.0 c.dynad.net
0.0.0.0 c.eblastengine.com
0.0.0.0 c.es.msn.com
0.0.0.0 c.fi.msn.com
0.0.0.0 c.fr.msn.com
0.0.0.0 c.gr.msn.com
0.0.0.0 c.hk.msn.com
0.0.0.0 c.id.msn.com
0.0.0.0 c.ie.msn.com
0.0.0.0 c.il.msn.com
0.0.0.0 c.imedia.cz
0.0.0.0 c.in.msn.com
0.0.0.0 c.it.msn.com
0.0.0.0 c.jp.msn.com
0.0.0.0 c.l.qq.com
0.0.0.0 c.latam.msn.com
0.0.0.0 c.lomadee.com
0.0.0.0 c.media-dl.co
0.0.0.0 c.mgid.com
0.0.0.0 c.my.msn.com
0.0.0.0 c.nl.msn.com
0.0.0.0 c.no.msn.com
0.0.0.0 c.novostimira.biz
0.0.0.0 c.ph.msn.com
0.0.0.0 c.prodigy.msn.com
0.0.0.0 c.pt.msn.com
0.0.0.0 c.ru.msn.com
0.0.0.0 c.se.msn.com
0.0.0.0 c.seznam.cz
0.0.0.0 c.sg.msn.com
0.0.0.0 c.silvinst.com
0.0.0.0 c.th.msn.com
0.0.0.0 c.tr.msn.com
0.0.0.0 c.tw.msn.com
0.0.0.0 c.uk.msn.com
0.0.0.0 c.za.msn.com
0.0.0.0 c0011.boursorama.com
0.0.0.0 c1.adform.net
0.0.0.0 c1.cembuyukhanli.com
0.0.0.0 c1.popads.net
0.0.0.0 c1.somalisounds.com
0.0.0.0 c1.teaser-goods.ru
0.0.0.0 c1.zedo.com
0.0.0.0 c11370896.c.youradexchange.com
0.0.0.0 c2.cembuyukhanli.com
0.0.0.0 c2.l.qq.com
0.0.0.0 c2.popads.net
0.0.0.0 c2.somalisounds.com
0.0.0.0 c2.taboola.com
0.0.0.0 c2.zedo.com
0.0.0.0 c2366475.c.youradexchange.com
0.0.0.0 c3.cembuyukhanli.com
0.0.0.0 c3.somalisounds.com
0.0.0.0 c3.zedo.com
0.0.0.0 c35000246.c.youradexchange.com
0.0.0.0 c4.cembuyukhanli.com
0.0.0.0 c4.maxserving.com
0.0.0.0 c4.somalisounds.com
0.0.0.0 c4.zedo.com
0.0.0.0 c4tracking01.com
0.0.0.0 c5.cembuyukhanli.com
0.0.0.0 c5.somalisounds.com
0.0.0.0 c5.zedo.com
0.0.0.0 c6.cembuyukhanli.com
0.0.0.0 c6.somalisounds.com
0.0.0.0 c6.zedo.com
0.0.0.0 c7.cembuyukhanli.com
0.0.0.0 c7.somalisounds.com
0.0.0.0 c7.zedo.com
0.0.0.0 c8.zedo.com
0.0.0.0 ca.adserver.yahoo.com
0.0.0.0 ca3.revieworbit.com
0.0.0.0 ca4.revieworbit.com
0.0.0.0 cabrerapelaez.com
0.0.0.0 cache-dev.addthis.com
0.0.0.0 cache.addthis.com
0.0.0.0 cache.addthiscdn.com
0.0.0.0 cache.adm.cnzz.net
0.0.0.0 cache.betweendigital.com
0.0.0.0 cache.unicast.com
0.0.0.0 cacheserve.eurogrand.com
0.0.0.0 cadsans.com
0.0.0.0 cam2cam.xlovecam.com
0.0.0.0 camgeil.com
0.0.0.0 campaigns.f2.com.au
0.0.0.0 canadaalltax.com
0.0.0.0 canuckmethod.com
0.0.0.0 canva2023.com
0.0.0.0 capath.com
0.0.0.0 carambo.la
0.0.0.0 cardgamespidersolitaire.com
0.0.0.0 cards.virtuagirlhd.com
0.0.0.0 careersincorrectquickie.com
0.0.0.0 carmuffler.net
0.0.0.0 carnegienet.net
0.0.0.0 cas.clickability.com
0.0.0.0 cas.criteo.com
0.0.0.0 casale-match.dotomi.com
0.0.0.0 casalemedia.com
0.0.0.0 cashback.co.uk
0.0.0.0 cashbackwow.co.uk
0.0.0.0 cashflowmarketing.com
0.0.0.0 cashreportz.com
0.0.0.0 casino770.com
0.0.0.0 caslemedia.com
0.0.0.0 casting.openv.com
0.0.0.0 cb.alimama.cn
0.0.0.0 cb.baidu.com
0.0.0.0 cbango.com.ar
0.0.0.0 cbanners.virtuagirlhd.com
0.0.0.0 cc-dt.com
0.0.0.0 ccb.myzen.co.uk
0.0.0.0 ccpmo.com
0.0.0.0 cctv.adsunion.com
0.0.0.0 cdbs.com.tr
0.0.0.0 cdddfia.hornylocals24.com
0.0.0.0 cdn.8digits.com
0.0.0.0 cdn.acloudvideos.com
0.0.0.0 cdn.ad.citynews.it
0.0.0.0 cdn.ad.plus
0.0.0.0 cdn.adikteev.com
0.0.0.0 cdn.adk2.com
0.0.0.0 cdn.adnxs.com
0.0.0.0 cdn.adplxmd.com
0.0.0.0 cdn.adservingsolutionsinc.com
0.0.0.0 cdn.adskeeper.co.uk
0.0.0.0 cdn.adsrvmedia.net
0.0.0.0 cdn.adtrue.com
0.0.0.0 cdn.altitudeplatform.com
0.0.0.0 cdn.amgdgt.com
0.0.0.0 cdn.assets.craveonline.com
0.0.0.0 cdn.atlassbx.com
0.0.0.0 cdn.augur.io
0.0.0.0 cdn.axphotoalbum.top
0.0.0.0 cdn.ayads.co
0.0.0.0 cdn.banners.scubl.com
0.0.0.0 cdn.betgorebysson.club
0.0.0.0 cdn.braun634.com
0.0.0.0 cdn.carbonads.com
0.0.0.0 cdn.constafun.com
0.0.0.0 cdn.cpmstar.com
0.0.0.0 cdn.directrev.com
0.0.0.0 cdn.epommarket.com
0.0.0.0 cdn.freefaits.com
0.0.0.0 cdn.freefarcy.com
0.0.0.0 cdn.freehonor.com
0.0.0.0 cdn.freejars.com
0.0.0.0 cdn.freejax.com
0.0.0.0 cdn.freelac.com
0.0.0.0 cdn.getsmartcontent.com
0.0.0.0 cdn.hauleddes.com
0.0.0.0 cdn.innovid.com
0.0.0.0 cdn.inskinad.com
0.0.0.0 cdn.mediative.ca
0.0.0.0 cdn.mobicow.com
0.0.0.0 cdn.nativery.com
0.0.0.0 cdn.nearbyad.com
0.0.0.0 cdn.nsimg.net
0.0.0.0 cdn.onescreen.net
0.0.0.0 cdn.onthe.io
0.0.0.0 cdn.owebanalytics.com
0.0.0.0 cdn.sagent.io
0.0.0.0 cdn.stat-rock.com
0.0.0.0 cdn.stickyadstv.com
0.0.0.0 cdn.syn.verticalacuity.com
0.0.0.0 cdn.taboola.com
0.0.0.0 cdn.trafficstars.com
0.0.0.0 cdn.udmserve.net
0.0.0.0 cdn.undertone.com
0.0.0.0 cdn.usabilitytracker.com
0.0.0.0 cdn.viglink.com
0.0.0.0 cdn.wg.uproxx.com
0.0.0.0 cdn.wwwpromoter.com
0.0.0.0 cdn.yottos.com
0.0.0.0 cdn.zeusclicks.com
0.0.0.0 cdn1.ad-center.com
0.0.0.0 cdn1.adexprt.com
0.0.0.0 cdn1.ads.contentabc.com
0.0.0.0 cdn1.rmgserving.com
0.0.0.0 cdn1.smartadserver.com
0.0.0.0 cdn1.traffichaus.com
0.0.0.0 cdn1sitescout.edgesuite.net
0.0.0.0 cdn2.ad-center.com
0.0.0.0 cdn2.adsdk.com
0.0.0.0 cdn2.emediate.eu
0.0.0.0 cdn3.adexprts.com
0.0.0.0 cdn5.tribalfusion.com
0.0.0.0 cdn6.emediate.eu
0.0.0.0 cdnads.cam4.com
0.0.0.0 cdnaws.mobidea.com
0.0.0.0 cdns.mydirtyhobby.com
0.0.0.0 cds.adecn.com
0.0.0.0 cds.taboola.com
0.0.0.0 ce.lijit.com
0.0.0.0 cecash.com
0.0.0.0 ced.sascdn.com
0.0.0.0 cekornapred.org
0.0.0.0 cellphoneincentives.com
0.0.0.0 cent.adbureau.net
0.0.0.0 center-message-mobile.com
0.0.0.0 certifiedwinners.info
0.0.0.0 cetelemportugal2.solution.weborama.fr
0.0.0.0 cf.kampyle.com
0.0.0.0 cfg.adsmogo.com
0.0.0.0 cfg.datafastguru.info
0.0.0.0 cgirm.greatfallstribune.com
0.0.0.0 cgmt.co.id
0.0.0.0 chaintopdom.nl
0.0.0.0 channelvue.com.au
0.0.0.0 charging-technology.com
0.0.0.0 charmflirt.com
0.0.0.0 charmstroy.info
0.0.0.0 chartbeat.com
0.0.0.0 chatgpt-premium.com
0.0.0.0 chechla.cnixon.com
0.0.0.0 cherryhi.app.ur.gcion.com
0.0.0.0 chip.popmarker.com
0.0.0.0 choicedealz.com
0.0.0.0 choicesurveypanel.com
0.0.0.0 christianbusinessadvertising.com
0.0.0.0 cicero-mit.com
0.0.0.0 cileni.seznam.cz
0.0.0.0 cinelario.com
0.0.0.0 citlink.net
0.0.0.0 citrio.com
0.0.0.0 citrix.market2lead.com
0.0.0.0 cityads.telus.net
0.0.0.0 citycash2.blogspot.com
0.0.0.0 civilhir.net
0.0.0.0 cj.dotomi.com
0.0.0.0 cjhq.baidu.com
0.0.0.0 ck.juicyads.com
0.0.0.0 claimfreerewards.com
0.0.0.0 classicjack.com
0.0.0.0 clausing-advies.nl
0.0.0.0 clb.bazzacco.net
0.0.0.0 cleancrdio.shop
0.0.0.0 cleaningformac.com
0.0.0.0 clearonclick.com
0.0.0.0 clearviewhub9.cc
0.0.0.0 clevernt.com
0.0.0.0 clhctrk.com
0.0.0.0 click.a-ads.com
0.0.0.0 click.adpile.net
0.0.0.0 click.go2net.com
0.0.0.0 click.maaxmarket.com
0.0.0.0 click.newviralmobistore.com
0.0.0.0 click.runcpa.com
0.0.0.0 clickad.eo.pl
0.0.0.0 clickbangpop.com
0.0.0.0 clickcdn.shareaholic.com
0.0.0.0 clickit.go2net.com
0.0.0.0 clickmedia.ro
0.0.0.0 clicks.adultplex.com
0.0.0.0 clicks.deskbabes.com
0.0.0.0 clicks.hurriyet.com.tr
0.0.0.0 clicks.minimob.com
0.0.0.0 clicks.roularta.adhese.com
0.0.0.0 clicks.totemcash.com
0.0.0.0 clicks.toteme.com
0.0.0.0 clicks.virtuagirl.com
0.0.0.0 clicks.virtuagirlhd.com
0.0.0.0 clicks.virtuaguyhd.com
0.0.0.0 clicks.walla.co.il
0.0.0.0 clicks2.virtuagirl.com
0.0.0.0 clickserv.sitescout.com
0.0.0.0 clickserve.cc-dt.com
0.0.0.0 clickserve.eu.dartsearch.net
0.0.0.0 clickserve.uk.dartsearch.net
0.0.0.0 clickserve.us2.dartsearch.net
0.0.0.0 clicksor.com
0.0.0.0 clicksotrk.com
0.0.0.0 clickthru.net
0.0.0.0 clickthruserver.com
0.0.0.0 clickthrutraffic.com
0.0.0.0 clients-share.com
0.0.0.0 clk.addmt.com
0.0.0.0 clk.atdmt.com
0.0.0.0 clk.tradedoubler.com
0.0.0.0 clkads.com
0.0.0.0 clktrk.com
0.0.0.0 clkuk.tradedoubler.com
0.0.0.0 cloudadservers.com
0.0.0.0 cloudcrown.com
0.0.0.0 cloudserver098095.home.pl
0.0.0.0 clubwinnerz.com
0.0.0.0 cluster.adultadworld.com
0.0.0.0 cluster3.adultadworld.com
0.0.0.0 cmads.sv.publicus.com
0.0.0.0 cmads.us.publicus.com
0.0.0.0 cmn1lsm2.beliefnet.com
0.0.0.0 cmps.mt50ad.com
0.0.0.0 cmweb.ilike.alibaba.com
0.0.0.0 cn.adserver.yahoo.com
0.0.0.0 cnf.adshuffle.com
0.0.0.0 cnt.trafficstars.com
0.0.0.0 cnt1.xhamster.com
0.0.0.0 cntmc.com
0.0.0.0 cobalten.com
0.0.0.0 code.adtlgc.com
0.0.0.0 code.vihub.ru
0.0.0.0 code2.adtlgc.com
0.0.0.0 codevexillium.org
0.0.0.0 coin-ad.com
0.0.0.0 coinad.com
0.0.0.0 coinhits.com
0.0.0.0 coinurl.com
0.0.0.0 coinverti.com
0.0.0.0 coinzilla.io
0.0.0.0 col-med.com
0.0.0.0 col.mobileads.msn.com
0.0.0.0 colddry.com
0.0.0.0 collegiogeometri.it
0.0.0.0 com.htmlwww.youfck.com
0.0.0.0 comcastresidentialservices.tt.omtrdc.net
0.0.0.0 commerce.www.ibm.com
0.0.0.0 companion.adap.tv
0.0.0.0 computer-offer.com
0.0.0.0 computersncs.com
0.0.0.0 computersoostynaarlo.nl
0.0.0.0 computertechanalysis.com
0.0.0.0 conexionesymanguerashidrocalidas.com.mx
0.0.0.0 config.getmyip.com
0.0.0.0 config.seedtag.com
0.0.0.0 config.sensic.net
0.0.0.0 config.unityads.unity3d.com
0.0.0.0 connect.247media.ads.link4ads.com
0.0.0.0 constintptr.com
0.0.0.0 consulturias.com
0.0.0.0 consumerinfo.tt.omtrdc.net
0.0.0.0 contaxe.com
0.0.0.0 content.aimatch.com
0.0.0.0 content.clipster.ws
0.0.0.0 content.yieldmanager.edgesuite.net
0.0.0.0 content.zontera.com
0.0.0.0 contextad.pl
0.0.0.0 contextual.media.net
0.0.0.0 contextweb.com
0.0.0.0 conv.adengage.com
0.0.0.0 conversantmedia.com
0.0.0.0 conversion-pixel.invitemedia.com
0.0.0.0 convlatbmp.taboola.com
0.0.0.0 cookie.pebblemedia.be
0.0.0.0 cookie.sync.ad.cpe.dotomi.com
0.0.0.0 cookiecontainer.blox.pl
0.0.0.0 cookingtiprewards.com
0.0.0.0 coolnovelties.co.uk
0.0.0.0 coolsavings.com
0.0.0.0 coquine-dispo.com
0.0.0.0 corba.adtech.fr
0.0.0.0 corba.adtech.us
0.0.0.0 corbalanlopez.com
0.0.0.0 core.adprotected.com
0.0.0.0 core.insightexpressai.com
0.0.0.0 core.royalads.net
0.0.0.0 core.videoegg.com
0.0.0.0 core.zontera.com
0.0.0.0 core0.node12.top.mail.ru
0.0.0.0 core2.adtlgc.com
0.0.0.0 coreg.flashtrack.net
0.0.0.0 coreglead.co.uk
0.0.0.0 corp-downloads.com
0.0.0.0 corusads.dserv.ca
0.0.0.0 cosmeticscentre.uk.com
0.0.0.0 count6.51yes.com
0.0.0.0 cpm20.com
0.0.0.0 cpmadvisors.com
0.0.0.0 cpro.baidu.com
0.0.0.0 cpxdeliv.com
0.0.0.0 crcdn.org
0.0.0.0 creatiby1.unicast.com
0.0.0.0 creative.ad131m.com
0.0.0.0 creative.adshuffle.com
0.0.0.0 creatives.livejasmin.com
0.0.0.0 creatives.rgadvert.com
0.0.0.0 creditburner.blueadvertise.com
0.0.0.0 creditperformance.com.br
0.0.0.0 creditsoffer.blogspot.com
0.0.0.0 creview.adbureau.net
0.0.0.0 crosspixel.demdex.net
0.0.0.0 crowdgravity.com
0.0.0.0 crowdignite.com
0.0.0.0 crsystems.it
0.0.0.0 crux.songline.com
0.0.0.0 crwdcntrl.net
0.0.0.0 cryptoblog.biz
0.0.0.0 cryptocoinsad.com
0.0.0.0 cryptolabpro.com
0.0.0.0 cs-cart.jp
0.0.0.0 cs-kn.de
0.0.0.0 cs.adxpansion.com
0.0.0.0 csh.actiondesk.com
0.0.0.0 cspix.media6degrees.com
0.0.0.0 csr.onet.pl
0.0.0.0 cstatic.weborama.fr
0.0.0.0 csync.smartadserver.com
0.0.0.0 ctbdev.net
0.0.0.0 cti.w55c.net
0.0.0.0 ctnsnet.com
0.0.0.0 ctxtad.tribalfusion.com
0.0.0.0 cue4you.nl
0.0.0.0 cukierniatylczynscy.lh.pl
0.0.0.0 cumc-hmb.com
0.0.0.0 cuntwars.com
0.0.0.0 cyberfaery.com
0.0.0.0 cyberprotection.pro
0.0.0.0 cz.bbelements.com
0.0.0.0 cz8.clickzs.com
0.0.0.0 czilladx.com
0.0.0.0 d-road.com
0.0.0.0 d.101m3.com
0.0.0.0 d.adroll.com
0.0.0.0 d.adup-tech.com
0.0.0.0 d.adxcore.com
0.0.0.0 d.agkn.com
0.0.0.0 d.cntv.cn
0.0.0.0 d.company-target.com
0.0.0.0 d.getaccss.com
0.0.0.0 d.sspcash.adxcore.com
0.0.0.0 d1.zedo.com
0.0.0.0 d10.zedo.com
0.0.0.0 d11.zedo.com
0.0.0.0 d12.zedo.com
0.0.0.0 d14.zedo.com
0.0.0.0 d2.sina.com.cn
0.0.0.0 d2.zedo.com
0.0.0.0 d3.sina.com.cn
0.0.0.0 d3.zedo.com
0.0.0.0 d3v3bqdndm4erx.cloudfront.net
0.0.0.0 d4.zedo.com
0.0.0.0 d4q8zgf756.com
0.0.0.0 d5.zedo.com
0.0.0.0 d5p.de17a.com
0.0.0.0 d6.c5.b0.a2.top.mail.ru
0.0.0.0 d6.zedo.com
0.0.0.0 d7.zedo.com
0.0.0.0 d8.zedo.com
0.0.0.0 d9.zedo.com
0.0.0.0 da.oipzyrzffum.ovh
0.0.0.0 darakht.com
0.0.0.0 daretodreamfarm.com
0.0.0.0 darmowe-liczniki.info
0.0.0.0 darmowe-zakupy.com
0.0.0.0 dart.chron.com
0.0.0.0 dashbo15myapp.com
0.0.0.0 dashboard.adcalls.nl
0.0.0.0 dashboardnew.adcalls.nl
0.0.0.0 dashgreen.online
0.0.0.0 dashingleather.com
0.0.0.0 data-failover.eroadvertising.com
0.0.0.0 data.ad-score.com
0.0.0.0 data.eroadvertising.com
0.0.0.0 data.flurry.com
0.0.0.0 data.namesakeoscilloscopemarquis.com
0.0.0.0 data.netscope.marktest.pt
0.0.0.0 data0.bell.ca
0.0.0.0 dataidea.it
0.0.0.0 date.and-have.fun
0.0.0.0 date.ventivmedia.com
0.0.0.0 datedate.today
0.0.0.0 datingadvertising.com
0.0.0.0 dawnnationaladvertiser.com
0.0.0.0 dax-match.dotomi.com
0.0.0.0 dazzler.liquidus.net
0.0.0.0 db4.net-filter.com
0.0.0.0 dbbsrv.com
0.0.0.0 dcads.sina.com.cn
0.0.0.0 dclk-match.dotomi.com
0.0.0.0 dctracking.com
0.0.0.0 de.ads.justpremium.com
0.0.0.0 de.adserver.yahoo.com
0.0.0.0 deal-courrier.be
0.0.0.0 decide.mixpanel.com
0.0.0.0 decor8.ie
0.0.0.0 decouvre.la
0.0.0.0 deechtebol.com
0.0.0.0 defpush.com
0.0.0.0 del1.phillyburbs.com
0.0.0.0 delb.mspaceads.com
0.0.0.0 delivery.adnuntius.com
0.0.0.0 delivery.adyea.com
0.0.0.0 delivery.clickonometrics.pl
0.0.0.0 delivery.myswitchads.com
0.0.0.0 delivery.reklamz.com
0.0.0.0 delivery.swid.switchads.com
0.0.0.0 delivery.trafficjunky.net
0.0.0.0 delivery.us.myswitchads.com
0.0.0.0 deloton.com
0.0.0.0 demetnagement.com
0.0.0.0 demo1.lerian-nti.be
0.0.0.0 demr.mspaceads.com
0.0.0.0 demr.opt.fimserve.com
0.0.0.0 denetsuk.com
0.0.0.0 dentistsinyourarea.com
0.0.0.0 depo.realist.gen.tr
0.0.0.0 derangedadage91wis.files.wordpress.com
0.0.0.0 dereferer.co
0.0.0.0 derkeiler.com
0.0.0.0 derstandard.nuggad.net
0.0.0.0 desb.mspaceads.com
0.0.0.0 designbloxlive.com
0.0.0.0 desk.mspaceads.com
0.0.0.0 desk.opt.fimserve.com
0.0.0.0 dev.adforum.com
0.0.0.0 dev.sfbg.com
0.0.0.0 dev.visualwebsiteoptimizer.com
0.0.0.0 devart.adbureau.net
0.0.0.0 dg.specificclick.net
0.0.0.0 dgm2.com
0.0.0.0 dgmaustralia.com
0.0.0.0 diaita.ch
0.0.0.0 diamond-water.hk
0.0.0.0 diesilberamis.meeriwelt.de
0.0.0.0 diff1.smartadserver.com
0.0.0.0 diff2.smartadserver.com
0.0.0.0 diff3.smartadserver.com
0.0.0.0 diff4.smartadserver.com
0.0.0.0 digitaldsp.com
0.0.0.0 dinsalgsvagt.adservinginternational.com
0.0.0.0 direct-space.com
0.0.0.0 direct.ad.cpe.dotomi.com
0.0.0.0 directleads.com
0.0.0.0 directoffers.go2cloud.org
0.0.0.0 dirtyrhino.com
0.0.0.0 discoverdemo.com
0.0.0.0 discoverecommerce.tt.omtrdc.net
0.0.0.0 disqusads.com
0.0.0.0 dist.belnk.com
0.0.0.0 districtm-match.dotomi.com
0.0.0.0 divx.adbureau.net
0.0.0.0 dizzcloud.com
0.0.0.0 djbanners.deadjournal.com
0.0.0.0 djugoogs.com
0.0.0.0 dk.adserver.yahoo.com
0.0.0.0 dl.payforme.top
0.0.0.0 dl.privatecollection.top
0.0.0.0 dlvr.readserver.net
0.0.0.0 dmatica.it
0.0.0.0 dmp.vihub.ru
0.0.0.0 dmxleo.dailymotion.com
0.0.0.0 dnps.com
0.0.0.0 dobbenetes.com
0.0.0.0 docs-downloading.com
0.0.0.0 doctorschoicenursing.com
0.0.0.0 doesok.top
0.0.0.0 dolohen.com
0.0.0.0 dondolino.it
0.0.0.0 dorianbaroque.org
0.0.0.0 dosugcz.biz
0.0.0.0 dot.wp.pl
0.0.0.0 download-shares.com
0.0.0.0 download.filmfanatic.com
0.0.0.0 download.inboxace.com
0.0.0.0 download.weatherblink.com
0.0.0.0 download.yesmessenger.com
0.0.0.0 download5s.com
0.0.0.0 downloadcdn.com
0.0.0.0 downloadplayer.xyz
0.0.0.0 downloads.larivieracasino.com
0.0.0.0 downloads.mytvandmovies.com
0.0.0.0 dp-sync.dotomi.com
0.0.0.0 dp1.33across.com
0.0.0.0 dqs001.adtech.fr
0.0.0.0 dqs001.adtech.us
0.0.0.0 dr.soso.com
0.0.0.0 dra.amazon-adsystem.com
0.0.0.0 draco-artgallery.wz.cz
0.0.0.0 drecentreshu.info
0.0.0.0 drivingschoolburlington.ca
0.0.0.0 drm-google-analtyic.com
0.0.0.0 drm-server-booking.com
0.0.0.0 drm-server13-login-microsoftonline.com
0.0.0.0 dropbox-download-eu.com
0.0.0.0 dropbox-download.com
0.0.0.0 dropbox-en.com
0.0.0.0 dropbox-er.com
0.0.0.0 dropbox-eu.com
0.0.0.0 dropbox-sdn.com
0.0.0.0 drowle.com
0.0.0.0 ds.contextweb.com
0.0.0.0 ds.onet.pl
0.0.0.0 ds.serving-sys.com
0.0.0.0 dt.adsafeprotected.com
0.0.0.0 dub.mobileads.msn.com
0.0.0.0 dy.admerize.be
0.0.0.0 dylanwong.com
0.0.0.0 dynip.org
0.0.0.0 dysoool.com
0.0.0.0 e.baidu.com
0.0.0.0 e.company-target.com
0.0.0.0 e.email.simon.com
0.0.0.0 e.serverbid.com
0.0.0.0 e0.extreme-dm.com
0.0.0.0 e1.addthis.com
0.0.0.0 e1.wetterkameras.com
0.0.0.0 e2.cdn.qnsr.com
0.0.0.0 e2.wetterkameras.com
0.0.0.0 e3.wetterkameras.com
0.0.0.0 e4.wetterkameras.com
0.0.0.0 e5.wetterkameras.com
0.0.0.0 e6.wetterkameras.com
0.0.0.0 e7.wetterkameras.com
0.0.0.0 earnlivingonline.net
0.0.0.0 eas4.emediate.eu
0.0.0.0 easyadservice.com
0.0.0.0 easypills.co
0.0.0.0 eatondesigns.com
0.0.0.0 eb.adbureau.net
0.0.0.0 ebayadvertising.com
0.0.0.0 ebayadvertising.triadretail.net
0.0.0.0 ebiads.ebiuniverse.com
0.0.0.0 eblastengine.upickem.net
0.0.0.0 eclkmpbn.com
0.0.0.0 eclkmpsa.com
0.0.0.0 eclkspbn.com
0.0.0.0 ecoencomputer.com
0.0.0.0 ecomadserver.com
0.0.0.0 ecs1.engageya.com
0.0.0.0 edchargina.pro
0.0.0.0 eddy.noneto.com
0.0.0.0 edge.bnmla.com
0.0.0.0 edge.quantserve.com
0.0.0.0 edgecast-vod.yimg.com
0.0.0.0 edirect.hotkeys.com
0.0.0.0 edog2017.karyamedia.net
0.0.0.0 eduardorodrigues.adv.br
0.0.0.0 eduthermas.sk
0.0.0.0 egeszsegespont.hu
0.0.0.0 egyazegyben.com
0.0.0.0 egyenesen.com
0.0.0.0 egyveleg.com
0.0.0.0 eiv.baidu.com
0.0.0.0 ej.progresas.lt
0.0.0.0 elzaservis.cz
0.0.0.0 emea-bidder.mathtag.com
0.0.0.0 emeraldtiger.com
0.0.0.0 emily.tncrun.net
0.0.0.0 emisja.adsearch.pl
0.0.0.0 emisja.contentstream.pl
0.0.0.0 emx-match.dotomi.com
0.0.0.0 en.btcprofit.we-trck.com
0.0.0.0 engage.everyone.net
0.0.0.0 engageya.com
0.0.0.0 engine.4chan-ads.org
0.0.0.0 engine.adbooth.com
0.0.0.0 engine.adzerk.net
0.0.0.0 engine.carbonads.com
0.0.0.0 engine.espace.netavenir.com
0.0.0.0 engine.phn.doublepimp.com
0.0.0.0 engine.spotscenered.info
0.0.0.0 engine2.adzerk.net
0.0.0.0 entertainment-specials.com
0.0.0.0 entrenador-personal.com
0.0.0.0 epomads2.4shared.com
0.0.0.0 equativ-match.dotomi.com
0.0.0.0 eren.ecoencomputer.com
0.0.0.0 erie.smartage.com
0.0.0.0 ero-advertising.com
0.0.0.0 erp.garan.pro
0.0.0.0 errorfixing.space
0.0.0.0 ertopcu.com
0.0.0.0 es.adserver.yahoo.com
0.0.0.0 escape.insites.eu
0.0.0.0 esd-secure.taboola.com.edgekey.net
0.0.0.0 esoterik-lenormand.com
0.0.0.0 etahub.com
0.0.0.0 etrk.asus.com
0.0.0.0 etype.adbureau.net
0.0.0.0 eu-global-online.com
0.0.0.0 eu-global.com
0.0.0.0 eu-gmtdmp.gd1.mookie1.com
0.0.0.0 eu-pn4.adserver.yahoo.com
0.0.0.0 eu.track.digitaladsystems.com
0.0.0.0 eu2.madsone.com
0.0.0.0 euniverseads.com
0.0.0.0 europe.adserver.yahoo.com
0.0.0.0 euw.adserver.snapads.com
0.0.0.0 event.ad.cpe.dotomi.com
0.0.0.0 events.kiosked.com
0.0.0.0 events.streamrail.net
0.0.0.0 eventtracker.videostrip.com
0.0.0.0 evroteplo.ru
0.0.0.0 exchange.scalemonk.com
0.0.0.0 exclusivegiftcards.com
0.0.0.0 exipure.net
0.0.0.0 exponential.com
0.0.0.0 ext.royalcactus.com
0.0.0.0 eyeota-match.dotomi.com
0.0.0.0 eyewonder.com
0.0.0.0 ezl.com
0.0.0.0 eztnezdmeg.net
0.0.0.0 f.qstatic.com
0.0.0.0 f1.p0y.com
0.0.0.0 f11098.privacy4browsers.com
0.0.0.0 f2.p0y.com
0.0.0.0 f3.p0y.com
0.0.0.0 f4.p0y.com
0.0.0.0 fabryka-nagrod.com
0.0.0.0 facebook-drm-server3.com
0.0.0.0 fachadasalaire.com
0.0.0.0 fadadosexo.com.br
0.0.0.0 fadskis.com
0.0.0.0 fajnefanty.com
0.0.0.0 falcon1.net
0.0.0.0 falkag.net
0.0.0.0 famwillems.nl
0.0.0.0 fangirlmag.com
0.0.0.0 farm.plista.com
0.0.0.0 fastfixing.tech
0.0.0.0 fastpopunder.com
0.0.0.0 fasts-downloads.com
0.0.0.0 fatcatrewards.com
0.0.0.0 fbd.de
0.0.0.0 fc.webmasterpro.de
0.0.0.0 fcg.casino770.com
0.0.0.0 fdimages.fairfax.com.au
0.0.0.0 fe.lea.lycos.es
0.0.0.0 fedup.tv
0.0.0.0 feed.4wnet.com
0.0.0.0 feeds.videosz.com
0.0.0.0 feeds.weselltraffic.com
0.0.0.0 fei.pro-market.net
0.0.0.0 fejezet.com
0.0.0.0 felix.data.tm-awx.com
0.0.0.0 fepete.ch
0.0.0.0 fervortracer.com
0.0.0.0 ffxitrack.com
0.0.0.0 figyelo-net.com
0.0.0.0 filateliadimauro.com
0.0.0.0 file-shares.com
0.0.0.0 file.ipinyou.com.cn
0.0.0.0 fileshare-storage.com
0.0.0.0 filipelucio.com
0.0.0.0 filmes-hd.com
0.0.0.0 filmfanatic.com
0.0.0.0 filmhir.net
0.0.0.0 fin.adbureau.net
0.0.0.0 fin.tips
0.0.0.0 finance-offer.com
0.0.0.0 finder.cox.net
0.0.0.0 findsexguide.com
0.0.0.0 firrectly.top
0.0.0.0 firstgame.xyz
0.0.0.0 fixbonus.com
0.0.0.0 fixxermorsel.za.com
0.0.0.0 flbox.net
0.0.0.0 fliplens.com
0.0.0.0 floatingads.madisonavenue.com
0.0.0.0 floratelecom.com
0.0.0.0 floridat.app.ur.gcion.com
0.0.0.0 flower.bg
0.0.0.0 fls-na.amazon-adsystem.com
0.0.0.0 flu23.com
0.0.0.0 fm3cafe.hu
0.0.0.0 fmads.osdn.com
0.0.0.0 focusin.ads.targetnet.com
0.0.0.0 fodder.qq.com
0.0.0.0 fodder.tc.qq.com
0.0.0.0 fogjunkossze.com
0.0.0.0 folloyu.com
0.0.0.0 font.liquidus.net
0.0.0.0 fontostudni.club
0.0.0.0 food-offer.com
0.0.0.0 forsi.net
0.0.0.0 fotoseiten.heimat.eu
0.0.0.0 fp.uclo.net
0.0.0.0 fr-go.kelkoogroup.net
0.0.0.0 fr.a2dfp.net
0.0.0.0 fr.adserver.yahoo.com
0.0.0.0 fr.classic.clickintext.net
0.0.0.0 fra1-ib.adnxs-simple.com
0.0.0.0 fra1-ib.adnxs.com
0.0.0.0 franko.info
0.0.0.0 free.thesocialsexnetwork.com
0.0.0.0 freebiegb.co.uk
0.0.0.0 freecamerasource.com
0.0.0.0 freecamsexposed.com
0.0.0.0 freedvddept.com
0.0.0.0 freefoodsource.com
0.0.0.0 freefuelcard.com
0.0.0.0 freefuelcoupon.com
0.0.0.0 freeipoduk.co.uk
0.0.0.0 freelaptopreward.com
0.0.0.0 freenation.com
0.0.0.0 freeplasmanation.com
0.0.0.0 freevideodownloadforpc.com
0.0.0.0 freewheel-match.dotomi.com
0.0.0.0 fromjoytohappiness.com
0.0.0.0 fructa.nl
0.0.0.0 ftpadmin.edv-stumpf.de
0.0.0.0 funtabsafe.com
0.0.0.0 fuuze.net
0.0.0.0 fvaweb.it
0.0.0.0 fw.adsafeprotected.com
0.0.0.0 fw.qq.com
0.0.0.0 fwdservice.com
0.0.0.0 g.adnxs.com
0.0.0.0 g.thinktarget.com
0.0.0.0 g1-globo.com-b4.info
0.0.0.0 g1-globosaude.com
0.0.0.0 g1.idg.pl
0.0.0.0 g2.gumgum.com
0.0.0.0 g4p.grt02.com
0.0.0.0 g7.com.tw
0.0.0.0 gadgeteer.pdamart.com
0.0.0.0 gads.pubmatic.com
0.0.0.0 gahu.hit.gemius.pl
0.0.0.0 gam.adnxs.com
0.0.0.0 gamerz123.com
0.0.0.0 games.superappbox.com
0.0.0.0 gamesrotator.com
0.0.0.0 gaming-box.com
0.0.0.0 gar-tech.com
0.0.0.0 garant.bos.ru
0.0.0.0 garciaestelles.com
0.0.0.0 gasurvey.gemius.com
0.0.0.0 gate.hyperpaysys.com
0.0.0.0 gazeta.hit.gemius.pl
0.0.0.0 gbp.ebayadvertising.triadretail.net
0.0.0.0 gcads.osdn.com
0.0.0.0 gcdn.2mdn.net
0.0.0.0 gcirm.argusleader.com
0.0.0.0 gcirm.argusleader.gcion.com
0.0.0.0 gcirm.battlecreekenquirer.com
0.0.0.0 gcirm.burlingtonfreepress.com
0.0.0.0 gcirm.centralohio.gcion.com
0.0.0.0 gcirm.cincinnati.com
0.0.0.0 gcirm.citizen-times.com
0.0.0.0 gcirm.clarionledger.com
0.0.0.0 gcirm.coloradoan.com
0.0.0.0 gcirm.courier-journal.com
0.0.0.0 gcirm.courierpostonline.com
0.0.0.0 gcirm.customcoupon.com
0.0.0.0 gcirm.dailyrecord.com
0.0.0.0 gcirm.delawareonline.com
0.0.0.0 gcirm.democratandchronicle.com
0.0.0.0 gcirm.desmoinesregister.com
0.0.0.0 gcirm.dmp.gcion.com
0.0.0.0 gcirm.dmregister.com
0.0.0.0 gcirm.dnj.com
0.0.0.0 gcirm.gannettnetwork.com
0.0.0.0 gcirm.greatfallstribune.com
0.0.0.0 gcirm.greenvilleonline.com
0.0.0.0 gcirm.greenvilleonline.gcion.com
0.0.0.0 gcirm.honoluluadvertiser.gcion.com
0.0.0.0 gcirm.idahostatesman.com
0.0.0.0 gcirm.indystar.com
0.0.0.0 gcirm.injersey.com
0.0.0.0 gcirm.jacksonsun.com
0.0.0.0 gcirm.lsj.com
0.0.0.0 gcirm.montgomeryadvertiser.com
0.0.0.0 gcirm.muskogeephoenix.com
0.0.0.0 gcirm.news-press.com
0.0.0.0 gcirm.newsleader.com
0.0.0.0 gcirm.press-citizen.com
0.0.0.0 gcirm.pressconnects.com
0.0.0.0 gcirm.rgj.com
0.0.0.0 gcirm.sctimes.com
0.0.0.0 gcirm.stargazette.com
0.0.0.0 gcirm.statesmanjournal.com
0.0.0.0 gcirm.tallahassee.com
0.0.0.0 gcirm.tennessean.com
0.0.0.0 gcirm.thedailyjournal.com
0.0.0.0 gcirm.theolympian.com
0.0.0.0 gcirm.thespectrum.com
0.0.0.0 gcirm2.indystar.com
0.0.0.0 gdeee.hit.gemius.pl
0.0.0.0 gdelt.hit.gemius.pl
0.0.0.0 gdelv.hit.gemius.pl
0.0.0.0 gdyn.cnngo.com
0.0.0.0 gem.pl
0.0.0.0 gemius.pl
0.0.0.0 geniusdisplay.com
0.0.0.0 geo.moatads.com
0.0.0.0 geoads.com
0.0.0.0 geoads.osdn.com
0.0.0.0 geoloc11.geovisite.com
0.0.0.0 geolocation-db.com
0.0.0.0 geoweb.e-kolay.net
0.0.0.0 get-downloads.com
0.0.0.0 get-express-vpn.com
0.0.0.0 get.optad360.io
0.0.0.0 get.x-link.pl
0.0.0.0 getagiftonline.com
0.0.0.0 getlink-service.com
0.0.0.0 getlink.pw
0.0.0.0 getmyads.com
0.0.0.0 getmyads24.com
0.0.0.0 getmyfreegiftcard.com
0.0.0.0 getrelator.com
0.0.0.0 getrunkhomuto.info
0.0.0.0 getrxhere.co
0.0.0.0 getspecialgifts.com
0.0.0.0 getyour5kcredits0.blogspot.com
0.0.0.0 getyourgiftnow2.blogspot.com
0.0.0.0 getyourgiftnow3.blogspot.com
0.0.0.0 gezinti.com
0.0.0.0 ghb.console.adtarget.com.tr
0.0.0.0 ghmtr.hit.gemius.pl
0.0.0.0 giftcardchallenge.com
0.0.0.0 giftcardsurveys.us.com
0.0.0.0 giles.uk.net
0.0.0.0 gimg.baidu.com
0.0.0.0 gingert.net
0.0.0.0 global.adserver.yahoo.com
0.0.0.0 global.ymtrack.com
0.0.0.0 globalwebads.com
0.0.0.0 gm.mmstat.com
0.0.0.0 gmads.net
0.0.0.0 go.admulti.com
0.0.0.0 go.bb007.bbelements.com
0.0.0.0 go.cz.bbelements.com
0.0.0.0 go.data1rtb.com
0.0.0.0 go.eu.bbelements.com
0.0.0.0 go.lfstmedia.com
0.0.0.0 go.onclasrv.com
0.0.0.0 go.padsdelivery.com
0.0.0.0 go.padstm.com
0.0.0.0 go.pl.bbelements.com
0.0.0.0 go.rightdailyfeed.com
0.0.0.0 go.spaceshipads.com
0.0.0.0 go.stirshakead.com
0.0.0.0 go.verymuchad.com
0.0.0.0 go2.hit.gemius.pl
0.0.0.0 go2page.net
0.0.0.0 goautofinance.com
0.0.0.0 gocarosel.com
0.0.0.0 goldbach.hit.gemius.pl
0.0.0.0 goodbookbook.com
0.0.0.0 googledrive-en.com
0.0.0.0 googledv-match.dotomi.com
0.0.0.0 goplayz.com
0.0.0.0 got2goshop.com
0.0.0.0 goto.trafficmultiplier.com
0.0.0.0 gozing.directtrack.com
0.0.0.0 grabbit-rabbit.com
0.0.0.0 graizoah.com
0.0.0.0 grandeweddings.com
0.0.0.0 graphics.adultfriendfinder.com
0.0.0.0 graphics.pop6.com
0.0.0.0 graphql-cdn-slplatform.liquidus.net
0.0.0.0 gravitron.chron.com
0.0.0.0 greasypalm.com
0.0.0.0 gremimedia.pl
0.0.0.0 grfx.mp3.com
0.0.0.0 groupm.com
0.0.0.0 grtexch.com
0.0.0.0 gserv.cneteu.net
0.0.0.0 gspro.hit.gemius.pl
0.0.0.0 guiaconsumidor.com
0.0.0.0 guide2poker.com
0.0.0.0 guildofangels.net
0.0.0.0 gwallet.com
0.0.0.0 h-adashx.ut.taobao.com
0.0.0.0 h-adashx4ae.ut.taobao.com
0.0.0.0 h-afnetwww.adshuffle.com
0.0.0.0 h.ppjol.com
0.0.0.0 h1.helenrosi.com
0.0.0.0 h2.helenrosi.com
0.0.0.0 h3.helenrosi.com
0.0.0.0 h4.helenrosi.com
0.0.0.0 h5.helenrosi.com
0.0.0.0 h6.helenrosi.com
0.0.0.0 h7.helenrosi.com
0.0.0.0 hamiltonpainters.ca
0.0.0.0 hapax.qc.ca
0.0.0.0 harvest.adgardener.com
0.0.0.0 harvest176.adgardener.com
0.0.0.0 harvest284.adgardener.com
0.0.0.0 harvest285.adgardener.com
0.0.0.0 haslundalsted.dk
0.0.0.0 hathor.eztonez.com
0.0.0.0 hatter-story.info
0.0.0.0 haynet.adbureau.net
0.0.0.0 hb.mediafuse.com
0.0.0.0 hbads.eboz.com
0.0.0.0 hbadz.eboz.com
0.0.0.0 hdporium.com
0.0.0.0 healthbeautyncs.com
0.0.0.0 healthfood.syoutikubai.com
0.0.0.0 hebdotop.com
0.0.0.0 help.adtech.fr
0.0.0.0 help.adtech.us
0.0.0.0 helpint.mywebsearch.com
0.0.0.0 heroesofrpg.com
0.0.0.0 heti-naplo.com
0.0.0.0 hg8dc7bm.com
0.0.0.0 hgusler.com
0.0.0.0 hhcj.co.uk
0.0.0.0 hhvdds.com
0.0.0.0 hieroglyph.freeuk.com
0.0.0.0 hightrafficads.com
0.0.0.0 hilltopads.net
0.0.0.0 himediads.com
0.0.0.0 hipersushiads.com
0.0.0.0 hir-tv.com
0.0.0.0 hir44.blogspot.com
0.0.0.0 hirado.top
0.0.0.0 hirek-online.com
0.0.0.0 hirfolyam24.blogspot.hu
0.0.0.0 hirmadar.com
0.0.0.0 hirorigo.net
0.0.0.0 hirozon.info
0.0.0.0 hirszabadsag.blogspot.com
0.0.0.0 hirtop.in
0.0.0.0 hirturi.blogspot.hu
0.0.0.0 hirvilag.co
0.0.0.0 hirzona24.com
0.0.0.0 histats.com
0.0.0.0 histock.info
0.0.0.0 hit.8digits.com
0.0.0.0 hit4.hotlog.ru
0.0.0.0 hk.adserver.yahoo.com
0.0.0.0 hlcc.ca
0.0.0.0 hlok.qertewrt.com
0.0.0.0 hm.baidu.com
0.0.0.0 hm.l.qq.com
0.0.0.0 hmw42.host-my-website.com
0.0.0.0 hnfwg.voluumtrk.com
0.0.0.0 home.foni.net
0.0.0.0 home.gelsennet.de
0.0.0.0 home.townisp.com
0.0.0.0 honolulu.app.ur.gcion.com
0.0.0.0 hooqy.com
0.0.0.0 host207.ewtn.com
0.0.0.0 host81-138-7-108.in-addr.btopenworld.com
0.0.0.0 hosting.adjug.com
0.0.0.0 hot.useractive.com
0.0.0.0 hotchatdate.com
0.0.0.0 hotgiftzone.com
0.0.0.0 hp1.tcbnet.ne.jp
0.0.0.0 hpad.www.infoseek.co.jp
0.0.0.0 hrnecek.com
0.0.0.0 ht-srl.com
0.0.0.0 html.centralmediaserver.com
0.0.0.0 htmlwww.youfck.com
0.0.0.0 httpads.com
0.0.0.0 httpring.qq.com
0.0.0.0 httpwwwadserver.com
0.0.0.0 hub.com.pl
0.0.0.0 huis.istats.nl
0.0.0.0 huiwiw.hit.gemius.pl
0.0.0.0 hungaryexpres.com
0.0.0.0 hungfei.com
0.0.0.0 huntingtonbank.tt.omtrdc.net
0.0.0.0 hurricaneprotection.com
0.0.0.0 hyperion.adtech.fr
0.0.0.0 hyperion.adtech.us
0.0.0.0 hz.mmstat.com
0.0.0.0 i-sharecloud.com
0.0.0.0 i.adwise.bg
0.0.0.0 i.blogads.com
0.0.0.0 i.casalemedia.com
0.0.0.0 i.hotkeys.com
0.0.0.0 i.imedia.cz
0.0.0.0 i.interia.pl
0.0.0.0 i.libertystmedia.com
0.0.0.0 i.media.cz
0.0.0.0 i.seznam.cz
0.0.0.0 i.simpli.fi
0.0.0.0 i.total-media.net
0.0.0.0 i.trkjmp.com
0.0.0.0 i.w.inmobi.com
0.0.0.0 i1.ictorganisers.com
0.0.0.0 i1.teaser-goods.ru
0.0.0.0 i1.vaishnaviinterior.com
0.0.0.0 i2.ictorganisers.com
0.0.0.0 i2.vaishnaviinterior.com
0.0.0.0 i3.ictorganisers.com
0.0.0.0 i3.vaishnaviinterior.com
0.0.0.0 i4.ictorganisers.com
0.0.0.0 i4.vaishnaviinterior.com
0.0.0.0 i4track.net
0.0.0.0 i5.ictorganisers.com
0.0.0.0 i5.vaishnaviinterior.com
0.0.0.0 i6.ictorganisers.com
0.0.0.0 i6.vaishnaviinterior.com
0.0.0.0 i7.ictorganisers.com
0.0.0.0 i7.vaishnaviinterior.com
0.0.0.0 iacas.adbureau.net
0.0.0.0 iad-usadmm-ds.dotomi.com
0.0.0.0 iad-usadmm.dotomi.com
0.0.0.0 iad.anm.co.uk
0.0.0.0 ialaddin.genieesspv.jp
0.0.0.0 ib.adnxs.com
0.0.0.0 ibis.lgappstv.com
0.0.0.0 iceman30.de
0.0.0.0 iceonecasino.com
0.0.0.0 icmserver.net
0.0.0.0 id.jixie.io
0.0.0.0 id11938.luxup.ru
0.0.0.0 id3103.com
0.0.0.0 id5576.al21.luxup.ru
0.0.0.0 idearc.tt.omtrdc.net
0.0.0.0 idpix.media6degrees.com
0.0.0.0 ieee.adbureau.net
0.0.0.0 if.bbanner.it
0.0.0.0 igrs.ca
0.0.0.0 ih.adscale.de
0.0.0.0 ih2.gamecopyworld.com
0.0.0.0 iijls.com
0.0.0.0 ilinks.industrybrains.com
0.0.0.0 ilovemobi.com
0.0.0.0 im.52441.com
0.0.0.0 im.adtech.de
0.0.0.0 im.banner.t-online.de
0.0.0.0 im.of.pl
0.0.0.0 im.xo.pl
0.0.0.0 imads.integral-marketing.com
0.0.0.0 image.click.livedoor.com
0.0.0.0 image.i1img.com
0.0.0.0 image.linkexchange.com
0.0.0.0 image2.pubmatic.com
0.0.0.0 images-cdn.azoogleads.com
0.0.0.0 images.ads.fairfax.com.au
0.0.0.0 images.bluetime.com
0.0.0.0 images.clickfinders.com
0.0.0.0 images.conduit-banners.com
0.0.0.0 images.cybereps.com
0.0.0.0 images.directtrack.com
0.0.0.0 images.jambocast.com
0.0.0.0 images.linkwithin.com
0.0.0.0 images.mbuyu.nl
0.0.0.0 images.mediago.io
0.0.0.0 images.netcomvad.com
0.0.0.0 images.outbrain.com
0.0.0.0 images.outbrainimg.com
0.0.0.0 images.people2people.com
0.0.0.0 images.persgroepadvertising.be
0.0.0.0 images.sexlist.com
0.0.0.0 images.sohu.com
0.0.0.0 images.steamray.com
0.0.0.0 images.taboola.com
0.0.0.0 images.trafficmp.com
0.0.0.0 images3.linkwithin.com
0.0.0.0 imageserv.adtech.fr
0.0.0.0 imageserv.adtech.us
0.0.0.0 imagesnep.admaster.cc
0.0.0.0 imagesrv.adition.com
0.0.0.0 imarker.com
0.0.0.0 imarker.ru
0.0.0.0 imc.l.qq.com
0.0.0.0 img-a2.ak.imagevz.net
0.0.0.0 img.3lift.com
0.0.0.0 img.alibaba.com
0.0.0.0 img.awr.im
0.0.0.0 img.blogads.com
0.0.0.0 img.directtrack.com
0.0.0.0 img.img-taboola.com
0.0.0.0 img.layer-ads.de
0.0.0.0 img.liczniki.org
0.0.0.0 img.marketgid.com
0.0.0.0 img.sn00.net
0.0.0.0 img.xnxx.com
0.0.0.0 img2.ru.redtram.com
0.0.0.0 imgg-cdn.adskeeper.co.uk
0.0.0.0 imgg-cdn.steepto.com
0.0.0.0 imgg.dt00.net
0.0.0.0 imgg.marketgid.com
0.0.0.0 imgg.mgid.com
0.0.0.0 imgn.dt00.net
0.0.0.0 imgn.dt07.com
0.0.0.0 imgn.marketgid.com
0.0.0.0 imgserv.adbutler.com
0.0.0.0 imp.admarketplace.net
0.0.0.0 imp.adsmogo.com
0.0.0.0 impbe.tradedoubler.com
0.0.0.0 impl.onscroll.com
0.0.0.0 import.globalsources.com
0.0.0.0 import43.com
0.0.0.0 imppl.tradedoubler.com
0.0.0.0 imprlatbmp.taboola.com
0.0.0.0 imrk.net
0.0.0.0 imserv001.adtech.fr
0.0.0.0 imserv001.adtech.us
0.0.0.0 imserv002.adtech.fr
0.0.0.0 imserv002.adtech.us
0.0.0.0 imserv003.adtech.fr
0.0.0.0 imserv003.adtech.us
0.0.0.0 imserv004.adtech.fr
0.0.0.0 imserv004.adtech.us
0.0.0.0 imserv005.adtech.fr
0.0.0.0 imserv005.adtech.us
0.0.0.0 imserv006.adtech.fr
0.0.0.0 imserv006.adtech.us
0.0.0.0 imserv00x.adtech.fr
0.0.0.0 imserv00x.adtech.us
0.0.0.0 imssl01.adtech.fr
0.0.0.0 imssl01.adtech.us
0.0.0.0 in.adserver.yahoo.com
0.0.0.0 in.getclicky.com
0.0.0.0 incentivegateway.com
0.0.0.0 inclk.com
0.0.0.0 indexhu.adocean.pl
0.0.0.0 indisancal.com
0.0.0.0 indyscribe.com
0.0.0.0 infinite-ads.com
0.0.0.0 informacja-dnia.com
0.0.0.0 injuredworkersadvocates.com
0.0.0.0 inklineglobal.com
0.0.0.0 inkoleasing.ru
0.0.0.0 inl.adbureau.net
0.0.0.0 inlinefascia.com
0.0.0.0 inmobi-match.dotomi.com
0.0.0.0 inpagepush.com
0.0.0.0 input.insights.gravity.com
0.0.0.0 insight.adsrvr.org
0.0.0.0 insightexpressai.com
0.0.0.0 insightxe.pittsburghlive.com
0.0.0.0 insightxe.vtsgonline.com
0.0.0.0 integer-ms-home.com
0.0.0.0 intela.com
0.0.0.0 intelliads.com
0.0.0.0 intensedigital.adk2x.com
0.0.0.0 interia.adsearch.adkontekst.pl
0.0.0.0 internet.billboard.cz
0.0.0.0 internewsweb.com
0.0.0.0 intertech.co.jp
0.0.0.0 interyield.td573.com
0.0.0.0 intrack.pl
0.0.0.0 inv-nets.admixer.net
0.0.0.0 investbooking.de
0.0.0.0 invitefashion.com
0.0.0.0 ipacc1.adtech.fr
0.0.0.0 ipacc1.adtech.us
0.0.0.0 ipdata.adtech.fr
0.0.0.0 ipdata.adtech.us
0.0.0.0 ipm-provider.ff.avast.com
0.0.0.0 iq001.adtech.fr
0.0.0.0 iq001.adtech.us
0.0.0.0 iqoption.com
0.0.0.0 ir-de.amazon-adsystem.com
0.0.0.0 ir-na.amazon-adsystem.com
0.0.0.0 ir2.beap.gemini.yahoo.com
0.0.0.0 isg01.casalemedia.com
0.0.0.0 ishinomakicatering.web.fc2.com
0.0.0.0 ismailersoz.com
0.0.0.0 istockbargains.com
0.0.0.0 it.adserver.yahoo.com
0.0.0.0 itempana.site
0.0.0.0 itnuzleafan.com
0.0.0.0 itrackerpro.com
0.0.0.0 itsfree123.com
0.0.0.0 iwbubcs.v01aelux.space
0.0.0.0 izmsj.co.jp
0.0.0.0 j.adlooxtracking.com
0.0.0.0 j1.jinghuaqitb.com
0.0.0.0 j1.jmooreassoc.com
0.0.0.0 j2.jinghuaqitb.com
0.0.0.0 j2.jmooreassoc.com
0.0.0.0 j3.jinghuaqitb.com
0.0.0.0 j3.jmooreassoc.com
0.0.0.0 j4.jinghuaqitb.com
0.0.0.0 j4.jmooreassoc.com
0.0.0.0 j5.jinghuaqitb.com
0.0.0.0 j5.jmooreassoc.com
0.0.0.0 j6.jinghuaqitb.com
0.0.0.0 j6.jmooreassoc.com
0.0.0.0 j7.jinghuaqitb.com
0.0.0.0 j7.jmooreassoc.com
0.0.0.0 jadserve.postrelease.com
0.0.0.0 jambocast.com
0.0.0.0 jav.ee
0.0.0.0 jb9clfifs6.s.ad6media.fr
0.0.0.0 jcarter.spinbox.net
0.0.0.0 jcrew.tt.omtrdc.net
0.0.0.0 jenno.adsb4all.com
0.0.0.0 jerry.proweb.net
0.0.0.0 jesamcorp.com
0.0.0.0 jf71qh5v14.com
0.0.0.0 jh.revolvermaps.com
0.0.0.0 jingjia.qq.com
0.0.0.0 jivox.com
0.0.0.0 jkcontrols.co.uk
0.0.0.0 jl-mag.de
0.0.0.0 jlcarral.com
0.0.0.0 jlijten.nl
0.0.0.0 jlinks.industrybrains.com
0.0.0.0 jmn.jangonetwork.com
0.0.0.0 jmvisuals.com
0.0.0.0 join.pro-gaming-world.com
0.0.0.0 join1.winhundred.com
0.0.0.0 jp-microsoft-store.com
0.0.0.0 jrfa.net
0.0.0.0 jrsa.net
0.0.0.0 js-sec.indexww.com
0.0.0.0 js.ad-score.com
0.0.0.0 js.adlink.net
0.0.0.0 js.adscale.de
0.0.0.0 js.adserverpub.com
0.0.0.0 js.adsonar.com
0.0.0.0 js.adspro.it
0.0.0.0 js.adsrvr.org
0.0.0.0 js.betburdaaffiliates.com
0.0.0.0 js.bizographics.com
0.0.0.0 js.goods.redtram.com
0.0.0.0 js.himediads.com
0.0.0.0 js.hotkeys.com
0.0.0.0 js.hs-scripts.com
0.0.0.0 js.hscollectedforms.net
0.0.0.0 js.hsleadflows.net
0.0.0.0 js.moatads.com
0.0.0.0 js.ru.redtram.com
0.0.0.0 js.smi2.ru
0.0.0.0 js.softreklam.com
0.0.0.0 js.srcsmrtgs.com
0.0.0.0 js.tongji.linezing.com
0.0.0.0 js.zevents.com
0.0.0.0 js1.bloggerads.net
0.0.0.0 jsc.adskeeper.co.uk
0.0.0.0 jsc.dt07.net
0.0.0.0 jsc.mgid.com
0.0.0.0 jsfactory.net
0.0.0.0 jsn.dt07.net
0.0.0.0 juggler.inetinteractive.com
0.0.0.0 justdating.online
0.0.0.0 justdeckshamilton.ca
0.0.0.0 justwebads.com
0.0.0.0 jxliu.com
0.0.0.0 jzclick.soso.com
0.0.0.0 k1.karbilyazilim.com
0.0.0.0 k1.mobileadsserver.com
0.0.0.0 k2.karbilyazilim.com
0.0.0.0 k3.karbilyazilim.com
0.0.0.0 k3vzn.flx10.com
0.0.0.0 k4.karbilyazilim.com
0.0.0.0 k5.karbilyazilim.com
0.0.0.0 k5ads.osdn.com
0.0.0.0 k6.karbilyazilim.com
0.0.0.0 k7.karbilyazilim.com
0.0.0.0 kaartenhuis.nl.site-id.nl
0.0.0.0 kaharmonie.nl
0.0.0.0 kanzlei-borchers.de
0.0.0.0 kaprazatos.club
0.0.0.0 karat.hu
0.0.0.0 kargo-match.dotomi.com
0.0.0.0 karinart.de
0.0.0.0 kasumikarate.hanagasumi.net
0.0.0.0 katch.ne.jp
0.0.0.0 katcol.co.uk
0.0.0.0 katofer.axelero.net
0.0.0.0 katu.adbureau.net
0.0.0.0 kawabe.es
0.0.0.0 kawarayu.net
0.0.0.0 kbd1.kpns.ijinshan.com
0.0.0.0 kdconstructionusa.com
0.0.0.0 keepyoungphone.bid
0.0.0.0 kelder.nl
0.0.0.0 kergaukr.com
0.0.0.0 keys.dmtracker.com
0.0.0.0 keywordblocks.com
0.0.0.0 keywords.adtlgc.com
0.0.0.0 kh1.kimhasa.com
0.0.0.0 kh2.kimhasa.com
0.0.0.0 kh3.kimhasa.com
0.0.0.0 kh4.kimhasa.com
0.0.0.0 kh5.kimhasa.com
0.0.0.0 kh6.kimhasa.com
0.0.0.0 kh7.kimhasa.com
0.0.0.0 kilomniadst.info
0.0.0.0 kiosked-d.openx.net
0.0.0.0 kitaramarketplace.com
0.0.0.0 kitaramedia.com
0.0.0.0 kithrup.matchlogic.com
0.0.0.0 kixer.com
0.0.0.0 klikasz-i-masz.com
0.0.0.0 klikk.linkpulse.com
0.0.0.0 kliks.affiliate4you.nl
0.0.0.0 kliksaya.com
0.0.0.0 klipmart.forbes.com
0.0.0.0 knc.lv
0.0.0.0 kodu.neti.ee
0.0.0.0 konax.kontera.com
0.0.0.0 kontera.com
0.0.0.0 kos.interseek.si
0.0.0.0 koszykrd.wp.pl
0.0.0.0 kozszolgalat.com
0.0.0.0 krakenfolio.com
0.0.0.0 krasnaya.co.uk
0.0.0.0 kreaffiliation.com
0.0.0.0 kromtech.net
0.0.0.0 kropka.onet.pl
0.0.0.0 krush-match.dotomi.com
0.0.0.0 ksi2trk.com
0.0.0.0 ktrackdata.com
0.0.0.0 kuhdi.com
0.0.0.0 kvision.tv
0.0.0.0 l-sspcash.adxcore.com
0.0.0.0 l.admob.com
0.0.0.0 l.linkpulse.com
0.0.0.0 l.ohmyad.co
0.0.0.0 l.qq.com
0.0.0.0 l.yieldmanager.net
0.0.0.0 l2.l.qq.com
0.0.0.0 labas-hl.de
0.0.0.0 labashl.de
0.0.0.0 laborex.hu
0.0.0.0 ladyclicks.ru
0.0.0.0 laltraimmagine.ss.it
0.0.0.0 lamiflor.xyz
0.0.0.0 land.purifier.cc
0.0.0.0 lanzar.publicidadweb.com
0.0.0.0 lap-click.tr.line.me
0.0.0.0 laptopreportcard.com
0.0.0.0 laptoprewards.com
0.0.0.0 laptoprewardsgroup.com
0.0.0.0 laptoprewardszone.com
0.0.0.0 larivieracasino.com
0.0.0.0 larossola.it
0.0.0.0 lastmeasure.zoy.org
0.0.0.0 latticescience.com
0.0.0.0 latticescipub.com
0.0.0.0 launch.adserver.yahoo.com
0.0.0.0 layer-ads.de
0.0.0.0 ldglob01.adtech.fr
0.0.0.0 ldglob01.adtech.us
0.0.0.0 ldglob02.adtech.fr
0.0.0.0 ldglob02.adtech.us
0.0.0.0 ldimage01.adtech.fr
0.0.0.0 ldimage01.adtech.us
0.0.0.0 ldimage02.adtech.fr
0.0.0.0 ldimage02.adtech.us
0.0.0.0 ldserv01.adtech.fr
0.0.0.0 ldserv01.adtech.us
0.0.0.0 ldserv02.adtech.fr
0.0.0.0 ldserv02.adtech.us
0.0.0.0 le1er.net
0.0.0.0 lead-analytics.nl
0.0.0.0 lead.program3.com
0.0.0.0 leader.linkexchange.com
0.0.0.0 leadsynaptic.go2jump.org
0.0.0.0 ledobbensz.blogspot.hu
0.0.0.0 leftoverdense.com
0.0.0.0 legfrissebb.info
0.0.0.0 legjava.com
0.0.0.0 legjava.pro
0.0.0.0 leklicht.net
0.0.0.0 lesrivesdechambesy.ch
0.0.0.0 letmefind.co
0.0.0.0 letsfinder.com
0.0.0.0 letssearch.com
0.0.0.0 levexis.com
0.0.0.0 lewell.fr
0.0.0.0 lftqch650apz.com
0.0.0.0 lg.brandreachsys.com
0.0.0.0 libdgel.net
0.0.0.0 liberty.gedads.com
0.0.0.0 liczniki.org
0.0.0.0 lie2anyone.com
0.0.0.0 liivecams.com
0.0.0.0 limonecomunicacao.com.br
0.0.0.0 lincolnshirefitness.co.uk
0.0.0.0 link2me.ru
0.0.0.0 link4ads.com
0.0.0.0 link4win.net
0.0.0.0 linkit.biz
0.0.0.0 linknotification.com
0.0.0.0 linktracker.angelfire.com
0.0.0.0 linuxpark.adtech.fr
0.0.0.0 linuxpark.adtech.us
0.0.0.0 liquidad.narrowcastmedia.com
0.0.0.0 live-cams-1.livejasmin.com
0.0.0.0 live-en.com
0.0.0.0 live-msr.com
0.0.0.0 ll.atdmt.com
0.0.0.0 lmadvertising.engine.adglare.net
0.0.0.0 lmqh.ecoencomputer.com
0.0.0.0 lnads.osdn.com
0.0.0.0 load.exelator.com
0.0.0.0 load.focalex.com
0.0.0.0 load.sumome.com
0.0.0.0 loadesecoparc.co.uk
0.0.0.0 loading321.com
0.0.0.0 loadm.exelator.com
0.0.0.0 loboclick.com
0.0.0.0 local-download.com
0.0.0.0 locp-ir.viber.com
0.0.0.0 log.olark.com
0.0.0.0 log.outbrain.com
0.0.0.0 log.tagcade.com
0.0.0.0 logger.virgul.com
0.0.0.0 login-ds.dotomi.com
0.0.0.0 login.dotomi.com
0.0.0.0 login.linkpulse.com
0.0.0.0 logs.spilgames.com
0.0.0.0 long-space.com
0.0.0.0 look.djfiln.com
0.0.0.0 look.ichlnk.com
0.0.0.0 look.kfiopkln.com
0.0.0.0 look.opskln.com
0.0.0.0 look.udncoeln.com
0.0.0.0 look.ufinkln.com
0.0.0.0 look.utndln.com
0.0.0.0 loopme-match.dotomi.com
0.0.0.0 lotame-match.dotomi.com
0.0.0.0 louisvil.app.ur.gcion.com
0.0.0.0 louisvil.ur.gcion.com
0.0.0.0 lovedonesproducts.com
0.0.0.0 lovittco.com.au
0.0.0.0 lp.empire.goodgamestudios.com
0.0.0.0 lp.sexyadults.eu
0.0.0.0 lp4.onlinecasinoreports.com
0.0.0.0 lpa.myzen.co.uk
0.0.0.0 lpg02.com
0.0.0.0 ls.hit.gemius.pl
0.0.0.0 lsassoc.com
0.0.0.0 lt.andomedia.com
0.0.0.0 lt.angelfire.com
0.0.0.0 ltk.pw
0.0.0.0 lucker.co
0.0.0.0 lucky-day-uk.com
0.0.0.0 luxup.ru
0.0.0.0 lydownload.net
0.0.0.0 m.adbridge.de
0.0.0.0 m.addthis.com
0.0.0.0 m.addthisedge.com
0.0.0.0 m.admob.com
0.0.0.0 m.fexiaen.com
0.0.0.0 m.friendlyduck.com
0.0.0.0 m.openv.tv
0.0.0.0 m.pl.pornzone.tv
0.0.0.0 m.quantcount.com
0.0.0.0 m.servedby-buysellads.com
0.0.0.0 m.tidebuy.com
0.0.0.0 m.tribalfusion.com
0.0.0.0 m1.nsimg.net
0.0.0.0 m2.media-box.co
0.0.0.0 m2.nsimg.net
0.0.0.0 m4.media-box.co
0.0.0.0 ma-kaeser.ch
0.0.0.0 ma-plastifieuse.info
0.0.0.0 ma.wp.pl
0.0.0.0 maaxmarket.com
0.0.0.0 mac.system-alert1.com
0.0.0.0 macads.net
0.0.0.0 macatawa.org
0.0.0.0 macaxpower.com.br
0.0.0.0 maccleanersecurity.com
0.0.0.0 macdamaged.tech
0.0.0.0 mackeeperapp.mackeeper.com
0.0.0.0 mackeeperapp1.zeobit.com
0.0.0.0 mackeeperapp2.mackeeper.com
0.0.0.0 mackeeperapp3.mackeeper.com
0.0.0.0 macleaner.space
0.0.0.0 macpurifier.com
0.0.0.0 mad2.brandreachsys.com
0.0.0.0 madadsmedia.com
0.0.0.0 madeleinekrook.nl
0.0.0.0 mads.amazon-adsystem.com
0.0.0.0 mads.dailymail.co.uk
0.0.0.0 magyarkozosseg.net
0.0.0.0 magyarnep.me
0.0.0.0 magyarokvagyunk.com
0.0.0.0 mail.radar.imgsmail.ru
0.0.0.0 main-boost.com
0.0.0.0 main.exoclick.com
0.0.0.0 main.vodonet.net
0.0.0.0 makeitworkfaster.life
0.0.0.0 makemoneyrobot.com
0.0.0.0 mama.pipi.ne.jp
0.0.0.0 manage001.adtech.fr
0.0.0.0 manage001.adtech.us
0.0.0.0 mangler3.generals.ea.com
0.0.0.0 mangler4.generals.ea.com
0.0.0.0 manuel.theonion.com
0.0.0.0 margaretanddavid.com
0.0.0.0 marketgid.com
0.0.0.0 marketing.888.com
0.0.0.0 marketing.hearstmagazines.nl
0.0.0.0 marriottinternationa.tt.omtrdc.net
0.0.0.0 martinsmith.nl
0.0.0.0 mashinkhabar.com
0.0.0.0 match.ads.betweendigital.com
0.0.0.0 match.adsrvr.org
0.0.0.0 match.sync.ad.cpe.dotomi.com
0.0.0.0 match.taboola.com
0.0.0.0 matomy.adk2.co
0.0.0.0 maxads.ruralpress.com
0.0.0.0 maxadserver.corusradionetwork.com
0.0.0.0 maxbounty.com
0.0.0.0 maxmusics.com
0.0.0.0 maxonclick.com
0.0.0.0 maxserving.com
0.0.0.0 mb01.com
0.0.0.0 mbox9.offermatica.com
0.0.0.0 mc.webvisor.org
0.0.0.0 mc.yandex.ru
0.0.0.0 mccafee-orientador.com-br.site
0.0.0.0 mcfg.sandai.net
0.0.0.0 mcsgrp.com
0.0.0.0 mdunker.gmxhome.de
0.0.0.0 mechtech.za.com
0.0.0.0 medhiartis.com
0.0.0.0 media-angel.de
0.0.0.0 media-fire.org
0.0.0.0 media.888.com
0.0.0.0 media.adcentriconline.com
0.0.0.0 media.adrcdn.com
0.0.0.0 media.adrevolver.com
0.0.0.0 media.adrime.com
0.0.0.0 media.b.lead.program3.com
0.0.0.0 media.betburdaaffiliates.com
0.0.0.0 media.bonnint.net
0.0.0.0 media.boomads.com
0.0.0.0 media.charter.com
0.0.0.0 media.contextweb.com
0.0.0.0 media.easyads.bg
0.0.0.0 media.espace-plus.net
0.0.0.0 media.fairlink.ru
0.0.0.0 media.funpic.de
0.0.0.0 media.liquidus.net
0.0.0.0 media.markethealth.com
0.0.0.0 media.msg.dotomi.com
0.0.0.0 media.naked.com
0.0.0.0 media.nk-net.pl
0.0.0.0 media.ontarionorth.com
0.0.0.0 media.popmarker.com
0.0.0.0 media.popuptraffic.com
0.0.0.0 media.primalforce.net
0.0.0.0 media.trafficfactory.biz
0.0.0.0 media.trafficjunky.net
0.0.0.0 media.ventivmedia.com
0.0.0.0 media.xxxnavy.com
0.0.0.0 media1.popmarker.com
0.0.0.0 media10.popmarker.com
0.0.0.0 media2.adshuffle.com
0.0.0.0 media2.legacy.com
0.0.0.0 media2.popmarker.com
0.0.0.0 media2.travelzoo.com
0.0.0.0 media2021.videostrip.com
0.0.0.0 media3.popmarker.com
0.0.0.0 media4.popmarker.com
0.0.0.0 media4021.videostrip.com
0.0.0.0 media5.popmarker.com
0.0.0.0 media5021.videostrip.com
0.0.0.0 media6.popmarker.com
0.0.0.0 media6021.videostrip.com
0.0.0.0 media7.popmarker.com
0.0.0.0 media8.popmarker.com
0.0.0.0 media9.popmarker.com
0.0.0.0 mediacharger.com
0.0.0.0 mediafaze.com
0.0.0.0 medialand.relax.ru
0.0.0.0 medianet-match.dotomi.com
0.0.0.0 mediaplex-match.dotomi.com
0.0.0.0 mediapst-images.adbureau.net
0.0.0.0 mediapst.adbureau.net
0.0.0.0 mediation.adnxs.com
0.0.0.0 mediative.ca
0.0.0.0 mediative.com
0.0.0.0 mediavadasz.info
0.0.0.0 mediawhirl.net
0.0.0.0 medical-offer.com
0.0.0.0 medleyads.com
0.0.0.0 medya.e-kolay.net
0.0.0.0 megapanel.gem.pl
0.0.0.0 megawealthbiz.com
0.0.0.0 megoszthato.blogspot.hu
0.0.0.0 mellowads.com
0.0.0.0 members.chello.at
0.0.0.0 members.chello.nl
0.0.0.0 members.iinet.net.au
0.0.0.0 members.upc.nl
0.0.0.0 memorableordealstranger.com
0.0.0.0 mercury.bravenet.com
0.0.0.0 messagent.duvalguillaume.com
0.0.0.0 messardu.com
0.0.0.0 meteon.org
0.0.0.0 meter-svc.nytimes.com
0.0.0.0 metrics.ikea.com
0.0.0.0 metrics.natmags.co.uk
0.0.0.0 metrics.sfr.fr
0.0.0.0 metrics.target.com
0.0.0.0 mettelindberg.dk
0.0.0.0 mezmerband.com
0.0.0.0 mg.dt00.net
0.0.0.0 mg.mgid.com
0.0.0.0 mgid.com
0.0.0.0 mh-miyoshi.jp
0.0.0.0 mhlnk.com
0.0.0.0 mi.adinterax.com
0.0.0.0 micmusik.com
0.0.0.0 microsof.wemfbox.ch
0.0.0.0 microsoft-cnd.com
0.0.0.0 microsoft-debug-098.com
0.0.0.0 microsoft-home-en.com
0.0.0.0 microsoft-online-en-us.com
0.0.0.0 microsoft-ware.com
0.0.0.0 microwinds.de
0.0.0.0 mightymagoo.com
0.0.0.0 milyondolar.com
0.0.0.0 minden-egyben.com
0.0.0.0 mindenegyben.com
0.0.0.0 mindenegybenblog.hu
0.0.0.0 mindenegybenblog.net
0.0.0.0 mini.videostrip.com
0.0.0.0 mirror.pointroll.com
0.0.0.0 mizvan.com
0.0.0.0 mjlunalaw.com
0.0.0.0 mjonkers.nl
0.0.0.0 mjxads.internet.com
0.0.0.0 mk.limonshel.de
0.0.0.0 mklik.gazeta.pl
0.0.0.0 mks98.com
0.0.0.0 ml314.com
0.0.0.0 mlntracker.com
0.0.0.0 mm.chitika.net
0.0.0.0 mmoframes.com
0.0.0.0 mmofreegames.online
0.0.0.0 mob.adwhirl.com
0.0.0.0 mobfactory.info
0.0.0.0 mobile-browser.me
0.0.0.0 mobile.bet.pt
0.0.0.0 mobile.juicyads.com
0.0.0.0 mobileads.msn.com
0.0.0.0 mobileanalytics.us-east-1.amazonaws.com
0.0.0.0 mobileleads.msn.com
0.0.0.0 mobrevflwms.com
0.0.0.0 mochibot.com
0.0.0.0 modescrips.info
0.0.0.0 modlily.net
0.0.0.0 mokavilag.com
0.0.0.0 monarchy.nl
0.0.0.0 monetate.net
0.0.0.0 monetizepros.com
0.0.0.0 moneybot.net
0.0.0.0 moneyraid.com
0.0.0.0 monkposseacre.casa
0.0.0.0 moodoo.com.cn
0.0.0.0 moodretrieval.com
0.0.0.0 morefastermac.trade
0.0.0.0 morefreecamsecrets.com
0.0.0.0 morenorubio.com
0.0.0.0 morevisits.info
0.0.0.0 motd.pinion.gg
0.0.0.0 motorocio.com
0.0.0.0 motosal.net
0.0.0.0 moveyourmarket.com
0.0.0.0 movieads.imgs.sapo.pt
0.0.0.0 movies-box.net
0.0.0.0 movies-cine.com
0.0.0.0 movies-cinema.com
0.0.0.0 movsflix.com
0.0.0.0 moz.execulink.net
0.0.0.0 mozebyctwoje.com
0.0.0.0 mr4evmd0r1.s.ad6media.fr
0.0.0.0 mrazens.com
0.0.0.0 ms-debug-services.com
0.0.0.0 ms-downloading.com
0.0.0.0 ms-home-live.com
0.0.0.0 ms-pipes-service.com
0.0.0.0 ms-shopguide.su
0.0.0.0 ms-shopzone.su
0.0.0.0 ms.yandex.ru
0.0.0.0 msft-ssp-emea.adnxs.com
0.0.0.0 mslinks-downloads.com
0.0.0.0 msn-cdn.effectivemeasure.net
0.0.0.0 msn.tns-cs.net
0.0.0.0 msnbe-hp.metriweb.be
0.0.0.0 msnsearch.srv.girafa.com
0.0.0.0 msonebox.com
0.0.0.0 mt58.mtree.com
0.0.0.0 mttwtrack.com
0.0.0.0 mtvbrazil-services.vimn.com
0.0.0.0 mtvnlatservices.com
0.0.0.0 mulato.info
0.0.0.0 multi.xnxx.com
0.0.0.0 music.getyesappz1.com
0.0.0.0 music.myappzcenter.com
0.0.0.0 music611.com
0.0.0.0 musikzoo.com
0.0.0.0 mvonline.com
0.0.0.0 mwt.net
0.0.0.0 mx.adserver.yahoo.com
0.0.0.0 my-rewardsvault.com
0.0.0.0 my.blueadvertise.com
0.0.0.0 my.putlocker.to
0.0.0.0 my2.hizliizlefilm.net
0.0.0.0 myanyone.net
0.0.0.0 myao.adocean.pl
0.0.0.0 myasiantv.gsspcln.jp
0.0.0.0 mybinaryoptionsrobot.com
0.0.0.0 mycashback.co.uk
0.0.0.0 mychoicerewards.com
0.0.0.0 myexclusiverewards.com
0.0.0.0 myfreedinner.com
0.0.0.0 myfreegifts.co.uk
0.0.0.0 myfreemp3player.com
0.0.0.0 mygiftresource.com
0.0.0.0 mygreatrewards.com
0.0.0.0 mymediarecommendations.com
0.0.0.0 mypopups.com
0.0.0.0 myprivatephotoalbum.top
0.0.0.0 mysagagame.com
0.0.0.0 myseostats.com
0.0.0.0 mytimerpro.com
0.0.0.0 myusersonline.com
0.0.0.0 myyearbookdigital.checkm8.com
0.0.0.0 n01d05.cumulus-cloud.com
0.0.0.0 n1.nskfyl.com
0.0.0.0 n1internet.com
0.0.0.0 n2.nskfyl.com
0.0.0.0 n3.nskfyl.com
0.0.0.0 n339.asp-cc.com
0.0.0.0 n4.nskfyl.com
0.0.0.0 n4p.ru.redtram.com
0.0.0.0 n5.nskfyl.com
0.0.0.0 n6.nskfyl.com
0.0.0.0 n7.nskfyl.com
0.0.0.0 na.ads.yahoo.com
0.0.0.0 najlepszedlaciebie.com
0.0.0.0 nakladatelstvi-brazda.wz.cz
0.0.0.0 nanoadexchange.com
0.0.0.0 nanocluster.reklamz.com
0.0.0.0 napimigrans.com
0.0.0.0 napimigrans.info
0.0.0.0 napitrend.blogspot.hu
0.0.0.0 napiujsag.hu
0.0.0.0 naplo-extra.com
0.0.0.0 nationalissuepanel.com
0.0.0.0 nationalpost.adperfect.com
0.0.0.0 nationalsurveypanel.com
0.0.0.0 native.sharethrough.com
0.0.0.0 naturahirek.com
0.0.0.0 naturainmente.com
0.0.0.0 naxnet.or.jp
0.0.0.0 nbads.com
0.0.0.0 nbc.adbureau.net
0.0.0.0 nbimg.dt00.net
0.0.0.0 nc.ru.redtram.com
0.0.0.0 nctitds.top
0.0.0.0 nctracking.com
0.0.0.0 nearbyad.com
0.0.0.0 needadvertising.com
0.0.0.0 neo-kikaku.jp
0.0.0.0 nessy-stage.dotomi.com
0.0.0.0 neszmely.eu
0.0.0.0 netadclick.com
0.0.0.0 netads.hotwired.com
0.0.0.0 netbulvar.eu
0.0.0.0 netcomm.spinbox.net
0.0.0.0 netextra.hu
0.0.0.0 netshelter.adtrix.com
0.0.0.0 netsponsors.com
0.0.0.0 network.realmedia.com
0.0.0.0 networkad.net
0.0.0.0 networkads.net
0.0.0.0 neumanns-installation.de
0.0.0.0 new.lerian-nti.be
0.0.0.0 newads.cmpnet.com
0.0.0.0 newadserver.interfree.it
0.0.0.0 newagevz.homes
0.0.0.0 newclk.com
0.0.0.0 newip427.changeip.net
0.0.0.0 newjunk4u.com
0.0.0.0 newlovez.co
0.0.0.0 newlovez2.co
0.0.0.0 newlovez3.co
0.0.0.0 newlovez4.co
0.0.0.0 newmedsdeal.eu
0.0.0.0 newms-shop.su
0.0.0.0 newpipe.app
0.0.0.0 newpipe.cc
0.0.0.0 news-37876-mshome.com
0.0.0.0 news-389767-mshome.com
0.0.0.0 news-finances.com
0.0.0.0 news-server17-yahoo.com
0.0.0.0 news6health.com
0.0.0.0 newsprofin.com
0.0.0.0 newt1.adultadworld.com
0.0.0.0 newt1.adultworld.com
0.0.0.0 nextlnk2.com
0.0.0.0 nextoptim.com
0.0.0.0 ng.virgul.com
0.0.0.0 ng3.ads.warnerbros.com
0.0.0.0 ngads.smartage.com
0.0.0.0 ngp1.intnotif.club
0.0.0.0 nhn.dk
0.0.0.0 nitrous.exitfuel.com
0.0.0.0 nkcache.brandreachsys.com
0.0.0.0 nl.ads.justpremium.com
0.0.0.0 nl.adserver.yahoo.com
0.0.0.0 nlink.com.br
0.0.0.0 no.adserver.yahoo.com
0.0.0.0 nofreezingmac.space
0.0.0.0 nofreezingmac.work
0.0.0.0 nospartenaires.com
0.0.0.0 notification-browser.com
0.0.0.0 notify.beap.gemini.yahoo.com
0.0.0.0 notifyday.com
0.0.0.0 nottinghamsuburbanrailway.co.uk
0.0.0.0 novafinanza.com
0.0.0.0 novem.onet.pl
0.0.0.0 nozawashoten.com
0.0.0.0 npmpecd.com
0.0.0.0 nrkno.linkpulse.com
0.0.0.0 ns-vip2.hitbox.com
0.0.0.0 ns-vip3.hitbox.com
0.0.0.0 ns.netnet.or.jp
0.0.0.0 ns2.hitbox.com
0.0.0.0 ns38541.ovh.net
0.0.0.0 nsads.hotwired.com
0.0.0.0 nsads.us.publicus.com
0.0.0.0 nsads4.us.publicus.com
0.0.0.0 nsclick.baidu.com
0.0.0.0 nspmotion.com
0.0.0.0 nst.broadcast.pm
0.0.0.0 ntskeptics.org
0.0.0.0 nxtscrn.adbureau.net
0.0.0.0 nyittc.com
0.0.0.0 nytadvertising.nytimes.com
0.0.0.0 nytva-nmz.ru
0.0.0.0 o0.winfuture.de
0.0.0.0 o1.qnsr.com
0.0.0.0 o2.eyereturn.com
0.0.0.0 o3sndvzo25.com
0.0.0.0 oads.cracked.com
0.0.0.0 oamsrhads.us.publicus.com
0.0.0.0 oas.dn.se
0.0.0.0 oasc02023.247realmedia.com
0.0.0.0 oasc04.247.realmedia.com
0.0.0.0 oasc05.247realmedia.com
0.0.0.0 oasc05050.247realmedia.com
0.0.0.0 oasc16.247realmedia.com
0.0.0.0 oasc18065.247realmedia.com
0.0.0.0 oasis.promon.cz
0.0.0.0 oasis.zmh.zope.com
0.0.0.0 oasis.zmh.zope.net
0.0.0.0 oassis.zmh.zope.com
0.0.0.0 objects.abcvisiteurs.com
0.0.0.0 objects.designbloxlive.com
0.0.0.0 obs.nnm2.ru
0.0.0.0 obuse-apple.com
0.0.0.0 ocdn.adsterra.com
0.0.0.0 ocslab.com
0.0.0.0 odb.outbrain.com
0.0.0.0 odd-onead.cdn.hinet.net
0.0.0.0 offer.alibaba.com
0.0.0.0 offer.camp
0.0.0.0 offerimage.com
0.0.0.0 offerreality.com
0.0.0.0 offers.bycontext.com
0.0.0.0 offers.impower.com
0.0.0.0 offers.nordvpn.com
0.0.0.0 offers.royalvegascasino.com
0.0.0.0 offertrakking.info
0.0.0.0 offerx.co.uk
0.0.0.0 office-2023.com
0.0.0.0 office-2023.net
0.0.0.0 office2023.net
0.0.0.0 office365-eu-update.com
0.0.0.0 office365-us-update.com
0.0.0.0 ohmydating.com
0.0.0.0 oimsgad.qq.com
0.0.0.0 oiseau-perdu.fr
0.0.0.0 okclub.org.uk
0.0.0.0 oldftp.otenet.gr
0.0.0.0 olioeroli.it
0.0.0.0 om.elvenar.com
0.0.0.0 ometrics.warnerbros.com
0.0.0.0 onclickads.net
0.0.0.0 onclickmega.com
0.0.0.0 onclicksuper.com
0.0.0.0 onclkds.com
0.0.0.0 ondermaat.nl
0.0.0.0 one-drive-ms.com
0.0.0.0 onedrive-cdn.com
0.0.0.0 onedrive-download-en.com
0.0.0.0 onedrive-download.com
0.0.0.0 onedrive-en-live.com
0.0.0.0 onedrive-en.com
0.0.0.0 onedrive-sd.com
0.0.0.0 onedrive-sn.com
0.0.0.0 onedrive-us-en.com
0.0.0.0 onet.hit.gemius.pl
0.0.0.0 onlinadverts.com
0.0.0.0 online-office365.com
0.0.0.0 online1.webcams.com
0.0.0.0 onlineads.magicvalley.com
0.0.0.0 only.best-games.today
0.0.0.0 only2date.com
0.0.0.0 onmarshtompor.com
0.0.0.0 onmypc.net
0.0.0.0 oopt.fr
0.0.0.0 openad.travelnow.com
0.0.0.0 openadext.tf1.fr
0.0.0.0 openads.dimcab.com
0.0.0.0 openads.friendfinder.com
0.0.0.0 openads.nightlifemagazine.ca
0.0.0.0 openads.smithmag.net
0.0.0.0 openads.zeads.com
0.0.0.0 opencandy.com
0.0.0.0 openload.info
0.0.0.0 opentable.tt.omtrdc.net
0.0.0.0 openweb-match.dotomi.com
0.0.0.0 openx.adfactor.nl
0.0.0.0 openx2-match.dotomi.com
0.0.0.0 openxxx.viragemedia.com
0.0.0.0 oplaca-sie.pl
0.0.0.0 opr.adx.opera.com
0.0.0.0 opsonew3org.sg
0.0.0.0 optimaconsulting.com.au
0.0.0.0 optimize.indieclick.com
0.0.0.0 optimized.by.vitalads.net
0.0.0.0 ordie.adbureau.net
0.0.0.0 organic-harmony.com
0.0.0.0 organikusok.blogspot.hu
0.0.0.0 origer.info
0.0.0.0 origin.chron.com
0.0.0.0 orpheus.cuci.nl
0.0.0.0 osd-onead.cdn.hinet.net
0.0.0.0 osm-onead.cdn.hinet.net
0.0.0.0 otakutee.com
0.0.0.0 otletdivak.hu
0.0.0.0 otpercpiheno.blogspot.com
0.0.0.0 otpercpiheno.hu
0.0.0.0 out.popads.net
0.0.0.0 outbrain.com
0.0.0.0 outils.yesmessenger.com
0.0.0.0 overflow.adsoftware.com
0.0.0.0 overlay.ringtonematcher.com
0.0.0.0 overstock.tt.omtrdc.net
0.0.0.0 owabgxis.wp.pl
0.0.0.0 own-eu-cloud.com
0.0.0.0 ox-d.hbr.org
0.0.0.0 ox-d.hulkshare.com
0.0.0.0 ox-d.hypeads.org
0.0.0.0 ox-d.zenoviagroup.com
0.0.0.0 ox-i.zenoviagroup.com
0.0.0.0 oz.valueclick.com
0.0.0.0 oz.valueclick.ne.jp
0.0.0.0 ozonemedia.adbureau.net
0.0.0.0 p.ic.tynt.com
0.0.0.0 p.l.qq.com
0.0.0.0 p.nexac.com
0.0.0.0 p.profistats.net
0.0.0.0 p1.preppypm.com
0.0.0.0 p2.l.qq.com
0.0.0.0 p2.preppypm.com
0.0.0.0 p232207.mybestmv.com
0.0.0.0 p3.preppypm.com
0.0.0.0 p3p.mmstat.com
0.0.0.0 p4.preppypm.com
0.0.0.0 p4psearch.china.alibaba.com
0.0.0.0 p5.preppypm.com
0.0.0.0 p6.preppypm.com
0.0.0.0 p7.preppypm.com
0.0.0.0 paclitor.com
0.0.0.0 page.0ffer.eu
0.0.0.0 pagead2.googlesyndication.com
0.0.0.0 pageplop.com
0.0.0.0 pagesense.com
0.0.0.0 paid.outbrain.com
0.0.0.0 paime.com
0.0.0.0 palyazatfigyelo.info
0.0.0.0 papageienseite.de
0.0.0.0 paperg.com
0.0.0.0 parafiaukta.pl
0.0.0.0 parronnotandone.info
0.0.0.0 parskabab.com
0.0.0.0 partner-api.jobbio.com
0.0.0.0 partner-ts.groupon.be
0.0.0.0 partner-ts.groupon.co.uk
0.0.0.0 partner-ts.groupon.com
0.0.0.0 partner-ts.groupon.de
0.0.0.0 partner-ts.groupon.fr
0.0.0.0 partner-ts.groupon.net
0.0.0.0 partner-ts.groupon.nl
0.0.0.0 partner-ts.groupon.pl
0.0.0.0 partner.ah-ha.com
0.0.0.0 partner.ceneo.pl
0.0.0.0 partner.magna.ru
0.0.0.0 partner.pobieraczek.pl
0.0.0.0 partner.tagscreator.com
0.0.0.0 partner.wapacz.pl
0.0.0.0 partner.wapster.pl
0.0.0.0 partnerprogramma.bol.com
0.0.0.0 partners.adklick.de
0.0.0.0 partners.webmasterplan.com
0.0.0.0 passeura.com
0.0.0.0 passivemarcoanyhow.com
0.0.0.0 pathforpoints.com
0.0.0.0 paulomatosconsultores.com.br
0.0.0.0 paulsnetwork.com
0.0.0.0 payae8moon9.com
0.0.0.0 payforme.top
0.0.0.0 pb.tynt.com
0.0.0.0 pbid.pro-market.net
0.0.0.0 pc-gizmos-ssl.com
0.0.0.0 pc-virus-d0l92j2.pw
0.0.0.0 pcads.ru
0.0.0.0 pcmuzic.com
0.0.0.0 pcookie.aliexpress.com
0.0.0.0 peever.myzen.co.uk
0.0.0.0 pension-pentacon.de
0.0.0.0 performanceadexchange.com
0.0.0.0 persgroepadvertising.nl
0.0.0.0 perso.menara.ma
0.0.0.0 petzel.be
0.0.0.0 pg2.solution.weborama.fr
0.0.0.0 pg308-zmbra.ads.tremorhub.com
0.0.0.0 ph-ad01.focalink.com
0.0.0.0 ph-ad02.focalink.com
0.0.0.0 ph-ad03.focalink.com
0.0.0.0 ph-ad04.focalink.com
0.0.0.0 ph-ad05.focalink.com
0.0.0.0 ph-ad06.focalink.com
0.0.0.0 ph-ad07.focalink.com
0.0.0.0 ph-ad08.focalink.com
0.0.0.0 ph-ad09.focalink.com
0.0.0.0 ph-ad10.focalink.com
0.0.0.0 ph-ad11.focalink.com
0.0.0.0 ph-ad12.focalink.com
0.0.0.0 ph-ad13.focalink.com
0.0.0.0 ph-ad14.focalink.com
0.0.0.0 ph-ad15.focalink.com
0.0.0.0 ph-ad16.focalink.com
0.0.0.0 ph-ad17.focalink.com
0.0.0.0 ph-ad18.focalink.com
0.0.0.0 ph-ad19.focalink.com
0.0.0.0 ph-ad20.focalink.com
0.0.0.0 ph-ad21.focalink.com
0.0.0.0 ph-cdn.effectivemeasure.net
0.0.0.0 phcde.top
0.0.0.0 phobia.net
0.0.0.0 phoenixads.co.in
0.0.0.0 phoenixinvestigations.ca
0.0.0.0 phones4you.be
0.0.0.0 photo-cam.com
0.0.0.0 photobucket.adnxs.com
0.0.0.0 photography-hq.com
0.0.0.0 photos.daily-deals.analoganalytics.com
0.0.0.0 photos.pop6.com
0.0.0.0 photos0.pop6.com
0.0.0.0 photos1.pop6.com
0.0.0.0 photos2.pop6.com
0.0.0.0 photos3.pop6.com
0.0.0.0 photos4.pop6.com
0.0.0.0 photos5.pop6.com
0.0.0.0 photos6.pop6.com
0.0.0.0 photos7.pop6.com
0.0.0.0 photos8.pop6.com
0.0.0.0 phox2ey.bid
0.0.0.0 phpads.astalavista.us
0.0.0.0 phpads.flipcorp.com
0.0.0.0 phpads.foundrymusic.com
0.0.0.0 phpadsnew.wn.com
0.0.0.0 phuphi.com
0.0.0.0 pic.casee.cn
0.0.0.0 pickytime.com
0.0.0.0 pictures-album.com
0.0.0.0 ping.chartbeat.net
0.0.0.0 pingfore.qq.com
0.0.0.0 pingfore.soso.com
0.0.0.0 pipslab.nl
0.0.0.0 pitakchon.com
0.0.0.0 pitbull-marketing.com
0.0.0.0 pix.revsci.net
0.0.0.0 pix01.revsci.net
0.0.0.0 pix521.adtech.fr
0.0.0.0 pix521.adtech.us
0.0.0.0 pix522.adtech.fr
0.0.0.0 pix522.adtech.us
0.0.0.0 pixel-secure.solvemedia.com
0.0.0.0 pixel.adsafeprotected.com
0.0.0.0 pixel.adssafeprotected.com
0.0.0.0 pixel.everesttech.net
0.0.0.0 pixel.mathtag.com
0.0.0.0 pixel.sitescout.com
0.0.0.0 pixel.watch
0.0.0.0 piz7ohhujogi.com
0.0.0.0 pl.ads.justpremium.com
0.0.0.0 pl.bbelements.com
0.0.0.0 pl.betclic.com
0.0.0.0 pl.spanel.gem.pl
0.0.0.0 pl.web.toleadoo.com
0.0.0.0 planearconsultoria.com.br
0.0.0.0 plasmatv4free.com
0.0.0.0 platform.liquidus.net
0.0.0.0 play.heavymetalmachines.com
0.0.0.0 play.istlandoll.com
0.0.0.0 play.leadzupc.com
0.0.0.0 play.traffpartners.com
0.0.0.0 player.mediafuse.com
0.0.0.0 playinvaders.com
0.0.0.0 playlink.pl
0.0.0.0 playnow.guru
0.0.0.0 playstream.co
0.0.0.0 playtime.tubemogul.com
0.0.0.0 pleasewait.co
0.0.0.0 ploaz54.com
0.0.0.0 pm.adsafeprotected.com
0.0.0.0 pm.w55c.net
0.0.0.0 pmelon.com
0.0.0.0 pmstrk.mercadolivre.com.br
0.0.0.0 pntm-images.adbureau.net
0.0.0.0 pntm.adbureau.net
0.0.0.0 pocofh.com
0.0.0.0 pohs2oom.com
0.0.0.0 pole.6rooms.com
0.0.0.0 politicalopinionsurvey.com
0.0.0.0 pollet-rauen.de
0.0.0.0 pomp-buerotechnik.de
0.0.0.0 pool-roularta.adhese.com
0.0.0.0 pool.admedo.com
0.0.0.0 pool.distilled.ie
0.0.0.0 pool.pebblemedia.adhese.com
0.0.0.0 pop.redirect.adsjudo.com
0.0.0.0 pop.revimedia.com
0.0.0.0 popadscdn.net
0.0.0.0 popcash.net
0.0.0.0 popclick.net
0.0.0.0 popec.net
0.0.0.0 popmyads.com
0.0.0.0 popmycash.com
0.0.0.0 poponclick.com
0.0.0.0 popunder.adsrevenue.net
0.0.0.0 popunder.loading-delivery1.com
0.0.0.0 popunder.paypopup.com
0.0.0.0 popup.softreklam.com
0.0.0.0 popup.taboola.com
0.0.0.0 popupclick.ru
0.0.0.0 popupdomination.com
0.0.0.0 popups.afftrack001.com
0.0.0.0 popups.infostart.com
0.0.0.0 pornstargals.com
0.0.0.0 pos.baidu.com
0.0.0.0 post.rmbn.ru
0.0.0.0 poster.gamesprite.me
0.0.0.0 postmasterdirect.com
0.0.0.0 pp.free.fr
0.0.0.0 pp2.pptv.com
0.0.0.0 practeddagek.club
0.0.0.0 praktijkewalts.info
0.0.0.0 praktijkmariekehuisman.nl
0.0.0.0 pratik.com.tr
0.0.0.0 prd.epsilon-rtr.dotomi.com
0.0.0.0 prebid-match.dotomi.com
0.0.0.0 prebid.adspro.it
0.0.0.0 predskolaci.cz
0.0.0.0 preligions.com
0.0.0.0 premium-offers.space
0.0.0.0 premiumproductsonline.com
0.0.0.0 prestoris.com
0.0.0.0 prexyone.appspot.com
0.0.0.0 prfctlivs.click
0.0.0.0 primetime.ad.primetime.net
0.0.0.0 primusbelgium.com
0.0.0.0 privatecollection.top
0.0.0.0 privitize.com
0.0.0.0 prizes.co.uk
0.0.0.0 prjcq.com
0.0.0.0 pro.hit.gemius.pl
0.0.0.0 pro.letv.com
0.0.0.0 probusinesshub.com
0.0.0.0 proc.ad.cpe.dotomi.com
0.0.0.0 prod-a.applovin.com
0.0.0.0 prodentim101.com
0.0.0.0 productresearchpanel.com
0.0.0.0 producttestpanel.com
0.0.0.0 profile.uproxx.com
0.0.0.0 profiline-berlin.de
0.0.0.0 profitboosterapp.com
0.0.0.0 programe.top
0.0.0.0 promo.awempire.com
0.0.0.0 promo.betcity.net
0.0.0.0 promo.easy-dating.org
0.0.0.0 promo.mes-meilleurs-films.fr
0.0.0.0 promo.mobile.de
0.0.0.0 promo.profxbrokers.com
0.0.0.0 promo.streaming-illimite.net
0.0.0.0 promoreclame.info
0.0.0.0 promoreclame.nl
0.0.0.0 promos.fling.com
0.0.0.0 promotion.partnercash.com
0.0.0.0 promotions.sportingbet.com
0.0.0.0 promoviral.com
0.0.0.0 prospectnews.com
0.0.0.0 protect-your-privacy.net
0.0.0.0 protection.ASpolice.com
0.0.0.0 protection.AUpolice.com
0.0.0.0 protection.AZpolice.com
0.0.0.0 protection.BTpolice.com
0.0.0.0 protection.BYpolice.com
0.0.0.0 protection.CApolice.com
0.0.0.0 protection.CCpolice.com
0.0.0.0 protection.DKpolice.com
0.0.0.0 protection.ESpolice.com
0.0.0.0 protection.FRpolice.com
0.0.0.0 protection.FXpolice.com
0.0.0.0 protection.GApolice.com
0.0.0.0 protection.HKpolice.com
0.0.0.0 protection.HNpolice.com
0.0.0.0 protection.ILpolice.com
0.0.0.0 protection.ITpolice.com
0.0.0.0 protection.JMpolice.com
0.0.0.0 protection.KYpolice.com
0.0.0.0 protection.LApolice.com
0.0.0.0 protection.LBpolice.com
0.0.0.0 protection.LCpolice.com
0.0.0.0 protection.LIpolice.com
0.0.0.0 protection.LRpolice.com
0.0.0.0 protection.LSpolice.com
0.0.0.0 protection.LVpolice.com
0.0.0.0 protection.MApolice.com
0.0.0.0 protection.MDpolice.com
0.0.0.0 protection.MEpolice.com
0.0.0.0 protection.MNpolice.com
0.0.0.0 protection.NApolice.com
0.0.0.0 protection.NCpolice.com
0.0.0.0 protection.NZpolice.com
0.0.0.0 protection.PApolice.com
0.0.0.0 protection.PGpolice.com
0.0.0.0 protection.SBpolice.com
0.0.0.0 protection.TNpolice.com
0.0.0.0 protection.TOpolice.com
0.0.0.0 protection.VApolice.com
0.0.0.0 protection.VIpolice.com
0.0.0.0 protection.stpolice.com
0.0.0.0 proweb.co.uk
0.0.0.0 proximityads.flipcorp.com
0.0.0.0 prpops.com
0.0.0.0 ps-us.amazon-adsystem.com
0.0.0.0 ps.eyeota.net
0.0.0.0 ps.popcash.net
0.0.0.0 ps4ux.com
0.0.0.0 psoabojaksou.net
0.0.0.0 pstatic.datafastguru.info
0.0.0.0 pt-gmtdmp.mookie1.com
0.0.0.0 pt.beststreams.club
0.0.0.0 pt.trafficjunky.net
0.0.0.0 pt21na.com
0.0.0.0 pt5.titans-gel.net
0.0.0.0 pteenoum.com
0.0.0.0 ptirgaux.com
0.0.0.0 ptrads.mp3.com
0.0.0.0 pttsite.com
0.0.0.0 pub.sapo.pt
0.0.0.0 pub.web.sapo.io
0.0.0.0 pubdirecte.com
0.0.0.0 pubimgs.sapo.pt
0.0.0.0 publiads.com
0.0.0.0 publicidades.redtotalonline.com
0.0.0.0 publicis.adcentriconline.com
0.0.0.0 publisher-config.unityads.unity3d.com
0.0.0.0 publishers.adscholar.com
0.0.0.0 publishers.bidtraffic.com
0.0.0.0 publishing.kalooga.com
0.0.0.0 pubmatic-match.dotomi.com
0.0.0.0 pubpress.net
0.0.0.0 pubserver.xl.pt
0.0.0.0 pubshop.img.uol.com.br
0.0.0.0 pulsepoint-match.dotomi.com
0.0.0.0 purryowl.com
0.0.0.0 push-ad.com
0.0.0.0 push-notification.tools
0.0.0.0 push.aarth.net
0.0.0.0 pushagim.com
0.0.0.0 pushno.com
0.0.0.0 pwdplz.com
0.0.0.0 pwwysydh.com
0.0.0.0 px.moatads.com
0.0.0.0 q.azcentral.com
0.0.0.0 qd.admetricspro.com
0.0.0.0 qfdn3gyfbs.com
0.0.0.0 qip.magna.ru
0.0.0.0 qqlogo.qq.com
0.0.0.0 qring-tms.qq.com
0.0.0.0 qss-client.qq.com
0.0.0.0 qualifiedourspecialoffer.com
0.0.0.0 quickandeasy.co.za
0.0.0.0 quickbrowsersearch.com
0.0.0.0 quickfilmz.com
0.0.0.0 quik-serv.com
0.0.0.0 quizzitch.net
0.0.0.0 qxxru.linknotification.com
0.0.0.0 r.chitika.net
0.0.0.0 r.reklama.biz
0.0.0.0 r.turn.com
0.0.0.0 r.turn.com.akadns.net
0.0.0.0 r1.ritikajoshi.com
0.0.0.0 r1.romeflirt.com
0.0.0.0 r2.adwo.com
0.0.0.0 r2.ritikajoshi.com
0.0.0.0 r2.romeflirt.com
0.0.0.0 r3.ritikajoshi.com
0.0.0.0 r3.romeflirt.com
0.0.0.0 r4.ritikajoshi.com
0.0.0.0 r4.romeflirt.com
0.0.0.0 r5.ritikajoshi.com
0.0.0.0 r5.romeflirt.com
0.0.0.0 r6.ritikajoshi.com
0.0.0.0 r6.romeflirt.com
0.0.0.0 r7.ritikajoshi.com
0.0.0.0 r7.romeflirt.com
0.0.0.0 r7mediar.com
0.0.0.0 rad.live.com
0.0.0.0 rad.msn.com
0.0.0.0 rads.stackoverflow.com
0.0.0.0 railroadtomato.com
0.0.0.0 rassegnavermentino.it
0.0.0.0 razor.arnes.si
0.0.0.0 rc.asci.freenet.de
0.0.0.0 rc.bt.ilsemedia.nl
0.0.0.0 rc.hotkeys.com
0.0.0.0 rc.rlcdn.com
0.0.0.0 rc.wl.webads.nl
0.0.0.0 rcdna.gwallet.com
0.0.0.0 rcm-images.amazon.com
0.0.0.0 rcm-it.amazon.it
0.0.0.0 rcm-na.amazon-adsystem.com
0.0.0.0 rd.speakol.com
0.0.0.0 rdsa2012.com
0.0.0.0 re.directrev.com
0.0.0.0 reactads.cdn.adglare.net
0.0.0.0 realads.realmedia.com
0.0.0.0 realgfsbucks.com
0.0.0.0 realizationnewestfangs.com
0.0.0.0 realmedia-a800.d4p.net
0.0.0.0 realmedia.advance.net
0.0.0.0 realplayz.com
0.0.0.0 rebevengwas.com
0.0.0.0 recommendedforyou.xyz
0.0.0.0 record.commissionlounge.com
0.0.0.0 redherring.ngadcenter.net
0.0.0.0 redir.bebi.com
0.0.0.0 redir9.alteabz.it
0.0.0.0 redirect.click2net.com
0.0.0.0 redirect.hotkeys.com
0.0.0.0 redirect.xmlheads.com
0.0.0.0 redonetype.com
0.0.0.0 reduxads.valuead.com
0.0.0.0 regflow.com
0.0.0.0 regie.espace-plus.net
0.0.0.0 regio.adlink.de
0.0.0.0 register.cinematrix.net
0.0.0.0 register.silverscreen.cc
0.0.0.0 reklam.arabul.com
0.0.0.0 reklam.ebiuniverse.com
0.0.0.0 reklam.milliyet.com.tr
0.0.0.0 reklam.misli.com
0.0.0.0 reklam.mynet.com
0.0.0.0 reklam.softreklam.com
0.0.0.0 reklama.onet.pl
0.0.0.0 reklamagaci.com
0.0.0.0 reklamtrk.com
0.0.0.0 reklamy.sfd.pl
0.0.0.0 relestar.com
0.0.0.0 relevantairbornefantastic.com
0.0.0.0 remekcikkek.com
0.0.0.0 rencontreavenue.com
0.0.0.0 reninet.com
0.0.0.0 report02.adtech.fr
0.0.0.0 report02.adtech.us
0.0.0.0 reporter.adtech.fr
0.0.0.0 reporter.adtech.us
0.0.0.0 reporter001.adtech.fr
0.0.0.0 reporter001.adtech.us
0.0.0.0 reportimage.adtech.fr
0.0.0.0 reportimage.adtech.us
0.0.0.0 reporting.aatkit.com
0.0.0.0 repostuj.push-ad.com
0.0.0.0 req.adsmogo.com
0.0.0.0 res-backup.com
0.0.0.0 res1.applovin.com
0.0.0.0 reselling-corp.com
0.0.0.0 resolvingserver.com
0.0.0.0 resources.infolinks.com
0.0.0.0 restaurantcom.tt.omtrdc.net
0.0.0.0 retargetly-match.dotomi.com
0.0.0.0 reverso.refr.adgtw.orangeads.fr
0.0.0.0 revsci.net
0.0.0.0 rewardpoll.com
0.0.0.0 rewardsflow.com
0.0.0.0 reynders.info
0.0.0.0 rf-arch.com
0.0.0.0 rh.qq.com
0.0.0.0 rh.revolvermaps.com
0.0.0.0 rhads.sv.publicus.com
0.0.0.0 rich.qq.com
0.0.0.0 richmedia.yimg.com
0.0.0.0 ridepush.com
0.0.0.0 rimaje.nl
0.0.0.0 ringtonepartner.com
0.0.0.0 rivalo.network
0.0.0.0 river-store.com
0.0.0.0 rjr-rs.com.br
0.0.0.0 rmbn.ru
0.0.0.0 rmcdn.2mdn.net
0.0.0.0 rmcdn.f.2mdn.net
0.0.0.0 rmedia.boston.com
0.0.0.0 rmm1u.checkm8.com
0.0.0.0 rmp.rakuten.com
0.0.0.0 robbiblubber.org
0.0.0.0 robot.royalcactus.com
0.0.0.0 romepartners.com
0.0.0.0 roosevelt.gjbig.com
0.0.0.0 rosettastone.tt.omtrdc.net
0.0.0.0 rotumal.com
0.0.0.0 route31.org
0.0.0.0 router.adlure.net
0.0.0.0 rovion.com
0.0.0.0 rp.hit.gemius.pl
0.0.0.0 rpc-php.trafficfactory.biz
0.0.0.0 rpc.trafficfactory.biz
0.0.0.0 rpgmasterleague.com
0.0.0.0 rpm.newrelisc.com
0.0.0.0 rqtrk.eu
0.0.0.0 rs1.qq.com
0.0.0.0 rs2.qq.com
0.0.0.0 rss.buysellads.com
0.0.0.0 rta.dailymail.co.uk
0.0.0.0 rtb-lb-event-sjc.tubemogul.com
0.0.0.0 rtb.pclick.yahoo.com
0.0.0.0 rtb.tubemogul.com
0.0.0.0 rtb1.adscience.nl
0.0.0.0 rtb10.adscience.nl
0.0.0.0 rtb11.adscience.nl
0.0.0.0 rtb12.adscience.nl
0.0.0.0 rtb13.adscience.nl
0.0.0.0 rtb14.adscience.nl
0.0.0.0 rtb15.adscience.nl
0.0.0.0 rtb16.adscience.nl
0.0.0.0 rtb17.adscience.nl
0.0.0.0 rtb18.adscience.nl
0.0.0.0 rtb19.adscience.nl
0.0.0.0 rtb2.adscience.nl
0.0.0.0 rtb20.adscience.nl
0.0.0.0 rtb21.adscience.nl
0.0.0.0 rtb22.adscience.nl
0.0.0.0 rtb23.adscience.nl
0.0.0.0 rtb24.adscience.nl
0.0.0.0 rtb25.adscience.nl
0.0.0.0 rtb26.adscience.nl
0.0.0.0 rtb27.adscience.nl
0.0.0.0 rtb28.adscience.nl
0.0.0.0 rtb29.adscience.nl
0.0.0.0 rtb3.adscience.nl
0.0.0.0 rtb30.adscience.nl
0.0.0.0 rtb4.adscience.nl
0.0.0.0 rtb5.adscience.nl
0.0.0.0 rtb6.adscience.nl
0.0.0.0 rtb7.adscience.nl
0.0.0.0 rtb8.adscience.nl
0.0.0.0 rtb9.adscience.nl
0.0.0.0 rtl-most.blogspot.hu
0.0.0.0 rtr.innovid.com
0.0.0.0 rts.sparkstudios.com
0.0.0.0 ru.redtram.com
0.0.0.0 ru4.com
0.0.0.0 rubicon-match.dotomi.com
0.0.0.0 rubyfortune.com
0.0.0.0 ruegenfleisch.de
0.0.0.0 runcpa.com
0.0.0.0 runtime.lemonpi.io
0.0.0.0 rv.adcpx.v1.de.eusem.adaos-ads.net
0.0.0.0 s-adserver.sandbox.cxad.cxense.com
0.0.0.0 s-bid.rmp.rakuten.com
0.0.0.0 s-clk.rmp.rakuten.com
0.0.0.0 s-usweb.dotomi.com
0.0.0.0 s.ad131m.com
0.0.0.0 s.admulti.com
0.0.0.0 s.arclk.net
0.0.0.0 s.atemda.com
0.0.0.0 s.baidu.com
0.0.0.0 s.boom.ro
0.0.0.0 s.click.aliexpress.com
0.0.0.0 s.clickiocdn.com
0.0.0.0 s.clicktale.net
0.0.0.0 s.console.adtarget.com.tr
0.0.0.0 s.di.com.pl
0.0.0.0 s.domob.cn
0.0.0.0 s.dynad.net
0.0.0.0 s.flite.com
0.0.0.0 s.innovid.com
0.0.0.0 s.media-imdb.com
0.0.0.0 s.megaclick.com
0.0.0.0 s.moatads.com
0.0.0.0 s.ntv.io
0.0.0.0 s.optnx.com
0.0.0.0 s.oroll.com
0.0.0.0 s.ppjol.net
0.0.0.0 s.rev2pub.com
0.0.0.0 s.seedtag.com
0.0.0.0 s.skimresources.com
0.0.0.0 s.spolecznosci.net
0.0.0.0 s.spoutable.com
0.0.0.0 s.tcimg.com
0.0.0.0 s.thebrighttag.com
0.0.0.0 s.visilabs.net
0.0.0.0 s0b.bluestreak.com
0.0.0.0 s1.2mdn.net
0.0.0.0 s1.adform.net
0.0.0.0 s3.adbers.com
0.0.0.0 s3.buysellads.com
0.0.0.0 s3.pfp.sina.net
0.0.0.0 s5.addthis.com
0.0.0.0 s7.addthis.com
0.0.0.0 s7clean.com
0.0.0.0 s8t.teads.tv
0.0.0.0 s9kkremkr0.com
0.0.0.0 sabre.com.tw
0.0.0.0 safe.hyperpaysys.com
0.0.0.0 safebrowse.com
0.0.0.0 sagent.io
0.0.0.0 salesforcecom.tt.omtrdc.net
0.0.0.0 saletrybest.su
0.0.0.0 samsung3.solution.weborama.fr
0.0.0.0 sanalreklam.com
0.0.0.0 sarahshuckburgh.com
0.0.0.0 sas.decisionnews.com
0.0.0.0 saturn.tiser.com.au
0.0.0.0 save-plan.com
0.0.0.0 savings-time.com
0.0.0.0 sayac.hurriyet.com.tr
0.0.0.0 sayfabulunamadi.com
0.0.0.0 sb.freeskreen.com
0.0.0.0 sb.scorecardresearch.com
0.0.0.0 sb1.shble.com
0.0.0.0 sb2.shble.com
0.0.0.0 sb3.shble.com
0.0.0.0 sb4.shble.com
0.0.0.0 sb5.shble.com
0.0.0.0 sb6.shble.com
0.0.0.0 sb7.shble.com
0.0.0.0 scalemonk.com
0.0.0.0 scdown.qq.com
0.0.0.0 scegli-vinci.it
0.0.0.0 scgis.co.uk
0.0.0.0 schoorsteen.geenstijl.nl
0.0.0.0 schumacher.adtech.fr
0.0.0.0 schumacher.adtech.us
0.0.0.0 schwab.tt.omtrdc.net
0.0.0.0 scnet.tv
0.0.0.0 scr.kliksaya.com
0.0.0.0 screen-mates.com
0.0.0.0 script.banstex.com
0.0.0.0 script.crsspxl.com
0.0.0.0 scripts.kiosked.com
0.0.0.0 scripts.linkz.net
0.0.0.0 scripts.verticalacuity.com
0.0.0.0 sdk.streamrail.com
0.0.0.0 se.adserver.yahoo.com
0.0.0.0 seapower-italia.it
0.0.0.0 search.addthis.com
0.0.0.0 search.freeonline.com
0.0.0.0 search.keywordblocks.com
0.0.0.0 search.netseer.com
0.0.0.0 search.spotxchange.com
0.0.0.0 searchwe.com
0.0.0.0 sec.hit.gemius.pl
0.0.0.0 secimage.adtech.fr
0.0.0.0 secimage.adtech.us
0.0.0.0 secondchancecoaching.com
0.0.0.0 secserv.adtech.de
0.0.0.0 secserv.adtech.fr
0.0.0.0 secserv.adtech.us
0.0.0.0 secure-js.kontera.com
0.0.0.0 secure.addthis.com
0.0.0.0 secure.adnxs.com
0.0.0.0 secure.bidvertiser.com
0.0.0.0 secure.bidvertiserr.com
0.0.0.0 secure.netscope.marktest.pt
0.0.0.0 secure.webconnect.net
0.0.0.0 securecloud-smart.com
0.0.0.0 secureir.ebaystatic.com
0.0.0.0 securerr.com
0.0.0.0 securerunner.com
0.0.0.0 security60-e.com
0.0.0.0 sedlec.unas.cz
0.0.0.0 see-back.com
0.0.0.0 seemlessfixing.tech
0.0.0.0 seiyuu.ne.jp
0.0.0.0 seks-partner.com
0.0.0.0 select001.adtech.fr
0.0.0.0 select001.adtech.us
0.0.0.0 select002.adtech.fr
0.0.0.0 select002.adtech.us
0.0.0.0 select003.adtech.fr
0.0.0.0 select003.adtech.us
0.0.0.0 select004.adtech.fr
0.0.0.0 select004.adtech.us
0.0.0.0 selling-group.com
0.0.0.0 sergarius.popunder.ru
0.0.0.0 serv.ad-rotator.com
0.0.0.0 serv.adspeed.com
0.0.0.0 serv.tooplay.com
0.0.0.0 serv2.ad-rotator.com
0.0.0.0 serve.adplxmd.com
0.0.0.0 serve.freegaypix.com
0.0.0.0 serve.mediayan.com
0.0.0.0 serve.popads.net
0.0.0.0 serve.prestigecasino.com
0.0.0.0 servedby-buysellads.com
0.0.0.0 servedby.adcombination.com
0.0.0.0 servedby.flashtalking.com
0.0.0.0 servedbyadbutler.com
0.0.0.0 server.as5000.com
0.0.0.0 server.bittads.com
0.0.0.0 server.cpmstar.com
0.0.0.0 server.zoiets.be
0.0.0.0 server2.as5000.com
0.0.0.0 server2.mediajmp.com
0.0.0.0 server44.dubhosting.co.uk
0.0.0.0 server821.com
0.0.0.0 service.adtech.fr
0.0.0.0 service.adtech.us
0.0.0.0 service.urchin.com
0.0.0.0 service001.adtech.fr
0.0.0.0 service001.adtech.us
0.0.0.0 service002.adtech.fr
0.0.0.0 service002.adtech.us
0.0.0.0 service003.adtech.fr
0.0.0.0 service003.adtech.us
0.0.0.0 service004.adtech.fr
0.0.0.0 service004.adtech.us
0.0.0.0 service00x.adtech.fr
0.0.0.0 service00x.adtech.us
0.0.0.0 servicer.mgid.com
0.0.0.0 services.adtech.fr
0.0.0.0 services.adtech.us
0.0.0.0 services1.adtech.fr
0.0.0.0 services1.adtech.us
0.0.0.0 serving-sys.com
0.0.0.0 serving.plexop.net
0.0.0.0 serving.stat-rock.com
0.0.0.0 serwisy.gremimedia.pl
0.0.0.0 setrise.nl
0.0.0.0 seward.net
0.0.0.0 sexpartnerx.com
0.0.0.0 sexsponsors.com
0.0.0.0 sexzavod.com
0.0.0.0 seyatosan.iaigiri.com
0.0.0.0 sfads.osdn.com
0.0.0.0 sg.adserver.yahoo.com
0.0.0.0 sg3.beap.gemini.yahoo.com
0.0.0.0 sgs001.adtech.fr
0.0.0.0 sgs001.adtech.us
0.0.0.0 sh2070.evanzo-server.de
0.0.0.0 sh4sure-images.adbureau.net
0.0.0.0 share-clouds.com
0.0.0.0 share-server.com
0.0.0.0 share-stores.com
0.0.0.0 shareaholic.com
0.0.0.0 shareasale.com
0.0.0.0 sharebar.addthiscdn.com
0.0.0.0 shared-download.com
0.0.0.0 sharefile-us.com
0.0.0.0 sharefiles-eu.com
0.0.0.0 shares-cloud.com
0.0.0.0 shatershepeleve.com
0.0.0.0 shellstore.info
0.0.0.0 shichihukuudon.com
0.0.0.0 shinedns.net
0.0.0.0 shinystat.shiny.it
0.0.0.0 shopperpromotions.com
0.0.0.0 shopping-offer.com
0.0.0.0 shoppingminds.net
0.0.0.0 short-share.com
0.0.0.0 shortcut-links.com
0.0.0.0 shorthouse.com
0.0.0.0 show-msgch.qq.com
0.0.0.0 showads1000.pubmatic.com
0.0.0.0 showadsak.pubmatic.com
0.0.0.0 shrek.6.cn
0.0.0.0 shrimpsqueezed.com
0.0.0.0 si.hit.gemius.pl
0.0.0.0 sidare.homes
0.0.0.0 sifomedia.citypaketet.se
0.0.0.0 signup.advance.net
0.0.0.0 silcom.com
0.0.0.0 simba.6.cn
0.0.0.0 simg.zedo.com
0.0.0.0 simpleads.net
0.0.0.0 simpli.fi
0.0.0.0 simpli.top
0.0.0.0 sinseisyoji.co.jp
0.0.0.0 sistemishop.it
0.0.0.0 site.adform.com
0.0.0.0 siteadvisor.com-br.site
0.0.0.0 siteonline.stream
0.0.0.0 sixapart.adbureau.net
0.0.0.0 sjc-usadmm-ds.dotomi.com
0.0.0.0 sjc-usadmm.dotomi.com
0.0.0.0 skaluneris.com
0.0.0.0 sky.od.ua
0.0.0.0 slayinglance.com
0.0.0.0 slhk23.0101host.com
0.0.0.0 slimspots.com
0.0.0.0 slowmac.tech
0.0.0.0 slowmacfaster.trade
0.0.0.0 smaato-match.dotomi.com
0.0.0.0 smarine.mu
0.0.0.0 smart-scripts.com
0.0.0.0 smartadserver.com
0.0.0.0 smartclip.com
0.0.0.0 smartclip.net
0.0.0.0 smartcontext.pl
0.0.0.0 smartinit.webads.nl
0.0.0.0 smartlifeguides.com
0.0.0.0 smartshare.lgtvsdp.com
0.0.0.0 smarttopchain.nl
0.0.0.0 smitt.nl
0.0.0.0 smokersopinionpoll.com
0.0.0.0 smsmovies.net
0.0.0.0 smutstone.com
0.0.0.0 snammar-jumntal.com
0.0.0.0 snaps.vidiemi.com
0.0.0.0 snip.answers.com
0.0.0.0 soarpower.com
0.0.0.0 sobar.baidu.com
0.0.0.0 sochr.com
0.0.0.0 social.bidsystem.com
0.0.0.0 socom.es
0.0.0.0 softlinkers.popunder.ru
0.0.0.0 sokrates.adtech.fr
0.0.0.0 sokrates.adtech.us
0.0.0.0 sol-images.adbureau.net
0.0.0.0 sol.adbureau.net
0.0.0.0 solartia.com
0.0.0.0 solicita.info
0.0.0.0 solitairetime.com
0.0.0.0 solution.weborama.fr
0.0.0.0 somethingawful.crwdcntrl.net
0.0.0.0 sonycomputerentertai.tt.omtrdc.net
0.0.0.0 sophang8.com
0.0.0.0 sortis.lt
0.0.0.0 sp.adbrn.com
0.0.0.0 spaces.slimspots.com
0.0.0.0 spadework.org
0.0.0.0 spanel.gem.pl
0.0.0.0 spanids.dictionary.com
0.0.0.0 spanids.thesaurus.com
0.0.0.0 special-alerts.com
0.0.0.0 specialoffers.aol.com
0.0.0.0 speed.pointroll.com
0.0.0.0 speedboink.com
0.0.0.0 speedclicks.ero-advertising.com
0.0.0.0 speedcurve.com
0.0.0.0 speednetwork14.adk2x.com
0.0.0.0 speednetwork6.adk2x.com
0.0.0.0 speeltuintalud.nl
0.0.0.0 spendsdetachment.com
0.0.0.0 spensa.co
0.0.0.0 spin.spinbox.net
0.0.0.0 spinbox.com
0.0.0.0 spinbox.freedom.com
0.0.0.0 spinbox.techtracker.com
0.0.0.0 spiralfolderrollers.com
0.0.0.0 spolecznosci.mgr.consensu.org
0.0.0.0 spolecznosci.net
0.0.0.0 sponsor1.com
0.0.0.0 sponsorships.net
0.0.0.0 sportreisen.de
0.0.0.0 sportydesktops.com
0.0.0.0 spotxchange.com
0.0.0.0 sq2trk2.com
0.0.0.0 srs.targetpoint.com
0.0.0.0 srtb.msn.com
0.0.0.0 srv.bebi.com
0.0.0.0 srv.juiceadv.com
0.0.0.0 srv.sayyac.com
0.0.0.0 srv7.admedit.net
0.0.0.0 ssads.osdn.com
0.0.0.0 sso.canada.com
0.0.0.0 ssp.adplus.co.id
0.0.0.0 ssp.imedia.cz
0.0.0.0 ssp.seznam.cz
0.0.0.0 ssp.streamrail.net
0.0.0.0 sspcash.adxcore.com
0.0.0.0 st.blogads.com
0.0.0.0 st.pba.xl.pt
0.0.0.0 st.videojam.tv
0.0.0.0 staceydodge.com
0.0.0.0 stampen.adtlgc.com
0.0.0.0 stampen.linkpulse.com
0.0.0.0 stampscom.tt.omtrdc.net
0.0.0.0 stanbridgeestate.com
0.0.0.0 star-advertising.com
0.0.0.0 star.pulseonclick.com
0.0.0.0 start.badults.se
0.0.0.0 stat.56.com
0.0.0.0 stat.blogads.com
0.0.0.0 stat.dealtime.com
0.0.0.0 stat.detelefoongids.nl
0.0.0.0 stat.rolledwil.biz
0.0.0.0 stat2.corp.56.com
0.0.0.0 static-downloads.com
0.0.0.0 static-google-analtyic.com
0.0.0.0 static.2mdn.net
0.0.0.0 static.admaximize.com
0.0.0.0 static.adsafeprotected.com
0.0.0.0 static.adsonar.com
0.0.0.0 static.adwo.com
0.0.0.0 static.adzerk.net
0.0.0.0 static.chartbeat.com
0.0.0.0 static.clickonometrics.pl
0.0.0.0 static.criteo.net
0.0.0.0 static.doubleclick.net
0.0.0.0 static.eu.criteo.net
0.0.0.0 static.everyone.net
0.0.0.0 static.fmpub.net
0.0.0.0 static.freenet.de
0.0.0.0 static.freeskreen.com
0.0.0.0 static.ifa.camads.net
0.0.0.0 static.l3.cdn.adbucks.com
0.0.0.0 static.l3.cdn.adsucks.com
0.0.0.0 static.linkz.net
0.0.0.0 static.loboclick.com
0.0.0.0 static.mackeeper.com
0.0.0.0 static.mediav.com
0.0.0.0 static.oroll.com
0.0.0.0 static.plista.com
0.0.0.0 static.plugrush.com
0.0.0.0 static.ptoahaistais.com
0.0.0.0 static.scanscout.com
0.0.0.0 static.trackuity.com
0.0.0.0 static.trafficstars.com
0.0.0.0 static.unocdn.com
0.0.0.0 static.vertamedia.com
0.0.0.0 static.virgul.com
0.0.0.0 static.vpptechnologies.com
0.0.0.0 static.wooboo.com.cn
0.0.0.0 static.youmi.net
0.0.0.0 staticads.btopenworld.com
0.0.0.0 staticb.mydirtyhobby.com
0.0.0.0 staticd.cdn.adblade.com
0.0.0.0 statistic.ads24h.net
0.0.0.0 statistik-gallup.dk
0.0.0.0 stats.appsflyer.com
0.0.0.0 stats.askmoses.com
0.0.0.0 stats.defense.gov
0.0.0.0 stats.fd.nl
0.0.0.0 stats.ipinyou.com
0.0.0.0 stats.shopify.com
0.0.0.0 stats.tubemogul.com
0.0.0.0 stats.x14.eu
0.0.0.0 statsie.com
0.0.0.0 stephanie.tnctrx.com
0.0.0.0 stocker.bonnint.net
0.0.0.0 stompebi.link
0.0.0.0 storage.softure.com
0.0.0.0 storage.trafic.ro
0.0.0.0 store-downloads.com
0.0.0.0 strategy.lmobi.net
0.0.0.0 stream-direct.co
0.0.0.0 streamate.com
0.0.0.0 streamate.doublepimp.com
0.0.0.0 stub.mainspotvideosfree.best
0.0.0.0 studiomugnaini.eu
0.0.0.0 studiospa.com.pl
0.0.0.0 stx-match.dotomi.com
0.0.0.0 su.addthis.com
0.0.0.0 su.valley.ne.jp
0.0.0.0 sudokuwhiz.com
0.0.0.0 suhunsoo.uk
0.0.0.0 summer.ntua.edu.tw
0.0.0.0 sumo.ad
0.0.0.0 sumome.com
0.0.0.0 sunmaker.com
0.0.0.0 super-mario-deluxe.net
0.0.0.0 superbrewards.com
0.0.0.0 superfastcdn.com
0.0.0.0 superinterstitial.com
0.0.0.0 superlecker.info
0.0.0.0 support-ip.com
0.0.0.0 support.sweepstakes.com
0.0.0.0 suprama.online
0.0.0.0 surfindave.com
0.0.0.0 surfsecured.net
0.0.0.0 surplus-suppliers.com
0.0.0.0 survey.china.alibaba.com
0.0.0.0 survey.nuggad.net
0.0.0.0 surveymonkeycom.tt.omtrdc.net
0.0.0.0 surveypass.com
0.0.0.0 survymonkey.xyz
0.0.0.0 susi.adtech.fr
0.0.0.0 susi.adtech.us
0.0.0.0 svava.eu
0.0.0.0 svd.adtlgc.com
0.0.0.0 svd2.adtlgc.com
0.0.0.0 swa.and.co.uk
0.0.0.0 swa.metro.co.uk
0.0.0.0 sweetsforfree.com
0.0.0.0 swfhostltd.com
0.0.0.0 sworkitads.herokuapp.com
0.0.0.0 syn.verticalacuity.com
0.0.0.0 synacor-match.dotomi.com
0.0.0.0 synad.nuffnang.com.sg
0.0.0.0 synad2.nuffnang.com.cn
0.0.0.0 sync-eu.exe.bid
0.0.0.0 sync-share.com
0.0.0.0 sync.1rx.io
0.0.0.0 sync.audtd.com
0.0.0.0 sync.console.adtarget.com.tr
0.0.0.0 sync.credebat.com
0.0.0.0 sync.mathtag.com
0.0.0.0 sync.outbrain.com
0.0.0.0 sync.pulseradius.com
0.0.0.0 sync.upravel.com
0.0.0.0 syncaccess.net
0.0.0.0 syncdownload.com
0.0.0.0 syncdownloading.com
0.0.0.0 syndicated.mondominishows.com
0.0.0.0 syndication.exdynsrv.com
0.0.0.0 syndication.exoclick.com
0.0.0.0 syndication.exosrv.com
0.0.0.0 syndication.optimizesrv.com
0.0.0.0 syndication.traffichaus.com
0.0.0.0 sysadmin.map24.com
0.0.0.0 sysip.net
0.0.0.0 szabadonebredok.info
0.0.0.0 szalonenagrody.com
0.0.0.0 szalonepromocje.com
0.0.0.0 szemlelo.com
0.0.0.0 szupertanacsok.blog.hu
0.0.0.0 t-ads.adap.tv
0.0.0.0 t-o-kitano.com
0.0.0.0 t-odx.op-mobile.opera.com
0.0.0.0 t.atpanel.com
0.0.0.0 t.dynad.net
0.0.0.0 t.frtyg.com
0.0.0.0 t.mdn2015x3.com
0.0.0.0 t.seedtag.com
0.0.0.0 t.silvinst.com
0.0.0.0 t1.adserver.com
0.0.0.0 t2.junbi-tracker.com
0.0.0.0 t8t7frium3.s.ad6media.fr
0.0.0.0 taboola.com
0.0.0.0 taboola.com.edgekey.net
0.0.0.0 taboolasyndication.com
0.0.0.0 tag-dyn.omnitagjs.com
0.0.0.0 tag.contextweb.com
0.0.0.0 tag.regieci.com
0.0.0.0 tag.webcompteur.com
0.0.0.0 tag.yieldoptimizer.com
0.0.0.0 tags.bluekai.com
0.0.0.0 tags.expo9.exponential.com
0.0.0.0 tags.hypeads.org
0.0.0.0 tags.onscroll.com
0.0.0.0 tags.tagcade.com
0.0.0.0 taicheetee.com
0.0.0.0 takeforme.xyz
0.0.0.0 takeoneaudio.jp
0.0.0.0 tanio-najtaniej.com
0.0.0.0 taobaoafp.allyes.cn
0.0.0.0 taouxis.gr
0.0.0.0 tapixesa.pro
0.0.0.0 tc.tradetracker.net
0.0.0.0 tcadops.ca
0.0.0.0 tcimg.com
0.0.0.0 tcss.qq.com
0.0.0.0 tdameritrade.tt.omtrdc.net
0.0.0.0 tdc.advertorials.dk
0.0.0.0 te.kontera.com
0.0.0.0 te1.techgeetam.com
0.0.0.0 teads-match.dotomi.com
0.0.0.0 tealium.com
0.0.0.0 tealiumiq.com
0.0.0.0 techexpert.site
0.0.0.0 techms-shop.su
0.0.0.0 techreview-images.adbureau.net
0.0.0.0 techreview.adbureau.net
0.0.0.0 teeser.ru
0.0.0.0 telefoniabologna.it
0.0.0.0 telusplanet.net
0.0.0.0 testapp.adhood.com
0.0.0.0 testensie.de
0.0.0.0 testpconly12.prepare2upvideosafesystem4setnow.online
0.0.0.0 tewxda71.secure.ne.jp
0.0.0.0 texas-diesel.com
0.0.0.0 text-link-ads.com
0.0.0.0 textad.traficdublu.ro
0.0.0.0 textads.madisonavenue.com
0.0.0.0 textsrv.com
0.0.0.0 tf.nexac.com
0.0.0.0 tgpmanager.com
0.0.0.0 thamescom.com
0.0.0.0 thanku.page
0.0.0.0 the-adblocker.website
0.0.0.0 the-binary-trader.biz
0.0.0.0 thebestgame2020.com
0.0.0.0 thebitcrew.com
0.0.0.0 thebrighttag.com
0.0.0.0 thebuzz.today
0.0.0.0 thedirecthor.com
0.0.0.0 theestatehouse.co.uk
0.0.0.0 theketo-complete.com
0.0.0.0 themaplemethod.com
0.0.0.0 theotime.net
0.0.0.0 thepiratetrader.com
0.0.0.0 theswimshop.co.za
0.0.0.0 theuseful.com
0.0.0.0 theuseful.net
0.0.0.0 thinknyc.eu-adcenter.net
0.0.0.0 thinktarget.com
0.0.0.0 thirtydaychange.com
0.0.0.0 this.content.served.by.addshuffle.com
0.0.0.0 this.content.served.by.adshuffle.com
0.0.0.0 throtle-match.dotomi.com
0.0.0.0 throwingsevens.co.uk
0.0.0.0 thruport.com
0.0.0.0 tic.filmstoon.cam
0.0.0.0 tidebuy.com
0.0.0.0 tiltott.net
0.0.0.0 timetunnel.net
0.0.0.0 tiqcdn.com
0.0.0.0 titan-gel-extra.com
0.0.0.0 titkoshirek.wordpress.com
0.0.0.0 titokterminal.com
0.0.0.0 tj6w5.flx10.com
0.0.0.0 tlx.3lift.com
0.0.0.0 tmx.technoratimedia.com
0.0.0.0 toads.osdn.com
0.0.0.0 todayresearch.com
0.0.0.0 toiletpaper.life
0.0.0.0 tommasobuglioni.com
0.0.0.0 tommysbookmarks.com
0.0.0.0 tommysbookmarks.net
0.0.0.0 tomsonguitars.co.uk
0.0.0.0 tongji.baidu.com
0.0.0.0 toolbar.baidu.com
0.0.0.0 toolbar.soso.com
0.0.0.0 top.list.ru
0.0.0.0 top100-images.rambler.ru
0.0.0.0 top1site.3host.com
0.0.0.0 top5.mail.ru
0.0.0.0 topbestgames.com
0.0.0.0 topcashvibes.com
0.0.0.0 topconsumergifts.com
0.0.0.0 topdemaroc.com
0.0.0.0 tophirek.hu
0.0.0.0 toplist.cz
0.0.0.0 toplist.eu
0.0.0.0 toplist.throughput.de
0.0.0.0 topshape.me
0.0.0.0 toro-tags.com
0.0.0.0 toroadvertisingmedia.com
0.0.0.0 tororango.com
0.0.0.0 touch.media-serving.com
0.0.0.0 tour.cineble.com
0.0.0.0 tp2.beap.gemini.yahoo.com
0.0.0.0 tpads.ovguide.com
0.0.0.0 tpc.googlesyndication.com
0.0.0.0 tps.doubleverify.com
0.0.0.0 tps10216.doubleverify.com
0.0.0.0 tps20519.doubleverify.com
0.0.0.0 tps30.doubleverify.com
0.0.0.0 tps31.doubleverify.com
0.0.0.0 tpt.dotomi.com
0.0.0.0 tr.bigpoint.com
0.0.0.0 tr.outbrain.com
0.0.0.0 tr.wl.webads.nl
0.0.0.0 traaaack.com
0.0.0.0 trace.qq.com
0.0.0.0 track.adbooth.net
0.0.0.0 track.cam4tracking.com
0.0.0.0 track.e7r.com.br
0.0.0.0 track.omgpl.com
0.0.0.0 track.roularta.adhese.com
0.0.0.0 track.tooplay.com
0.0.0.0 track.vscash.com
0.0.0.0 tracker.awr.im
0.0.0.0 tracker.baidu.com
0.0.0.0 tracking.aatkit.com
0.0.0.0 tracking.craktraffic.com
0.0.0.0 tracking.edvisors.com
0.0.0.0 tracking.feedmob.com
0.0.0.0 tracking.internetstores.de
0.0.0.0 tracking.joker.com
0.0.0.0 tracking.keywordmax.com
0.0.0.0 tracking.scientific-meets.com
0.0.0.0 tracking.truthfinder.com
0.0.0.0 tracking.vcommission.com
0.0.0.0 tracking.veoxa.com
0.0.0.0 trackvoluum.com
0.0.0.0 tradearabia.advertserve.com
0.0.0.0 tradecore.tradehouse.media
0.0.0.0 tradelax.com
0.0.0.0 tradem.com
0.0.0.0 tradetracker.net
0.0.0.0 traffic.adxprts.com
0.0.0.0 traffic.adxprtz.com
0.0.0.0 traffic.focuusing.com
0.0.0.0 traffic.getmyads.com
0.0.0.0 traffic.outbrain.com
0.0.0.0 trafficbee.com
0.0.0.0 trafficnetworkads24.com
0.0.0.0 trafficrevenue.net
0.0.0.0 trafficsan.com
0.0.0.0 traffictraders.com
0.0.0.0 traffprofit.com
0.0.0.0 trafmag.com
0.0.0.0 trafsearchonline.com
0.0.0.0 traktum.com
0.0.0.0 transferwiser.io
0.0.0.0 transplugin.io
0.0.0.0 travelhub.com.sg
0.0.0.0 trc.taboola.com
0.0.0.0 trekmedia.net
0.0.0.0 trendingpatrol.com
0.0.0.0 trendnews.com
0.0.0.0 trends.revcontent.com
0.0.0.0 triangle.dealsaver.com
0.0.0.0 tridentenvironmental.co.uk
0.0.0.0 triplelift-match.dotomi.com
0.0.0.0 trk.ablogica.com
0.0.0.0 trk.etrigue.com
0.0.0.0 trk.vidible.tv
0.0.0.0 trourted.pro
0.0.0.0 trustaffs.com
0.0.0.0 trvlnet-images.adbureau.net
0.0.0.0 trvlnet.adbureau.net
0.0.0.0 tryanimalemale.com
0.0.0.0 ts-shimada.com
0.0.0.0 tsbm.ch
0.0.0.0 tsp2002.com
0.0.0.0 tste.startribune.com
0.0.0.0 tsyndicate.com
0.0.0.0 ttarget.adbureau.net
0.0.0.0 ttnet.yandex.com.tr
0.0.0.0 ttoc8ok.com
0.0.0.0 tudasfaja.com
0.0.0.0 tudaskor.com
0.0.0.0 tudathalo.blogspot.hu
0.0.0.0 tudatosanelok.com
0.0.0.0 tudnodkel.blogspot.com
0.0.0.0 tudnodkell.info
0.0.0.0 turn.com
0.0.0.0 turnerapac.d1.sc.omtrdc.net
0.0.0.0 tv2no.linkpulse.com
0.0.0.0 tvn.adocean.pl
0.0.0.0 tvn.hit.gemius.pl
0.0.0.0 tvshowsnow.tvmax.hop.clickbank.net
0.0.0.0 tw.adserver.yahoo.com
0.0.0.0 tw2.adserver.yahoo.com
0.0.0.0 twofish.freeuk.com
0.0.0.0 twoj-typ.pl
0.0.0.0 twoj-voucher.com
0.0.0.0 twoje-nagrody.com.pl
0.0.0.0 twoje-nagrody.pl
0.0.0.0 twojszczesliwydzien.com
0.0.0.0 tz284.com
0.0.0.0 u-ads.adap.tv
0.0.0.0 u.openx.net
0.0.0.0 u.videoamp.com
0.0.0.0 uac.advertising.com
0.0.0.0 uav.tidaltv.com
0.0.0.0 ubmcmm.baidustatic.com
0.0.0.0 ucstat.baidu.com
0.0.0.0 ud.adkmob.com
0.0.0.0 udarem.com
0.0.0.0 uedata.amazon.com
0.0.0.0 uelbdc74fn.s.ad6media.fr
0.0.0.0 ugo.eu-adcenter.net
0.0.0.0 ui.ppjol.com
0.0.0.0 ujvilagtudat.blogspot.hu
0.0.0.0 uk-ads.openx.net
0.0.0.0 uk.adserver.yahoo.com
0.0.0.0 uk.bitcoinfreedom-appl.t500track42.com
0.0.0.0 ukrashulya.ru
0.0.0.0 uktc.ijento.com
0.0.0.0 ultrasponsor.com
0.0.0.0 ulusalofis.com
0.0.0.0 um.simpli.fi
0.0.0.0 ums.adtechus.com
0.0.0.0 unclechunk.com
0.0.0.0 undertonenetworks.com
0.0.0.0 uniclick.openv.com
0.0.0.0 union.56.com
0.0.0.0 union.6.cn
0.0.0.0 union.baidu.com
0.0.0.0 unityads.unity.cn
0.0.0.0 unityads.unitychina.cn
0.0.0.0 unruly-match.dotomi.com
0.0.0.0 unser-en.de
0.0.0.0 unstat.baidu.com
0.0.0.0 uole.ad.uol.com.br
0.0.0.0 upbeatbut.com
0.0.0.0 upgrade-ms-home.com
0.0.0.0 upload.adtech.fr
0.0.0.0 upload.adtech.us
0.0.0.0 uproar.com
0.0.0.0 uproar.fortunecity.com
0.0.0.0 urban.adspirit.de
0.0.0.0 urc.taboolasyndication.com
0.0.0.0 us-ads.openx.net
0.0.0.0 us-microsoft-store.com
0.0.0.0 us-u.openx.net
0.0.0.0 us.adserver.yahoo.com
0.0.0.0 usadmm-ds.dotomi.com
0.0.0.0 usadmm.dotomi.com
0.0.0.0 usatoday.app.ur.gcion.com
0.0.0.0 usc.adserver.snapads.com
0.0.0.0 usemax.de
0.0.0.0 users.cuci.nl
0.0.0.0 users.tpg.com.au
0.0.0.0 usswrite.com
0.0.0.0 utarget.ru
0.0.0.0 utility.baidu.com
0.0.0.0 utils.media-general.com
0.0.0.0 utils.mediageneral.com
0.0.0.0 uvimage.56.com
0.0.0.0 v-support.free.bg
0.0.0.0 v1.browser-tools.systems
0.0.0.0 v1.viayonetici.com
0.0.0.0 v16.56.com
0.0.0.0 v2.adsbookie.com
0.0.0.0 v2.viayonetici.com
0.0.0.0 v2profit.com
0.0.0.0 v3.toolbar.soso.com
0.0.0.0 v3.viayonetici.com
0.0.0.0 v4.viayonetici.com
0.0.0.0 v5.viayonetici.com
0.0.0.0 v6.viayonetici.com
0.0.0.0 v7.viayonetici.com
0.0.0.0 vaitu.club
0.0.0.0 vakarek.info
0.0.0.0 valsgaard-kofod.dk
0.0.0.0 van.ads.link4ads.com
0.0.0.0 vanbenthem.org
0.0.0.0 vast.ssp.optimatic.com
0.0.0.0 vast.tubemogul.com
0.0.0.0 vast.vertamedia.com
0.0.0.0 vcdn.adnxs.com
0.0.0.0 vda.oipzyrzffum.ovh
0.0.0.0 vdbunt.net
0.0.0.0 ve1.claker.top
0.0.0.0 ve1.techgeetam.com
0.0.0.0 ve2.techgeetam.com
0.0.0.0 veirregnant.club
0.0.0.0 vendorlist.consensu.org
0.0.0.0 venetia.iad.appboy.com
0.0.0.0 vhowland.co.uk
0.0.0.0 vht.tradedoubler.com
0.0.0.0 viamichelin.cdn11.contentabc.com
0.0.0.0 viamichelin.media.trafficjunky.net
0.0.0.0 vibrantmedia.com
0.0.0.0 vice-ads-cdn.vice.com
0.0.0.0 victorlutte.cl
0.0.0.0 vidamsag.postr.hu
0.0.0.0 video-bazis.com
0.0.0.0 video.cynogage.com
0.0.0.0 video.entertaintastic.com
0.0.0.0 videobox.com
0.0.0.0 videocop.com
0.0.0.0 videoegg.adbureau.net
0.0.0.0 videogamerewardscentral.com
0.0.0.0 videomediagroep.nl
0.0.0.0 videos.fleshlight.com
0.0.0.0 videoslots.888.com
0.0.0.0 videovip.org
0.0.0.0 vidnline.com
0.0.0.0 vidroll.ru
0.0.0.0 view.atdmt.com
0.0.0.0 view.binlayer.com
0.0.0.0 view.jamba.de
0.0.0.0 views.m4n.nl
0.0.0.0 viglink.com
0.0.0.0 viglink.pgpartner.com
0.0.0.0 vilagfigyelo.com
0.0.0.0 vilaghelyzete.blogspot.com
0.0.0.0 vilagpolgarok.blogspot.hu
0.0.0.0 vilagunk.hu
0.0.0.0 villagarden.pl
0.0.0.0 vinkelvej12.dk
0.0.0.0 vip.adpiano.com
0.0.0.0 vipfastmoney.com
0.0.0.0 viralture.com
0.0.0.0 viralvideos.tips
0.0.0.0 vj.quanjingpay.com
0.0.0.0 vltwox7zl7h1wv.com
0.0.0.0 vmcsatellite.com
0.0.0.0 vmix.adbureau.net
0.0.0.0 vn.grab-credit4u.com
0.0.0.0 vnu.eu-adcenter.net
0.0.0.0 vnumedia02.webtrekk.net
0.0.0.0 vnumedia03.webtrekk.net
0.0.0.0 vnumedia04.webtrekk.net
0.0.0.0 vodafoneit.solution.weborama.fr
0.0.0.0 vodoustoichivshperplat.com
0.0.0.0 vodus-api-serverless.azurewebsites.net
0.0.0.0 vodus-api.azurewebsites.net
0.0.0.0 vodus.com
0.0.0.0 voduscdn.azureedge.net
0.0.0.0 volksaddiction.nl
0.0.0.0 voluumtracker.com
0.0.0.0 voluumtrk.com
0.0.0.0 voluumtrk2.com
0.0.0.0 voluumtrk3.com
0.0.0.0 voordeel.ad.nl
0.0.0.0 vpm.hu
0.0.0.0 vq91811.com
0.0.0.0 vu.veoxa.com
0.0.0.0 vz-cdn.trafficjunky.net
0.0.0.0 vzarabotke.ru
0.0.0.0 w-chat.xf.cz
0.0.0.0 w.ic.tynt.com
0.0.0.0 w.l.qq.com
0.0.0.0 w1.am15.net
0.0.0.0 w1.webcompteur.com
0.0.0.0 w10.centralmediaserver.com
0.0.0.0 w11.centralmediaserver.com
0.0.0.0 w2.am15.net
0.0.0.0 wa.and.co.uk
0.0.0.0 wac.2ddcc.alphacdn.net
0.0.0.0 wafmedia3.com
0.0.0.0 wahoha.com
0.0.0.0 wallflore.de
0.0.0.0 wangmeng.baidu.com
0.0.0.0 waoptions.com.au
0.0.0.0 wap.casee.cn
0.0.0.0 watch-this.live
0.0.0.0 waust.at
0.0.0.0 wayfarerspoutpraise.com
0.0.0.0 wd.adcolony.com
0.0.0.0 wdm29.com
0.0.0.0 we-are-gamers.com
0.0.0.0 weather.fixitpro.ro
0.0.0.0 web-bars.com
0.0.0.0 web.adblade.com
0.0.0.0 web.hb.ad.cpe.dotomi.com
0.0.0.0 web123.webhotelli.fi
0.0.0.0 web1b.netreflector.com
0.0.0.0 webads.bizservers.com
0.0.0.0 webads.nl
0.0.0.0 webcamsex.nl
0.0.0.0 webcompteur.com
0.0.0.0 webhosting-ads.home.pl
0.0.0.0 webkurchatov.ru
0.0.0.0 webmdcom.tt.omtrdc.net
0.0.0.0 webstats1.com
0.0.0.0 websurvey.spa-mr.com
0.0.0.0 webtj.net
0.0.0.0 webtrekk.net
0.0.0.0 webuysupplystore.mooo.com
0.0.0.0 webwise.bt.com
0.0.0.0 wedleaunocomp.work
0.0.0.0 wegetpaid.net
0.0.0.0 wegotmedia.co
0.0.0.0 welcome.faptitans.com
0.0.0.0 welcome.pussysaga.com
0.0.0.0 wellnessnaturopathic.com
0.0.0.0 werinussa.net
0.0.0.0 westbridges.net
0.0.0.0 wf.basebanner.com
0.0.0.0 wf.taboola.com
0.0.0.0 whatishotnow.net
0.0.0.0 whos.amung.us
0.0.0.0 widespace.com
0.0.0.0 widget.achetezfacile.com
0.0.0.0 widget.adcovery.com
0.0.0.0 widget3.linkwithin.com
0.0.0.0 widget5.linkwithin.com
0.0.0.0 widgets.amung.us
0.0.0.0 widgets.outbrain.com
0.0.0.0 widgets.tcimg.com
0.0.0.0 wigetmedia.com
0.0.0.0 wikiforosh.ir
0.0.0.0 williamhill.es
0.0.0.0 windowgolddealtheclicks.live
0.0.0.0 windows-afx-update.com
0.0.0.0 windows-cnd-update.com
0.0.0.0 windows-en-us-update.com
0.0.0.0 windows-fsd-update.com
0.0.0.0 windows-msd-update.com
0.0.0.0 windows-office365.com
0.0.0.0 windows-service-en.com
0.0.0.0 windows-several-update.com
0.0.0.0 windows-update-02-en.com
0.0.0.0 windows-wsus-update.com
0.0.0.0 winner-prize.com
0.0.0.0 wm.baidu.com
0.0.0.0 wmedia.adk2x.com
0.0.0.0 wms-eu.amazon-adsystem.com
0.0.0.0 wms-na.amazon-adsystem.com
0.0.0.0 wonderlandads.com
0.0.0.0 worden.samenresultaat.nl
0.0.0.0 work-offer.com
0.0.0.0 workaccount.free.bg
0.0.0.0 workdeadlinededicate.com
0.0.0.0 worldmedpilldeliver.com
0.0.0.0 worry-free-savings.com
0.0.0.0 wowanalytics.co.uk
0.0.0.0 wppluginspro.com
0.0.0.0 ws-na.amazon-adsystem.com
0.0.0.0 wtp101.com
0.0.0.0 ww1.flashx.net
0.0.0.0 ww12.audienceexposure.com
0.0.0.0 ww1510.smartadserver.com
0.0.0.0 ww251.smartadserver.com
0.0.0.0 ww690.smartadserver.com
0.0.0.0 ww7.audienceexposure.com
0.0.0.0 www-x-videos.com
0.0.0.0 www.0202.com.tw
0.0.0.0 www.1-1ads.com
0.0.0.0 www.1120.com.tw
0.0.0.0 www.1hkfq6598i.com
0.0.0.0 www.247realmedia.com
0.0.0.0 www.321cba.com
0.0.0.0 www.360ads.com
0.0.0.0 www.3qqq.net
0.0.0.0 www.3turtles.com
0.0.0.0 www.404errorpage.com
0.0.0.0 www.56.com
0.0.0.0 www.5thavenue.com
0.0.0.0 www.7500.com
0.0.0.0 www.7bpeople.com
0.0.0.0 www.805m.com
0.0.0.0 www.888.com
0.0.0.0 www.888casino.com
0.0.0.0 www.888poker.com
0.0.0.0 www.90offbags.com
0.0.0.0 www.961.com
0.0.0.0 www.aandgwright.plus.com
0.0.0.0 www.aarth.net
0.0.0.0 www.abc-tax.jp
0.0.0.0 www.actiondesk.com
0.0.0.0 www.ad-center.com
0.0.0.0 www.ad-souk.com
0.0.0.0 www.ad-up.com
0.0.0.0 www.ad-words.ru
0.0.0.0 www.ad6media.fr
0.0.0.0 www.adblockanalytics.com
0.0.0.0 www.adbrite.com
0.0.0.0 www.adcanadian.com
0.0.0.0 www.adcash.com
0.0.0.0 www.addthis.com
0.0.0.0 www.adengage.com
0.0.0.0 www.adexchangecloud.com
0.0.0.0 www.adfactor.nl
0.0.0.0 www.adfunkyserver.com
0.0.0.0 www.adfusion.com
0.0.0.0 www.adimages.beeb.com
0.0.0.0 www.adipics.com
0.0.0.0 www.adjmps.com
0.0.0.0 www.adjug.com
0.0.0.0 www.adloader.com
0.0.0.0 www.adlogix.com
0.0.0.0 www.admex.com
0.0.0.0 www.adnet.biz
0.0.0.0 www.adnet.com
0.0.0.0 www.adnet.de
0.0.0.0 www.adnetworkperformance.com
0.0.0.0 www.adnxs.com
0.0.0.0 www.adobee.com
0.0.0.0 www.adocean.pl
0.0.0.0 www.adotube.com
0.0.0.0 www.adpepper.dk
0.0.0.0 www.adpmbtj.com
0.0.0.0 www.adpowerzone.com
0.0.0.0 www.adquest3d.com
0.0.0.0 www.adreporting.com
0.0.0.0 www.adrianwaldock.plus.com
0.0.0.0 www.ads.revenue.net
0.0.0.0 www.ads2srv.com
0.0.0.0 www.adscience.nl
0.0.0.0 www.adsensecustomsearchads.com
0.0.0.0 www.adserver-espnet.sportszone.net
0.0.0.0 www.adserver.co.il
0.0.0.0 www.adserver.com
0.0.0.0 www.adserver.com.my
0.0.0.0 www.adserver.janes.net
0.0.0.0 www.adserver.janes.org
0.0.0.0 www.adserver.net
0.0.0.0 www.adserver.ugo.nl
0.0.0.0 www.adservtech.com
0.0.0.0 www.adsinimages.com
0.0.0.0 www.adskeeper.co.uk
0.0.0.0 www.adsoftware.com
0.0.0.0 www.adspics.com
0.0.0.0 www.adsrvr.org
0.0.0.0 www.adstogo.com
0.0.0.0 www.adsupplyads.com
0.0.0.0 www.adtechus.com
0.0.0.0 www.adtrader.com
0.0.0.0 www.adtrix.com
0.0.0.0 www.advaliant.com
0.0.0.0 www.advanpromo.com
0.0.0.0 www.advconversion.com
0.0.0.0 www.adverterenbijrtl.nl
0.0.0.0 www.adverterenbijsbs.nl
0.0.0.0 www.adverterenzeeland.nl
0.0.0.0 www.advertpro.com
0.0.0.0 www.adverts.dcthomson.co.uk
0.0.0.0 www.advertyz.com
0.0.0.0 www.adview.cn
0.0.0.0 www.adzerk.net
0.0.0.0 www.aero-source.net
0.0.0.0 www.afcyhf.com
0.0.0.0 www.affiliate-fr.com
0.0.0.0 www.affiliateclick.com
0.0.0.0 www.affiliation-france.com
0.0.0.0 www.afform.co.uk
0.0.0.0 www.affpartners.com
0.0.0.0 www.afterdownload.com
0.0.0.0 www.agkn.com
0.0.0.0 www.agt.net
0.0.0.0 www.airfrance.life
0.0.0.0 www.ajalis.com
0.0.0.0 www.akiko.f9.co.uk
0.0.0.0 www.alexrc.plus.com
0.0.0.0 www.algocashmaster.com
0.0.0.0 www.allosponsor.com
0.0.0.0 www.amazing-opportunities.info
0.0.0.0 www.andyhawk.free-online.co.uk
0.0.0.0 www.andymurray.plus.com
0.0.0.0 www.annuaire-autosurf.com
0.0.0.0 www.anrdoezrs.net
0.0.0.0 www.api.taboola.com
0.0.0.0 www.apogara.plus.com
0.0.0.0 www.applelounge.com
0.0.0.0 www.applicationwiki.com
0.0.0.0 www.appliedsemantics.com
0.0.0.0 www.appnexus.com
0.0.0.0 www.aptracking1.com
0.0.0.0 www.area043.com
0.0.0.0 www.art-offer.com
0.0.0.0 www.atpanel.com
0.0.0.0 www.audienceexposure.com
0.0.0.0 www.aureate.com
0.0.0.0 www.autohipnose.com
0.0.0.0 www.automotive-offer.com
0.0.0.0 www.avenues-inc.com
0.0.0.0 www.avsads.com
0.0.0.0 www.awltovhc.com
0.0.0.0 www.baba-t.com
0.0.0.0 www.balnakiel.plus.com
0.0.0.0 www.bannerads.de
0.0.0.0 www.bannerbackup.com
0.0.0.0 www.bannerconnect.net
0.0.0.0 www.bannersurvey.biz
0.0.0.0 www.banstex.com
0.0.0.0 www.bbelements.com
0.0.0.0 www.benhamlyn.plus.com
0.0.0.0 www.best-iphone6s.com
0.0.0.0 www.bicoinsprofit.com
0.0.0.0 www.bidtraffic.com
0.0.0.0 www.bidvertiser.com
0.0.0.0 www.bigbangempire.com
0.0.0.0 www.bigbrandpromotions.com
0.0.0.0 www.bigbrandrewards.com
0.0.0.0 www.biggestgiftrewards.com
0.0.0.0 www.billcarthy.f9.co.uk
0.0.0.0 www.binarysystem4u.com
0.0.0.0 www.bitcoadz.io
0.0.0.0 www.bitmedia.io
0.0.0.0 www.bitraffic.com
0.0.0.0 www.biz-offer.com
0.0.0.0 www.bizographics.com
0.0.0.0 www.bjhdrx.com
0.0.0.0 www.blockadsnot.com
0.0.0.0 www.blockchaintop.nl
0.0.0.0 www.blossomtel.com
0.0.0.0 www.bluecrabhosting.co.uk
0.0.0.0 www.bluediamondoffers.com
0.0.0.0 www.bnnr.nl
0.0.0.0 www.bodog.eu
0.0.0.0 www.boonsolutions.com
0.0.0.0 www.bostonwall.com
0.0.0.0 www.bovadapromotions.lv
0.0.0.0 www.brandsurveypanel.com
0.0.0.0 www.bretby.plus.com
0.0.0.0 www.brightonclick.com
0.0.0.0 www.bryantaylor.free-online.co.uk
0.0.0.0 www.btalbot.plus.com
0.0.0.0 www.btvm.ne.jp
0.0.0.0 www.budsinc.com
0.0.0.0 www.bulkclicks.com
0.0.0.0 www.bulletads.com
0.0.0.0 www.burstnet.com
0.0.0.0 www.bus-offer.com
0.0.0.0 www.buttcandy.com
0.0.0.0 www.buycheapadvertising.com
0.0.0.0 www.buyhitscheap.com
0.0.0.0 www.buzzadnetwork.com
0.0.0.0 www.buzzonclick.com
0.0.0.0 www.c2.taboola.com
0.0.0.0 www.cadvision.com
0.0.0.0 www.cafecoquin.com
0.0.0.0 www.cam4.fr
0.0.0.0 www.camion.idps.co.uk
0.0.0.0 www.canuckmethods.com
0.0.0.0 www.capath.com
0.0.0.0 www.capturedcovers.com
0.0.0.0 www.carnegienet.net
0.0.0.0 www.cashback.co.uk
0.0.0.0 www.cashbackwow.co.uk
0.0.0.0 www.cashcapitalsystem.com
0.0.0.0 www.cashcount.com
0.0.0.0 www.casino770.com
0.0.0.0 www.cati.com.tw
0.0.0.0 www.cdn.taboola.com
0.0.0.0 www.cdn4ads.com
0.0.0.0 www.cellphoneincentives.com
0.0.0.0 www.chartbeat.com
0.0.0.0 www.chartercare.plus.com
0.0.0.0 www.chienhung.url.tw
0.0.0.0 www.chiyih.com
0.0.0.0 www.choicedealz.com
0.0.0.0 www.choicesurveypanel.com
0.0.0.0 www.christianbusinessadvertising.com
0.0.0.0 www.claimfreerewards.com
0.0.0.0 www.clevernt.com
0.0.0.0 www.click10.com
0.0.0.0 www.click4click.com
0.0.0.0 www.clickbank.com
0.0.0.0 www.clickdensity.com
0.0.0.0 www.clicksgear.com
0.0.0.0 www.clicksor.com
0.0.0.0 www.clicktale.com
0.0.0.0 www.clicktale.net
0.0.0.0 www.clickthruserver.com
0.0.0.0 www.clickthrutraffic.com
0.0.0.0 www.clicktilluwin.com
0.0.0.0 www.clickxchange.com
0.0.0.0 www.cliftons.plus.com
0.0.0.0 www.coin-ad.com
0.0.0.0 www.coinad.com
0.0.0.0 www.coinzilla.io
0.0.0.0 www.computer-offer.com
0.0.0.0 www.computersncs.com
0.0.0.0 www.contaxe.com
0.0.0.0 www.contextuads.com
0.0.0.0 www.contextweb.com
0.0.0.0 www.conversantmedia.com
0.0.0.0 www.cookingtiprewards.com
0.0.0.0 www.coolconcepts.nl
0.0.0.0 www.coreglead.co.uk
0.0.0.0 www.cosmeticscentre.uk.com
0.0.0.0 www.cotc.net
0.0.0.0 www.courtneywalker.plus.com
0.0.0.0 www.cpabank.com
0.0.0.0 www.cpmadvisors.com
0.0.0.0 www.crazypopups.com
0.0.0.0 www.crazywinnings.com
0.0.0.0 www.crispads.com
0.0.0.0 www.crowdgravity.com
0.0.0.0 www.crowdignite.com
0.0.0.0 www.cryptocoinsad.com
0.0.0.0 www.crystaltao.art
0.0.0.0 www.csalikft.hu
0.0.0.0 www.ctaz.com
0.0.0.0 www.ctbdev.net
0.0.0.0 www.cuci.nl
0.0.0.0 www.cyberfaery.com
0.0.0.0 www.da-ads.com
0.0.0.0 www.dalesnewzealand.co.nz
0.0.0.0 www.danair.es
0.0.0.0 www.datatech.es
0.0.0.0 www.datingadvertising.com
0.0.0.0 www.datoben.waw.pl
0.0.0.0 www.davion.plus.com
0.0.0.0 www.debbo.plus.com
0.0.0.0 www.deelen-wageningen.nl
0.0.0.0 www.defaultinternet.com
0.0.0.0 www.delton.com
0.0.0.0 www.derekrjones.plus.com
0.0.0.0 www.designbloxlive.com
0.0.0.0 www.destinationurl.com
0.0.0.0 www.devenney.plus.com
0.0.0.0 www.devis-abri-de-piscine.fr
0.0.0.0 www.devon38.plus.com
0.0.0.0 www.dgmaustralia.com
0.0.0.0 www.diaita.ch
0.0.0.0 www.digimedia.com
0.0.0.0 www.directnetadvertising.net
0.0.0.0 www.dirtyrhino.com
0.0.0.0 www.djugoogs.com
0.0.0.0 www.dragonawaken.com
0.0.0.0 www.drowle.com
0.0.0.0 www.dt1blog.com
0.0.0.0 www.dunlop.force9.co.uk
0.0.0.0 www.dutchsales.org
0.0.0.0 www.e-bannerx.com
0.0.0.0 www.eastwood35.idps.co.uk
0.0.0.0 www.easy2date.net
0.0.0.0 www.easyadservice.com
0.0.0.0 www.ebayadservices.com
0.0.0.0 www.ebayadvertising.com
0.0.0.0 www.ebaybanner.com
0.0.0.0 www.ecoledessciences.com
0.0.0.0 www.edv-waldherr.at
0.0.0.0 www.emadesign.net
0.0.0.0 www.emarketmakers.com
0.0.0.0 www.entertainment-specials.com
0.0.0.0 www.eshopads2.com
0.0.0.0 www.euros4click.de
0.0.0.0 www.eva.hi-ho.ne.jp
0.0.0.0 www.everestgroupcorp.com
0.0.0.0 www.everifymatch.com
0.0.0.0 www.exclusivegiftcards.com
0.0.0.0 www.expoteam.net
0.0.0.0 www.eyewonder.com
0.0.0.0 www.ezl.com
0.0.0.0 www.ezlink.ca
0.0.0.0 www.fast-adv.it
0.0.0.0 www.fatcatrewards.com
0.0.0.0 www.feedstermedia.com
0.0.0.0 www.finance-offer.com
0.0.0.0 www.fineclicks.com
0.0.0.0 www.firemouth.plus.com
0.0.0.0 www.firered.plus.com
0.0.0.0 www.flagcounter.com
0.0.0.0 www.flexibletool.com
0.0.0.0 www.flowerdevon.idps.co.uk
0.0.0.0 www.flu23.com
0.0.0.0 www.focalex.com
0.0.0.0 www.folloyu.com
0.0.0.0 www.food-offer.com
0.0.0.0 www.ford7.plus.com
0.0.0.0 www.formosahappiness.org
0.0.0.0 www.fpctraffic2.com
0.0.0.0 www.fra19.plus.com
0.0.0.0 www.framar.plus.com
0.0.0.0 www.freeadguru.com
0.0.0.0 www.freebiegb.co.uk
0.0.0.0 www.freecamerasource.com
0.0.0.0 www.freecamsecrets.com
0.0.0.0 www.freecamsexposed.com
0.0.0.0 www.freedvddept.com
0.0.0.0 www.freefoodsource.com
0.0.0.0 www.freefuelcard.com
0.0.0.0 www.freefuelcoupon.com
0.0.0.0 www.freeipoduk.co.uk
0.0.0.0 www.freelaptopreward.com
0.0.0.0 www.freenation.com
0.0.0.0 www.freeplasmanation.com
0.0.0.0 www.freespinwinner.win
0.0.0.0 www.freo-stats.nl
0.0.0.0 www.friendlyduck.com
0.0.0.0 www.frontpagecash.com
0.0.0.0 www.ftjcfx.com
0.0.0.0 www.funkydoowop.plus.com
0.0.0.0 www.fusionbanners.com
0.0.0.0 www.garethwalker.plus.com
0.0.0.0 www.gatesofhell.plus.com
0.0.0.0 www.gatoradvertisinginformationnetwork.com
0.0.0.0 www.gbinnie.plus.com
0.0.0.0 www.georgewatson.plus.com
0.0.0.0 www.get-express-vpn.com
0.0.0.0 www.getagiftonline.com
0.0.0.0 www.getlink.pw
0.0.0.0 www.getloan.com
0.0.0.0 www.getmyads24.com
0.0.0.0 www.getmyfreegiftcard.com
0.0.0.0 www.getspecialgifts.com
0.0.0.0 www.giftcardchallenge.com
0.0.0.0 www.giftcardsurveys.us.com
0.0.0.0 www.gigdnetwork.com
0.0.0.0 www.gm4pgv.plus.com
0.0.0.0 www.gmads.net
0.0.0.0 www.googleadservices.com
0.0.0.0 www.grabbit-rabbit.com
0.0.0.0 www.greasypalm.com
0.0.0.0 www.greatdexchange.com
0.0.0.0 www.greencentral.plus.com
0.0.0.0 www.groupm.com
0.0.0.0 www.grtexch.com
0.0.0.0 www.guesstheview.com
0.0.0.0 www.hansvanderwerf.nl
0.0.0.0 www.healthbeautyncs.com
0.0.0.0 www.hebdotop.com
0.0.0.0 www.heusmarketing.nl
0.0.0.0 www.hibids10.com
0.0.0.0 www.hieroglyph.freeuk.com
0.0.0.0 www.highleycoupons.com
0.0.0.0 www.hightrafficads.com
0.0.0.0 www.hiroden-con.jp
0.0.0.0 www.histats.com
0.0.0.0 www.hooqy.com
0.0.0.0 www.hotchatdate.com
0.0.0.0 www.hotgiftzone.com
0.0.0.0 www.hotkeys.com
0.0.0.0 www.i-younet.ne.jp
0.0.0.0 www.idealcasino.net
0.0.0.0 www.idirect.com
0.0.0.0 www.ifileyou.com
0.0.0.0 www.iicdn.com
0.0.0.0 www.ili.net
0.0.0.0 www.ilovecheating.com
0.0.0.0 www.ilovemobi.com
0.0.0.0 www.images.taboola.com
0.0.0.0 www.imcounting.com
0.0.0.0 www.incentivegateway.com
0.0.0.0 www.indiads.com
0.0.0.0 www.infinite-ads.com
0.0.0.0 www.inflationbreedinghoax.com
0.0.0.0 www.intela.com
0.0.0.0 www.interstitialzone.com
0.0.0.0 www.invitefashion.com
0.0.0.0 www.inyes.com.tw
0.0.0.0 www.iqoption.com
0.0.0.0 www.is1.clixgalore.com
0.0.0.0 www.isfilebest.com
0.0.0.0 www.isistech.com.tw
0.0.0.0 www.istats.nl
0.0.0.0 www.itrackerpro.com
0.0.0.0 www.itsfree123.com
0.0.0.0 www.izmsj.co.jp
0.0.0.0 www.izu.co.jp
0.0.0.0 www.jetseeker.com
0.0.0.0 www.jivox.com
0.0.0.0 www.jolic2.com
0.0.0.0 www.jrhayley.plus.com
0.0.0.0 www.jxliu.com
0.0.0.0 www.k-macs.ne.jp
0.0.0.0 www.katch.ne.jp
0.0.0.0 www.kenkudo.plus.com
0.0.0.0 www.keywordblocks.com
0.0.0.0 www.kitaramarketplace.com
0.0.0.0 www.kitaramedia.com
0.0.0.0 www.kixer.com
0.0.0.0 www.kliksaya.com
0.0.0.0 www.knell.plus.com
0.0.0.0 www.kolks.nl
0.0.0.0 www.konimkan.com
0.0.0.0 www.kontera.com
0.0.0.0 www.konversation.com
0.0.0.0 www.kreaffiliation.com
0.0.0.0 www.kuhdi.com
0.0.0.0 www.ladyclicks.ru
0.0.0.0 www.laptopreportcard.com
0.0.0.0 www.laptoprewards.com
0.0.0.0 www.laptoprewardsgroup.com
0.0.0.0 www.laptoprewardszone.com
0.0.0.0 www.larivieracasino.com
0.0.0.0 www.lduhtrp.net
0.0.0.0 www.le1er.net
0.0.0.0 www.leadgreed.com
0.0.0.0 www.leklicht.net
0.0.0.0 www.lincolnshirefitness.co.uk
0.0.0.0 www.linkhut.com
0.0.0.0 www.linkpulse.com
0.0.0.0 www.linkredirect.biz
0.0.0.0 www.linkwithin.com
0.0.0.0 www.liveadexchanger.com
0.0.0.0 www.loboclick.com
0.0.0.0 www.lottoforever.com
0.0.0.0 www.lpcloudsvr302.com
0.0.0.0 www.lpmxp2017.com
0.0.0.0 www.lpmxp2024.com
0.0.0.0 www.lucky-day-uk.com
0.0.0.0 www.lysabarnard.plus.com
0.0.0.0 www.m2trk.com
0.0.0.0 www.ma-kaeser.ch
0.0.0.0 www.maaxmarket.com
0.0.0.0 www.macatawa.org
0.0.0.0 www.market-buster.com
0.0.0.0 www.marketrip.co
0.0.0.0 www.maxbounty.com
0.0.0.0 www.maxonclick.com
0.0.0.0 www.mb01.com
0.0.0.0 www.mb102.com
0.0.0.0 www.medhiartis.com
0.0.0.0 www.media-motor.com
0.0.0.0 www.media2.travelzoo.com
0.0.0.0 www.medical-offer.com
0.0.0.0 www.megawealthbiz.com
0.0.0.0 www.mellowads.com
0.0.0.0 www.merijntjeaanderijn.nl
0.0.0.0 www.merlin.co.il
0.0.0.0 www.mgid.com
0.0.0.0 www.mightymagoo.com
0.0.0.0 www.mikaeljigmo.com
0.0.0.0 www.miqsoft.hu
0.0.0.0 www.miyazaki-catv.ne.jp
0.0.0.0 www.mjonkers.nl
0.0.0.0 www.mlntracker.com
0.0.0.0 www.mochibot.com
0.0.0.0 www.monetizemore.com
0.0.0.0 www.morefreecamsecrets.com
0.0.0.0 www.morevisits.info
0.0.0.0 www.mpression.net
0.0.0.0 www.mr-mondial.com
0.0.0.0 www.mrazens.com
0.0.0.0 www.ms247.plus.com
0.0.0.0 www.my-rewardsvault.com
0.0.0.0 www.my-stats.com
0.0.0.0 www.myadsl.co.za
0.0.0.0 www.myaffiliateprogram.com
0.0.0.0 www.mycashback.co.uk
0.0.0.0 www.mychoicerewards.com
0.0.0.0 www.myexclusiverewards.com
0.0.0.0 www.myfreedinner.com
0.0.0.0 www.myfreegifts.co.uk
0.0.0.0 www.myfreemp3player.com
0.0.0.0 www.mygreatrewards.com
0.0.0.0 www.myseostats.com
0.0.0.0 www.myuitm.com
0.0.0.0 www.myusersonline.com
0.0.0.0 www.na47.com
0.0.0.0 www.nas-k.co.jp
0.0.0.0 www.nationalissuepanel.com
0.0.0.0 www.nationalsurveypanel.com
0.0.0.0 www.nctracking.com
0.0.0.0 www.ndbsoft.be
0.0.0.0 www.nearbyad.com
0.0.0.0 www.nebulus30.plus.com
0.0.0.0 www.needadvertising.com
0.0.0.0 www.neptuneads.com
0.0.0.0 www.neszmely.eu
0.0.0.0 www.newmedia.plus.com
0.0.0.0 www.newnorth.net
0.0.0.0 www.news6health.com
0.0.0.0 www.newtrees.plus.com
0.0.0.0 www.nextlnk7.com
0.0.0.0 www.nospartenaires.com
0.0.0.0 www.novelsys.co
0.0.0.0 www.nozawashoten.com
0.0.0.0 www.nutaku.com
0.0.0.0 www.odyssey.on.ca
0.0.0.0 www.offerx.co.uk
0.0.0.0 www.olioeroli.it
0.0.0.0 www.onclickpredictiv.com
0.0.0.0 www.onclicktop.com
0.0.0.0 www.ontheweb.com
0.0.0.0 www.opendownload.de
0.0.0.0 www.openload.de
0.0.0.0 www.optad360.com
0.0.0.0 www.outbrain.com
0.0.0.0 www.ozonatory24.pl
0.0.0.0 www.paperg.com
0.0.0.0 www.parsads.com
0.0.0.0 www.partycasino.com
0.0.0.0 www.pathforpoints.com
0.0.0.0 www.paypopup.com
0.0.0.0 www.peachy18.com
0.0.0.0 www.pedigree1.plus.com
0.0.0.0 www.perfectgirls.net
0.0.0.0 www.performanceonclick.com
0.0.0.0 www.persgroepadvertising.nl
0.0.0.0 www.perso.ch
0.0.0.0 www.peteralexander.plus.com
0.0.0.0 www.peterfishwick.free-online.co.uk
0.0.0.0 www.pfhsystem.com
0.0.0.0 www.phoenixads.co.in
0.0.0.0 www.phorm.com
0.0.0.0 www.pitakchon.com
0.0.0.0 www.placelocal.com
0.0.0.0 www.planet.eon.net
0.0.0.0 www.plasmatv4free.com
0.0.0.0 www.politicalopinionsurvey.com
0.0.0.0 www.pomp-buerotechnik.de
0.0.0.0 www.poponclick.com
0.0.0.0 www.popup.taboola.com
0.0.0.0 www.popupad.net
0.0.0.0 www.popupdomination.com
0.0.0.0 www.popuptraffic.com
0.0.0.0 www.postmasterbannernet.com
0.0.0.0 www.postmasterdirect.com
0.0.0.0 www.postnewsads.com
0.0.0.0 www.praktijkmariekehuisman.nl
0.0.0.0 www.predictivadnetwork.com
0.0.0.0 www.premiumproductsonline.com
0.0.0.0 www.prizes.co.uk
0.0.0.0 www.pro-partners.nl
0.0.0.0 www.probabilidades.net
0.0.0.0 www.probusinesshub.com
0.0.0.0 www.productresearchpanel.com
0.0.0.0 www.producttestpanel.com
0.0.0.0 www.projectwonderful.com
0.0.0.0 www.prtc.net
0.0.0.0 www.psclicks.com
0.0.0.0 www.pubdirecte.com
0.0.0.0 www.pureadexchange.com
0.0.0.0 www.qcoldtui1999.com
0.0.0.0 www.quickbrowsersearch.com
0.0.0.0 www.radiate.com
0.0.0.0 www.rankyou.com
0.0.0.0 www.redactiepartners.nl
0.0.0.0 www.regflow.com
0.0.0.0 www.registrarads.com
0.0.0.0 www.reklam3.net
0.0.0.0 www.resolvingserver.com
0.0.0.0 www.reusenproject-n.nl
0.0.0.0 www.rewardsflow.com
0.0.0.0 www.ringtonepartner.com
0.0.0.0 www.riskybus.f9.co.uk
0.0.0.0 www.ritikhush.com
0.0.0.0 www.robm674.plus.com
0.0.0.0 www.romepartners.com
0.0.0.0 www.roulettebotplus.com
0.0.0.0 www.rpepin.plus.com
0.0.0.0 www.rtcode.com
0.0.0.0 www.rubyfortune.com
0.0.0.0 www.ryosuke.plus.com
0.0.0.0 www.sa44.net
0.0.0.0 www.sagent.io
0.0.0.0 www.sarge05.plus.com
0.0.0.0 www.savings-time.com
0.0.0.0 www.sayfabulunamadi.com
0.0.0.0 www.schemml.de
0.0.0.0 www.scottofyork.plus.com
0.0.0.0 www.screen-mates.com
0.0.0.0 www.searchingzone.com
0.0.0.0 www.searchwe.com
0.0.0.0 www.securerunner.com
0.0.0.0 www.servedby-buysellads.com
0.0.0.0 www.servitemequipos.cl
0.0.0.0 www.seward.net
0.0.0.0 www.sexadvertentiesite.nl
0.0.0.0 www.sexpartnerx.com
0.0.0.0 www.sexsponsors.com
0.0.0.0 www.sgtwilko.f9.co.uk
0.0.0.0 www.share-server.com
0.0.0.0 www.shareasale.com
0.0.0.0 www.shaunfennings.plus.com
0.0.0.0 www.shichihukuudon.com
0.0.0.0 www.shopperpromotions.com
0.0.0.0 www.shopping-offer.com
0.0.0.0 www.shoppingjobshere.com
0.0.0.0 www.shoppingminds.net
0.0.0.0 www.shorthouse.com
0.0.0.0 www.silcom.com
0.0.0.0 www.simpli.fi
0.0.0.0 www.skegness.net
0.0.0.0 www.skvarsani.plus.com
0.0.0.0 www.sky-net.or.jp
0.0.0.0 www.skywin.com.tw
0.0.0.0 www.smailes.plus.com
0.0.0.0 www.smart-scripts.com
0.0.0.0 www.smartadserver.com
0.0.0.0 www.smarttopchain.nl
0.0.0.0 www.smichovbike.cz
0.0.0.0 www.smokersopinionpoll.com
0.0.0.0 www.smspop.com
0.0.0.0 www.sochr.com
0.0.0.0 www.sociallypublish.com
0.0.0.0 www.speedboink.com
0.0.0.0 www.speedyclick.com
0.0.0.0 www.spinbox.com
0.0.0.0 www.spinia.com
0.0.0.0 www.sponsorads.de
0.0.0.0 www.sponsoradulto.com
0.0.0.0 www.sq2trk2.com
0.0.0.0 www.ssquire.plus.com
0.0.0.0 www.star-advertising.com
0.0.0.0 www.startnewtab.com
0.0.0.0 www.studiomugnaini.eu
0.0.0.0 www.subsitesadserver.co.uk
0.0.0.0 www.sudokuwhiz.com
0.0.0.0 www.sun-inet.or.jp
0.0.0.0 www.superbrewards.com
0.0.0.0 www.superinterstitial.com
0.0.0.0 www.surplus-suppliers.com
0.0.0.0 www.sweetsforfree.com
0.0.0.0 www.syncaccess.net
0.0.0.0 www.system-live-media.cz
0.0.0.0 www.taboola.com
0.0.0.0 www.tao123.com
0.0.0.0 www.tbitcoin.me
0.0.0.0 www.teltech.hu
0.0.0.0 www.telusplanet.net
0.0.0.0 www.terraclicks.com
0.0.0.0 www.text-link-ads.com
0.0.0.0 www.textbanners.net
0.0.0.0 www.textsrv.com
0.0.0.0 www.tgpmanager.com
0.0.0.0 www.thatrendsystem.com
0.0.0.0 www.thepringlefamily.plus.com
0.0.0.0 www.thetraderinpajamas.com
0.0.0.0 www.theuseful.com
0.0.0.0 www.theuseful.net
0.0.0.0 www.thewaycloud.com
0.0.0.0 www.thinktarget.com
0.0.0.0 www.thruport.com
0.0.0.0 www.tlauder.f9.co.uk
0.0.0.0 www.top-free-casino-games.com
0.0.0.0 www.top20free.com
0.0.0.0 www.topcashvibes.com
0.0.0.0 www.topconsumergifts.com
0.0.0.0 www.topdemaroc.com
0.0.0.0 www.topreward.site
0.0.0.0 www.topsecretmagic.co.uk
0.0.0.0 www.topworld.nl
0.0.0.0 www.tqlkg.com
0.0.0.0 www.track2cash.com
0.0.0.0 www.tracklead.net
0.0.0.0 www.tradeadexchange.com
0.0.0.0 www.tradelax.com
0.0.0.0 www.tradem.com
0.0.0.0 www.trafficnetworkads24.com
0.0.0.0 www.trafficrevenue.net
0.0.0.0 www.traffictrader.net
0.0.0.0 www.traffictraders.com
0.0.0.0 www.trafsearchonline.com
0.0.0.0 www.traktrafficflow.com
0.0.0.0 www.tranzit124.cz
0.0.0.0 www.traveladvertising.com
0.0.0.0 www.trc.taboola.com
0.0.0.0 www.treeloot.com
0.0.0.0 www.trendnews.com
0.0.0.0 www.trendsonline.biz
0.0.0.0 www.trourted.pro
0.0.0.0 www.truentertainment.net
0.0.0.0 www.ts-shimada.com
0.0.0.0 www.ttnet.yandex.com.tr
0.0.0.0 www.ttoc8ok.com
0.0.0.0 www.turn.com
0.0.0.0 www.tutka.net
0.0.0.0 www.tutop.com
0.0.0.0 www.twofish.freeuk.com
0.0.0.0 www.u1trkqf.com
0.0.0.0 www.ukbanners.com
0.0.0.0 www.uproar.com
0.0.0.0 www.urdoot.win
0.0.0.0 www.usemax.de
0.0.0.0 www.user-shield.com
0.0.0.0 www.users.dialstart.net
0.0.0.0 www.users.freenetname.co.uk
0.0.0.0 www.utarget.co.uk
0.0.0.0 www.valueclick.com
0.0.0.0 www.vandenberghider.plus.com
0.0.0.0 www.vanguard-art.com
0.0.0.0 www.veritaspartners.co.jp
0.0.0.0 www.vibrantmedia.com
0.0.0.0 www.victorlutte.cl
0.0.0.0 www.victory1999.com
0.0.0.0 www.videoconverterhd.com
0.0.0.0 www.videogamerewardscentral.com
0.0.0.0 www.videomediagroep.nl
0.0.0.0 www.view4cash.de
0.0.0.0 www.vilaglato.info
0.0.0.0 www.virtumundo.com
0.0.0.0 www.visualwebsiteoptimizer.com
0.0.0.0 www.vmcsatellite.com
0.0.0.0 www.wctc.net
0.0.0.0 www.wdm29.com
0.0.0.0 www.webcompteur.com
0.0.0.0 www.websitepromoten.be
0.0.0.0 www.websponsors.com
0.0.0.0 www.webtj.net
0.0.0.0 www.webtrekk.net
0.0.0.0 www.wegetpaid.net
0.0.0.0 www.wessexgrange.plus.com
0.0.0.0 www.westreclameadvies.nl
0.0.0.0 www.whalecashads.com
0.0.0.0 www.widespace.com
0.0.0.0 www.widgetbucks.com
0.0.0.0 www.wigetmedia.com
0.0.0.0 www.williamhill.es
0.0.0.0 www.windaily.com
0.0.0.0 www.wondertravelegypt.com
0.0.0.0 www.work-offer.com
0.0.0.0 www.worry-free-savings.com
0.0.0.0 www.wppluginspro.com
0.0.0.0 www.wu4652.com.tw
0.0.0.0 www.wwt-ag.ch
0.0.0.0 www.xadsmart.com
0.0.0.0 www.xaxis.com
0.0.0.0 www.xbn.ru
0.0.0.0 www.xn--turkishirlines-1p8g.com
0.0.0.0 www.yceml.net
0.0.0.0 www.yieldmanager.net
0.0.0.0 www.yieldpartners.com
0.0.0.0 www.youfck.com
0.0.0.0 www.your-gift-zone.com
0.0.0.0 www.yourgascards.com
0.0.0.0 www.yourgiftrewards.com
0.0.0.0 www.yourgiftzone.com
0.0.0.0 www.youripad4free.com
0.0.0.0 www.yourrewardzone.com
0.0.0.0 www.yoursmartrewards.com
0.0.0.0 www.yuzuni.com
0.0.0.0 www.ywmc.com.tw
0.0.0.0 www.zabavazaodrasle.com
0.0.0.0 www.zbippirad.info
0.0.0.0 www.zemgo.com
0.0.0.0 www.zevents.com
0.0.0.0 www.zytpirwai.net
0.0.0.0 www1.amigo2.ne.jp
0.0.0.0 www1.bannerspace.com
0.0.0.0 www1.belboon.de
0.0.0.0 www1.mpnrs.com
0.0.0.0 www1.xmediaserve.com
0.0.0.0 www1.zapadserver1.com
0.0.0.0 www10.glam.com
0.0.0.0 www10.indiads.com
0.0.0.0 www10.paypopup.com
0.0.0.0 www12.glam.com
0.0.0.0 www123.glam.com
0.0.0.0 www13.glam.com
0.0.0.0 www14.smartadserver.com
0.0.0.0 www17.glam.com
0.0.0.0 www18.glam.com
0.0.0.0 www2.ad-server.online
0.0.0.0 www2.adserverpub.com
0.0.0.0 www2.bannerspace.com
0.0.0.0 www2.glam.com
0.0.0.0 www2.gorillavid.in
0.0.0.0 www2.pubdirecte.com
0.0.0.0 www2.tpgi.com.au
0.0.0.0 www2.wyylde.com
0.0.0.0 www2.zapadserver1.com
0.0.0.0 www210.paypopup.com
0.0.0.0 www211.paypopup.com
0.0.0.0 www212.paypopup.com
0.0.0.0 www213.paypopup.com
0.0.0.0 www24.glam.com
0.0.0.0 www24a.glam.com
0.0.0.0 www25.glam.com
0.0.0.0 www25a.glam.com
0.0.0.0 www3.addthis.com
0.0.0.0 www3.bannerspace.com
0.0.0.0 www3.game-advertising-online.com
0.0.0.0 www3.haberturk.com
0.0.0.0 www3.smartadserver.com
0.0.0.0 www3.telus.net
0.0.0.0 www3.webhostingtalk.com
0.0.0.0 www30.glam.com
0.0.0.0 www30a1-orig.glam.com
0.0.0.0 www30a1.glam.com
0.0.0.0 www30a2-orig.glam.com
0.0.0.0 www30a3-orig.glam.com
0.0.0.0 www30a3.glam.com
0.0.0.0 www30a7.glam.com
0.0.0.0 www30l2.glam.com
0.0.0.0 www30t1-orig.glam.com
0.0.0.0 www35f.glam.com
0.0.0.0 www35jm.glam.com
0.0.0.0 www35t.glam.com
0.0.0.0 www4.bannerspace.com
0.0.0.0 www4.glam.com
0.0.0.0 www4.smartadserver.com
0.0.0.0 www4176uc.sakura.ne.jp
0.0.0.0 www5.bannerspace.com
0.0.0.0 www5.zoosi.club
0.0.0.0 www6.bannerspace.com
0.0.0.0 www7.bannerspace.com
0.0.0.0 www8.bannerspace.com
0.0.0.0 www9.paypopup.com
0.0.0.0 www9.smartadserver.com
0.0.0.0 wwwroot.forent.sk
0.0.0.0 wytypowany-zwyciezca.com
0.0.0.0 wytypowany-zwyciezca.pl
0.0.0.0 x-album.com
0.0.0.0 x-album.net
0.0.0.0 x-albums.net
0.0.0.0 x-image.net
0.0.0.0 x-images.com
0.0.0.0 x-images.net
0.0.0.0 x-photobucket.top
0.0.0.0 x-photos.net
0.0.0.0 x-picture.net
0.0.0.0 x-pictures.net
0.0.0.0 x.azjmp.com
0.0.0.0 x.bidswitch.net
0.0.0.0 x.iasrv.com
0.0.0.0 x.interia.pl
0.0.0.0 x.mochiads.com
0.0.0.0 x2.trk1.co
0.0.0.0 xads.zedo.com
0.0.0.0 xaxis.com
0.0.0.0 xbox-ms-store-debug.com
0.0.0.0 xch.smrtgs.com
0.0.0.0 xl-trk.com
0.0.0.0 xml.ad-maven.com
0.0.0.0 xml.adfclick1.com
0.0.0.0 xml.adservme.com
0.0.0.0 xml.adtech.fr
0.0.0.0 xml.adtech.us
0.0.0.0 xml.click9.com
0.0.0.0 xml.explorads.com
0.0.0.0 xml.mediashakers.com
0.0.0.0 xml.realtime-bid.com
0.0.0.0 xml.yepmedia.com
0.0.0.0 xmlheads.com
0.0.0.0 xpantivirus.com
0.0.0.0 xphones-2019.info
0.0.0.0 xphotos-album.com
0.0.0.0 xphotos.net
0.0.0.0 xpictures.net
0.0.0.0 xstatic.nk-net.pl
0.0.0.0 xuochfumvoaalgthpcwkvcro.audienceexposure.com
0.0.0.0 y.cdn.adblade.com
0.0.0.0 yadro.ru
0.0.0.0 yahoo-match.dotomi.com
0.0.0.0 yas-jr.com
0.0.0.0 yepdigital.adk2x.com
0.0.0.0 yhti.net
0.0.0.0 yieldmanager.net
0.0.0.0 yieldmo-match.dotomi.com
0.0.0.0 yllix.com
0.0.0.0 ym.adnxs.com
0.0.0.0 yodleeinc.tt.omtrdc.net
0.0.0.0 yoredi.com
0.0.0.0 yotube.com
0.0.0.0 youfck.com
0.0.0.0 your-gift-zone.com
0.0.0.0 your.dailytopdealz.com
0.0.0.0 youradexchange.com
0.0.0.0 yourgascards.com
0.0.0.0 yourgiftrewards.com
0.0.0.0 yourgiftzone.com
0.0.0.0 youripad4free.com
0.0.0.0 yourrewardzone.com
0.0.0.0 yoursmartrewards.com
0.0.0.0 ysiu.freenation.com
0.0.0.0 yt-adblocker.com
0.0.0.0 yumenetworks.com
0.0.0.0 yx-in-f108.1e100.net
0.0.0.0 z-na.amazon-adsystem.com
0.0.0.0 z.blogads.com
0.0.0.0 z.dynad.net
0.0.0.0 z.moatads.com
0.0.0.0 z1.adserver.com
0.0.0.0 zabavazaodrasle.com
0.0.0.0 zads.zedo.com
0.0.0.0 zapadserver1.com
0.0.0.0 zapcdn.space
0.0.0.0 zazerygu.pro
0.0.0.0 zc1.zeroredirect11.com
0.0.0.0 zdads.e-media.com
0.0.0.0 zem.outbrainimg.com
0.0.0.0 zemgo.com
0.0.0.0 zeroredirect.com
0.0.0.0 zeroredirect1.com
0.0.0.0 zeroredirect11.com
0.0.0.0 zeroredirect12.com
0.0.0.0 zeroredirect2.com
0.0.0.0 zeroredirect5.com
0.0.0.0 zeroredirect8.com
0.0.0.0 zevents.com
0.0.0.0 zlhoteckelinie.wz.cz
0.0.0.0 zoeandjo.co.uk
0.0.0.0 zoologyfibre.com
0.0.0.0 zu1.november-lax.com
0.0.0.0 zulu.r867qq.net
0.0.0.0 zytpirwai.net
#</ad-sites>

# https://securehomes.esat.kuleuven.be/~gacar/persistent/index.html
#<canvass-fingerprinting-sites>
0.0.0.0 admicro1.vcmedia.vn
0.0.0.0 ct1.addthis.com
0.0.0.0 cya2.net
0.0.0.0 i.ligatus.com
0.0.0.0 images.revtrax.com
0.0.0.0 shorte.st
0.0.0.0 src.kitcode.net
#</canvass-fingerprinting-sites>

#<evercookies-sites>
0.0.0.0 ar.hao123.com
0.0.0.0 irs01.net
0.0.0.0 kiks.yandex.ru
0.0.0.0 y3.ifengimg.com
#</evercookies-sites>

#<yahoo-ad-sites>

# yahoo banner ads
# If you have trouble with Yahoo email, you may need to comment out these lines
#0.0.0.0 us.i1.yimg.com	#Uncomment this to block yahoo images
0.0.0.0 in.yimg.com
0.0.0.0 us.a1.yimg.com
#</yahoo-ad-sites>

#<hitbox-sites>

# hitbox.com web bugs
0.0.0.0 adminec1.hitbox.com
0.0.0.0 ads.hitbox.com
0.0.0.0 ai.hitbox.com
0.0.0.0 counter.hitbox.com
0.0.0.0 counter2.hitbox.com
0.0.0.0 dev101.hitbox.com
0.0.0.0 download.hitbox.com
0.0.0.0 ec1.hitbox.com
0.0.0.0 ehg-247internet.hitbox.com
0.0.0.0 ehg-accuweather.hitbox.com
0.0.0.0 ehg-acdsystems.hitbox.com
0.0.0.0 ehg-adeptscience.hitbox.com
0.0.0.0 ehg-affinitynet.hitbox.com
0.0.0.0 ehg-aha.hitbox.com
0.0.0.0 ehg-amerix.hitbox.com
0.0.0.0 ehg-apcc.hitbox.com
0.0.0.0 ehg-ati.hitbox.com
0.0.0.0 ehg-attenza.hitbox.com
0.0.0.0 ehg-autodesk.hitbox.com
0.0.0.0 ehg-baa.hitbox.com
0.0.0.0 ehg-backweb.hitbox.com
0.0.0.0 ehg-bestbuy.hitbox.com
0.0.0.0 ehg-bizjournals.hitbox.com
0.0.0.0 ehg-boschsiemens.hitbox.com
0.0.0.0 ehg-bskyb.hitbox.com
0.0.0.0 ehg-cafepress.hitbox.com
0.0.0.0 ehg-careerbuilder.hitbox.com
0.0.0.0 ehg-cbc.hitbox.com
0.0.0.0 ehg-cbs.hitbox.com
0.0.0.0 ehg-cbsradio.hitbox.com
0.0.0.0 ehg-cedarpoint.hitbox.com
0.0.0.0 ehg-clearchannel.hitbox.com
0.0.0.0 ehg-closetmaid.hitbox.com
0.0.0.0 ehg-commjun.hitbox.com
0.0.0.0 ehg-communityconnect.hitbox.com
0.0.0.0 ehg-comscore.hitbox.com
0.0.0.0 ehg-corusentertainment.hitbox.com
0.0.0.0 ehg-coverityinc.hitbox.com
0.0.0.0 ehg-crain.hitbox.com
0.0.0.0 ehg-ctv.hitbox.com
0.0.0.0 ehg-cygnusbm.hitbox.com
0.0.0.0 ehg-datamonitor.hitbox.com
0.0.0.0 ehg-dig.hitbox.com
0.0.0.0 ehg-digg.hitbox.com
0.0.0.0 ehg-eckounlimited.hitbox.com
0.0.0.0 ehg-esa.hitbox.com
0.0.0.0 ehg-espn.hitbox.com
0.0.0.0 ehg-fifa.hitbox.com
0.0.0.0 ehg-findlaw.hitbox.com
0.0.0.0 ehg-foundation.hitbox.com
0.0.0.0 ehg-foxsports.hitbox.com
0.0.0.0 ehg-futurepub.hitbox.com
0.0.0.0 ehg-gamedaily.hitbox.com
0.0.0.0 ehg-gamespot.hitbox.com
0.0.0.0 ehg-gatehousemedia.hitbox.com
0.0.0.0 ehg-glam.hitbox.com
0.0.0.0 ehg-groceryworks.hitbox.com
0.0.0.0 ehg-groupernetworks.hitbox.com
0.0.0.0 ehg-guardian.hitbox.com
0.0.0.0 ehg-hasbro.hitbox.com
0.0.0.0 ehg-hellodirect.hitbox.com
0.0.0.0 ehg-himedia.hitbox.com
0.0.0.0 ehg-hitent.hitbox.com
0.0.0.0 ehg-hollywood.hitbox.com
0.0.0.0 ehg-idg.hitbox.com
0.0.0.0 ehg-idgentertainment.hitbox.com
0.0.0.0 ehg-ifilm.hitbox.com
0.0.0.0 ehg-ignitemedia.hitbox.com
0.0.0.0 ehg-intel.hitbox.com
0.0.0.0 ehg-ittoolbox.hitbox.com
0.0.0.0 ehg-itworldcanada.hitbox.com
0.0.0.0 ehg-kingstontechnology.hitbox.com
0.0.0.0 ehg-knightridder.hitbox.com
0.0.0.0 ehg-learningco.hitbox.com
0.0.0.0 ehg-legonewyorkinc.hitbox.com
0.0.0.0 ehg-liveperson.hitbox.com
0.0.0.0 ehg-macpublishingllc.hitbox.com
0.0.0.0 ehg-macromedia.hitbox.com
0.0.0.0 ehg-magicalia.hitbox.com
0.0.0.0 ehg-maplesoft.hitbox.com
0.0.0.0 ehg-mgnlimited.hitbox.com
0.0.0.0 ehg-mindshare.hitbox.com
0.0.0.0 ehg-mtv.hitbox.com
0.0.0.0 ehg-mybc.hitbox.com
0.0.0.0 ehg-newegg.hitbox.com
0.0.0.0 ehg-newscientist.hitbox.com
0.0.0.0 ehg-nokiafin.hitbox.com
0.0.0.0 ehg-novell.hitbox.com
0.0.0.0 ehg-nvidia.hitbox.com
0.0.0.0 ehg-oreilly.hitbox.com
0.0.0.0 ehg-pacifictheatres.hitbox.com
0.0.0.0 ehg-pennwell.hitbox.com
0.0.0.0 ehg-peoplesoft.hitbox.com
0.0.0.0 ehg-philipsvheusen.hitbox.com
0.0.0.0 ehg-pizzahut.hitbox.com
0.0.0.0 ehg-playboy.hitbox.com
0.0.0.0 ehg-qualcomm.hitbox.com
0.0.0.0 ehg-quantumcorp.hitbox.com
0.0.0.0 ehg-randomhouse.hitbox.com
0.0.0.0 ehg-redherring.hitbox.com
0.0.0.0 ehg-register.hitbox.com
0.0.0.0 ehg-researchinmotion.hitbox.com
0.0.0.0 ehg-rfa.hitbox.com
0.0.0.0 ehg-rodale.hitbox.com
0.0.0.0 ehg-salesforce.hitbox.com
0.0.0.0 ehg-salonmedia.hitbox.com
0.0.0.0 ehg-samsungusa.hitbox.com
0.0.0.0 ehg-seca.hitbox.com
0.0.0.0 ehg-shoppersdrugmart.hitbox.com
0.0.0.0 ehg-sonybssc.hitbox.com
0.0.0.0 ehg-sonycomputer.hitbox.com
0.0.0.0 ehg-sonyelec.hitbox.com
0.0.0.0 ehg-sonymusic.hitbox.com
0.0.0.0 ehg-sonyny.hitbox.com
0.0.0.0 ehg-space.hitbox.com
0.0.0.0 ehg-streamload.hitbox.com
0.0.0.0 ehg-superpages.hitbox.com
0.0.0.0 ehg-techtarget.hitbox.com
0.0.0.0 ehg-tfl.hitbox.com
0.0.0.0 ehg-thefirstchurchchrist.hitbox.com
0.0.0.0 ehg-tigerdirect.hitbox.com
0.0.0.0 ehg-tigerdirect2.hitbox.com
0.0.0.0 ehg-topps.hitbox.com
0.0.0.0 ehg-tribute.hitbox.com
0.0.0.0 ehg-tumbleweed.hitbox.com
0.0.0.0 ehg-ubisoft.hitbox.com
0.0.0.0 ehg-uniontrib.hitbox.com
0.0.0.0 ehg-usnewsworldreport.hitbox.com
0.0.0.0 ehg-verizoncommunications.hitbox.com
0.0.0.0 ehg-viacom.hitbox.com
0.0.0.0 ehg-vmware.hitbox.com
0.0.0.0 ehg-vonage.hitbox.com
0.0.0.0 ehg-wachovia.hitbox.com
0.0.0.0 ehg-wacomtechnology.hitbox.com
0.0.0.0 ehg-womanswallstreet.hitbox.com
0.0.0.0 ehg-wss.hitbox.com
0.0.0.0 ehg-xxolympicwintergames.hitbox.com
0.0.0.0 ehg-yellowpages.hitbox.com
0.0.0.0 ehg-youtube.hitbox.com
0.0.0.0 ehg.hitbox.com
0.0.0.0 ejs.hitbox.com
0.0.0.0 enterprise.hitbox.com
0.0.0.0 esg.hitbox.com
0.0.0.0 evwr.hitbox.com
0.0.0.0 get.hitbox.com
0.0.0.0 hg1.hitbox.com
0.0.0.0 hg10.hitbox.com
0.0.0.0 hg11.hitbox.com
0.0.0.0 hg12.hitbox.com
0.0.0.0 hg13.hitbox.com
0.0.0.0 hg14.hitbox.com
0.0.0.0 hg15.hitbox.com
0.0.0.0 hg16.hitbox.com
0.0.0.0 hg17.hitbox.com
0.0.0.0 hg2.hitbox.com
0.0.0.0 hg6a.hitbox.com
0.0.0.0 hitbox.com
0.0.0.0 hitboxbenchmarker.com
0.0.0.0 hitboxcentral.com
0.0.0.0 host6.hitbox.com
0.0.0.0 ias.hitbox.com
0.0.0.0 ias2.hitbox.com
0.0.0.0 ibg.hitbox.com
0.0.0.0 ics.hitbox.com
0.0.0.0 idb.hitbox.com
0.0.0.0 js1.hitbox.com
0.0.0.0 lookup.hitbox.com
0.0.0.0 mrtg.hitbox.com
0.0.0.0 myhitbox.com
0.0.0.0 nei.hitbox.com
0.0.0.0 noc.hitbox.com
0.0.0.0 ns1.hitbox.com
0.0.0.0 oas.hitbox.com
0.0.0.0 phg.hitbox.com
0.0.0.0 rd1.hitbox.com
0.0.0.0 reseller.hitbox.com
0.0.0.0 resources.hitbox.com
0.0.0.0 sitesearch.hitbox.com
0.0.0.0 ss.hitbox.com
0.0.0.0 stage.hitbox.com
0.0.0.0 stage101.hitbox.com
0.0.0.0 stage102.hitbox.com
0.0.0.0 stage103.hitbox.com
0.0.0.0 stats.hitbox.com
0.0.0.0 stats2.hitbox.com
0.0.0.0 stats3.hitbox.com
0.0.0.0 tetra.hitbox.com
0.0.0.0 tools.hitbox.com
0.0.0.0 tools2.hitbox.com
0.0.0.0 toolsa.hitbox.com
0.0.0.0 ts1.hitbox.com
0.0.0.0 ts2.hitbox.com
0.0.0.0 vwr1.hitbox.com
0.0.0.0 w1.hitbox.com
0.0.0.0 w10.hitbox.com
0.0.0.0 w100.hitbox.com
0.0.0.0 w101.hitbox.com
0.0.0.0 w102.hitbox.com
0.0.0.0 w103.hitbox.com
0.0.0.0 w104.hitbox.com
0.0.0.0 w105.hitbox.com
0.0.0.0 w106.hitbox.com
0.0.0.0 w107.hitbox.com
0.0.0.0 w108.hitbox.com
0.0.0.0 w109.hitbox.com
0.0.0.0 w11.hitbox.com
0.0.0.0 w110.hitbox.com
0.0.0.0 w111.hitbox.com
0.0.0.0 w112.hitbox.com
0.0.0.0 w113.hitbox.com
0.0.0.0 w114.hitbox.com
0.0.0.0 w115.hitbox.com
0.0.0.0 w116.hitbox.com
0.0.0.0 w117.hitbox.com
0.0.0.0 w118.hitbox.com
0.0.0.0 w119.hitbox.com
0.0.0.0 w12.hitbox.com
0.0.0.0 w120.hitbox.com
0.0.0.0 w121.hitbox.com
0.0.0.0 w122.hitbox.com
0.0.0.0 w123.hitbox.com
0.0.0.0 w124.hitbox.com
0.0.0.0 w126.hitbox.com
0.0.0.0 w128.hitbox.com
0.0.0.0 w129.hitbox.com
0.0.0.0 w13.hitbox.com
0.0.0.0 w130.hitbox.com
0.0.0.0 w131.hitbox.com
0.0.0.0 w132.hitbox.com
0.0.0.0 w133.hitbox.com
0.0.0.0 w135.hitbox.com
0.0.0.0 w136.hitbox.com
0.0.0.0 w137.hitbox.com
0.0.0.0 w138.hitbox.com
0.0.0.0 w139.hitbox.com
0.0.0.0 w14.hitbox.com
0.0.0.0 w140.hitbox.com
0.0.0.0 w141.hitbox.com
0.0.0.0 w144.hitbox.com
0.0.0.0 w147.hitbox.com
0.0.0.0 w15.hitbox.com
0.0.0.0 w153.hitbox.com
0.0.0.0 w154.hitbox.com
0.0.0.0 w155.hitbox.com
0.0.0.0 w157.hitbox.com
0.0.0.0 w159.hitbox.com
0.0.0.0 w16.hitbox.com
0.0.0.0 w161.hitbox.com
0.0.0.0 w162.hitbox.com
0.0.0.0 w167.hitbox.com
0.0.0.0 w168.hitbox.com
0.0.0.0 w17.hitbox.com
0.0.0.0 w170.hitbox.com
0.0.0.0 w175.hitbox.com
0.0.0.0 w18.hitbox.com
0.0.0.0 w19.hitbox.com
0.0.0.0 w2.hitbox.com
0.0.0.0 w20.hitbox.com
0.0.0.0 w21.hitbox.com
0.0.0.0 w22.hitbox.com
0.0.0.0 w23.hitbox.com
0.0.0.0 w24.hitbox.com
0.0.0.0 w25.hitbox.com
0.0.0.0 w26.hitbox.com
0.0.0.0 w27.hitbox.com
0.0.0.0 w28.hitbox.com
0.0.0.0 w29.hitbox.com
0.0.0.0 w3.hitbox.com
0.0.0.0 w30.hitbox.com
0.0.0.0 w31.hitbox.com
0.0.0.0 w32.hitbox.com
0.0.0.0 w33.hitbox.com
0.0.0.0 w36.hitbox.com
0.0.0.0 w4.hitbox.com
0.0.0.0 w5.hitbox.com
0.0.0.0 w6.hitbox.com
0.0.0.0 w7.hitbox.com
0.0.0.0 w8.hitbox.com
0.0.0.0 w9.hitbox.com
0.0.0.0 webload101.hitbox.com
0.0.0.0 wvwr1.hitbox.com
0.0.0.0 ww1.hitbox.com
0.0.0.0 ww2.hitbox.com
0.0.0.0 ww3.hitbox.com
0.0.0.0 wwa.hitbox.com
0.0.0.0 wwb.hitbox.com
0.0.0.0 wwc.hitbox.com
0.0.0.0 wwd.hitbox.com
0.0.0.0 www.hitbox.com
0.0.0.0 yang.hitbox.com
0.0.0.0 ying.hitbox.com
#</hitbox-sites>

#<extreme-dm-sites>

# www.extreme-dm.com tracking
0.0.0.0 extreme-dm.com
0.0.0.0 reports.extreme-dm.com
0.0.0.0 t.extreme-dm.com
0.0.0.0 t0.extreme-dm.com
0.0.0.0 t1.extreme-dm.com
0.0.0.0 u.extreme-dm.com
0.0.0.0 u0.extreme-dm.com
0.0.0.0 u1.extreme-dm.com
0.0.0.0 v.extreme-dm.com
0.0.0.0 v0.extreme-dm.com
0.0.0.0 v1.extreme-dm.com
0.0.0.0 w.extreme-dm.com
0.0.0.0 w0.extreme-dm.com
0.0.0.0 w1.extreme-dm.com
0.0.0.0 www.extreme-dm.com
0.0.0.0 x3.extreme-dm.com
0.0.0.0 y.extreme-dm.com
0.0.0.0 y0.extreme-dm.com
0.0.0.0 y1.extreme-dm.com
0.0.0.0 z.extreme-dm.com
0.0.0.0 z0.extreme-dm.com
0.0.0.0 z1.extreme-dm.com
#</extreme-dm-sites>

#<realmedia-sites>

# realmedia.com's Open Ad Stream
0.0.0.0 ap.oasfile.aftenposten.no
0.0.0.0 oas-central.east.realmedia.com
0.0.0.0 oas-central.realmedia.com
0.0.0.0 oas.adservingml.com
0.0.0.0 oas.benchmark.fr
0.0.0.0 oas.foxnews.com
0.0.0.0 oas.ibnlive.com
0.0.0.0 oas.publicitas.ch
0.0.0.0 oas.sciencemag.org
0.0.0.0 oas.startribune.com
0.0.0.0 oas.toronto.com
0.0.0.0 oas.uniontrib.com
0.0.0.0 oas.villagevoice.com
0.0.0.0 oas.vtsgonline.com
0.0.0.0 oasc03012.247realmedia.com
0.0.0.0 oasc03049.247realmedia.com
0.0.0.0 oasc06006.247realmedia.com
0.0.0.0 oasc08008.247realmedia.com
0.0.0.0 oasc09.247realmedia.com
0.0.0.0 oascentral.123greetings.com
0.0.0.0 oascentral.abclocal.go.com
0.0.0.0 oascentral.adage.com
0.0.0.0 oascentral.adageglobal.com
0.0.0.0 oascentral.aircanada.com
0.0.0.0 oascentral.artistirect.com
0.0.0.0 oascentral.askmen.com
0.0.0.0 oascentral.blackenterprises.com
0.0.0.0 oascentral.businessweeks.com
0.0.0.0 oascentral.buy.com
0.0.0.0 oascentral.canadaeast.com
0.0.0.0 oascentral.canadianliving.com
0.0.0.0 oascentral.charleston.net
0.0.0.0 oascentral.chicagobusiness.com
0.0.0.0 oascentral.chron.com
0.0.0.0 oascentral.citypages.com
0.0.0.0 oascentral.clearchannel.com
0.0.0.0 oascentral.comcast.net
0.0.0.0 oascentral.comics.com
0.0.0.0 oascentral.construction.com
0.0.0.0 oascentral.consumerreports.org
0.0.0.0 oascentral.crainsdetroit.com
0.0.0.0 oascentral.cybereps.com
0.0.0.0 oascentral.dailybreeze.com
0.0.0.0 oascentral.discovery.com
0.0.0.0 oascentral.drphil.com
0.0.0.0 oascentral.fashionmagazine.com
0.0.0.0 oascentral.fayettevillenc.com
0.0.0.0 oascentral.forsythnews.com
0.0.0.0 oascentral.fortunecity.com
0.0.0.0 oascentral.foxnews.com
0.0.0.0 oascentral.freedom.com
0.0.0.0 oascentral.gigex.com
0.0.0.0 oascentral.herenb.com
0.0.0.0 oascentral.hollywood.com
0.0.0.0 oascentral.houstonpress.com
0.0.0.0 oascentral.inq7.net
0.0.0.0 oascentral.investorwords.com
0.0.0.0 oascentral.itbusiness.ca
0.0.0.0 oascentral.laptopmag.com
0.0.0.0 oascentral.law.com
0.0.0.0 oascentral.laweekly.com
0.0.0.0 oascentral.looksmart.com
0.0.0.0 oascentral.lycos.com
0.0.0.0 oascentral.mayoclinic.com
0.0.0.0 oascentral.medbroadcast.com
0.0.0.0 oascentral.minnpost.com
0.0.0.0 oascentral.mochila.com
0.0.0.0 oascentral.nerve.com
0.0.0.0 oascentral.newsmax.com
0.0.0.0 oascentral.onwisconsin.com
0.0.0.0 oascentral.phoenixnewtimes.com
0.0.0.0 oascentral.phoenixvillenews.com
0.0.0.0 oascentral.poconorecord.com
0.0.0.0 oascentral.politico.com
0.0.0.0 oascentral.post-gazette.com
0.0.0.0 oascentral.pottsmerc.com
0.0.0.0 oascentral.rcrnews.com
0.0.0.0 oascentral.redherring.com
0.0.0.0 oascentral.redstate.com
0.0.0.0 oascentral.register.com
0.0.0.0 oascentral.santacruzsentinel.com
0.0.0.0 oascentral.seacoastonline.com
0.0.0.0 oascentral.sfgate.com
0.0.0.0 oascentral.sfweekly.com
0.0.0.0 oascentral.sina.com
0.0.0.0 oascentral.sina.com.hk
0.0.0.0 oascentral.sparknotes.com
0.0.0.0 oascentral.starbulletin.com
0.0.0.0 oascentral.surfline.com
0.0.0.0 oascentral.thechronicleherald.ca
0.0.0.0 oascentral.thenation.com
0.0.0.0 oascentral.theonion.com
0.0.0.0 oascentral.theonionavclub.com
0.0.0.0 oascentral.thephoenix.com
0.0.0.0 oascentral.tmcnet.com
0.0.0.0 oascentral.tnr.com
0.0.0.0 oascentral.tourismvancouver.com
0.0.0.0 oascentral.townhall.com
0.0.0.0 oascentral.trutv.com
0.0.0.0 oascentral.upi.com
0.0.0.0 oascentral.villagevoice.com
0.0.0.0 oascentral.virtualtourist.com
0.0.0.0 oascentral.washtimes.com
0.0.0.0 oascentral.wciv.com
0.0.0.0 oascentral.westword.com
0.0.0.0 oascentral.where.ca
0.0.0.0 oascentral.wjla.com
0.0.0.0 oascentral.wkrn.com
0.0.0.0 oascentral.yellowpages.com
0.0.0.0 oascentral.zwire.com
0.0.0.0 oascentralnx.comcast.net
#</realmedia-sites>

#<fastclick-sites>

# fastclick banner ads
0.0.0.0 fastclick.net
#</fastclick-sites>

#<belo-interactive-sites>

# belo interactive ads
0.0.0.0 te.about.com
0.0.0.0 te.adlandpro.com
0.0.0.0 te.advance.net
0.0.0.0 te.ap.org
0.0.0.0 te.astrology.com
0.0.0.0 te.boston.com
0.0.0.0 te.chron.com
0.0.0.0 te.cleveland.net
0.0.0.0 te.greenwichtime.com
0.0.0.0 te.infoworld.com
0.0.0.0 te.journalnow.com
0.0.0.0 te.newsday.com
0.0.0.0 te.nytdigital.com
0.0.0.0 te.scrippsnetworksprivacy.com
0.0.0.0 te.scrippsnewspapersprivacy.com
0.0.0.0 te.sfgate.com
0.0.0.0 te.signonsandiego.com
0.0.0.0 te.stamfordadvocate.com
0.0.0.0 te.thestar.ca
0.0.0.0 te.thestar.com
0.0.0.0 te.trb.com
0.0.0.0 te.versiontracker.com
#</belo-interactive-sites>

#<popup-traps>

# popup traps -- sites that bounce you around or won't let you leave
0.0.0.0 adultfriendfinder.com
0.0.0.0 incestland.com
0.0.0.0 lesview.com
0.0.0.0 searchforit.com
0.0.0.0 www.bangbuddy.com
0.0.0.0 www.datanotary.com
0.0.0.0 www.entercasino.com
0.0.0.0 www.justhookup.com
0.0.0.0 www.mangayhentai.com
0.0.0.0 www.ourfuckbook.com
0.0.0.0 www.realincestvideos.com
0.0.0.0 www.searchv.com
0.0.0.0 www.seductiveamateurs.com
0.0.0.0 www.smsmovies.net
0.0.0.0 www.wowjs.1www.cn
0.0.0.0 www.xxxnations.com
0.0.0.0 www.xxxtoolbar.com
0.0.0.0 www.yourfuckbook.com
#</popup-traps>

#<ecard-scam-sites>

# malicious e-card -- these sites send out mass quantities of spam 
	# and some distribute adware and spyware
0.0.0.0 123greetings.com	# contains one link to distributor of adware or spyware
0.0.0.0 2000greetings.com
0.0.0.0 celebwelove.com
0.0.0.0 ecard4all.com
0.0.0.0 eforu.com
0.0.0.0 freewebcards.com
0.0.0.0 fukkad.com
0.0.0.0 fun-e-cards.com
0.0.0.0 funnyreign.com	# heavy spam (Site Advisor received 1075 e-mails/week)
0.0.0.0 funsilly.com
0.0.0.0 myfuncards.com
0.0.0.0 www.cool-downloads.com
0.0.0.0 www.cool-downloads.net
0.0.0.0 www.friend-card.com
0.0.0.0 www.friend-cards.com
0.0.0.0 www.friend-cards.net
0.0.0.0 www.friend-greeting.com
0.0.0.0 www.friend-greetings.com
0.0.0.0 www.friend-greetings.net
0.0.0.0 www.friendgreetings.com
0.0.0.0 www.friendgreetings.net
0.0.0.0 www.laugh-mail.com
0.0.0.0 www.laugh-mail.net
#</ecard-scam-sites>

#<IVW-sites>

# European network of tracking sites
#</IVW-sites>

#<wiki-spam-sites>

# message board and wiki spam -- these sites are linked in 
	# message board spam and are unlikely to be real sites
0.0.0.0 21jewelry.com
0.0.0.0 24x7.soliday.org
0.0.0.0 2site.com
0.0.0.0 33b.b33r.net
0.0.0.0 4allfree.com
0.0.0.0 55.2myip.com
0.0.0.0 6165.rapidforum.com
0.0.0.0 7x.cc
0.0.0.0 911.x24hr.com
0.0.0.0 ab.5.p2l.info
0.0.0.0 aboutharrypotter.fasthost.tv
0.0.0.0 acyclovir.1.p2l.info
0.0.0.0 adderall.ourtablets.com
0.0.0.0 adipex.1.p2l.info
0.0.0.0 adipex.24sws.ws
0.0.0.0 adipex.3.p2l.info
0.0.0.0 adipex.4.p2l.info
0.0.0.0 adipex.hut1.ru
0.0.0.0 adipex.ourtablets.com
0.0.0.0 adipex.shengen.ru
0.0.0.0 adipex.t-amo.net
0.0.0.0 adipexp.3xforum.ro
0.0.0.0 adult.shengen.ru
0.0.0.0 aid-golf-golfdust-training.tabrays.com
0.0.0.0 ak.5.p2l.info
0.0.0.0 al.5.p2l.info
0.0.0.0 all-sex.shengen.ru
0.0.0.0 allegra.1.p2l.info
0.0.0.0 allergy.1.p2l.info
0.0.0.0 alprazolam.ourtablets.com
0.0.0.0 alprazolamonline.findmenow.info
0.0.0.0 alyssamilano.home.sapo.pt
0.0.0.0 ambien.1.p2l.info
0.0.0.0 ambien.3.p2l.info
0.0.0.0 ambien.4.p2l.info
0.0.0.0 ambien.ourtablets.com
0.0.0.0 amoxicillin.ourtablets.com
0.0.0.0 anklets.shengen.ru
0.0.0.0 antidepressants.1.p2l.info
0.0.0.0 anxiety.1.p2l.info
0.0.0.0 aol.spb.su
0.0.0.0 ar.5.p2l.info
0.0.0.0 arcade.ya.com
0.0.0.0 arthritis.atspace.com
0.0.0.0 as.5.p2l.info
0.0.0.0 ativan.ourtablets.com
0.0.0.0 auto.allewagen.de
0.0.0.0 az.5.p2l.info
0.0.0.0 azz.badazz.org
0.0.0.0 balabass.peerserver.com
0.0.0.0 bbs.ws
0.0.0.0 bc.5.p2l.info
0.0.0.0 beauty.finaltips.com
0.0.0.0 bextra-store.shengen.ru
0.0.0.0 bextra.ourtablets.com
0.0.0.0 birth-control.1.p2l.info
0.0.0.0 bontril.1.p2l.info
0.0.0.0 bontril.ourtablets.com
0.0.0.0 bupropion-hcl.1.p2l.info
0.0.0.0 buspar.1.p2l.info
0.0.0.0 buspirone.1.p2l.info
0.0.0.0 butalbital-apap.1.p2l.info
0.0.0.0 buy-adipex.aca.ru
0.0.0.0 buy-adipex.hut1.ru
0.0.0.0 buy-cheap-phentermine.blogspot.com
0.0.0.0 buy-cialis-online.iscool.nl
0.0.0.0 buy-cialis.splinder.com
0.0.0.0 buy-fioricet.hut1.ru
0.0.0.0 buy-hydrocodone.aca.ru
0.0.0.0 buy-hydrocodone.este.ru
0.0.0.0 buy-lortab-online.iscool.nl
0.0.0.0 buy-lortab.hut1.ru
0.0.0.0 buy-phentermine.thepizza.net
0.0.0.0 buy-ultram-online.iscool.nl
0.0.0.0 buy-valium.este.ru
0.0.0.0 buy-valium.hut1.ru
0.0.0.0 buy-viagra.aca.ru
0.0.0.0 buy-vicodin-online.seumala.net
0.0.0.0 buy-vicodin-online.supersite.fr
0.0.0.0 buy-vicodin.hut1.ru
0.0.0.0 buy-vicodin.iscool.nl
0.0.0.0 buy-xanax-cheap-xanax-online.com
0.0.0.0 buy-xanax.aztecaonline.net
0.0.0.0 buy-xanax.hut1.ru
0.0.0.0 buycialisonline.7h.com
0.0.0.0 buyfioricet.findmenow.info
0.0.0.0 buyfioricetonline.7h.com
0.0.0.0 buyfioricetonline.freeservers.com
0.0.0.0 buyhydrocodoneonline.findmenow.info
0.0.0.0 buylevitra.3xforum.ro
0.0.0.0 buylevitraonline.7h.com
0.0.0.0 buylortabonline.7h.com
0.0.0.0 buypaxilonline.7h.com
0.0.0.0 buyphentermineonline.7h.com
0.0.0.0 buyvicodinonline.veryweird.com
0.0.0.0 ca.5.p2l.info
0.0.0.0 car-donation.shengen.ru
0.0.0.0 car-loan.shengen.ru
0.0.0.0 carisoprodol.1.p2l.info
0.0.0.0 carisoprodol.hut1.ru
0.0.0.0 carisoprodol.ourtablets.com
0.0.0.0 carisoprodol.shengen.ru
0.0.0.0 cash-advance.now-cash.com
0.0.0.0 cat.onlinepeople.net
0.0.0.0 cc5f.dnyp.com
0.0.0.0 celebrex.1.p2l.info
0.0.0.0 celexa.1.p2l.info
0.0.0.0 celexa.3.p2l.info
0.0.0.0 celexa.4.p2l.info
0.0.0.0 cephalexin.ourtablets.com
0.0.0.0 cheap-adipex.hut1.ru
0.0.0.0 cheap-web-hosting-here.blogspot.com
0.0.0.0 cheap-xanax-here.blogspot.com
0.0.0.0 cheapxanax.hut1.ru
0.0.0.0 cialis-store.shengen.ru
0.0.0.0 cialis.1.p2l.info
0.0.0.0 cialis.3.p2l.info
0.0.0.0 cialis.4.p2l.info
0.0.0.0 cialis.ourtablets.com
0.0.0.0 co.5.p2l.info
0.0.0.0 codeine.ourtablets.com
0.0.0.0 creampie.afdss.info
0.0.0.0 credit-card-application.now-cash.com
0.0.0.0 credit-cards.shengen.ru
0.0.0.0 ct.5.p2l.info
0.0.0.0 cyclobenzaprine.1.p2l.info
0.0.0.0 cyclobenzaprine.ourtablets.com
0.0.0.0 danger-phentermine.allforyourlife.com
0.0.0.0 darvocet.ourtablets.com
0.0.0.0 dc.5.p2l.info
0.0.0.0 de.5.p2l.info
0.0.0.0 debt.shengen.ru
0.0.0.0 def.5.p2l.info
0.0.0.0 detox-kit.com
0.0.0.0 detox.shengen.ru
0.0.0.0 diazepam.ourtablets.com
0.0.0.0 diazepam.razma.net
0.0.0.0 diazepam.shengen.ru
0.0.0.0 didrex.1.p2l.info
0.0.0.0 diet-pills.hut1.ru
0.0.0.0 dir.opank.com
0.0.0.0 dos.velek.com
0.0.0.0 drug-testing.shengen.ru
0.0.0.0 drugdetox.shengen.ru
0.0.0.0 e-dot.hut1.ru
0.0.0.0 e-hosting.hut1.ru
0.0.0.0 eb.prout.be
0.0.0.0 ed.at.thamaster.de
0.0.0.0 effexor-xr.1.p2l.info
0.0.0.0 en.ultrex.ru
0.0.0.0 enpresse.1.p2l.info
0.0.0.0 erectile.byethost33.com
0.0.0.0 esgic.1.p2l.info
0.0.0.0 fahrrad.bikesshop.de
0.0.0.0 famvir.1.p2l.info
0.0.0.0 farmius.org
0.0.0.0 fee-hydrocodone.bebto.com
0.0.0.0 female-v.1.p2l.info
0.0.0.0 femaleviagra.findmenow.info
0.0.0.0 fg.softguy.com
0.0.0.0 findmenow.info
0.0.0.0 fioricet-online.blogspot.com
0.0.0.0 fioricet.1.p2l.info
0.0.0.0 fioricet.3.p2l.info
0.0.0.0 fioricet.4.p2l.info
0.0.0.0 fl.5.p2l.info
0.0.0.0 flexeril.1.p2l.info
0.0.0.0 flextra.1.p2l.info
0.0.0.0 flonase.1.p2l.info
0.0.0.0 flonase.3.p2l.info
0.0.0.0 flonase.4.p2l.info
0.0.0.0 fluoxetine.1.p2l.info
0.0.0.0 fo4n.com
0.0.0.0 forex-broker.hut1.ru
0.0.0.0 forex-chart.hut1.ru
0.0.0.0 forex-market.hut1.ru
0.0.0.0 forex-news.hut1.ru
0.0.0.0 forex-online.hut1.ru
0.0.0.0 forex-signal.hut1.ru
0.0.0.0 forex-trade.hut1.ru
0.0.0.0 forex-trading-benefits.blogspot.com
0.0.0.0 forextrading.hut1.ru
0.0.0.0 free-money.host.sk
0.0.0.0 ga.5.p2l.info
0.0.0.0 gastrointestinal.1.p2l.info
0.0.0.0 gu.5.p2l.info
0.0.0.0 guerria-skateboard-tommy.tabrays.com
0.0.0.0 h1.ripway.com
0.0.0.0 herpes.1.p2l.info
0.0.0.0 herpes.3.p2l.info
0.0.0.0 herpes.4.p2l.info
0.0.0.0 hi.5.p2l.info
0.0.0.0 homehre.bravehost.com
0.0.0.0 homehre.ifrance.com
0.0.0.0 homehre.tripod.com
0.0.0.0 hydrocodone-buy-online.blogspot.com
0.0.0.0 hydrocodone.irondel.swisshost.by
0.0.0.0 hydrocodone.shengen.ru
0.0.0.0 hydrocodone.t-amo.net
0.0.0.0 hydrocodone.visa-usa.ru
0.0.0.0 ia.5.p2l.info
0.0.0.0 id.5.p2l.info
0.0.0.0 il.5.p2l.info
0.0.0.0 imitrex.1.p2l.info
0.0.0.0 imitrex.3.p2l.info
0.0.0.0 imitrex.4.p2l.info
0.0.0.0 in.5.p2l.info
0.0.0.0 ionamin.1.p2l.info
0.0.0.0 irondel.swisshost.by
0.0.0.0 ks.5.p2l.info
0.0.0.0 ky.5.p2l.info
0.0.0.0 la.5.p2l.info
0.0.0.0 levitra.1.p2l.info
0.0.0.0 levitra.3.p2l.info
0.0.0.0 levitra.4.p2l.info
0.0.0.0 lexapro.1.p2l.info
0.0.0.0 lexapro.3.p2l.info
0.0.0.0 lexapro.4.p2l.info
0.0.0.0 loan.aol.msk.su
0.0.0.0 loestrin.1.p2l.info
0.0.0.0 lol.to
0.0.0.0 lortab-cod.hut1.ru
0.0.0.0 lortab.hut1.ru
0.0.0.0 ma.5.p2l.info
0.0.0.0 make-money.shengen.ru
0.0.0.0 mb.5.p2l.info
0.0.0.0 md.5.p2l.info
0.0.0.0 me.5.p2l.info
0.0.0.0 medical.carway.net
0.0.0.0 mens.1.p2l.info
0.0.0.0 meridia.1.p2l.info
0.0.0.0 meridia.3.p2l.info
0.0.0.0 meridia.4.p2l.info
0.0.0.0 meridiameridia.3xforum.ro
0.0.0.0 mesotherapy.jino-net.ru
0.0.0.0 mi.5.p2l.info
0.0.0.0 mn.5.p2l.info
0.0.0.0 mo.5.p2l.info
0.0.0.0 mortgage-rates.now-cash.com
0.0.0.0 mp.5.p2l.info
0.0.0.0 ms.5.p2l.info
0.0.0.0 mt.5.p2l.info
0.0.0.0 multimedia-projector.katrina.ru
0.0.0.0 muscle-relaxers.1.p2l.info
0.0.0.0 nasacort.1.p2l.info
0.0.0.0 nasonex.1.p2l.info
0.0.0.0 nb.5.p2l.info
0.0.0.0 nc.5.p2l.info
0.0.0.0 nd.5.p2l.info
0.0.0.0 ne.5.p2l.info
0.0.0.0 nexium.1.p2l.info
0.0.0.0 nextel-ringtone.spb.su
0.0.0.0 nf.5.p2l.info
0.0.0.0 nh.5.p2l.info
0.0.0.0 nj.5.p2l.info
0.0.0.0 nm.5.p2l.info
0.0.0.0 nordette.1.p2l.info
0.0.0.0 nordette.3.p2l.info
0.0.0.0 nordette.4.p2l.info
0.0.0.0 ns.5.p2l.info
0.0.0.0 nv.5.p2l.info
0.0.0.0 ny.5.p2l.info
0.0.0.0 o8.aus.cc
0.0.0.0 oh.5.p2l.info
0.0.0.0 ok.5.p2l.info
0.0.0.0 on.5.p2l.info
0.0.0.0 online-casino.shengen.ru
0.0.0.0 online-casino.webpark.pl
0.0.0.0 online-forex-trading-systems.blogspot.com
0.0.0.0 online-forex.hut1.ru
0.0.0.0 online-pharmacy-online.blogspot.com
0.0.0.0 online-poker.shengen.ru
0.0.0.0 only-valium.shengen.ru
0.0.0.0 or.5.p2l.info
0.0.0.0 orderadipex.findmenow.info
0.0.0.0 ortho-tri-cyclen.1.p2l.info
0.0.0.0 pa.5.p2l.info
0.0.0.0 pacific-poker.e-online-poker-4u.net
0.0.0.0 pain-relief.1.p2l.info
0.0.0.0 paintball-gun.tripod.com
0.0.0.0 patio-furniture.dreamhoster.com
0.0.0.0 paxil.1.p2l.info
0.0.0.0 payday-loans.now-cash.com
0.0.0.0 pe.5.p2l.info
0.0.0.0 peter-north-cum-shot.blogspot.com
0.0.0.0 pets.finaltips.com
0.0.0.0 pharmacy-canada.forsearch.net
0.0.0.0 pharmacy-news.blogspot.com
0.0.0.0 pharmacy.hut1.ru
0.0.0.0 phendimetrazine.1.p2l.info
0.0.0.0 phentermine-online.iscool.nl
0.0.0.0 phentermine.1.p2l.info
0.0.0.0 phentermine.3.p2l.info
0.0.0.0 phentermine.4.p2l.info
0.0.0.0 phentermine.aussie7.com
0.0.0.0 phentermine.shengen.ru
0.0.0.0 phentermine.t-amo.net
0.0.0.0 phentermine.webpark.pl
0.0.0.0 phone-calling-card.exnet.su
0.0.0.0 plavix.shengen.ru
0.0.0.0 play-poker-free.forsearch.net
0.0.0.0 poker-games.e-online-poker-4u.net
0.0.0.0 pop.egi.biz
0.0.0.0 pr.5.p2l.info
0.0.0.0 prescription-drugs.easy-find.net
0.0.0.0 prescription-drugs.shengen.ru
0.0.0.0 prevacid.1.p2l.info
0.0.0.0 prilosec.1.p2l.info
0.0.0.0 propecia.1.p2l.info
0.0.0.0 protonix.shengen.ru
0.0.0.0 psorias.atspace.com
0.0.0.0 purchase.hut1.ru
0.0.0.0 qc.5.p2l.info
0.0.0.0 refinance.shengen.ru
0.0.0.0 renova.1.p2l.info
0.0.0.0 resanium.com
0.0.0.0 retin-a.1.p2l.info
0.0.0.0 ri.5.p2l.info
0.0.0.0 sc.5.p2l.info
0.0.0.0 sd.5.p2l.info
0.0.0.0 search-phentermine.hpage.net
0.0.0.0 search4you.50webs.com
0.0.0.0 seasonale.1.p2l.info
0.0.0.0 sk.5.p2l.info
0.0.0.0 skelaxin.1.p2l.info
0.0.0.0 skelaxin.3.p2l.info
0.0.0.0 skelaxin.4.p2l.info
0.0.0.0 skin-care.1.p2l.info
0.0.0.0 skocz.pl
0.0.0.0 sleep-aids.1.p2l.info
0.0.0.0 sleeper-sofa.dreamhoster.com
0.0.0.0 sobolev.net.ru
0.0.0.0 soma-store.visa-usa.ru
0.0.0.0 soma.1.p2l.info
0.0.0.0 soma.3xforum.ro
0.0.0.0 sonata.1.p2l.info
0.0.0.0 spyware-removers.shengen.ru
0.0.0.0 sq7.co.uk
0.0.0.0 stop-smoking.1.p2l.info
0.0.0.0 supplements.1.p2l.info
0.0.0.0 sx.nazari.org
0.0.0.0 sx.z0rz.com
0.0.0.0 tenuate.1.p2l.info
0.0.0.0 texas-hold-em.e-online-poker-4u.net
0.0.0.0 texas-holdem.shengen.ru
0.0.0.0 ticket20.tripod.com
0.0.0.0 tizanidine.1.p2l.info
0.0.0.0 tn.5.p2l.info
0.0.0.0 topmeds10.com
0.0.0.0 tramadol.1.p2l.info
0.0.0.0 tramadol.3.p2l.info
0.0.0.0 tramadol.4.p2l.info
0.0.0.0 tramadol2006.3xforum.ro
0.0.0.0 triphasil.1.p2l.info
0.0.0.0 triphasil.3.p2l.info
0.0.0.0 triphasil.4.p2l.info
0.0.0.0 tx.5.p2l.info
0.0.0.0 ultracet.1.p2l.info
0.0.0.0 ultram.1.p2l.info
0.0.0.0 urlcut.net
0.0.0.0 ut.5.p2l.info
0.0.0.0 utairway.com
0.0.0.0 va.5.p2l.info
0.0.0.0 valium.este.ru
0.0.0.0 valium.hut1.ru
0.0.0.0 valium.ourtablets.com
0.0.0.0 valiumvalium.3xforum.ro
0.0.0.0 valtrex.1.p2l.info
0.0.0.0 valtrex.3.p2l.info
0.0.0.0 valtrex.4.p2l.info
0.0.0.0 valtrex.7h.com
0.0.0.0 vaniqa.1.p2l.info
0.0.0.0 vi.5.p2l.info
0.0.0.0 viagra-pill.blogspot.com
0.0.0.0 viagra-soft-tabs.1.p2l.info
0.0.0.0 viagra-store.shengen.ru
0.0.0.0 viagra.1.p2l.info
0.0.0.0 viagra.3.p2l.info
0.0.0.0 viagra.4.p2l.info
0.0.0.0 viagraviagra.3xforum.ro
0.0.0.0 vicodin-store.shengen.ru
0.0.0.0 vicodin.t-amo.net
0.0.0.0 viewtools.com
0.0.0.0 vioxx.1.p2l.info
0.0.0.0 vitalitymax.1.p2l.info
0.0.0.0 vt.5.p2l.info
0.0.0.0 wa.5.p2l.info
0.0.0.0 water-bed.8p.org.uk
0.0.0.0 webhosting.hut1.ru
0.0.0.0 weborg.hut1.ru
0.0.0.0 weight-loss.1.p2l.info
0.0.0.0 weight-loss.3.p2l.info
0.0.0.0 weight-loss.4.p2l.info
0.0.0.0 weight-loss.hut1.ru
0.0.0.0 wellbutrin.1.p2l.info
0.0.0.0 wellbutrin.3.p2l.info
0.0.0.0 wellbutrin.4.p2l.info
0.0.0.0 wellnessmonitor.bravehost.com
0.0.0.0 wi.5.p2l.info
0.0.0.0 wp-club.net
0.0.0.0 ws01.do.nu
0.0.0.0 ws02.do.nu
0.0.0.0 ws03.do.nu
0.0.0.0 ws03.home.sapo.pt
0.0.0.0 ws04.do.nu
0.0.0.0 ws04.home.sapo.pt
0.0.0.0 ws05.home.sapo.pt
0.0.0.0 ws06.home.sapo.pt
0.0.0.0 wv.5.p2l.info
0.0.0.0 www.31d.net
0.0.0.0 www.adspoll.com
0.0.0.0 www.adult-top-list.com
0.0.0.0 www.aektschen.de
0.0.0.0 www.aeqs.com
0.0.0.0 www.atlantis-asia.com
0.0.0.0 www.bestrxpills.com
0.0.0.0 www.bigsister-puff.cxa.de
0.0.0.0 www.bigsister.cxa.de
0.0.0.0 www.bitlocker.net
0.0.0.0 www.cheap-online-stamp.cast.cc
0.0.0.0 www.computerxchange.com
0.0.0.0 www.credit-dreams.com
0.0.0.0 www.exe-file.de
0.0.0.0 www.fetisch-pornos.cxa.de
0.0.0.0 www.ficken-ficken-ficken.cxa.de
0.0.0.0 www.ficken-xxx.cxa.de
0.0.0.0 www.heimlich-gefilmt.cxa.de
0.0.0.0 www.keyofhealth.com
0.0.0.0 www.kitchentablegang.org
0.0.0.0 www.km69.de
0.0.0.0 www.kvr-systems.de
0.0.0.0 www.lesben-pornos.cxa.de
0.0.0.0 www.littledevildoubt.com
0.0.0.0 www.masterspace.biz
0.0.0.0 www.medical-research-books.com
0.0.0.0 www.nextstudent.com
0.0.0.0 www.nutten-verzeichnis.cxa.de
0.0.0.0 www.obesitycheck.com
0.0.0.0 www.pawnauctions.net
0.0.0.0 www.poker-new.com
0.0.0.0 www.poker-unique.com
0.0.0.0 www.poker4spain.com
0.0.0.0 www.porno-lesben.cxa.de
0.0.0.0 www.randppro-cuts.com
0.0.0.0 www.romanticmaui.net
0.0.0.0 www.schwule-boys-nackt.cxa.de
0.0.0.0 www.shopping-artikel.de
0.0.0.0 www.showcaserealestate.net
0.0.0.0 www.skattabrain.com
0.0.0.0 www.softcha.com
0.0.0.0 www.talentbroker.net
0.0.0.0 www.the-discount-store.com
0.0.0.0 www.topmeds10.com
0.0.0.0 www.uniqueinternettexasholdempoker.com
0.0.0.0 www.vthought.com
0.0.0.0 www.vtoyshop.com
0.0.0.0 www.vulcannonibird.de
0.0.0.0 www.willcommen.de
0.0.0.0 www4.at.debianbase.de
0.0.0.0 www6.ns1.name
0.0.0.0 www69.bestdeals.at
0.0.0.0 www69.byinter.net
0.0.0.0 www69.findhere.org
0.0.0.0 www9.compblue.com
0.0.0.0 www9.servequake.com
0.0.0.0 www99.bounceme.net
0.0.0.0 www99.zapto.org
0.0.0.0 wy.5.p2l.info
0.0.0.0 x25.plorp.com
0.0.0.0 x4.lov3.net
0.0.0.0 x888x.myserver.org
0.0.0.0 xanax-online.dot.de
0.0.0.0 xanax-online.run.to
0.0.0.0 xanax-store.shengen.ru
0.0.0.0 xanax.ourtablets.com
0.0.0.0 xanax.t-amo.net
0.0.0.0 xanaxxanax.3xforum.ro
0.0.0.0 xenical.1.p2l.info
0.0.0.0 xenical.3.p2l.info
0.0.0.0 xenical.4.p2l.info
0.0.0.0 xoomer.alice.it
0.0.0.0 yasmin.1.p2l.info
0.0.0.0 yasmin.3.p2l.info
0.0.0.0 yasmin.4.p2l.info
0.0.0.0 yt.5.p2l.info
0.0.0.0 zanaflex.1.p2l.info
0.0.0.0 zebutal.1.p2l.info
0.0.0.0 zoloft.1.p2l.info
0.0.0.0 zoloft.3.p2l.info
0.0.0.0 zoloft.4.p2l.info
0.0.0.0 zyban-store.shengen.ru
0.0.0.0 zyban.1.p2l.info
0.0.0.0 zyrtec.1.p2l.info
0.0.0.0 zyrtec.3.p2l.info
0.0.0.0 zyrtec.4.p2l.info
#</wiki-spam-sites>

#<Windows10>

# Windows 10 reporting domains. 
0.0.0.0 a.ads2.msads.net
0.0.0.0 adnexus.net
0.0.0.0 aidps.atdmt.com
0.0.0.0 az361816.vo.msecnd.net
0.0.0.0 az512334.vo.msecnd.net
0.0.0.0 b.ads1.msn.com
0.0.0.0 b.ads2.msads.net
0.0.0.0 c.atdmt.com
0.0.0.0 cdn.atdmt.com
0.0.0.0 cds26.ams9.msecn.net
0.0.0.0 db3aqu.atdmt.com
0.0.0.0 ec.atdmt.com
0.0.0.0 feedback.microsoft-hohm.com
0.0.0.0 flex.msn.com
0.0.0.0 h1.msn.com
0.0.0.0 live.rads.msn.com
0.0.0.0 m.adnxs.com
0.0.0.0 msntest.serving-sys.com
0.0.0.0 preview.msn.com
0.0.0.0 reports.wes.df.telemetry.microsoft.com
0.0.0.0 schemas.microsoft.akadns.net
0.0.0.0 secure.flashtalking.com
0.0.0.0 statsfe2.ws.microsoft.com
0.0.0.0 wes.df.telemetry.microsoft.com
#</Windows10>

#<shock-sites>
# For example, to block unpleasant pages, try:
0.0.0.0 goatse.cx       # More information on sites such as 
0.0.0.0 www.goatse.cx   # these can be found in this article
0.0.0.0 oralse.cx       # en.wikipedia.org/wiki/List_of_shock_sites
0.0.0.0 www.oralse.cx
0.0.0.0 goatse.ca
0.0.0.0 www.goatse.ca
0.0.0.0 oralse.ca
0.0.0.0 www.oralse.ca
0.0.0.0 goat.cx
0.0.0.0 www.goat.cx
0.0.0.0 shafou.com
0.0.0.0 www.shafou.com
0.0.0.0 joyjak.st
0.0.0.0 www.joyjak.st
0.0.0.0 1girl1pitcher.com
0.0.0.0 1girl1pitcher.org
0.0.0.0 1guy1cock.com
0.0.0.0 1man1jar.org
0.0.0.0 1man2needles.com
0.0.0.0 1priest1nun.com
0.0.0.0 1priest1nun.net
0.0.0.0 2girls1cup-free.com
0.0.0.0 2girls1cup.cc
0.0.0.0 2girls1cup.com
0.0.0.0 2girls1cup.nl
0.0.0.0 2girls1cup.ws
0.0.0.0 2girls1finger.com
0.0.0.0 2girls1finger.org
0.0.0.0 2guys1stump.org
0.0.0.0 3guys1hammer.ws
0.0.0.0 4girlsfingerpaint.com
0.0.0.0 4girlsfingerpaint.org
0.0.0.0 bagslap.com
0.0.0.0 ballsack.org
0.0.0.0 bestgore.fun
0.0.0.0 bestshockers.com
0.0.0.0 bluewaffle.biz
0.0.0.0 bottleguy.com
0.0.0.0 bowlgirl.com
0.0.0.0 cadaver.org
0.0.0.0 clownsong.com
0.0.0.0 cyberscat.com
0.0.0.0 dadparty.com
0.0.0.0 detroithardcore.com
0.0.0.0 donotwatch.org
0.0.0.0 dontwatch.us
0.0.0.0 eelsoup.net
0.0.0.0 fruitlauncher.com
0.0.0.0 funnelchair.com
0.0.0.0 goatse.bz
0.0.0.0 goatse.ru
0.0.0.0 goatsegirl.org
0.0.0.0 hai2u.com
0.0.0.0 homewares.org
0.0.0.0 howtotroll.org
0.0.0.0 japscat.org
0.0.0.0 jarsquatter.com
0.0.0.0 jiztini.com
0.0.0.0 kids-in-sandbox.com
0.0.0.0 kidsinsandbox.info
0.0.0.0 lemonparty.biz
0.0.0.0 lemonparty.org
0.0.0.0 lolhello.com
0.0.0.0 lolshock.com
0.0.0.0 loltrain.com
0.0.0.0 meatspin.biz
0.0.0.0 meatspin.com
0.0.0.0 merryholidays.org
0.0.0.0 milkfountain.com
0.0.0.0 mudfall.com
0.0.0.0 mudmonster.org
0.0.0.0 nimp.org
0.0.0.0 nobrain.dk
0.0.0.0 nutabuse.com
0.0.0.0 octopusgirl.com
0.0.0.0 on.nimp.org
0.0.0.0 painolympics.info
0.0.0.0 painolympics.org
0.0.0.0 phonejapan.com
0.0.0.0 pnrtscr.com
0.0.0.0 pressurespot.com
0.0.0.0 prolapseman.com
0.0.0.0 scrollbelow.com
0.0.0.0 selfpwn.org
0.0.0.0 shockgore.com
0.0.0.0 sourmath.com
0.0.0.0 strawpoii.me
0.0.0.0 suckdude.com
0.0.0.0 thatsjustgay.com
0.0.0.0 thatsphucked.com
0.0.0.0 thehomo.org
0.0.0.0 themacuser.org
0.0.0.0 thepounder.com
0.0.0.0 tubgirl.me
0.0.0.0 tubgirl.org
0.0.0.0 turdgasm.com
0.0.0.0 vomitgirl.org
0.0.0.0 walkthedinosaur.com
0.0.0.0 whipcrack.org
0.0.0.0 wormgush.com
0.0.0.0 www.1girl1pitcher.org
0.0.0.0 www.1guy1cock.com
0.0.0.0 www.1man1jar.org
0.0.0.0 www.1man2needles.com
0.0.0.0 www.1priest1nun.com
0.0.0.0 www.1priest1nun.net
0.0.0.0 www.2girls1cup-free.com
0.0.0.0 www.2girls1cup.cc
0.0.0.0 www.2girls1cup.nl
0.0.0.0 www.2girls1cup.ws
0.0.0.0 www.2girls1finger.org
0.0.0.0 www.2guys1stump.org
0.0.0.0 www.3guys1hammer.ws
0.0.0.0 www.4girlsfingerpaint.org
0.0.0.0 www.bagslap.com
0.0.0.0 www.ballsack.org
0.0.0.0 www.bestshockers.com
0.0.0.0 www.bluewaffle.biz
0.0.0.0 www.bottleguy.com
0.0.0.0 www.bowlgirl.com
0.0.0.0 www.cadaver.org
0.0.0.0 www.clownsong.com
0.0.0.0 www.cyberscat.com
0.0.0.0 www.dadparty.com
0.0.0.0 www.detroithardcore.com
0.0.0.0 www.donotwatch.org
0.0.0.0 www.dontwatch.us
0.0.0.0 www.eelsoup.net
0.0.0.0 www.fruitlauncher.com
0.0.0.0 www.funnelchair.com
0.0.0.0 www.goatse.bz
0.0.0.0 www.goatse.ru
0.0.0.0 www.goatsegirl.org
0.0.0.0 www.hai2u.com
0.0.0.0 www.homewares.org
0.0.0.0 www.howtotroll.org
0.0.0.0 www.japscat.org
0.0.0.0 www.jiztini.com
0.0.0.0 www.kids-in-sandbox.com
0.0.0.0 www.kidsinsandbox.info
0.0.0.0 www.lemonparty.biz
0.0.0.0 www.lemonparty.org
0.0.0.0 www.lolhello.com
0.0.0.0 www.lolshock.com
0.0.0.0 www.loltrain.com
0.0.0.0 www.meatspin.biz
0.0.0.0 www.meatspin.com
0.0.0.0 www.merryholidays.org
0.0.0.0 www.milkfountain.com
0.0.0.0 www.mudfall.com
0.0.0.0 www.mudmonster.org
0.0.0.0 www.nimp.org
0.0.0.0 www.nobrain.dk
0.0.0.0 www.nutabuse.com
0.0.0.0 www.octopusgirl.com
0.0.0.0 www.on.nimp.org
0.0.0.0 www.painolympics.info
0.0.0.0 www.painolympics.org
0.0.0.0 www.phonejapan.com
0.0.0.0 www.pressurespot.com
0.0.0.0 www.prolapseman.com
0.0.0.0 www.punishtube.com
0.0.0.0 www.scrollbelow.com
0.0.0.0 www.selfpwn.org
0.0.0.0 www.sourmath.com
0.0.0.0 www.strawpoii.me
0.0.0.0 www.suckdude.com
0.0.0.0 www.thatsjustgay.com
0.0.0.0 www.thatsphucked.com
0.0.0.0 www.theexgirlfriends.com
0.0.0.0 www.thehomo.org
0.0.0.0 www.themacuser.org
0.0.0.0 www.thepounder.com
0.0.0.0 www.tubgirl.me
0.0.0.0 www.tubgirl.org
0.0.0.0 www.turdgasm.com
0.0.0.0 www.vomitgirl.org
0.0.0.0 www.walkthedinosaur.com
0.0.0.0 www.whipcrack.org
0.0.0.0 www.wormgush.com
0.0.0.0 www.xvideoslive.com
0.0.0.0 www.youaresogay.com
0.0.0.0 www.ypmate.com
0.0.0.0 www.zentastic.com
0.0.0.0 youaresogay.com
0.0.0.0 zentastic.com
#</shock-sites>

# Acknowledgements
# I'd like to thank the following people for submitting sites, and
# helping promote the site.

# Bill Allison, Harj Basi, Lance Russhing, Marshall Drew-Brook, 
#  Leigh Brasington, Scott Terbush, Cary Newfeldt, Kaye, Jeff
#  Scrivener, Mark Hudson, Matt Bells, T. Kim Nguyen, Lino Demasi,
#  Marcelo Volmaro, Troy Martin, Donald Kerns, B.Patten-Walsh,
#  bobeangi, Chris Maniscalco, George Gilbert, Kim Nilsson, zeromus,
#  Robert Petty, Rob Morrison, Clive Smith, Cecilia Varni, OleKing 
#  Cole, William Jones, Brian Small, Raj Tailor, Richard Heritage,
#  Alan Harrison, Ordorica, Crimson, Joseph Cianci, sirapacz, 
#  Dvixen, Matthew Craig, Tobias Hessem, Kevin F. Quinn, Thomas 
#  Corthals, Chris McBee, Jaime A. Guerra, Anders Josefson, 
#  Simon Manderson, Spectre Ghost, Darren Tay, Dallas Eschenauer, Cecilia
#  Varni, Adam P. Cole, George Lefkaditis, grzesiek, Adam Howard, Mike 
#  Bizon, Samuel P. Mallare, Leinweber, Walter Novak, Stephen Genus, 
#  Zube, Johny Provoost, Peter Grafton, Johann Burkard, Magus, Ron Karner,
#  Fredrik Dahlman, Michele Cybula, Bernard Conlu, Riku B, Twillers, 
#  Shaika-Dzari, Vartkes Goetcherian, Michael McCown, Garth, Richard Nairn,
#  Exzar Reed, Robert Gauthier, Floyd Wilder, Mark Drissel, Kenny Lyons,
#  Paul Dunne, Tirath Pannu, Mike Lambert, Dan Kolcun, Daniel Aleksandersen,
#  Chris Heegard, Miles Golding, Daniel Bisca, Frederic Begou, Charles 
#  Fordyce, Mark Lehrer, Sebastien Nadeau-Jean, Russell Gordon, Alexey 
#  Gopachenko, Stirling Pearson, Alan Segal, Bobin Joseph, Chris Wall, Sean
#  Flesch, Brent Getz, Jerry Cain, Brian Micek, Lee Hancock, Kay Thiele,
#  Kwan Ting Chan, Wladimir Labeikovsky, Lino Demasi, Bowie Bailey, Andreas 
#  Marschall, Michael Tompkins, Michael O'Donnell, Jos&eacute; Lucas Teixeira
#  de Oliveira, M. &Ouml;mer G&ouml;lgeli, and Anthony Gelibert for helping to build 
#  the hosts file.
# Russell O'Connor for OS/2 information
# kwadronaut for Windows 7 and Vista information
# John Mueller and Lawrence H Smith for Mac Pre-OSX information
# Jesse Baird for the Cisco IOS script
'@

#  cleanup_main.bat - written to the Desktop by Build-DesktopTools
$script:CleanupMainBat = @'
@echo off
setlocal EnableExtensions
title Windows Cleanup

:: ============================================================
::  cleanup.bat - scan, choose, then clean.
::
::  Scans everything first and shows you the sizes, then asks
::  what to do. Nothing is deleted before you pick.
::
::  Elevates itself to Administrator automatically.
:: ============================================================

:: --- Self-elevate if not already admin ---
net session >nul 2>&1
if errorlevel 1 (
    echo Requesting administrator privileges...
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

set "LOG=%~dp0cleanup.log"
:: Keep the log from growing without bound - trim to the last 300 lines past 512 KB
for %%L in ("%LOG%") do if %%~zL GTR 524288 (
    powershell -NoProfile -Command "$p='%LOG%'; Get-Content -LiteralPath $p -Tail 300 | Set-Content -LiteralPath ($p + '.tmp'); Move-Item -LiteralPath ($p + '.tmp') -Destination $p -Force" >nul 2>&1
)

set "PF86=%ProgramFiles(x86)%"
:: Unique per run. A fixed name can get locked by security software,
:: and then every future run silently fails to write it.
:: Working files live beside the script, not in %TEMP%. Two reasons: %TEMP% is
:: the folder this script deletes, and short-lived .tmp files appearing there
:: look like a dropper to behavioural AV (Bitdefender ATC quarantines them).
set "TALLY=%~dp0.clnp_tally.tmp"
set "ROWS=%~dp0.clnp_rows.tmp"
set "HUNG=%~dp0.clnp_hung.tmp"
set "HUNGCOUNT=0"
set "DAYS=90"

:: Disk Cleanup handlers that start UNTICKED. Everything else starts ticked.
:: You get a screen to toggle any of them before Disk Cleanup runs.
::   DownloadsFolder deletes your ENTIRE Downloads folder, not just old files,
::   which is why it is the one left off by default.
:: "Recycle Bin" is here because this script empties bins itself, honouring
:: your C:-only / all-drives choice. cleanmgr would ignore that and empty
:: every drive. Leave it unticked unless you want that.
set "CMGR_SKIP=DownloadsFolder;Recycle Bin"


echo.
call :Log "=== Cleanup started %date% %time% ==="


:: ============================================================
::  PHASE 1 - SCAN (reads only, deletes nothing)
:: ============================================================
cls
echo.
echo   Scanning... this takes a few seconds.
echo.

del /f /q "%TALLY%" "%ROWS%" "%HUNG%" >nul 2>&1
set "DRYRUN=1"
set "PASS=S"
call :AllTargets

for /f "usebackq delims=" %%T in (`powershell -NoProfile -Command "$t=0; if (Test-Path -LiteralPath $env:TALLY) { foreach ($l in Get-Content -LiteralPath $env:TALLY) { $t += [int64]$l } }; '{0:N1} MB' -f ($t/1MB)"`) do set "TOTAL=%%T"

call :ScanHung


cls
echo.
echo   ============================================================
echo     SCAN RESULTS
echo   ============================================================
echo.
echo     SAFE TO DELETE - caches Windows rebuilds by itself
echo     ------------------------------------------------------
type "%ROWS%" 2>nul
echo     ------------------------------------------------------
echo     Total                            %TOTAL%
echo.
echo     NOT RESPONDING - apps Windows reports as hung
echo     ------------------------------------------------------
type "%HUNG%" 2>nul
echo.
echo     Your Downloads and Recycle Bin are NOT scanned by default.
echo     Option [5] sizes them up only if you ask for it.
echo.
call :CheckBrowsers


:: ============================================================
::  PHASE 2 - MENU
:: ============================================================
:Menu
echo   ============================================================
echo     WHAT DO YOU WANT TO DO?
echo   ============================================================
echo.
echo     [1]  Do everything   Close the hung apps above, delete everything
echo                          above, empty the Recycle Bin for good, run
echo                          Disk Cleanup, then trim memory.
echo                          Your Downloads are NOT touched.
echo.
echo     [2]  Trim only       Free memory only - nothing is deleted
echo.
echo     [3]  Keep browsers   Same as [1], but browser memory left alone
echo.
echo     [4]  Kill hung only  Force-close the not-responding apps listed
echo                          above. Unsaved work in them is lost.
echo.
echo     [5]  Clean + Downloads
echo                          Everything in [1] PLUS Downloads older than
echo                          %DAYS% days, sent to the Recycle Bin
echo.
echo     [6]  Exit            Change nothing
echo.
rem  set /p instead of choice, so a mistyped key does not beep. PICK still
rem  ends up holding the digit you typed, so the branching below is
rem  unchanged. The attempt cap stops this looping forever when stdin is
rem  not a console - set /p returns an empty string instantly there.
set "TRIES=0"
:AskPick
set "PICK="
set /p "PICK=   Choose [1-6]: "
if "%PICK%"=="1" goto :GotPick
if "%PICK%"=="2" goto :GotPick
if "%PICK%"=="3" goto :GotPick
if "%PICK%"=="4" goto :GotPick
if "%PICK%"=="5" goto :GotPick
if "%PICK%"=="6" goto :GotPick
set /a TRIES+=1
if %TRIES% GEQ 10 (
    echo.
    echo    No usable answer after 10 attempts - exiting without changes.
    goto :Bail
)
echo    Type a number from 1 to 6.
goto :AskPick
:GotPick
echo.

if "%PICK%"=="6" goto :Bail
if "%PICK%"=="2" goto :DoTrimOnly
if "%PICK%"=="4" goto :DoKillHung
if "%PICK%"=="5" goto :DoDownloads
if "%PICK%"=="3" set "KEEPBROWSERS=1"
goto :DoClean


:: ============================================================
::  PHASE 3 - ACT
:: ============================================================
:DoKillHung
if "%HUNGCOUNT%"=="0" (
    call :Log "Nothing is hung - no apps to close."
    goto :Finish
)
echo   These will be force-closed. Anything unsaved in them is lost:
echo.
type "%HUNG%" 2>nul
echo.
rem  set /p instead of choice - choice.exe beeps at the console on any key
rem  outside its list and no flag silences it. Same answers accepted.
rem  If no answer can be read at all the fallback is to LEAVE the apps
rem  running: force-closing them loses unsaved work, so that is the side
rem  to err on. Note this script runs without DelayedExpansion, hence
rem  %VAR% rather than !VAR! below.
set "TRIES=0"
:AskKill
set "KILLANS="
set /p "KILLANS=   Force-close them? [Y/N] "
if /i "%KILLANS%"=="Y" goto :DoKillNow
if /i "%KILLANS%"=="YES" goto :DoKillNow
if /i "%KILLANS%"=="N" goto :LeaveRunning
if /i "%KILLANS%"=="NO" goto :LeaveRunning
set /a TRIES+=1
if %TRIES% GEQ 10 goto :LeaveRunning
echo    Type Y to force-close, or N to leave them running.
goto :AskKill
:LeaveRunning
call :Log "Left running - nothing was closed."
goto :Finish
:DoKillNow
call :KillHung
goto :Finish

:DoDownloads
echo   Checking Downloads...
for /f "usebackq delims=" %%D in (`powershell -NoProfile -Command "$cut=(Get-Date).AddDays(-[int]$env:DAYS); $b=0; $n=0; foreach ($f in @(Get-ChildItem ($env:USERPROFILE+'\Downloads') -Force -File -EA SilentlyContinue)) { if ($f.LastWriteTime -lt $cut) { $b+=$f.Length; $n++ } }; '{0} files, {1:N1} GB' -f $n, ($b/1GB)"`) do set "DLINFO=%%D"
echo.
echo   Downloads older than %DAYS% days: %DLINFO%
echo   These go to the Recycle Bin, so you can restore them afterwards.
echo.
set "CONFIRM="
set /p "CONFIRM=  Type DELETE to confirm, or press Enter to skip: "
if /i not "%CONFIRM%"=="DELETE" (
    call :Log "Downloads left alone - not confirmed."
    goto :DoClean
)
set "DODOWNLOADS=1"
goto :DoClean

:DoClean
call :FindDrives
call :CleanScope
call :CmgrChoose
if not "%HUNGCOUNT%"=="0" (
    call :Log "Closing hung apps..."
    call :KillHung
)
call :Log "Cleaning..."
for /f %%a in ('powershell -NoProfile -Command "(Get-PSDrive C).Free"') do set "BEFORE=%%a"
set "DRYRUN="
set "PASS=C"
call :AllTargets
call :EmptyBins
if defined DODOWNLOADS call :CleanDownloads
call :DiskCleanup
for /f %%a in ('powershell -NoProfile -Command "(Get-PSDrive C).Free"') do set "AFTER=%%a"
echo.
for /f "usebackq delims=" %%a in (`powershell -NoProfile -Command "$d = %AFTER% - %BEFORE%; if ($d -ge 1MB) { 'Reclaimed {0:N1} MB.  Free space on C: is now {1:N1} GB.' -f ($d/1MB), (%AFTER%/1GB) } elseif ($d -gt 0) { 'Reclaimed less than 1 MB.  Free space on C: is now {0:N1} GB.' -f (%AFTER%/1GB) } else { 'No net space reclaimed - nothing left to clean.  Free space on C: is now {0:N1} GB.' -f (%AFTER%/1GB) }"`) do call :Log "%%a"

:: Re-measure the same targets. Anything still there was locked by a
:: running process - del cannot touch an open file, and says nothing.
del /f /q "%TALLY%" >nul 2>&1
set "DRYRUN=1"
set "PASS=V"
call :AllTargets
set "DRYRUN="
for /f "usebackq delims=" %%L in (`powershell -NoProfile -Command "$t=0; if (Test-Path -LiteralPath $env:TALLY) { foreach ($l in Get-Content -LiteralPath $env:TALLY) { $t += [int64]$l } }; if ($t -gt 1MB) { '  {0:N1} MB was in use by running apps and could not be deleted.' -f ($t/1MB) }"`) do call :Log "%%L"

:DoTrimOnly
echo.
call :Log "Trimming process working sets..."
call :TrimMemory
goto :Finish

:Bail
call :Log "Exited - nothing was changed."

:Finish
del /f /q "%TALLY%" "%ROWS%" "%HUNG%" >nul 2>&1
if defined DIDCMGR call :Log "Note: some Update Cleanup finishes on your next restart."
call :Log "=== Cleanup finished %date% %time% ==="
echo.
echo   Log: %LOG%
echo.
:: Counts down and closes on its own. Press any key to stop the countdown
:: and hold the window open; press any key again to close it.
:: Falls back to a plain 3 second wait if there is no real console.
powershell -NoProfile -Command "$cr=[string][char]13; try { $end=(Get-Date).AddSeconds(3); $paused=$false; while ($true) { $left=[int][Math]::Ceiling(($end-(Get-Date)).TotalSeconds); if ($left -le 0) { break } if ([Console]::KeyAvailable) { [void][Console]::ReadKey($true); $paused=$true; break } Write-Host -NoNewline ($cr+'   Closing in '+$left+' ...  press any key to stay open '); Start-Sleep -Milliseconds 100 } Write-Host -NoNewline ($cr+(' '*62)+$cr); if ($paused) { Write-Host '   Paused. Press any key to close.'; while ([Console]::KeyAvailable) { [void][Console]::ReadKey($true) } [void][Console]::ReadKey($true) } } catch { Start-Sleep -Seconds 3 }"
if errorlevel 1 "%SystemRoot%\System32\ping.exe" -n 4 127.0.0.1 >nul 2>&1
exit /b


:: ============================================================
::  Target list - called twice: once to scan, once to clean
:: ============================================================
:AllTargets
call :CleanDir "%TEMP%"                                             "User temp"
call :CleanDir "%LOCALAPPDATA%\Temp"                                "User temp (alt)"
call :CleanDir "%SystemRoot%\Temp"                                  "System temp"
call :CleanDir "%SystemRoot%\SoftwareDistribution\Download"         "Windows Update cache"
call :CleanDir "%SystemRoot%\SoftwareDistribution\DeliveryOptimization" "Delivery Optimization"
call :CleanDir "%LOCALAPPDATA%\CrashDumps"                          "Crash dumps"
call :CleanDir "%ProgramData%\Microsoft\Windows\WER\ReportQueue"    "Error reports (queue)"
call :CleanDir "%ProgramData%\Microsoft\Windows\WER\ReportArchive"  "Error reports (archive)"
call :Thumbnails
if not defined DRYRUN ipconfig /flushdns >nul 2>&1
:: Detached on purpose. Run elevated and in the foreground this works through
:: Windows' entire idle-maintenance queue and blocks for minutes. It is not
:: part of cleaning at all - delete these two lines if you do not want it.
if not defined DRYRUN start "" /b "%SystemRoot%\System32\rundll32.exe" advapi32.dll,ProcessIdleTasks
if not defined DRYRUN call :Log "  idle maintenance kicked off in the background"
goto :eof


:: ============================================================
::  Subroutines
:: ============================================================

:CleanDir
:: %1 = folder, %2 = label for the table.
:: Deletes the CONTENTS of a folder (files and subfolders), not the folder.
:: Refuses empty paths, drive roots, critical dirs and browser profiles.
if "%~1"=="" goto :eof
set "_CD=%~f1"
set "_LBL=%~2"
if "%_CD:~3%"=="" (
    call :Log "  REFUSED (drive root): %_CD%"
    goto :eof
)
for %%X in ("%SystemRoot%" "%SystemRoot%\System32" "%SystemDrive%\Users" "%ProgramFiles%" "%PF86%" "%ProgramData%" "%USERPROFILE%" "%LOCALAPPDATA%" "%APPDATA%" "%LOCALAPPDATA%\Google" "%LOCALAPPDATA%\Google\Chrome" "%LOCALAPPDATA%\Google\Chrome\User Data" "%LOCALAPPDATA%\Microsoft\Edge" "%LOCALAPPDATA%\Microsoft\Edge\User Data" "%LOCALAPPDATA%\BraveSoftware" "%LOCALAPPDATA%\Vivaldi" "%APPDATA%\Mozilla" "%APPDATA%\Opera Software") do (
    if /i "%_CD%"=="%%~fX" (
        call :Log "  REFUSED (protected): %_CD%"
        goto :eof
    )
)
if not exist "%_CD%\" goto :eof
:: Skip folders already handled this pass (%TEMP% and %LOCALAPPDATA%\Temp are often one folder)
set "_KEY=%_CD:\=_%"
set "_KEY=%_KEY::=%"
set "_KEY=%_KEY: =%"
if defined _SEEN%PASS%%_KEY% goto :eof
set "_SEEN%PASS%%_KEY%=1"

if defined DRYRUN (
    powershell -NoProfile -Command "$i=@(Get-ChildItem -LiteralPath '%_CD%' -Recurse -Force -File -EA SilentlyContinue); $s=0; foreach($f in $i){$s+=$f.Length}; Add-Content -LiteralPath $env:TALLY -Value $s; $r='     {0,-28}{1,10:N1} MB{2,8} files' -f $env:_LBL, ($s/1MB), $i.Count; Add-Content -LiteralPath $env:ROWS -Value $r" >nul 2>&1
    goto :eof
)
del /s /f /q "%_CD%\*.*" >nul 2>&1
for /d %%D in ("%_CD%\*") do rd /s /q "%%~fD" >nul 2>&1
call :Log "  cleaned: %_CD%"
goto :eof


:Thumbnails
if defined DRYRUN (
    powershell -NoProfile -Command "$i=@(Get-ChildItem -LiteralPath ($env:LOCALAPPDATA+'\Microsoft\Windows\Explorer') -Filter '*cache_*.db' -Force -File -EA SilentlyContinue); $s=0; foreach($f in $i){$s+=$f.Length}; Add-Content -LiteralPath $env:TALLY -Value $s; $r='     {0,-28}{1,10:N1} MB{2,8} files' -f 'Thumbnail/icon cache', ($s/1MB), $i.Count; Add-Content -LiteralPath $env:ROWS -Value $r" >nul 2>&1
    goto :eof
)
taskkill /f /im explorer.exe >nul 2>&1
del /f /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
del /f /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\iconcache_*.db"  >nul 2>&1
start "" explorer.exe
call :Log "  cleared thumbnail/icon cache (Explorer restarted)"
goto :eof




:DiskCleanup
:: Runs cleanmgr ONCE. Do not add per-drive calls: Windows ignores /d when it
:: is combined with /sagerun, so each call sweeps every drive anyway. Looping
:: over drives just repeats the whole job N times (hung a run on 2026-09-12).
:: The only mode that honours /d is /VERYLOWDISK, which force-enables every
:: handler including DownloadsFolder - it would wipe the whole Downloads folder.
if defined SKIPCMGR (
    call :Log "Disk Cleanup skipped."
    goto :eof
)
call :Log "Running Windows Disk Cleanup - its own window shows progress..."
for /f "usebackq delims=" %%C in (`powershell -NoProfile -Command "$p=Start-Process ($env:SystemRoot+'\System32\cleanmgr.exe') -ArgumentList '/sagerun:65' -PassThru; if ($p.WaitForExit(900000)) { '  Disk Cleanup finished (all drives)' } else { '  Disk Cleanup is still going - it will finish on its own' }"`) do call :Log "%%C"
set "DIDCMGR=1"
goto :eof





:FindDrives
:: Plain "if exist" probes - no WMI enumeration, no free-space measurement.
set "DLIST="
for %%D in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist %%D:\ call :AddDrive %%D
goto :eof

:AddDrive
set "DLIST=%DLIST% %~1"
goto :eof

:CleanScope
:: The Recycle Bin is the only genuinely per-drive thing here. Every other
:: handler only ever touches the system drive, so scope changes nothing else.
echo.
echo   ============================================================
echo     SCOPE
echo   ============================================================
echo.
echo     [1]  C: drive only                            (default)
echo          Disk Cleanup restricted to C:-only items, and only the
echo          C: Recycle Bin is emptied.
echo.
echo     [2]  All drives -%DLIST%
echo          Also clears per-volume leftovers (FOUND.00x, Catalog.wci)
echo          and empties the Recycle Bin on every drive.
echo.
set "SCOPE="
set /p "SCOPE=  Press ENTER for C: only, or type 2 for all drives: "
if "%SCOPE%"=="2" (
    set "BINDRIVES=%DLIST%"
) else (
    set "BINDRIVES=C"
    rem These three are the ONLY cleanmgr handlers with volume-relative paths
    rem (?:\msdownld.tmp, ?:\Catalog.wci, ?:\FOUND.00x). Unticking them leaves
    rem every remaining handler hard-coded to C:, so Disk Cleanup cannot reach
    rem another drive. Side effect: C:\Windows\msdownld.tmp is skipped too.
    set "CMGR_SKIP=%CMGR_SKIP%;Active Setup Temp Folders;Content Indexer Cleaner;Old ChkDsk Files"
)
goto :eof

:CmgrChoose
:: Interactive tick list. Writes the selection to Disk Cleanup profile 65.
:: Exit code 2 means skip Disk Cleanup altogether.
powershell -NoProfile -Command "$base='HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches'; $names=@(); foreach ($k in Get-ChildItem $base -EA SilentlyContinue) { $names += $k.PSChildName }; [Array]::Sort($names); $skip=@($env:CMGR_SKIP -split ';'); $state=@{}; foreach ($n in $names) { $state[$n] = (-not ($skip -contains $n)) }; $risky=@{}; $risky['DownloadsFolder']='deletes your ENTIRE Downloads folder'; $risky['Recycle Bin']='leave OFF - this script empties bins per your scope'; $risky['Previous Installations']='removes Windows.old, no rollback'; $risky['Windows ESD installation files']='breaks Reset this PC without media'; while ($true) { Clear-Host; Write-Host ''; Write-Host '   DISK CLEANUP - tick what you want removed'; Write-Host '   ---------------------------------------------------------------'; for ($i=0; $i -lt $names.Count; $i++) { $n=$names[$i]; $m='[ ]'; if ($state[$n]) { $m='[X]' }; $note=''; if ($risky.ContainsKey($n)) { $note='   ** ' + $risky[$n] }; Write-Host ('   {0,2} {1} {2}{3}' -f ($i+1), $m, $n, $note) }; Write-Host ''; Write-Host '   numbers = toggle (e.g. 3 or 3,7,12)   A = all on   N = all off   D = defaults'; Write-Host '   S = skip Disk Cleanup entirely'; Write-Host ''; $in=Read-Host '   Press ENTER to run Disk Cleanup with the ticked items, or type a choice'; $t=$in.Trim(); if ($t -eq '') { break }; if ($t -eq 'S' -or $t -eq 's') { exit 2 }; if ($t -eq 'A' -or $t -eq 'a') { foreach ($n in $names) { $state[$n]=$true }; continue }; if ($t -eq 'N' -or $t -eq 'n') { foreach ($n in $names) { $state[$n]=$false }; continue }; if ($t -eq 'D' -or $t -eq 'd') { foreach ($n in $names) { $state[$n] = (-not ($skip -contains $n)) }; continue }; foreach ($part in ($t -split '[,\s]+')) { $num=0; if ([int]::TryParse($part, [ref]$num)) { if ($num -ge 1 -and $num -le $names.Count) { $key=$names[$num-1]; $state[$key] = (-not $state[$key]) } } } }; $on=0; $off=0; try { foreach ($n in $names) { $v=0; if ($state[$n]) { $v=2 }; $null=New-ItemProperty -Path ($base + '\' + $n) -Name StateFlags0065 -Value $v -PropertyType DWord -Force -EA Stop; if ($v -eq 2) { $on++ } else { $off++ } }; Write-Host ('   {0} handlers ticked, {1} left off' -f $on, $off) } catch { Write-Host ('   could not save Disk Cleanup options: ' + $_.Exception.Message); exit 2 }; exit 0"
if errorlevel 2 set "SKIPCMGR=1"
goto :eof

:EmptyBins
:: Permanent deletion by design - bin treated as a shredder, not a holding pen.
:: Runs BEFORE the Downloads step on purpose, so anything option [5] moves into
:: the bin afterwards is still recoverable.
:: Clear-RecycleBin throws Win32Exception even when it succeeds, so that
:: exception is treated as success - only other errors count as a skip.
for /f "usebackq delims=" %%B in (`powershell -NoProfile -Command "$ds=@($env:BINDRIVES.Trim() -split '\s+'); $done=@(); $skip=@(); foreach ($d in $ds) { if ($d -ne '') { try { Clear-RecycleBin -DriveLetter $d -Force -ErrorAction Stop; $done += $d } catch [System.ComponentModel.Win32Exception] { $done += $d } catch { $skip += $d } } }; if ($done.Count) { '  Recycle Bin permanently emptied on: ' + ($done -join ', ') }; if ($skip.Count) { '  No Recycle Bin on: ' + ($skip -join ', ') }; if (-not $done.Count -and -not $skip.Count) { '  Recycle Bin: no drives in scope' }"`) do call :Log "%%B"
goto :eof

:CleanDownloads
:: Sends old Downloads to the Recycle Bin rather than deleting outright,
:: so a mistake here is recoverable.
for /f "usebackq delims=" %%D in (`powershell -NoProfile -Command "Add-Type -AssemblyName Microsoft.VisualBasic; $cut=(Get-Date).AddDays(-[int]$env:DAYS); $n=0; $b=0; foreach ($f in @(Get-ChildItem ($env:USERPROFILE+'\Downloads') -Force -File -EA SilentlyContinue)) { if ($f.LastWriteTime -lt $cut) { try { $sz=$f.Length; [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile($f.FullName,'OnlyErrorDialogs','SendToRecycleBin'); $n++; $b+=$sz } catch {} } }; '  Downloads: {0} files ({1:N1} GB) sent to Recycle Bin' -f $n, ($b/1GB)"`) do call :Log "%%D"
goto :eof


:ScanHung
:: A process only has a meaningful Responding value if it owns a window,
:: so background services are never counted as hung.
for /f "usebackq delims=" %%H in (`powershell -NoProfile -Command "$h=@(); foreach ($p in Get-Process) { try { if ($p.MainWindowHandle -ne 0 -and -not $p.Responding) { $h += $p } } catch {} }; $o=@(); foreach ($p in $h) { $o += '     {0,-28}PID {1}' -f $p.ProcessName, $p.Id }; if ($o.Count -eq 0) { $o = @('     none - everything is responding') }; Set-Content -LiteralPath $env:HUNG -Value $o; $h.Count"`) do set "HUNGCOUNT=%%H"
goto :eof

:KillHung
:: Never touches core OS processes. Explorer is allowed but restarted,
:: since a hung shell is one of the main reasons to run this.
for /f "usebackq delims=" %%K in (`powershell -NoProfile -Command "$crit=@('System','Idle','Registry','smss','csrss','wininit','winlogon','services','lsass','dwm','fontdrvhost','LogonUI','Memory Compression'); $killed=@(); $shell=$false; foreach ($p in Get-Process) { try { if ($p.MainWindowHandle -ne 0 -and -not $p.Responding) { if ($crit -contains $p.ProcessName) { continue }; $n=$p.ProcessName; Stop-Process -Id $p.Id -Force -EA Stop; $killed += $n; if ($n -eq 'explorer') { $shell=$true } } } catch {} }; if ($shell) { Start-Process explorer.exe }; if ($killed.Count) { '  closed {0}: {1}' -f $killed.Count, ($killed -join ', ') } else { '  nothing could be closed' }"`) do call :Log "%%K"
goto :eof

:CheckBrowsers
:: %TEMP% holds in-progress downloads and files opened straight from a browser.
set "BROWSING="
for /f "usebackq delims=" %%B in (`powershell -NoProfile -Command "$n=@(Get-Process chrome,msedge,firefox,brave,opera,vivaldi -EA SilentlyContinue); if ($n.Count) { $g=@(); foreach ($p in $n) { if ($g -notcontains $p.ProcessName) { $g+=$p.ProcessName } }; $g -join ', ' }"`) do set "BROWSING=%%B"
if not defined BROWSING goto :eof
echo     NOTE: browser running (%BROWSING%). Profiles, bookmarks and
echo     passwords are never touched, but your temp folder holds
echo     in-progress downloads. Close it first if one is running.
echo.
goto :eof


:TrimMemory
:: Asks Windows to page out each process idle working set. Non-destructive:
:: no file or setting changes, and pages fault back in on demand.
:: Uses the .NET MaxWorkingSet setter instead of a native P/Invoke, because
:: compiling C# at runtime is a heavily weighted signal for behavioural AV.
for /f "usebackq delims=" %%M in (`powershell -NoProfile -Command "$before = (Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory * 1KB; $ok=0; $skip=0; $bskip=0; $browsers = @('chrome','msedge','firefox','brave','opera','opera_gx','vivaldi','iexplore','browser_broker','msedgewebview2'); $leave = ($env:KEEPBROWSERS -eq '1'); foreach ($p in Get-Process) { if ($leave -and ($browsers -contains $p.ProcessName)) { $bskip++; continue }; try { $p.MaxWorkingSet = $p.MaxWorkingSet; $ok++ } catch { $skip++ } }; Start-Sleep -Milliseconds 500; $after = (Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory * 1KB; '  trimmed {0} processes, {1} skipped (protected/system), {2} browser processes left alone' -f $ok, $skip, $bskip; '  free RAM {0:N0} MB to {1:N0} MB (gain {2:+#,##0;-#,##0;0} MB)' -f ($before/1MB), ($after/1MB), (($after-$before)/1MB)"`) do call :Log "%%M"
goto :eof


:Log
echo %~1
echo [%date% %time%] %~1 >> "%LOG%"
goto :eof
'@

#  net-reset-reboot.bat - written to the Desktop, and invoked by NetResetReboot with /y /none
$script:NetResetRebootBat = @'
@echo off
setlocal EnableExtensions EnableDelayedExpansion
set "ALLARGS=%*"
set "RELAUNCH=%*"
set "SCRIPT=%~f0"
set "SCRIPTDIR=%~dp0"
title Windows Network Stack Reset

rem =====================================================================
rem  net-reset-reboot.bat  -  full TCP/IP + Winsock + DNS reset for Windows
rem
rem  Usage:
rem    net-reset-reboot.bat [/firewall] [/y] [/force] [/dryrun]
rem                         [/restart] [/shutdown] [/none]
rem    net-reset-reboot.bat /verify
rem
rem  Run it with no arguments - double-clicking counts - and it shows a
rem  three option menu: run the reset, dry run, or verify. Pressing Enter
rem  picks the reset.
rem
rem    /firewall  also reset Windows Firewall to defaults (deletes custom rules)
rem    /y         skip the "are you sure" prompt
rem    /force     run even from a remote/RDP session (you WILL be disconnected)
rem    /restart   restart when finished (recommended)
rem    /shutdown  shut down when finished
rem    /none      leave the machine running (a reboot is still required)
rem    /dryrun    print every command without running anything
rem    /verify    run ONLY the connectivity checks and append them to the
rem               last reset log - use this after the reboot to see whether
rem               anything actually improved. Changes nothing, needs no
rem               admin rights.
rem
rem  Statically configured DNS servers are saved before the reset and put
rem  back afterwards, so custom resolvers survive the process.
rem
rem  Files written to netreset-logs\ next to this script:
rem    netreset_<stamp>.log          the readable step-by-step record
rem    netsh-config_<stamp>.txt      full netsh config, restore with
rem                                    netsh -f "netsh-config_<stamp>.txt"
rem    winsock-catalog_<stamp>.txt   Winsock providers as they were before
rem                                    the reset removed the third-party ones
rem    ipreset_<stamp>.log           netsh's own reset logs
rem    dns-static_<stamp>.txt        your hand-set DNS servers, saved so they
rem                                    survive the reset. Deleted once they
rem                                    are put back, and KEPT only if the
rem                                    restore failed, so you can recover
rem                                    them by hand.
rem =====================================================================

set "DO_FIREWALL=0"
set "ASSUME_YES=0"
set "ENDACTION=ask"
set "DRYRUN=0"
set "FORCE=0"
set "VERIFY=0"
set "NOMENU=0"
set "STEPNUM=0"
set "FAILS=0"

rem ---------- parse arguments ------------------------------------------
:parse
if "%~1"=="" goto :parsed
if /i "%~1"=="/firewall" set "DO_FIREWALL=1"
if /i "%~1"=="/y"        set "ASSUME_YES=1"
if /i "%~1"=="/force"    set "FORCE=1"
if /i "%~1"=="/verify"   set "VERIFY=1"
if /i "%~1"=="/restart"  set "ENDACTION=restart"
if /i "%~1"=="/shutdown" set "ENDACTION=shutdown"
if /i "%~1"=="/none"     set "ENDACTION=none"
if /i "%~1"=="/dryrun"   set "DRYRUN=1"
if /i "%~1"=="/nomenu"   set "NOMENU=1"
if /i "%~1"=="/?"        goto :usage
if /i "%~1"=="-h"        goto :usage
shift /1
goto :parse
:parsed

rem ---------- menu, shown when double-clicked with no arguments ---------
rem  Double-clicking passes no arguments, so offer the three things you
rem  would actually want. Anything given on the command line skips this.
rem  /nomenu is internal: it is what the elevated copy gets relaunched
rem  with, so the menu is not shown a second time after the UAC prompt.
if not "%ALLARGS%"=="" goto :nomenu
if "%NOMENU%"=="1" goto :nomenu

:menu
cls
echo ===============================================================
echo   NETWORK STACK RESET  -  reboot required
echo ===============================================================
echo.
echo   What do you want to do?
echo.
echo     [1]  RUN THE RESET        (default - just press Enter)
echo          Resets the whole network stack. Needs admin rights,
echo          and the machine has to reboot afterwards.
echo.
echo     [2]  DRY RUN              (safe - changes nothing)
echo          Print every command it would run, then stop.
echo.
echo     [3]  VERIFY               (safe - changes nothing)
echo          Re-run the connectivity checks after a reboot and add
echo          the results to the last reset log.
echo.
set "SEL=1"
set /p "SEL=  Choose 1, 2 or 3, or press Enter for 1: "
if "!SEL!"=="1" ( set "RELAUNCH=/nomenu" & goto :nomenu )
if "!SEL!"=="2" ( set "DRYRUN=1" & goto :nomenu )
if "!SEL!"=="3" ( set "VERIFY=1" & goto :nomenu )
echo.
echo   That was not one of the options. Try again.
echo.
pause
goto :menu

:nomenu

rem ---------- re-launch as administrator if needed ----------------------
rem  /verify only reads, and /dryrun only prints, so neither needs elevating
if "%DRYRUN%"=="0" if "%VERIFY%"=="0" (
    net session >nul 2>&1
    if errorlevel 1 (
        echo Administrator rights are required - re-launching elevated...
        if "!RELAUNCH!"=="" (
            powershell -NoProfile -Command "try { Start-Process -FilePath '!SCRIPT!' -Verb RunAs -ErrorAction Stop } catch { exit 1 }"
        ) else (
            powershell -NoProfile -Command "try { Start-Process -FilePath '!SCRIPT!' -ArgumentList '!RELAUNCH!' -Verb RunAs -ErrorAction Stop } catch { exit 1 }"
        )
        if errorlevel 1 (
            echo.
            echo Elevation was declined - nothing has been changed.
            echo.
            pause
        )
        exit /b
    )
)

rem elevation drops us in C:\Windows\System32, so go back to the script
cd /d "%SCRIPTDIR%"

rem ---------- set up logging -------------------------------------------
set "LOGDIR=%SCRIPTDIR%netreset-logs"
if not exist "%LOGDIR%" mkdir "%LOGDIR%" 2>nul
>"%LOGDIR%\write.test" echo ok 2>nul
if not exist "%LOGDIR%\write.test" (
    set "LOGDIR=%TEMP%\netreset-logs"
    if not exist "!LOGDIR!" mkdir "!LOGDIR!" 2>nul
)
del "%LOGDIR%\write.test" 2>nul

set "STAMP=%RANDOM%"
for /f "delims=" %%A in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HHmmss"') do set "STAMP=%%A"
set "LOG=%LOGDIR%\netreset_%STAMP%.log"
set "BACKUP=%LOGDIR%\netsh-config_%STAMP%.txt"
set "DNSBAK=%LOGDIR%\dns-static_%STAMP%.txt"
set "WSBAK=%LOGDIR%\winsock-catalog_%STAMP%.txt"

if "%VERIFY%"=="1" goto :verify_mode

>"%LOG%" echo Windows network reset - started %DATE% %TIME%
>>"%LOG%" echo Computer: %COMPUTERNAME%   User: %USERNAME%   Session: %SESSIONNAME%
>>"%LOG%" echo Options: firewall=%DO_FIREWALL% endaction=%ENDACTION% dryrun=%DRYRUN% force=%FORCE%
>>"%LOG%" echo.

rem ---------- refuse to cut the branch we are sitting on -----------------
set "REMOTE=0"
if defined SESSIONNAME if /i not "%SESSIONNAME%"=="Console" set "REMOTE=1"
if defined CLIENTNAME set "REMOTE=1"
if "%REMOTE%"=="1" if "%FORCE%"=="0" goto :remote_abort

rem Only clear when double-clicked. %ALLARGS% is populated when the debloat script
rem calls this with /y /none - clearing there wipes the scrollback of everything the
rem script has done up to this point, which is exactly what you want to read afterwards.
if "%ALLARGS%"=="" cls
echo ===============================================================
echo   WINDOWS NETWORK STACK RESET
echo ===============================================================
echo.
echo   This releases your IP, flushes the DNS/NetBIOS/ARP caches and
echo   resets the TCP/IP, IPv6, Winsock and WinHTTP proxy stacks.
if "%DO_FIREWALL%"=="1" echo   It will ALSO reset Windows Firewall, deleting custom rules.
echo.
echo   You will have no network connectivity until the machine
echo   reboots. Save your work first.
echo.
echo   Log:    %LOG%
echo   Backup: %BACKUP%
if "%DRYRUN%"=="1" echo   *** DRY RUN - nothing will actually be changed ***
echo.

rem  set /p rather than choice, so a mistyped key does not beep at the
rem  console - choice.exe always beeps on a key outside its list and no
rem  flag turns that off. Only Y continues, same as before.
rem  The attempt counter matters: set /p returns an empty string instantly
rem  when stdin is not a console, which would otherwise spin this loop
rem  forever if the script were ever driven non-interactively without /y.
if "%ASSUME_YES%"=="1" goto :confirmed
if "%DRYRUN%"=="1" goto :confirmed
set "TRIES=0"
:confirm
set "YN="
set /p "YN=  Continue? [Y/N] "
if /i "!YN!"=="Y" goto :confirmed
if /i "!YN!"=="YES" goto :confirmed
if /i "!YN!"=="N" goto :aborted
if /i "!YN!"=="NO" goto :aborted
set /a TRIES+=1
if !TRIES! GEQ 10 (
    echo.
    echo   No usable answer after 10 attempts - cancelling.
    goto :aborted
)
echo   Type Y to continue, or N to cancel.
goto :confirm
:confirmed

echo.
echo ---------------------------------------------------------------
echo  PRE-FLIGHT
echo ---------------------------------------------------------------

rem ---------- back up current config before touching anything -----------
echo.
echo Saving netsh configuration backup...
if "%DRYRUN%"=="0" (
    netsh dump > "%BACKUP%" 2>&1
    if exist "%BACKUP%" (echo      [ ok ] %BACKUP%) else (echo      [FAIL] could not write backup)
) else (
    echo      netsh dump  ^>  "%BACKUP%"
)

rem ---------- record the Winsock providers before we wipe them ----------
rem  netsh winsock reset removes third-party layered service providers -
rem  VPN clients, VMware, proxies, some AV. netsh dump does not cover
rem  them, so if networking misbehaves afterwards this file is the only
rem  record of what used to be registered. It is ~540 lines, hence its
rem  own file rather than burying the main log.
echo.
echo Saving the Winsock provider catalog...
if "%DRYRUN%"=="0" (
    call :capture_winsock
    echo      [ ok ] !WSCOUNT! providers - winsock-catalog_%STAMP%.txt
    >>"%LOG%" echo Winsock catalog saved to %WSBAK% - entries: !WSCOUNT!
) else (
    echo      netsh winsock show catalog  ^>  "%WSBAK%"
)

rem ---------- remember statically configured DNS servers ----------------
rem  read straight from the registry: locale independent, and it only
rem  returns servers that were set by hand, not ones handed out by DHCP
echo.
echo Looking for statically configured DNS servers...
set "HAS_STATIC_DNS=0"
call :capture_dns
for %%F in ("%DNSBAK%") do if %%~zF GTR 0 set "HAS_STATIC_DNS=1"
if "%HAS_STATIC_DNS%"=="1" (
    >>"%LOG%" echo Static DNS servers found before reset:
    for /f "usebackq tokens=1,* delims=|" %%A in ("%DNSBAK%") do (
        echo      %%A  ^>  %%B
        >>"%LOG%" echo     %%A = %%B
    )
    echo.
    echo      Saved - these get re-applied after the reset.
) else (
    echo      None found - every adapter takes its DNS from DHCP.
    >>"%LOG%" echo No statically configured DNS servers found.
    del "%DNSBAK%" 2>nul
)
>>"%LOG%" echo.

rem ---------- baseline connectivity, for comparison afterwards ----------
echo.
echo Recording a connectivity baseline...
>>"%LOG%" echo --- BASELINE (before reset) ---
set "GW="
call :find_gateway
if defined GW (
    set "CMD=ping -n 2 !GW!"
    call :check "Default gateway !GW!"
) else (
    echo      No default gateway found
    echo        [none]
    >>"%LOG%" echo CHECK: no default gateway found
)
set "CMD=ping -n 2 8.8.8.8"
call :check "Internet reachability (8.8.8.8)"
set "CMD=nslookup www.microsoft.com"
call :check "DNS resolution"

rem ---------- the actual work -------------------------------------------
echo.
echo ---------------------------------------------------------------
echo  RESET
echo ---------------------------------------------------------------

set "CMD=ipconfig /all"
call :step "Record current adapter configuration in the log"

set "CMD=ipconfig /release"
call :step "Release IPv4 DHCP leases"

set "CMD=ipconfig /release6"
call :step "Release IPv6 DHCP leases"

set "CMD=ipconfig /flushdns"
call :step "Flush the DNS resolver cache"

set "CMD=nbtstat -R"
call :step "Purge the NetBIOS name cache"

set "CMD=nbtstat -RR"
call :step "Release and refresh NetBIOS names"

set "CMD=arp -d *"
call :step "Clear the ARP cache"

set "CMD=netsh int ip reset "%LOGDIR%\ipreset_%STAMP%.log""
call :step "Reset the TCP/IPv4 stack"

set "CMD=netsh int ipv6 reset "%LOGDIR%\ipv6reset_%STAMP%.log""
call :step "Reset the TCP/IPv6 stack"

set "CMD=netsh winsock reset"
call :step "Reset the Winsock catalog"

set "CMD=netsh winhttp reset proxy"
call :step "Clear the system-wide WinHTTP proxy"

if "%DO_FIREWALL%"=="1" (
    set "CMD=netsh advfirewall reset"
    call :step "Reset Windows Firewall to default rules"
)

rem  the ip reset above reverts every adapter to DHCP-supplied DNS, so put
rem  the saved servers back before we renew the lease
if "%HAS_STATIC_DNS%"=="1" call :restore_dns

set "CMD=ipconfig /renew"
call :step "Request a fresh IPv4 lease"

set "CMD=ipconfig /registerdns"
call :step "Re-register this machine in DNS"

rem ---------- summary ---------------------------------------------------
echo.
echo ===============================================================
if "%FAILS%"=="0" (
    echo   All %STEPNUM% steps completed without errors.
) else (
    echo   %STEPNUM% steps run, %FAILS% reported an error - check the log.
    echo   Some errors are normal here, e.g. renewing a lease before the
    echo   reboot has re-armed the Winsock catalog.
)
echo   Log: %LOG%
echo ===============================================================
>>"%LOG%" echo.
>>"%LOG%" echo Finished %DATE% %TIME% - %STEPNUM% steps, %FAILS% failures.

echo.
echo   A REBOOT IS REQUIRED for the Winsock and TCP/IP resets to apply.
if "%HAS_STATIC_DNS%"=="1" echo   Your DNS servers were re-applied - confirm they stuck afterwards.
echo.
echo   Once it is back up, run:  net-reset-reboot.bat /verify
echo   That re-runs the checks above and appends them to the same log,
echo   so you can see whether any of this actually helped.
echo.

if "%DRYRUN%"=="1" (
    echo Dry run complete - no changes were made.
    goto :done
)

rem  Same reasoning as the Continue prompt: no console beep, and a bounded
rem  loop. If no answer can be read at all, the safe fallback is to leave
rem  the machine running rather than reboot it out from under someone.
if /i not "%ENDACTION%"=="ask" goto :act
set "TRIES=0"
:endask
set "EA="
set /p "EA=  Restart now [R], shut down [S], or do nothing [N]? "
if /i "!EA!"=="R" set "ENDACTION=restart"
if /i "!EA!"=="S" set "ENDACTION=shutdown"
if /i "!EA!"=="N" set "ENDACTION=none"
if /i not "!ENDACTION!"=="ask" goto :act
set /a TRIES+=1
if !TRIES! GEQ 10 (
    echo.
    echo   No usable answer after 10 attempts - leaving the machine running.
    set "ENDACTION=none"
    goto :act
)
echo   Type R, S or N.
goto :endask

:act
echo.
if /i "%ENDACTION%"=="restart" (
    echo Restarting in 15 seconds.  Run  shutdown /a  to cancel.
    shutdown /r /t 15 /c "Network stack reset complete - restarting in 15 seconds..."
)
if /i "%ENDACTION%"=="shutdown" (
    echo Shutting down in 15 seconds.  Run  shutdown /a  to cancel.
    shutdown /s /t 15 /c "Network stack reset complete - shutting down in 15 seconds..."
)
if /i "%ENDACTION%"=="none" (
    echo Reboot when you are ready - the network stays broken until you do.
)

:done
echo.
if "%ASSUME_YES%"=="0" pause
endlocal
exit /b 0

rem =====================================================================
rem  /verify - the other half of the baseline taken before the reset
rem =====================================================================
:verify_mode
set "PREVLOG="
for /f "delims=" %%A in ('dir /b /a-d /o-d "%LOGDIR%\netreset_*.log" 2^>nul') do if not defined PREVLOG set "PREVLOG=%LOGDIR%\%%A"
if defined PREVLOG (set "LOG=%PREVLOG%") else (set "LOG=%LOGDIR%\verify_%STAMP%.log")

cls
echo ===============================================================
echo   POST-RESET VERIFICATION
echo ===============================================================
echo.
if defined PREVLOG (
    echo   Appending to the log from the last reset:
) else (
    echo   No previous reset log found, starting a new one:
)
echo   %LOG%
echo.
>>"%LOG%" echo.
>>"%LOG%" echo --- VERIFY (after reset) - %DATE% %TIME% ---

echo Re-running the connectivity checks...
echo.
set "GW="
call :find_gateway
if defined GW (
    set "CMD=ping -n 2 !GW!"
    call :check "Default gateway !GW!"
) else (
    echo      No default gateway found
    echo        [none]
    >>"%LOG%" echo CHECK: no default gateway found
)
set "CMD=ping -n 2 8.8.8.8"
call :check "Internet reachability (8.8.8.8)"
set "CMD=nslookup www.microsoft.com"
call :check "DNS resolution"

echo.
echo Statically configured DNS servers right now:
call :show_dns

echo.
echo ===============================================================
echo   Compare these against the BASELINE section higher up in:
echo   %LOG%
echo ===============================================================
echo.
pause
endlocal
exit /b 0

rem =====================================================================
rem  helpers
rem
rem  The PowerShell one-liners below live in their own subroutines on
rem  purpose. Inside a parenthesised IF block cmd would treat the pipes
rem  and brackets in them as its own syntax and the line would not parse.
rem =====================================================================

rem  :capture_dns - list adapters with hand-set DNS as  name|servers
:capture_dns
powershell -NoProfile -Command "Get-NetAdapter | ForEach-Object { $p = 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\' + $_.InterfaceGuid; $ns = (Get-ItemProperty -Path $p -Name NameServer -ErrorAction SilentlyContinue).NameServer; if ($ns) { $_.Name + '|' + $ns } }" > "%DNSBAK%" 2>nul
exit /b 0

rem  :show_dns - print the static DNS servers as they stand right now
:show_dns
call :capture_dns
set "FOUND=0"
for %%F in ("%DNSBAK%") do if %%~zF GTR 0 set "FOUND=1"
if "%FOUND%"=="1" (
    for /f "usebackq tokens=1,* delims=|" %%A in ("%DNSBAK%") do (
        echo      %%A  ^>  %%B
        >>"%LOG%" echo     DNS now: %%A = %%B
    )
) else (
    echo      None - every adapter is on DHCP-supplied DNS.
    >>"%LOG%" echo     DNS now: none set statically
)
del "%DNSBAK%" 2>nul
exit /b 0

rem  :capture_winsock - save the provider catalog and count the entries
:capture_winsock
set "WSCOUNT=?"
netsh winsock show catalog > "%WSBAK%" 2>&1
for /f "delims=" %%A in ('powershell -NoProfile -Command "(Select-String -LiteralPath '%WSBAK%' -Pattern 'Entry Type' -SimpleMatch).Count"') do set "WSCOUNT=%%A"
exit /b 0

rem  :find_gateway - lowest-metric IPv4 default gateway, into GW
:find_gateway
for /f "delims=" %%A in ('powershell -NoProfile -Command "(Get-NetRoute -DestinationPrefix 0.0.0.0/0 -ErrorAction SilentlyContinue | Sort-Object RouteMetric | Select-Object -First 1).NextHop"') do set "GW=%%A"
exit /b 0

rem  :restore_dns - write the saved DNS servers back onto their adapters
:restore_dns
set /a STEPNUM+=1
set "N=0!STEPNUM!"
echo.
echo [!N:~-2!] Restore statically configured DNS servers
echo      Set-DnsClientServerAddress from dns-static_%STAMP%.txt
>>"%LOG%" echo === [!N:~-2!] Restore statically configured DNS servers
>>"%LOG%" echo     source: %DNSBAK%
if "%DRYRUN%"=="1" (
    echo      [dry ] skipped
    >>"%LOG%" echo     result: skipped - dry run
    del "%DNSBAK%" 2>nul
    exit /b 0
)
rem  One adapter at a time, not one pipeline. A single bad adapter - say one
rem  that is Not Present on this machine but still carries static DNS in the
rem  registry - used to abort the whole restore via -ErrorAction Stop, so
rem  every adapter after it was silently skipped and the step reported one
rem  vague failure. Now each is tried on its own, the log names the ones that
rem  fail, and a non-zero exit keeps dns-static so you can recover by hand.
powershell -NoProfile -Command "$bad = @(); foreach ($line in Get-Content -LiteralPath '%DNSBAK%') { $a,$s = $line -split '\|',2; try { Set-DnsClientServerAddress -InterfaceAlias $a -ServerAddresses ($s -split ',') -ErrorAction Stop; '    ok: ' + $a + ' -> ' + $s } catch { $bad += $a; '    FAILED: ' + $a + ' - ' + $_.Exception.Message.Split([char]10)[0] } }; if ($bad.Count) { '    could not restore: ' + ($bad -join ', '); exit 1 }" >>"%LOG%" 2>&1
if errorlevel 1 (
    set /a FAILS+=1
    echo      [FAIL] could not restore - servers are listed in the log
    >>"%LOG%" echo     result: FAILED
) else (
    echo      [ ok ]
    >>"%LOG%" echo     result: ok
    rem  the servers are back on the adapters now, so the scratch copy is
    rem  redundant. On FAILURE it is kept on purpose - it is how you get
    rem  the values back by hand.
    del "%DNSBAK%" 2>nul
)
>>"%LOG%" echo.
exit /b 0

rem  :step - runs a command that changes something. Counts towards FAILS.
:step
set /a STEPNUM+=1
set "N=0!STEPNUM!"
echo.
echo [!N:~-2!] %~1
echo      %CMD%
>>"%LOG%" echo === [!N:~-2!] %~1
>>"%LOG%" echo     command: %CMD%
if "%DRYRUN%"=="1" (
    echo      [dry ] skipped
    >>"%LOG%" echo     result: skipped - dry run
    exit /b 0
)
%CMD% >>"%LOG%" 2>&1
if errorlevel 1 (
    set /a FAILS+=1
    echo      [FAIL] exit code !errorlevel!
    >>"%LOG%" echo     result: FAILED
) else (
    echo      [ ok ]
    >>"%LOG%" echo     result: ok
)
>>"%LOG%" echo.
exit /b 0

rem  :check - read-only probe. A failure here is information, not an error,
rem  so it deliberately does not count towards FAILS: no connectivity is
rem  usually the whole reason someone is running this script.
:check
echo      %~1
>>"%LOG%" echo CHECK: %~1
>>"%LOG%" echo     command: %CMD%
if "%DRYRUN%"=="1" (
    echo        [dry ] skipped
    >>"%LOG%" echo     result: skipped - dry run
    exit /b 0
)
%CMD% >>"%LOG%" 2>&1
if errorlevel 1 (
    echo        [down] no response
    >>"%LOG%" echo     result: unreachable
) else (
    echo        [ up ]
    >>"%LOG%" echo     result: reachable
)
>>"%LOG%" echo.
exit /b 0

:remote_abort
echo.
echo ===============================================================
echo   REMOTE SESSION DETECTED
echo ===============================================================
echo.
echo   Session: %SESSIONNAME%   Client: %CLIENTNAME%
echo.
echo   This script releases the IP address and resets the network
echo   stack. Run over Remote Desktop it drops your connection at
echo   the second step, and you will not be able to reconnect to
echo   finish the job or reboot the machine.
echo.
echo   Run it from the console instead. If you genuinely have
echo   another way back in, re-run with  /force
echo.
>>"%LOG%" echo ABORTED: remote session detected and /force was not given.
pause
endlocal
exit /b 2

:aborted
echo.
echo Cancelled - nothing was changed.
>>"%LOG%" echo ABORTED: user declined at the confirmation prompt.
echo.
pause
endlocal
exit /b 1

:usage
echo net-reset-reboot.bat [/firewall] [/y] [/force] [/dryrun]
echo                      [/restart] [/shutdown] [/none]
echo net-reset-reboot.bat /verify
echo.
echo   /firewall  also reset Windows Firewall - deletes custom rules
echo   /y         skip the confirmation prompt
echo   /force     run even from a remote session - you will be disconnected
echo   /restart   restart when finished - recommended
echo   /shutdown  shut down when finished
echo   /none      leave the machine running
echo   /dryrun    print the commands without running them
echo   /verify    after the reboot: re-run the connectivity checks only
echo              and append them to the last reset log. Changes nothing.
echo.
echo   With no arguments at all it shows a menu: reset, dry run, verify.
endlocal
exit /b 0
'@

#  net-reset-lite.bat - written to the Desktop as a standalone tool (no reboot needed)
$script:NetResetLiteBat = @'
@echo off
setlocal EnableExtensions EnableDelayedExpansion
rem  capture these BEFORE any shift - "shift" also shifts %0, which would
rem  collapse the script path and send the logs to the root of the drive
set "ALLARGS=%*"
set "SCRIPT=%~f0"
set "SCRIPTDIR=%~dp0"
title Network Refresh - no reboot required

rem =====================================================================
rem  net-reset-lite.bat  -  refresh the network WITHOUT a reboot
rem
rem  The little sibling of net-reset-reboot.bat, and a rewrite of
rem  netSoftReset.bat. Same idea as the original - release, flush, renew -
rem  but it finishes the job, keeps a log, and checks whether it helped.
rem
rem  THE ONE RULE OF THIS SCRIPT: NOTHING IN IT REQUIRES A REBOOT.
rem
rem  Everything here clears a cache or re-requests a lease. All of it takes
rem  effect the moment it runs. There is no shutdown or restart command
rem  anywhere in this file, and there is no "you must reboot" step.
rem
rem  Deliberately NOT included, because these DO need a reboot to apply:
rem      netsh int ip reset        netsh int ipv6 reset
rem      netsh winsock reset       netsh advfirewall reset
rem  Those live in net-reset-reboot.bat. If this script does not fix the
rem  problem, that one is the next step up - it says so at the end.
rem
rem  Because the stack is never reset, statically configured DNS servers
rem  are never wiped, so unlike the reboot version this script needs no
rem  save-and-restore dance for them. It just records them in the log.
rem
rem  Usage:
rem    net-reset-lite.bat [/adapter] [/proxy] [/y] [/force] [/dryrun]
rem    net-reset-lite.bat /verify
rem
rem    /adapter   also bounce the physical network adapters - a harder
rem               reset of the link itself, still no reboot. Virtual
rem               adapters - VMware, Hyper-V - are left alone on purpose.
rem    /proxy     also clear the system-wide WinHTTP proxy. Off by default
rem               because it changes configuration rather than refreshing
rem               state - if a proxy is needed here, this removes it.
rem    /y         skip the "are you sure" prompt
rem    /force     run even from a remote/RDP session
rem    /dryrun    print every command without running anything
rem    /verify    run ONLY the connectivity checks. Changes nothing, needs
rem               no admin rights. The normal run already checks before and
rem               after, so this is for looking again later.
rem
rem  A NOTE ON HOW SUCCESS IS JUDGED, because it matters here. None of the
rem  three tools you would reach for first can actually be trusted, and all
rem  three were checked rather than assumed:
rem    ipconfig returns exit code 0 even when it fails - a /renew that
rem      cannot reach a DHCP server still reports success. So ipconfig steps
rem      are marked [run] rather than [ ok ]: they ran, and the verdict comes
rem      from the state check afterwards, not from their exit code. netsh
rem      does report real exit codes, so netsh steps get a true [ok]/[FAIL].
rem    nslookup returns 0 for a domain that does not exist, so DNS is tested
rem      with Resolve-DnsName -ErrorAction Stop instead.
rem    ping can return 0 when a router answers "destination host
rem      unreachable" for the target, so reachability is tested with
rem      Test-Connection, which yields a result only for a real reply.
rem      Matching ping's output for "TTL=" would have worked too, but only
rem      on an English Windows.
rem
rem  Exit codes, so this can be driven from another script:
rem      0   network is up afterwards, or a dry run
rem      1   cancelled at the confirmation prompt
rem      2   refused: remote session and no /force
rem      3   ran, but the network is still down - escalate
rem      64  bad argument, nothing was run
rem
rem  Files written to netreset-logs\ next to this script - the same folder
rem  net-reset-reboot.bat uses, so the history of both sits together:
rem    netlite_<stamp>.log     step-by-step record, plus before/after
rem =====================================================================

set "DO_ADAPTER=0"
set "DO_PROXY=0"
set "ASSUME_YES=0"
set "DRYRUN=0"
set "FORCE=0"
set "VERIFY=0"
set "STEPNUM=0"
set "FAILS=0"
rem  exit code, overwritten by the verdict at the end
set "RC=0"

rem  how long to let DHCP settle before the after-checks, in seconds
set "SETTLE=6"

rem ---------- parse arguments ------------------------------------------
rem  Every flag also sets ARGOK, and anything that leaves ARGOK at 0 stops
rem  the script. That matters more here than it looks: without it a typo
rem  like /dryun is silently ignored, and instead of the preview you asked
rem  for you get the real thing.
:parse
if "%~1"=="" goto :parsed
set "ARGOK=0"
if /i "%~1"=="/adapter" ( set "DO_ADAPTER=1" & set "ARGOK=1" )
if /i "%~1"=="/proxy"   ( set "DO_PROXY=1"   & set "ARGOK=1" )
if /i "%~1"=="/y"       ( set "ASSUME_YES=1" & set "ARGOK=1" )
if /i "%~1"=="/force"   ( set "FORCE=1"      & set "ARGOK=1" )
if /i "%~1"=="/verify"  ( set "VERIFY=1"     & set "ARGOK=1" )
if /i "%~1"=="/dryrun"  ( set "DRYRUN=1"     & set "ARGOK=1" )
if /i "%~1"=="/?"       goto :usage
if /i "%~1"=="-h"       goto :usage
if /i "%~1"=="--help"   goto :usage
if "%ARGOK%"=="0" goto :badarg
shift /1
goto :parse
:parsed

rem ---------- re-launch as administrator if needed ----------------------
rem  The path and the arguments get embedded in a single-quoted PowerShell
rem  string below, so a single quote in either one would end that string
rem  early - a folder like C:\Users\Bob's PC breaks the launch outright,
rem  and an argument could inject PowerShell of its own. PowerShell escapes
rem  a quote inside a single-quoted string by doubling it, so do that.
rem  The "if defined" guard is not decorative: on an undefined variable cmd
rem  does not perform the substitution at all and leaks the literal text,
rem  and the substitution has to be !delayed! so it happens after the guard.
set "PSSCRIPT=%SCRIPT:'=''%"
set "PSARGS="
if defined ALLARGS set "PSARGS=!ALLARGS:'=''!"

rem  /verify only reads and /dryrun only prints, so neither needs elevating
if "%DRYRUN%"=="0" if "%VERIFY%"=="0" (
    net session >nul 2>&1
    if errorlevel 1 (
        echo Administrator rights are required - re-launching elevated...
        if not defined PSARGS (
            powershell -NoProfile -Command "try { Start-Process -FilePath '!PSSCRIPT!' -Verb RunAs -ErrorAction Stop } catch { exit 1 }"
        ) else (
            powershell -NoProfile -Command "try { Start-Process -FilePath '!PSSCRIPT!' -ArgumentList '!PSARGS!' -Verb RunAs -ErrorAction Stop } catch { exit 1 }"
        )
        if errorlevel 1 (
            echo.
            echo Elevation was declined - nothing has been changed.
            echo.
            pause
        )
        exit /b
    )
)

rem elevation drops us in C:\Windows\System32, so go back to the script
cd /d "%SCRIPTDIR%"

rem ---------- set up logging -------------------------------------------
set "LOGDIR=%SCRIPTDIR%netreset-logs"
if not exist "%LOGDIR%" mkdir "%LOGDIR%" 2>nul
>"%LOGDIR%\write.test" echo ok 2>nul
if not exist "%LOGDIR%\write.test" (
    set "LOGDIR=%TEMP%\netreset-logs"
    if not exist "!LOGDIR!" mkdir "!LOGDIR!" 2>nul
)
del "%LOGDIR%\write.test" 2>nul

set "STAMP=%RANDOM%"
for /f "delims=" %%A in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HHmmss"') do set "STAMP=%%A"
set "LOG=%LOGDIR%\netlite_%STAMP%.log"
set "DNSTMP=%LOGDIR%\dns-seen_%STAMP%.tmp"

if "%VERIFY%"=="1" goto :verify_mode

>"%LOG%" echo Network refresh - no reboot - started %DATE% %TIME%
>>"%LOG%" echo Computer: %COMPUTERNAME%   User: %USERNAME%   Session: %SESSIONNAME%
>>"%LOG%" echo Options: adapter=%DO_ADAPTER% proxy=%DO_PROXY% dryrun=%DRYRUN% force=%FORCE%
>>"%LOG%" echo.

rem ---------- refuse to cut the branch we are sitting on -----------------
rem  the release/renew pair drops the IP for a few seconds. Over RDP that
rem  kills the session. The script keeps running on the machine and will
rem  renew, so it usually comes back - but "usually" is not good enough to
rem  do without asking.
set "REMOTE=0"
if defined SESSIONNAME if /i not "%SESSIONNAME%"=="Console" set "REMOTE=1"
if defined CLIENTNAME set "REMOTE=1"
if "%REMOTE%"=="1" if "%FORCE%"=="0" goto :remote_abort

rem ---------- what are we working with ----------------------------------
call :inventory

cls
echo ===============================================================
echo   NETWORK REFRESH - NO REBOOT REQUIRED
echo ===============================================================
echo.
echo   Flushes the DNS, NetBIOS, ARP, destination and neighbour
echo   caches, then releases and renews the DHCP leases.
echo.
echo   Nothing here needs a reboot. The TCP/IP and Winsock stacks
echo   are NOT touched - that is net-reset-reboot.bat's job.
echo.
if "%DO_ADAPTER%"=="1" echo   /adapter: the physical adapters will also be bounced.
if "%DO_PROXY%"=="1"   echo   /proxy:   the WinHTTP proxy will also be cleared.
echo   Expect to be offline for a few seconds around the renew.
echo.
echo   Physical adapters up: %INV_PHYUP%      Virtual adapters up: %INV_VIRTUP%
if not "%INV_VIRTUP%"=="0" echo   Heads up: release/renew also cycles the virtual adapters,
if not "%INV_VIRTUP%"=="0" echo   so VM networking will blink too.
echo.
echo   Log: %LOG%
if "%DRYRUN%"=="1" echo   *** DRY RUN - nothing will actually be changed ***
echo.

rem  set /p rather than choice, so a mistyped key does not beep at the
rem  console - choice.exe always beeps on a key outside its list and no
rem  flag turns that off. Only Y continues, same as before.
rem  The attempt counter matters: set /p returns an empty string instantly
rem  when stdin is not a console, which would otherwise spin this loop
rem  forever if the script were ever driven non-interactively without /y.
if "%ASSUME_YES%"=="1" goto :confirmed
if "%DRYRUN%"=="1" goto :confirmed
set "TRIES=0"
:confirm
set "YN="
set /p "YN=  Continue? [Y/N] "
if /i "!YN!"=="Y" goto :confirmed
if /i "!YN!"=="YES" goto :confirmed
if /i "!YN!"=="N" goto :aborted
if /i "!YN!"=="NO" goto :aborted
set /a TRIES+=1
if !TRIES! GEQ 10 (
    echo.
    echo   No usable answer after 10 attempts - cancelling.
    goto :aborted
)
echo   Type Y to continue, or N to cancel.
goto :confirm
:confirmed

echo.
echo ---------------------------------------------------------------
echo  BEFORE
echo ---------------------------------------------------------------
>>"%LOG%" echo --- BEFORE ---
>>"%LOG%" echo Physical adapters up: %INV_PHYUP%   Virtual adapters up: %INV_VIRTUP%

rem ---------- note the DNS servers, for the record ----------------------
rem  read from the registry, not from the live adapters: locale independent,
rem  it only returns servers that were set by hand, and it does not miss an
rem  adapter that happens to be down. Nothing here modifies them - this
rem  script never resets the stack, so they cannot be lost.
echo.
echo Statically configured DNS servers:
call :show_dns

rem  a full ipconfig /all into the log. This is a record, not an action, so
rem  it is not one of the numbered steps - counting a read as a "step" would
rem  overstate what the script actually did.
echo.
echo Recording the full adapter configuration in the log...
>>"%LOG%" echo --- ipconfig /all, before the refresh ---
if "%DRYRUN%"=="0" (
    ipconfig /all >>"%LOG%" 2>&1
    echo      [ ok ]
) else (
    echo      [dry ] skipped
)

rem  a proxy nobody remembers setting is a common cause of "the internet is
rem  broken while the network is fine", and clearing it needs no reboot.
rem  Printed as-is rather than parsed, so no assumption about the language
rem  Windows is running in.
echo.
echo System-wide WinHTTP proxy:
call :show_proxy

rem  if these services are not running, no amount of releasing and renewing
rem  will get an address - and starting them does not need a reboot either
echo.
echo Services the refresh depends on:
call :show_services

rem ---------- baseline, to compare against afterwards -------------------
echo.
echo Connectivity before:
call :probe_state
set "B_IPGW=%PS_IPGW%"
set "B_APIPA=%PS_APIPA%"
echo      Adapters with an IP and a gateway: %B_IPGW%
echo      Adapters stuck on a 169.254 address: %B_APIPA%
>>"%LOG%" echo State: adapters with IP+gateway=%B_IPGW% apipa=%B_APIPA%
call :run_checks
set "B_GWR=%CHK_GW%"
set "B_NET=%CHK_NET%"
set "B_DNS=%CHK_DNS%"

rem ---------- the actual work -------------------------------------------
echo.
echo ---------------------------------------------------------------
echo  REFRESH
echo ---------------------------------------------------------------

set "CMD=ipconfig /flushdns"
call :runstep "Flush the DNS resolver cache"

rem  NetBIOS is legacy and -RR only really means anything where there is a
rem  WINS server to refresh against, so on a home network these two are
rem  close to no-ops. Kept deliberately: they cost milliseconds, they cannot
rem  do any harm, and they still matter on an older LAN.
set "CMD=nbtstat -R"
call :step "Purge the NetBIOS name cache"

set "CMD=nbtstat -RR"
call :step "Release and refresh NetBIOS names"

set "CMD=netsh interface ipv4 delete arpcache"
call :step "Flush the ARP cache"

set "CMD=netsh interface ipv4 delete destinationcache"
call :step "Clear the IPv4 destination cache"

set "CMD=netsh interface ipv6 delete destinationcache"
call :step "Clear the IPv6 destination cache"

set "CMD=netsh interface ipv6 delete neighbors"
call :step "Clear the IPv6 neighbour cache"

if "%DO_PROXY%"=="1" (
    set "CMD=netsh winhttp reset proxy"
    call :step "Clear the system-wide WinHTTP proxy"
)

set "CMD=ipconfig /release"
call :runstep "Release the IPv4 DHCP leases"

set "CMD=ipconfig /release6"
call :runstep "Release the IPv6 DHCP leases"

rem  bouncing the link while the lease is released is the cleanest moment
if "%DO_ADAPTER%"=="1" call :bounce_adapters

set "CMD=ipconfig /renew"
call :runstep "Request fresh IPv4 leases"

set "CMD=ipconfig /renew6"
call :runstep "Request fresh IPv6 leases"

rem  this asks the DNS server to update this machine's record, which only
rem  does anything where the server accepts dynamic updates - an Active
rem  Directory domain, essentially - so on a home network it is close to a
rem  no-op. Kept for the same reason as the nbtstat pair: free, harmless,
rem  and it does the right thing the day this machine joins a domain.
set "CMD=ipconfig /registerdns"
call :runstep "Re-register this machine in DNS"

rem  flush a second time, now that the new lease and its DNS servers are
rem  in place. Two reasons: anything cached against the old lease is gone,
rem  and it means the DNS check below has to do a real lookup instead of
rem  being handed the answer the BEFORE check already cached.
set "CMD=ipconfig /flushdns"
call :runstep "Flush the DNS cache again, against the new lease"

rem ---------- let DHCP settle, then look again --------------------------
echo.
echo ---------------------------------------------------------------
echo  AFTER
echo ---------------------------------------------------------------
>>"%LOG%" echo --- AFTER ---

if "%DRYRUN%"=="0" (
    echo.
    echo Giving DHCP %SETTLE% seconds to settle...
    rem  ping as the sleep: timeout.exe fails when stdin is redirected
    ping -n %SETTLE% 127.0.0.1 >nul 2>&1
)

echo.
echo Connectivity after:
call :probe_state
set "A_IPGW=%PS_IPGW%"
set "A_APIPA=%PS_APIPA%"
echo      Adapters with an IP and a gateway: %A_IPGW%
echo      Adapters stuck on a 169.254 address: %A_APIPA%
>>"%LOG%" echo State: adapters with IP+gateway=%A_IPGW% apipa=%A_APIPA%
call :run_checks
set "A_GWR=%CHK_GW%"
set "A_NET=%CHK_NET%"
set "A_DNS=%CHK_DNS%"

rem ---------- summary ---------------------------------------------------
echo.
echo ===============================================================
echo   BEFORE / AFTER
echo ===============================================================
echo.
echo                                    BEFORE     AFTER
call :row "Default gateway reachable"      "%B_GWR%"   "%A_GWR%"
call :row "Internet reachable"             "%B_NET%"   "%A_NET%"
call :row "DNS resolving"                  "%B_DNS%"   "%A_DNS%"
call :row "Adapters with IP + gateway"     "%B_IPGW%"  "%A_IPGW%"
call :row "Adapters on a 169.254 address"  "%B_APIPA%" "%A_APIPA%"
echo.
>>"%LOG%" echo.
>>"%LOG%" echo BEFORE/AFTER  gateway %B_GWR%/%A_GWR%  internet %B_NET%/%A_NET%  dns %B_DNS%/%A_DNS%
>>"%LOG%" echo BEFORE/AFTER  ip+gw %B_IPGW%/%A_IPGW%  apipa %B_APIPA%/%A_APIPA%

if "%FAILS%"=="0" (
    echo   %STEPNUM% steps ran, none reported an error.
) else (
    echo   %STEPNUM% steps ran, %FAILS% reported an error - check the log.
)
echo   Log: %LOG%
>>"%LOG%" echo.
>>"%LOG%" echo Finished %DATE% %TIME% - %STEPNUM% steps, %FAILS% failures.

if "%DRYRUN%"=="1" (
    echo.
    echo   Dry run complete - no changes were made.
    goto :done
)

echo.
echo ===============================================================
if /i "%A_NET%"=="up" if /i "%A_DNS%"=="up" goto :verdict_good
goto :verdict_bad

:verdict_good
set "RC=0"
echo   Network is up. NO REBOOT NEEDED - you are done.
>>"%LOG%" echo VERDICT: up - no reboot needed.
goto :verdict_end

:verdict_bad
set "RC=3"
echo   Still not working.
echo.
echo   This script only clears caches and re-requests leases, which
echo   is everything that can be fixed without a reboot. If the
echo   problem survived that, it is likely in the TCP/IP or Winsock
echo   stack itself, and resetting those DOES require a reboot:
echo.
echo       net-reset-reboot.bat /dryrun     see what it would do
echo       net-reset-reboot.bat             do it
echo.
rem  the "?" guard matters: if the state probe could not run, A_APIPA is "?"
rem  rather than a number, and without it this fires a false DHCP warning
if not "%A_APIPA%"=="0" if not "%A_APIPA%"=="?" echo   An adapter is on a 169.254 address, which means DHCP did not
if not "%A_APIPA%"=="0" if not "%A_APIPA%"=="?" echo   answer at all - check the cable, the Wi-Fi and the router too.
if "%DO_ADAPTER%"=="0" echo   Worth trying first, still no reboot:  net-reset-lite.bat /adapter
>>"%LOG%" echo VERDICT: still down - net-reset-reboot.bat suggested.
goto :verdict_end

:verdict_end
echo ===============================================================

:done
echo.
if "%ASSUME_YES%"=="0" pause
rem  exit code so this can be used from another script:
rem    0 = network is up (or a dry run)   3 = still down after the refresh
rem    1 = cancelled   2 = refused, remote session   64 = bad argument
endlocal & exit /b %RC%

rem =====================================================================
rem  /verify - the checks on their own, changing nothing
rem =====================================================================
:verify_mode
set "PREVLOG="
for /f "delims=" %%A in ('dir /b /a-d /o-d "%LOGDIR%\netlite_*.log" 2^>nul') do if not defined PREVLOG set "PREVLOG=%LOGDIR%\%%A"
if defined PREVLOG (set "LOG=%PREVLOG%") else (set "LOG=%LOGDIR%\netlite_verify_%STAMP%.log")

cls
echo ===============================================================
echo   CONNECTIVITY CHECK - read only
echo ===============================================================
echo.
if defined PREVLOG (
    echo   Appending to the log from the last run:
) else (
    echo   No previous run found, starting a new log:
)
echo   %LOG%
echo.
>>"%LOG%" echo.
>>"%LOG%" echo --- VERIFY - %DATE% %TIME% ---

call :probe_state
echo      Adapters with an IP and a gateway: %PS_IPGW%
echo      Adapters stuck on a 169.254 address: %PS_APIPA%
>>"%LOG%" echo State: adapters with IP+gateway=%PS_IPGW% apipa=%PS_APIPA%
echo.
call :run_checks

echo.
echo Statically configured DNS servers right now:
call :show_dns

echo.
echo System-wide WinHTTP proxy:
call :show_proxy

echo.
echo Services the refresh depends on:
call :show_services

echo.
echo ===============================================================
echo   Nothing was changed. Compare against the BEFORE/AFTER
echo   sections in: %LOG%
echo ===============================================================
echo.
pause
endlocal
exit /b 0

rem =====================================================================
rem  helpers
rem
rem  The PowerShell one-liners live in their own subroutines on purpose.
rem  Inside a parenthesised IF block cmd would read the pipes and brackets
rem  in them as its own syntax and the line would not parse.
rem =====================================================================

rem  :row <label> <before> <after> - one line of the before/after table.
rem  The values are padded here, at display time, rather than being stored
rem  padded. Storing them padded is what broke the verdict once already:
rem  "up  " does not equal "up", so the end-of-run check never fired and it
rem  reported failure on a working network.
:row
set "L=%~1                                   "
set "B=%~2    "
set "A=%~3    "
echo   !L:~0,33!!B:~0,4!       !A:~0,4!
exit /b 0

rem  :inventory - count adapters that are up, physical vs virtual
:inventory
set "INV_PHYUP=?"
set "INV_VIRTUP=?"
for /f "delims=" %%A in ('powershell -NoProfile -Command "@(Get-NetAdapter -Physical -ErrorAction SilentlyContinue | Where-Object { $_.Status -eq 'Up' }).Count"') do set "INV_PHYUP=%%A"
for /f "delims=" %%A in ('powershell -NoProfile -Command "@(Get-NetAdapter -ErrorAction SilentlyContinue | Where-Object { $_.Virtual -eq $true -and $_.Status -eq 'Up' }).Count"') do set "INV_VIRTUP=%%A"
exit /b 0

rem  :probe_state - the two numbers that say whether DHCP actually worked.
rem  APIPA is only counted on adapters that are UP: a disconnected adapter
rem  always holds a stale 169.254 address and would be a false alarm.
:probe_state
set "PS_IPGW=?"
set "PS_APIPA=?"
for /f "delims=" %%A in ('powershell -NoProfile -Command "@(Get-NetIPConfiguration -ErrorAction SilentlyContinue | Where-Object { $_.IPv4Address -and $_.IPv4DefaultGateway }).Count"') do set "PS_IPGW=%%A"
for /f "delims=" %%A in ('powershell -NoProfile -Command "@(Get-NetIPAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue | Where-Object { $_.IPAddress -like '169.254.*' -and (Get-NetAdapter -InterfaceIndex $_.InterfaceIndex -ErrorAction SilentlyContinue).Status -eq 'Up' }).Count"') do set "PS_APIPA=%%A"
exit /b 0

rem  :find_gateway - lowest-metric IPv4 default gateway, into GW
:find_gateway
set "GW="
for /f "delims=" %%A in ('powershell -NoProfile -Command "(Get-NetRoute -DestinationPrefix 0.0.0.0/0 -ErrorAction SilentlyContinue | Sort-Object RouteMetric | Select-Object -First 1).NextHop"') do set "GW=%%A"
exit /b 0

rem  :run_checks - the three probes, into CHK_GW / CHK_NET / CHK_DNS
:run_checks
call :find_gateway
if defined GW (
    call :check_ping "Default gateway !GW!" "!GW!"
    set "CHK_GW=!CHKRESULT!"
) else (
    echo      Default gateway              [none]
    >>"%LOG%" echo CHECK: default gateway - none found
    set "CHK_GW=none"
)
call :check_ping "Internet 8.8.8.8" "8.8.8.8"
set "CHK_NET=!CHKRESULT!"
call :check_dns
set "CHK_DNS=!CHKRESULT!"
exit /b 0

rem  :check_ping <label> <target> - is this host actually answering?
rem
rem  Test-Connection rather than ping.exe, for two reasons that both came
rem  out of testing this script:
rem    1. ping's exit code alone is not trustworthy - a router answering
rem       "destination host unreachable" on the target's behalf can still
rem       produce exit code 0. Test-Connection returns a result object only
rem       for a real echo reply, so there is nothing to misread.
rem    2. the obvious fix for that - grepping the output for "TTL=" - only
rem       works on an English Windows. Test-Connection needs no text
rem       matching at all, so it behaves the same in any UI language.
rem  It also replaces two ping invocations per check with one call that both
rem  logs the detail and returns the verdict.
rem
rem  A failure here is information, not a script error: no connectivity is
rem  usually the whole reason someone is running this. It never counts
rem  towards FAILS.
:check_ping
set "CHKRESULT=down"
>>"%LOG%" echo CHECK: %~1
if "%DRYRUN%"=="1" (
    echo      %~1  [dry ]
    >>"%LOG%" echo     result: skipped - dry run
    set "CHKRESULT=dry"
    exit /b 0
)
powershell -NoProfile -Command "$t = '%~2'; $r = Test-Connection -ComputerName $t -Count 2 -ErrorAction SilentlyContinue; if ($r) { $r | Format-Table -AutoSize | Out-String; exit 0 } else { 'no reply from ' + $t; exit 1 }" >>"%LOG%" 2>&1
if errorlevel 1 (
    echo      %~1  [down]
    >>"%LOG%" echo     result: unreachable
) else (
    echo      %~1  [ up ]
    >>"%LOG%" echo     result: reachable
    set "CHKRESULT=up"
)
exit /b 0

rem  :check_dns - Resolve-DnsName, not nslookup: nslookup exits 0 even for
rem  a domain that does not exist, so its exit code proves nothing.
:check_dns
set "CHKRESULT=down"
>>"%LOG%" echo CHECK: DNS resolution of www.microsoft.com
if "%DRYRUN%"=="1" (
    echo      DNS resolution              [dry ]
    >>"%LOG%" echo     result: skipped - dry run
    set "CHKRESULT=dry"
    exit /b 0
)
powershell -NoProfile -Command "try { $r = Resolve-DnsName -Name www.microsoft.com -DnsOnly -ErrorAction Stop; $r | Select-Object -First 4 | Out-String; exit 0 } catch { $_.Exception.Message; exit 1 }" >>"%LOG%" 2>&1
if errorlevel 1 (
    echo      DNS resolution              [down]
    >>"%LOG%" echo     result: failed
) else (
    echo      DNS resolution              [ up ]
    >>"%LOG%" echo     result: ok
    set "CHKRESULT=up"
)
exit /b 0

rem  :capture_dns - list adapters with hand-set DNS as  name|servers
:capture_dns
powershell -NoProfile -Command "Get-NetAdapter -ErrorAction SilentlyContinue | ForEach-Object { $p = 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\' + $_.InterfaceGuid; $ns = (Get-ItemProperty -Path $p -Name NameServer -ErrorAction SilentlyContinue).NameServer; if ($ns) { $_.Name + '|' + $ns } }" > "%DNSTMP%" 2>nul
exit /b 0

rem  :show_dns - print the static DNS servers as they stand right now
:show_dns
call :capture_dns
set "FOUND=0"
for %%F in ("%DNSTMP%") do if %%~zF GTR 0 set "FOUND=1"
if "%FOUND%"=="1" (
    for /f "usebackq tokens=1,* delims=|" %%A in ("%DNSTMP%") do (
        echo      %%A  ^>  %%B
        >>"%LOG%" echo     DNS: %%A = %%B
    )
    echo      Left untouched - this script never resets the stack.
) else (
    echo      None - every adapter takes its DNS from DHCP.
    >>"%LOG%" echo     DNS: none set statically
)
del "%DNSTMP%" 2>nul
exit /b 0

rem  :show_proxy - print the WinHTTP proxy exactly as netsh reports it.
rem  Deliberately not parsed: netsh output is localised, so matching on
rem  "Proxy Server" would quietly stop working on a non-English Windows.
rem  for /f skips blank lines for us, so this just indents what netsh says.
:show_proxy
>>"%LOG%" echo --- WinHTTP proxy before the refresh ---
for /f "delims=" %%A in ('netsh winhttp show proxy 2^>nul') do (
    echo      %%A
    >>"%LOG%" echo     %%A
)
if "%DO_PROXY%"=="0" echo      Not changed. Pass /proxy to clear it.
exit /b 0

rem  :show_services - the two services a DHCP refresh cannot work without.
rem  Status comes back as a .NET enum name, so "Running" is the same string
rem  in every UI language - safe to compare against, unlike netsh's text.
:show_services
for %%S in (Dhcp Dnscache) do call :one_service %%S
exit /b 0

:one_service
set "SVCSTATE=?"
for /f "delims=" %%A in ('powershell -NoProfile -Command "(Get-Service -Name '%~1' -ErrorAction SilentlyContinue).Status"') do set "SVCSTATE=%%A"
if /i "%SVCSTATE%"=="Running" (
    echo      %~1 service: Running
    >>"%LOG%" echo     service %~1 = Running
) else (
    echo      %~1 service: %SVCSTATE%  ^<-- not running, this is the problem
    echo        start it with:  sc start %~1
    >>"%LOG%" echo     service %~1 = %SVCSTATE% - NOT RUNNING
)
exit /b 0

rem  :bounce_adapters - disable and re-enable the physical adapters.
rem  Scoped to -Physical so VMware and Hyper-V switches are left alone;
rem  bouncing those would disrupt running VMs for no benefit here.
rem  Still no reboot - the driver reloads on its own.
:bounce_adapters
set /a STEPNUM+=1
set "N=0!STEPNUM!"
echo.
echo [!N:~-2!] Bounce the physical network adapters
echo      Restart-NetAdapter on every physical adapter that is up
>>"%LOG%" echo === [!N:~-2!] Bounce the physical network adapters
if "%DRYRUN%"=="1" (
    echo      [dry ] skipped
    >>"%LOG%" echo     result: skipped - dry run
    exit /b 0
)
powershell -NoProfile -Command "$a = @(Get-NetAdapter -Physical -ErrorAction SilentlyContinue | Where-Object { $_.Status -eq 'Up' }); if ($a.Count -eq 0) { 'no physical adapters are up - nothing to bounce'; exit 0 }; $a | ForEach-Object { $_.Name }; $a | Restart-NetAdapter -Confirm:$false -ErrorAction Stop; Start-Sleep -Seconds 5; exit 0" >>"%LOG%" 2>&1
if errorlevel 1 (
    set /a FAILS+=1
    echo      [FAIL] see the log
    >>"%LOG%" echo     result: FAILED
) else (
    echo      [ ok ]
    >>"%LOG%" echo     result: ok
)
>>"%LOG%" echo.
exit /b 0

rem  :step - a command whose exit code can be trusted - netsh, nbtstat.
rem  Counts towards FAILS.
:step
set /a STEPNUM+=1
set "N=0!STEPNUM!"
echo.
echo [!N:~-2!] %~1
echo      %CMD%
>>"%LOG%" echo === [!N:~-2!] %~1
>>"%LOG%" echo     command: %CMD%
if "%DRYRUN%"=="1" (
    echo      [dry ] skipped
    >>"%LOG%" echo     result: skipped - dry run
    exit /b 0
)
%CMD% >>"%LOG%" 2>&1
if errorlevel 1 (
    set /a FAILS+=1
    echo      [FAIL] exit code !errorlevel!
    >>"%LOG%" echo     result: FAILED
) else (
    echo      [ ok ]
    >>"%LOG%" echo     result: ok
)
>>"%LOG%" echo.
exit /b 0

rem  :runstep - an ipconfig command. ipconfig exits 0 even when it fails,
rem  so there is nothing honest to report beyond "it ran" - the real answer
rem  comes from the AFTER section. Marked [run] so the output does not
rem  claim a success it cannot actually verify, and never counts a failure.
:runstep
set /a STEPNUM+=1
set "N=0!STEPNUM!"
echo.
echo [!N:~-2!] %~1
echo      %CMD%
>>"%LOG%" echo === [!N:~-2!] %~1
>>"%LOG%" echo     command: %CMD%
if "%DRYRUN%"=="1" (
    echo      [dry ] skipped
    >>"%LOG%" echo     result: skipped - dry run
    exit /b 0
)
%CMD% >>"%LOG%" 2>&1
echo      [run ]
>>"%LOG%" echo     result: ran - ipconfig does not report a usable exit code
>>"%LOG%" echo.
exit /b 0

:remote_abort
echo.
echo ===============================================================
echo   REMOTE SESSION DETECTED
echo ===============================================================
echo.
echo   Session: %SESSIONNAME%   Client: %CLIENTNAME%
echo.
echo   Releasing the IP will drop this Remote Desktop session. The
echo   script renews straight afterwards and keeps running on the
echo   machine, so the connection usually comes back on its own -
echo   but "usually" is not a promise, and if it does not there is
echo   no way back in.
echo.
echo   Run it from the console, or re-run with  /force  to accept
echo   the risk. There is no reboot involved either way.
echo.
>>"%LOG%" echo ABORTED: remote session detected and /force was not given.
pause
endlocal
exit /b 2

:badarg
echo.
echo ===============================================================
echo   UNRECOGNISED OPTION: %~1
echo ===============================================================
echo.
echo   Nothing has been run. Valid options are:
echo.
echo      /adapter  /proxy  /y  /force  /dryrun  /verify  /?
echo.
echo   This stops rather than ignoring the option on purpose. A typo
echo   such as  /dryun  instead of  /dryrun  would otherwise be
echo   silently dropped, and you would get the real refresh when you
echo   were expecting a harmless preview.
echo.
pause
endlocal & exit /b 64

:aborted
echo.
echo Cancelled - nothing was changed.
>>"%LOG%" echo ABORTED: user declined at the confirmation prompt.
echo.
pause
endlocal
exit /b 1

:usage
echo net-reset-lite.bat [/adapter] [/proxy] [/y] [/force] [/dryrun]
echo net-reset-lite.bat /verify
echo.
echo   Refreshes the network without a reboot: flushes the DNS, NetBIOS,
echo   ARP, destination and neighbour caches, then releases and renews
echo   the DHCP leases. Checks connectivity before and after.
echo.
echo   /adapter   also bounce the physical adapters - still no reboot.
echo              Virtual adapters are left alone.
echo   /proxy     also clear the system-wide WinHTTP proxy
echo   /y         skip the confirmation prompt
echo   /force     run even from a remote session
echo   /dryrun    print the commands without running them
echo   /verify    connectivity checks only. Changes nothing, no admin.
echo.
echo   Exit codes: 0 up, 1 cancelled, 2 remote refused, 3 still down,
echo               64 bad argument.
echo.
echo   Nothing in this script requires a reboot. For the TCP/IP and
echo   Winsock stack resets, which do, see net-reset-reboot.bat
endlocal & exit /b 0
'@

Start-Transcript -OutputDirectory "$DebloatFolder" | Out-Null

#REWRITTEN: this whole block used to be ~220 lines of
#    Write-Host "Beginning to X. . ."  /  Start-Sleep 1
#    try { X -ErrorAction Stop; Write-Host "X worked!" } catch { Write-Host "X failed!" }
#None of those catches could ever fire (see the note on Invoke-Step above), so the script
#always claimed every step succeeded. Same steps, same order, same values - but now each one
#reports what actually happened, and Write-RunSummary prints the tally at the end.
#
#The decorative "Start-Sleep 1" between every step is gone too: there were roughly 28 of
#them, and Invoke-Step already prints a PROCESS line before and a result line after, so the
#pacing still reads fine without paying ~30 seconds for it on an unattended run.

#This goes first on purpose. It is quick, it touches nothing that can fail later, and it means
#your tools and God Mode are sitting on the Desktop within seconds of starting -
#rather than after DISM has ground away for half an hour. It also has to precede
#NetResetReboot, which calls the net-reset-reboot.bat this writes.
Invoke-Step "Building Desktop tools + God Mode" { Build-DesktopTools }

Invoke-Step "Creating a system restore point"        { GenSysRestorePoint } -Spin
Invoke-Step "Repairing the system image (DISM/SFC)"  { DISMWinRepair }

Write-Host "Creating PSDrive 'HKCR' (HKEY_CLASSES_ROOT). This will be used for the duration of the script as it is necessary for the removal and modification of specific registry keys." -ForegroundColor Yellow
New-PSDrive HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ErrorAction SilentlyContinue | Out-Null

Invoke-Step "Surveying unrecognised packages"                 { DebloatAll } -NoProgress
#WIRED IN: DebloatBlacklist was defined, listed in the function list at the top of the file,
#and called by absolutely nothing. DebloatAll is a whitelist sweep, so it catches most of
#this already - but the curated list (CandyCrush, Spotify, Facebook, the sponsored junk)
#was never explicitly targeted. It runs second so it can mop up anything the sweep left.
Invoke-Step "Removing blacklisted packages"    { DebloatBlacklist } -NoProgress
Invoke-Step "Removing leftover bloatware reg keys"   { Remove-Keys }
Invoke-Step "Restoring whitelisted apps"             { FixWhitelistedApps } -NoProgress
Invoke-Step "Applying privacy + telemetry settings"  { Protect-Privacy }
Invoke-Step "Disabling Cortana"                      { DisableCortana } -Spin
Invoke-Step "Disabling Diagnostics Tracking Service" { DisableDiagTrackService } -Spin
Invoke-Step "Re-enabling DMWAppushservice"           { CheckDMWService } -Spin
Invoke-Step "Removing 3D Objects from Explorer"      { Remove3dObjects } -Spin
Invoke-Step "Stopping Edge hijacking PDFs"           { Stop-EdgePDF } -Spin
Invoke-Step "Enabling .NET 3.5"                      { DISM /Online /Enable-Feature /FeatureName:NetFx3 /All }
Invoke-Step "Showing seconds in the system clock"    { SystemClockSec } -Spin
Invoke-Step "Optimizing for games"                   { GameOptimizer }
Invoke-Step "Optimizing the system"                  { SystemOpti }
Invoke-Step "Disabling Fast Boot (hybrid shutdown)"  { HSdisable } -Spin
Invoke-Step "Unparking the CPU"                      { UnparkCPU } -Spin
Invoke-Step "Disabling Nagle's Algorithm"            { NagleAlgoDis }
Invoke-Step "Applying the hosts blocklist"           { BlocklistMNNSSM }
Invoke-Step "Disabling AutoRun"                      { AutoRunDis } -Spin
Invoke-Step "Disabling the On-Screen Keyboard"       { OSKDis } -Spin
Invoke-Step "Disabling Aero Shake"                   { AeroShakeDisable } -Spin
#Was two steps hardcoded to adapters literally named "Ethernet" and "Wi-Fi". Now one step
#that enumerates connected physical adapters - and deliberately skips virtual ones, so it
#cannot clobber DNS on a VMware/Hyper-V/VPN adapter.
Invoke-Step "Setting DNS to CloudFlare"              { Set-CloudFlareDNS } -Spin
#REPLACES the old NetFullReset step. NetResetReboot shells out to net-reset-reboot.bat with
#/y /none, so it does the full stack reset but explicitly does NOT reboot - the reboot stays
#at the very end of this script as the prompt the user answers.
Invoke-Step "Resetting the local network stack"      { NetResetReboot }
Invoke-Step "Setting the Ultimate Performance power plan" { HIGHPOWA }
Invoke-Step "Disabling USB/PCIe/NIC power saving"    { OptimizeLinkAndInputPower } -Spin
Invoke-Step "Tuning scheduler and timer resolution"  { TuneSchedulerAndTimer } -Spin

#ADDED: security + privacy hardening. Placed at the end of the step list on purpose - EnableDoH
#has to land after Set-CloudFlareDNS has pointed the adapters at CloudFlare and after
#NetResetReboot has finished resetting the stack, or the reset would undo it.
Invoke-Step "Hardening SMB (v1 + guest auth)"                        { DisableSMBv1 } -Spin
Invoke-Step "Disabling LLMNR, mDNS and NetBIOS-NS"         { DisableLLMNRandNetBIOS } -Spin
Invoke-Step "Hardening credential storage"           { HardenCredentialStorage } -Spin
Invoke-Step "Removing the PowerShell v2 engine"      { DisablePowerShellV2 } -Spin
Invoke-Step "Completing AutoRun hardening"           { CompleteAutoRunHardening } -Spin
Invoke-Step "Disabling Recall / Windows AI"          { DisableRecallAndAI } -Spin
Invoke-Step "Disabling Activity History"             { DisableActivityHistory } -Spin
Invoke-Step "Disabling cross-device clipboard sync"  { DisableCloudClipboard } -Spin
Invoke-Step "Restricting Delivery Optimization"      { LimitDeliveryOptimization } -Spin
Invoke-Step "Enabling DNS over HTTPS"                { EnableDoH } -Spin

#ADDED (Tier A). Grouped after the existing hardening for the same reason DoH sits last:
#nothing here should run before the network steps have settled.
Invoke-Step "Disabling legacy remote access"         { DisableLegacyRemoteAccess } -Spin
Invoke-Step "Disabling error reporting and CEIP"     { DisableTelemetryExtras } -Spin
Invoke-Step "Restricting background app access"      { RestrictBackgroundApps } -Spin
Invoke-Step "Disabling Windows Copilot"              { DisableCopilot } -Spin
Invoke-Step "Muzzling Edge telemetry"                { HardenEdgeTelemetry } -Spin
Invoke-Step "Reclaiming disk space"                  { ReclaimDiskSpace }
Invoke-Step "Setting visual effects to performance"  { SetVisualEffectsPerformance } -Spin

Write-Host "Unloading the HKCR drive..." -ForegroundColor Yellow
Remove-PSDrive HKCR -ErrorAction SilentlyContinue

Write-RunSummary

Stop-Transcript | Out-Null
Start-Sleep 1
Write-Host "Everything is finished and your computer requires a reboot for changes to take effect 
please enter one of the following options below:" -ForegroundColor Yellow
redundantColors -Background Black -Foreground Yellow
$rebootyn = '   For reboot with ASCII art Yes = y, ya, tak, da, si, ja
    For reboot with ASCII art No = n, no, nyet, niet
    For instant reboot with no ASCII art = yy 
    For no reboot with no ASCII art no = nn 
    ___________________
    Please enter below
'

do {
    #Final sweep before the prompt. A banner left by any cmdlet earlier in the run will otherwise
    #sit across the top of the console covering this prompt and the closing countdown after it.
    Clear-ProgressBar
    $response = Read-Host -Prompt $rebootyn

    $YesResponsesR = @(
    "y"
    "Y"
    "ya"
    "tak"
    "da"
    "si"
    "ja"
    )

    $NoResponsesR = @(
    "n"
    "N"
    "no"
    "nyet"
    "niet"
    )

    $InstaYesR = @(
    "yy" 
    "YY" 
    "yY" 
    "Yy"
    )

    $InstaNoR = @(
     "nn" 
     "NN"   
     "nN" 
     "Nn"
    )
    if (!(($YesResponsesR -eq $response) -or ($NoResponsesR -eq $response) -or ($InstaYesR -eq $response) -or ($InstaNoR -eq $response))) {
        "Incorrect input. . .
        " 
    }elseif ($YesResponsesR -eq $response){
        $Random = New-Object System.Random
        $Venasaur = '
                           _._       _,._
                        _.*   `. * .*   _`.
                ,***/`**-.-.,/. ` V*\-,`.,--/***.*-..
              ,*    `...,* . ,\-----._|     `.   /   \
             `.            .`  -*`** .._   :> `-*   `.
            ,*  ,-.  _,.-*| `..___ ,*   |*-..__   .._ L
           .    \_ -*   `-*     ..      `.-* `.`-.*_ .|
           |   ,*,-,--..  ,--../  `.  .-.    , `-.  ``.
           `.,* ,  |   |  `.  /*/,,.\/  |    \|   |
                `  `---*    `j   .   \  .     *   j
              ,__`*        ,*|`*\_/`.*\*        |\-*-, _,.
       .--...`-. `-`. /    *- ..      _,    /\ ,* .--**  ,**.
     _*-**-    --  _`*-.../ __ *.*`-^,_`-****---....__  * _,-`
   _.----`  _..--.*        |  *`-..-* __|***         .**-. ***--.._
  /        *    /     ,  _.+-.*  ||._*   ****. .          `     .__\
 `---    /        /  / j*       _/|..`  -. `-`\ \   \  \   `.  \ `-..
,* _.-* /    /` ./  /`_|_,-*   *,*|       `. | -*`._,   L  \ .  `.   |
`** /  /  / ,__...-----| _.,  ,*            `|----.._`-.|* |. .` ..  .
   /  *| /.,/   \--.._ `-,* ,          .  *`.*  __,., *  **``._ \ \`,*
  /_,*---  ,     \`._,-` \ //  / . \    `._,  -`,  / / _   |   `-L -
   /       `.     ,  ..._ * `_/ *| |\ `._*       *-.*   `.,*     |
  *         /    /  ..   `.  `./ | ; `.*    ,** ,.  `.    \      |
   `.     ,*   ,*   | |\  |       *        |  ,*\ |   \    `    ,L
   /|`.  /    *     | `-| *                  /`-* |    L    `._/  \
  / | .`|    |  .   `._.*                   `.__,*   .  |     |  (`
 *-**-*_|    `. `.__,._____     .    _,        ____ ,-  j     *.-***
        \      `-.  \/.    `*--.._    _,.---***\/  *_,.*     /-*
         )        `-._ *-.        `--*      _.-*.-**        `.
        ./            `,. `*.._________...**_.-*`.          _j
       /_\.__,**.   ,.*  *`-...________.---*     .*.   ,.  / \
              \_/***-*                           `-*--(_,`*`-`
                Your PC will reboot in 4 seconds. . . 
'
        $Venasaur -split '' |
        ForEach-Object{
          Write-Host $_ -nonew -ForeGroundColor DarkGreen
          Start-Sleep -milliseconds $(1 + $Random.Next(1))
        }
        Start-Sleep 4
        redundantColors -Background Black -Foreground White -ClearScreen
        CleanMemoryy
        Start-Sleep 1
        Restart-Computer
    }elseif ($InstaYesR -eq $response){
        redundantColors -Background Black -Foreground White -ClearScreen
        CleanMemoryy
        Start-Sleep 1
        Restart-Computer
    }elseif ($InstaNoR -eq $response){
        redundantColors -Background Black -Foreground White -ClearScreen
        CleanMemoryy
        Start-Sleep 1
        Close-ScriptWindow -Seconds 3
    }elseif ($NoResponsesR -eq $response){
        $Random = New-Object System.Random
        $bisstarter = '
                                           /
                        _,.------....___,.* *,.-.
                     ,-*          _,.--*        |
                   ,*         _.-*              .
                  /   ,     ,*                   `
                 .   /     /                     ``.
                 |  |     .                       \.\
       ____      |___._.  |       __               \ `.
     .*    `---**       ``*-.--**`  \               .  \
    .  ,            __               `              |   .
    `,*         ,-**  .               \             |    L
   ,*          *    _.*                -._          /    |
  ,`-.    ,*.   `--*                      >.      ,*     |
 . .*\*   `-*       __    ,  ,-.         /  `.__.-      ,*
 ||:, .           ,*  ;  /  / \ `        `.    .      .*/
 j|:D  \          `--*  * ,*_  . .         `.__, \   , /
/ L:_  |                 .  ** :_;                `.*.*
.    ***                  ******                    V
 `.                                 .    `.   _,..  `
   `,_   .    .                _,-*/    .. `,*   __  `
    ) \`._        ___....----**  ,*   .*  \ |   *  \  .
   /   `. *`-.--**         _,* ,*     `---* |    `./  |
  .   _  `***--.._____..--*   ,             *         |
  | .* `. `-.                /-.           /          ,
  | `._.*    `,_            ;  /         ,*          .
 .*          /| `-.        . ,*         ,           ,
 *-.__ __ _,*,*    *`-..___;-...__   ,.*\ ____.___.*
 `*^--*..*   *-`-^-**--    `-^-*`.*******`.,^.`.--* 
                Reboot is skipped. . . 
'
        $bisstarter -split '' |
        ForEach-Object{
          Write-Host $_ -nonew -ForeGroundColor DarkGreen
          Start-Sleep -milliseconds $(1 + $Random.Next(1))
        }
        Write-Host "" 
        Start-Sleep 4
        redundantColors -Background Black -Foreground White -ClearScreen
        CleanMemoryy
        Start-Sleep 1
        Close-ScriptWindow -Seconds 3
    }
}While (!(($YesResponsesR -eq $response) -or ($NoResponsesR -eq $response) -or ($InstaYesR -eq $response) -or ($InstaNoR -eq $response)))



