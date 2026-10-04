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
##  OFTWARE.
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
##  Dan Pollock's hosts file is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License (CC BY-SA 4.0).
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
    #Line 15500 is end of the blocklist
    #This function edits the system hostfile with Dan Pollocks BlockList as well as a few extra entries.
    $hostsloc = "C:\Windows\System32\Drivers\Etc\hosts"
    Write-Host "Grabbing hosts file" -ForegroundColor Yellow 

	    
    #FRAGMENT 2: the 13,265-line blocklist used to sit inline right here, which is why 89% of
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

#  Dan Pollock's hosts blocklist - https://someonewhocares.org/hosts/ (CC BY-SA 4.0)
$script:MNNSSMBlocklist = @'
# This hosts file is brought to you by Dan Pollock and can be found at
# http://someonewhocares.org/hosts/
# You are free to copy and distribute this file for non-commercial uses,
# as long the original URL and attribution is included. 
# 
# This hosts file is proudly sponsored by adguard.com. 
#
# See below for acknowledgements.

# Please forward any additions, corrections or comments by email to
# hosts@someonewhocares.org

# Last updated: Thu, 25 Jun 2026 at 17:48:06 GMT

# Use this file to prevent your computer from connecting to selected
# internet hosts. This is an easy and effective way to protect you from 
# many types of spyware, reduces bandwidth use, blocks certain pop-up 
# traps, prevents user tracking by way of "web bugs" embedded in spam,
# provides partial protection to IE from certain web-based exploits and
# blocks most advertising you would otherwise be subjected to on the 
# internet. 

# There is a version of this file that uses 0.0.0.0 instead of 127.0.0.1 
# available at http://someonewhocares.org/hosts/zero/.
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
#    | please visit http://someonewhocares.org/hosts/mac/ for mac format
# For Android place the file at "/system/etc/hosts". You will need root
#   access on your device to do this.
#    ------------------
# To convert the hosts file to a set of Cisco IOS commands for Cisco routers
#   use this script by Jesse Baird:
#   http://jebaird.com/2012/12/21/hosts-to-ip-host-generating-blocked-hosts-from-a-host-file-for-a-cisco-router.html

# If there is a domain name you would rather never see, simply add a line
# that reads "127.0.0.1 machine.domain.tld". This will have the effect of
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
127.0.0.1    a.ads1.msn.com
127.0.0.1    a.ads2.msn.com
127.0.0.1    ac3.msn.com
127.0.0.1    ads.msn.com
127.0.0.1    ads1.msn.com
127.0.0.1    b.ads1.msn.com
127.0.0.1    statsfe1.ws.microsoft.com
127.0.0.1    statsfe2.update.microsoft.com.akadns.net
127.0.0.1    statsfe2.ws.microsoft.com
127.0.0.1    watson.microsoft.com
127.0.0.1    a.ads1.msn.com
127.0.0.1    a.ads2.msn.com
127.0.0.1    a.rad.msn.com
127.0.0.1    ac3.msn.com
127.0.0.1    ads.msn.com
127.0.0.1    ads1.msn.com
127.0.0.1    ads2.msn.com
127.0.0.1    ads2.msn.com.c.footprint.net
127.0.0.1    b.ads1.msn.com
127.0.0.1    b.rad.msn.com
127.0.0.1    c.msn.com
127.0.0.1    corpext.msitadfs.glbdns2.microsoft.com
127.0.0.1    fe2.update.microsoft.com.akadns.net
127.0.0.1    feedback.microsoft-hohm.com
127.0.0.1    flex.msn.com
127.0.0.1    g.msn.com
127.0.0.1    h1.msn.com
127.0.0.1    live.rads.msn.com
127.0.0.1    msnbot-207-46-194-33.search.msn.com
127.0.0.1    msnbot-65-55-108-23.search.msn.com
127.0.0.1    preview.msn.com
127.0.0.1    rad.msn.com
127.0.0.1    schemas.microsoft.akadns.net
127.0.0.1    settings-sandbox.data.glbdns2.microsoft.com
127.0.0.1    settings.data.glbdns2.microsoft.com
127.0.0.1    sls.update.microsoft.com.akadns.net
127.0.0.1    statsfe1.ws.microsoft.com
127.0.0.1    statsfe1.ws.microsoft.com.nsatc.net
127.0.0.1    statsfe2.update.microsoft.com.akadns.net
127.0.0.1    statsfe2.ws.microsoft.com
127.0.0.1    statsfe2.ws.microsoft.com.nsatc.net
127.0.0.1    survey.watson.microsoft.com
127.0.0.1    vortex-sandbox.data.glbdns2.microsoft.com
127.0.0.1    vortex.data.glbdns2.microsoft.com
127.0.0.1    watson.microsoft.com
127.0.0.1    watson.microsoft.com.nsatc.net
127.0.0.1    watson.mi

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
# removal programs such as SpyBotS&D, AdAware or HijackThis to remove this 
# nasty parasite. It's possible that blocking these sites using a hosts file 
# may not work, in which case you should remove the following lines from this
# file and try the tools listed above immediately. Don't forget to reboot 
# after a scan.
127.0.0.1 ads234.com
127.0.0.1 ads345.com
127.0.0.1 www.ads234.com
127.0.0.1 www.ads345.com
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
#127.0.0.1 auto.search.msn.com  # Microsoft uses this server to redirect
                                # mistyped URLs to search engines. They
                                # log all such errors.
#127.0.0.1 sitefinder.verisign.com	# Verisign has joined the game 
#127.0.0.1 sitefinder-idn.verisign.com	# of trying to hijack mistyped
					# URLs to their site. 
					# May break iOS Game Center.

#127.0.0.1 s0.2mdn.net		# This may interfere with some streaming 
				# video on sites such as cbc.ca
#127.0.0.1 ad.doubleclick.net   # This may interefere with www.sears.com
				# and potentially other sites. 
127.0.0.1 media.fastclick.net	# Likewise, this may interfere with some
127.0.0.1 cdn.fastclick.net	# sites. 
#127.0.0.1 ebay.doubleclick.net		# may interfere with ebay
#127.0.0.1 google-analytics.com			# breaks some sites
#127.0.0.1 ssl.google-analytics.com
#127.0.0.1 www.google-analytics.l.google.com
#127.0.0.1 stat.livejournal.com		# There are reports that this may mess 
 					# up CSS on livejournal
#127.0.0.1 stats.surfaid.ihost.com	# This has been known cause 
					# problems with NPR.org
#127.0.0.1 www.google-analytics.com		# breaks some sites
#127.0.0.1 ads.imeem.com		# Seems to interfere with the functioning of imeem.com
#</maybe-spy>

#127.0.0.1 ci-mpsnare.iovation.com	# See http://www.codingthewheel.com/archives/online-gambling-privacy-iesnare
#127.0.0.1 ll.a.hulu.com	# Uncomment to block Hulu.
#127.0.0.1 metrics.ticketmaster.com	# interferes with logging in to ticketmaster.com
#127.0.0.1 nl.sitestat.com	# may interfere with duo.nl
#127.0.0.1 pro.hit.gemius.pl	# May interfere with some video sites
#127.0.0.1 s.youtube.com				# Blocking this will interfere with video watching history and may interfere with Google Podcasts
#127.0.0.1 services.krxd.net
#127.0.0.1 stats.channel4.com
#127.0.0.1 t2.hulu.com		# Uncomment to block Hulu.
#127.0.0.1 track.hulu.com	# Uncomment to block Hulu.
#127.0.0.1 webstat.channel4.com
#127.0.0.1 www.googletagservices.com		#interferes with techrepublic
127.0.0.1 006.free-counter.co.uk
127.0.0.1 006.freecounters.co.uk
127.0.0.1 0stats.com
127.0.0.1 123counter.mycomputer.com
127.0.0.1 123counter.superstats.com
127.0.0.1 1ca.cqcounter.com
127.0.0.1 1uk.cqcounter.com
127.0.0.1 1us.cqcounter.com
127.0.0.1 1xxx.cqcounter.com
127.0.0.1 20585485p.rfihub.com
127.0.0.1 3dns-1.adobe.com
127.0.0.1 3dns-2.adobe.com
127.0.0.1 3dns-3.adobe.com
127.0.0.1 3dns-4.adobe.com
127.0.0.1 3dns.adobe.com
127.0.0.1 4-counter.com
127.0.0.1 a-nj.1rx.io
127.0.0.1 a-ssl.ligatus.com
127.0.0.1 a.predictvideo.com
127.0.0.1 a.visualrevenue.com
127.0.0.1 abclnks.com
127.0.0.1 aboardamusement.com
127.0.0.1 abscbn.spinbox.net
127.0.0.1 activity.serving-sys.com	#eyeblaster.com
127.0.0.1 adadvisor.net
127.0.0.1 adapi.ragapa.com
127.0.0.1 adcounter.theglobeandmail.com
127.0.0.1 addfreestats.com
127.0.0.1 adelogs.adobe.com	#See http://www.theregister.co.uk/2014/10/07/adobe_digital_editions_4_caught_snooping_into_ebook_collections_of_users/
127.0.0.1 ademails.com
127.0.0.1 adlog.com.com # Used by Ziff Davis to serve 
  # ads and track users across 
  # the com.com family of sites
127.0.0.1 admin.iovation.com
127.0.0.1 adopt.specificclick.net
127.0.0.1 adpatrof.com
127.0.0.1 ads.tiscali.it
127.0.0.1 adtrack.appcpi.net
127.0.0.1 adult.foxcounter.com
127.0.0.1 affpool.com
127.0.0.1 alert.mac-notification.com
127.0.0.1 alpha.easy-hit-counters.com
127.0.0.1 amateur.xxxcounter.com
127.0.0.1 amer.rel.msn.com
127.0.0.1 an.mlb.com
127.0.0.1 analytics-ingress-global.bitmovin.com
127.0.0.1 analytics-static.ugc.bazaarvoice.com
127.0.0.1 analytics.foresee.com
127.0.0.1 analytics.global.sky.com
127.0.0.1 analytics.msnbc.msn.com
127.0.0.1 analytics.ooyala.com
127.0.0.1 analytics.prx.org
127.0.0.1 analytics.publitas.com
127.0.0.1 analytics.sleeknote.com
127.0.0.1 analytics.tiktok.com
127.0.0.1 anonymousdemographics.com
127.0.0.1 ant.conversive.nl
127.0.0.1 apac.rel.msn.com
127.0.0.1 api.adsymptotic.com
127.0.0.1 api.behavioralengine.com
127.0.0.1 api.bizographics.com
127.0.0.1 api.gameanalytics.com
127.0.0.1 api.infinario.com
127.0.0.1 api.intentiq.com
127.0.0.1 api.redshell.io
127.0.0.1 api.simpleanalytics.io
127.0.0.1 api.tumra.com
127.0.0.1 apiadapter.ad5track.com
127.0.0.1 apis.murdoog.com
127.0.0.1 app-analytics-v2.snapchat.com
127.0.0.1 app-analytics.snapchat.com
127.0.0.1 app.yesware.com
127.0.0.1 arbo.hit.gemius.pl
127.0.0.1 aus-mec-tracking.adalyser.com
127.0.0.1 aus-smv-tracking.adalyser.com
127.0.0.1 auspice.augur.io
127.0.0.1 b.stats.paypal.com
127.0.0.1 bam.nr-data.net
127.0.0.1 banner.0catch.com
127.0.0.1 banners.webcounter.com
127.0.0.1 be.sitestat.com
127.0.0.1 beacon-1.newrelic.com
127.0.0.1 beacon.krxd.net
127.0.0.1 beacon.scorecardresearch.com
127.0.0.1 belierlaine.com
127.0.0.1 benchemail.bmetrack.com
127.0.0.1 best-search.cc	#spyware
127.0.0.1 beta.easy-hit-counters.com
127.0.0.1 beta.easyhitcounters.com
127.0.0.1 bigdata.adfuture.cn
127.0.0.1 bigdata.adsunflower.com
127.0.0.1 bigdata.adups.com
127.0.0.1 bigdata.advmob.cn
127.0.0.1 bindedge.com
127.0.0.1 bindfast.com
127.0.0.1 biomagin.com
127.0.0.1 bkrtx.com
127.0.0.1 bleachbit.com
127.0.0.1 bluekai.com
127.0.0.1 bluestreak.com
127.0.0.1 brightroll.com
127.0.0.1 brucelead.com
127.0.0.1 bullionglidingscuttle.com
127.0.0.1 c.go-mpulse.net
127.0.0.1 c.statcounter.com
127.0.0.1 c.thecounter.de
127.0.0.1 c0.adalyser.com
127.0.0.1 c1.statcounter.com
127.0.0.1 c1.thecounter.de
127.0.0.1 c1.xxxcounter.com
127.0.0.1 c10.statcounter.com
127.0.0.1 c11.statcounter.com
127.0.0.1 c12.statcounter.com
127.0.0.1 c13.statcounter.com
127.0.0.1 c14.statcounter.com
127.0.0.1 c15.statcounter.com
127.0.0.1 c16.statcounter.com
127.0.0.1 c17.statcounter.com
127.0.0.1 c2.gostats.com
127.0.0.1 c2.thecounter.de
127.0.0.1 c2.xxxcounter.com
127.0.0.1 c3.adalyser.com
127.0.0.1 c3.gostats.com
127.0.0.1 c3.statcounter.com
127.0.0.1 c3.xxxcounter.com
127.0.0.1 c4.myway.com
127.0.0.1 c4.statcounter.com
127.0.0.1 c5.statcounter.com
127.0.0.1 c6.statcounter.com
127.0.0.1 c7.statcounter.com
127.0.0.1 c8.statcounter.com
127.0.0.1 c9.statcounter.com
127.0.0.1 ca.cqcounter.com
127.0.0.1 cashcounter.com
127.0.0.1 cb1.counterbot.com
127.0.0.1 ccleaner.fr
127.0.0.1 cdn-gl.imrworldwide.com
127.0.0.1 cdn-social.janrain.com
127.0.0.1 cdn.decibelinsight.net
127.0.0.1 cdn.doublepimpssl.com
127.0.0.1 cdn.simpleanalytics.io
127.0.0.1 cdn.taboolasyndication.com
127.0.0.1 cdn.zarget.com
127.0.0.1 cf.addthis.com
127.0.0.1 cgi.sexlist.com
127.0.0.1 cgicounter.onlinehome.de
127.0.0.1 cgicounter.puretec.de
127.0.0.1 ci-admin.iovation.com
127.0.0.1 cig-arrete.com
127.0.0.1 citrix.tradedoubler.com
127.0.0.1 cjt1.net
127.0.0.1 clckcloud.com
127.0.0.1 click.atdmt.com
127.0.0.1 click.icptrack.com
127.0.0.1 click.jve.net
127.0.0.1 click.payserve.com
127.0.0.1 click.silvercash.com
127.0.0.1 clickauditor.net
127.0.0.1 clickmeter.com
127.0.0.1 clicks.emarketmakers.com
127.0.0.1 clicks.m4n.nl
127.0.0.1 clicks.natwest.com
127.0.0.1 clicks.rbs.co.uk
127.0.0.1 clickspring.net	#used by a spyware product called PurityScan
127.0.0.1 clickstatsview.earnmoneycasinos.com
127.0.0.1 clicktrack.onlineemailmarketing.com
127.0.0.1 clicktrack.premium-shops.net
127.0.0.1 clicktracker.alloymarketing.com
127.0.0.1 clicktracks.webmetro.com
127.0.0.1 clit10.sextracker.com
127.0.0.1 clit13.sextracker.com
127.0.0.1 clit15.sextracker.com
127.0.0.1 clit2.sextracker.com
127.0.0.1 clit4.sextracker.com
127.0.0.1 clit6.sextracker.com
127.0.0.1 clit7.sextracker.com
127.0.0.1 clit8.sextracker.com
127.0.0.1 clit9.sextracker.com
127.0.0.1 clk.aboxdeal.com
127.0.0.1 clk.relestar.com
127.0.0.1 cnn.entertainment.printthis.clickability.com
127.0.0.1 cnt.xcounter.com
127.0.0.1 code.murdoog.com
127.0.0.1 collector.deepmetrix.com
127.0.0.1 connectionlead.com
127.0.0.1 connexity.net
127.0.0.1 convertro.com
127.0.0.1 convnjmp.basebanner.com
127.0.0.1 cookies.cmpnet.com
127.0.0.1 count.channeladvisor.com
127.0.0.1 count.paycounter.com
127.0.0.1 counter.123counts.com
127.0.0.1 counter.adultcheck.com
127.0.0.1 counter.adultrevenueservice.com
127.0.0.1 counter.advancewebhosting.com
127.0.0.1 counter.aport.ru
127.0.0.1 counter.avp2000.com
127.0.0.1 counter.bizland.com
127.0.0.1 counter.bloke.com
127.0.0.1 counter.clubnet.ro
127.0.0.1 counter.cnw.cz
127.0.0.1 counter.cz
127.0.0.1 counter.dreamhost.com
127.0.0.1 counter.execpc.com
127.0.0.1 counter.fateback.com
127.0.0.1 counter.gamespy.com
127.0.0.1 counter.hitslink.com
127.0.0.1 counter.hitslinks.com
127.0.0.1 counter.inetusa.com
127.0.0.1 counter.kaspersky.com
127.0.0.1 counter.letssingit.com
127.0.0.1 counter.mtree.com
127.0.0.1 counter.mycomputer.com
127.0.0.1 counter.nope.dk
127.0.0.1 counter.nowlinux.com
127.0.0.1 counter.rambler.ru
127.0.0.1 counter.search.bg
127.0.0.1 counter.sparklit.com
127.0.0.1 counter.superstats.com
127.0.0.1 counter.surfcounters.com
127.0.0.1 counter.topping.com.ua
127.0.0.1 counter.tripod.com
127.0.0.1 counter.w3open.com
127.0.0.1 counter.webmedia.pl
127.0.0.1 counter.xxxcool.com
127.0.0.1 counter.yadro.ru
127.0.0.1 counter1.bravenet.com
127.0.0.1 counter1.sextracker.be
127.0.0.1 counter1.sextracker.com
127.0.0.1 counter10.bravenet.com
127.0.0.1 counter10.sextracker.be
127.0.0.1 counter10.sextracker.com
127.0.0.1 counter11.bravenet.com
127.0.0.1 counter11.sextracker.be
127.0.0.1 counter11.sextracker.com
127.0.0.1 counter12.bravenet.com
127.0.0.1 counter12.sextracker.be
127.0.0.1 counter12.sextracker.com
127.0.0.1 counter13.bravenet.com
127.0.0.1 counter13.sextracker.be
127.0.0.1 counter13.sextracker.com
127.0.0.1 counter14.bravenet.com
127.0.0.1 counter14.sextracker.be
127.0.0.1 counter14.sextracker.com
127.0.0.1 counter15.bravenet.com
127.0.0.1 counter15.sextracker.be
127.0.0.1 counter15.sextracker.com
127.0.0.1 counter16.bravenet.com
127.0.0.1 counter16.sextracker.be
127.0.0.1 counter16.sextracker.com
127.0.0.1 counter17.bravenet.com
127.0.0.1 counter18.bravenet.com
127.0.0.1 counter19.bravenet.com
127.0.0.1 counter2.bravenet.com
127.0.0.1 counter2.freeware.de
127.0.0.1 counter2.hitslink.com
127.0.0.1 counter2.sextracker.be
127.0.0.1 counter2.sextracker.com
127.0.0.1 counter20.bravenet.com
127.0.0.1 counter21.bravenet.com
127.0.0.1 counter22.bravenet.com
127.0.0.1 counter23.bravenet.com
127.0.0.1 counter24.bravenet.com
127.0.0.1 counter25.bravenet.com
127.0.0.1 counter26.bravenet.com
127.0.0.1 counter27.bravenet.com
127.0.0.1 counter28.bravenet.com
127.0.0.1 counter29.bravenet.com
127.0.0.1 counter3.bravenet.com
127.0.0.1 counter3.sextracker.be
127.0.0.1 counter3.sextracker.com
127.0.0.1 counter30.bravenet.com
127.0.0.1 counter31.bravenet.com
127.0.0.1 counter32.bravenet.com
127.0.0.1 counter33.bravenet.com
127.0.0.1 counter34.bravenet.com
127.0.0.1 counter35.bravenet.com
127.0.0.1 counter36.bravenet.com
127.0.0.1 counter37.bravenet.com
127.0.0.1 counter38.bravenet.com
127.0.0.1 counter39.bravenet.com
127.0.0.1 counter4.bravenet.com
127.0.0.1 counter4.sextracker.be
127.0.0.1 counter4.sextracker.com
127.0.0.1 counter40.bravenet.com
127.0.0.1 counter41.bravenet.com
127.0.0.1 counter42.bravenet.com
127.0.0.1 counter43.bravenet.com
127.0.0.1 counter44.bravenet.com
127.0.0.1 counter45.bravenet.com
127.0.0.1 counter46.bravenet.com
127.0.0.1 counter47.bravenet.com
127.0.0.1 counter48.bravenet.com
127.0.0.1 counter49.bravenet.com
127.0.0.1 counter4all.dk
127.0.0.1 counter4u.de
127.0.0.1 counter5.bravenet.com
127.0.0.1 counter5.sextracker.be
127.0.0.1 counter5.sextracker.com
127.0.0.1 counter50.bravenet.com
127.0.0.1 counter6.bravenet.com
127.0.0.1 counter6.sextracker.be
127.0.0.1 counter6.sextracker.com
127.0.0.1 counter7.bravenet.com
127.0.0.1 counter7.sextracker.be
127.0.0.1 counter7.sextracker.com
127.0.0.1 counter8.bravenet.com
127.0.0.1 counter8.sextracker.be
127.0.0.1 counter8.sextracker.com
127.0.0.1 counter9.bravenet.com
127.0.0.1 counter9.sextracker.be
127.0.0.1 counter9.sextracker.com
127.0.0.1 counteraport.spylog.com
127.0.0.1 counterbot.com
127.0.0.1 countercrazy.com
127.0.0.1 counters.auctionhelper.com		# comment these 
127.0.0.1 counters.auctionwatch.com		# out to allow 
127.0.0.1 counters.auctiva.com			# tracking by
127.0.0.1 counters.honesty.com			# ebay users
127.0.0.1 cs.sexcounter.com
127.0.0.1 cw.nu
127.0.0.1 cyberduck.fr
127.0.0.1 cyseal.cyveillance.com
127.0.0.1 cz3.clickzs.com
127.0.0.1 cz6.clickzs.com
127.0.0.1 da.newstogram.com
127.0.0.1 dap.digitalgov.gov
127.0.0.1 data.coremetrics.com
127.0.0.1 data.murdoog.com
127.0.0.1 data.webads.co.nz
127.0.0.1 data2.perf.overture.com
127.0.0.1 dc43.s290.meetrics.net
127.0.0.1 dclk.themarker.com
127.0.0.1 dclk.themarketer.com
127.0.0.1 de-config.sensic.net
127.0.0.1 de.sitestat.com
127.0.0.1 de.tynt.com
127.0.0.1 def.dev-nano.com
127.0.0.1 didtheyreadit.com		# email bugs
127.0.0.1 digistats.westjet.com
127.0.0.1 dimeprice.com		# "spam bugs"
127.0.0.1 directads.mcafee.com
127.0.0.1 dkb01.webtrekk.net
127.0.0.1 dnsdelegation.io
127.0.0.1 dotcomsecrets.com
127.0.0.1 dpbolvw.net
127.0.0.1 dwclick.com
127.0.0.1 dyn.emetriq.de
127.0.0.1 e-2dj6wfk4ehd5afq.stats.esomniture.com
127.0.0.1 e-2dj6wfk4ggdzkbo.stats.esomniture.com
127.0.0.1 e-2dj6wfk4gkcpiep.stats.esomniture.com
127.0.0.1 e-2dj6wfk4skdpogo.stats.esomniture.com
127.0.0.1 e-2dj6wfkiakdjgcp.stats.esomniture.com
127.0.0.1 e-2dj6wfkiepczoeo.stats.esomniture.com
127.0.0.1 e-2dj6wfkikjd5glq.stats.esomniture.com
127.0.0.1 e-2dj6wfkiokc5odp.stats.esomniture.com
127.0.0.1 e-2dj6wfkiqjcpifp.stats.esomniture.com
127.0.0.1 e-2dj6wfkocjczedo.stats.esomniture.com
127.0.0.1 e-2dj6wfkokjajseq.stats.esomniture.com
127.0.0.1 e-2dj6wfkowkdjokp.stats.esomniture.com
127.0.0.1 e-2dj6wfkykpazskq.stats.esomniture.com
127.0.0.1 e-2dj6wflicocjklo.stats.esomniture.com
127.0.0.1 e-2dj6wfligpd5iap.stats.esomniture.com
127.0.0.1 e-2dj6wflikgdpodo.stats.esomniture.com
127.0.0.1 e-2dj6wflikiajslo.stats.esomniture.com
127.0.0.1 e-2dj6wflioldzoco.stats.esomniture.com
127.0.0.1 e-2dj6wfliwpczolp.stats.esomniture.com
127.0.0.1 e-2dj6wfloenczmkq.stats.esomniture.com
127.0.0.1 e-2dj6wflokmajedo.stats.esomniture.com
127.0.0.1 e-2dj6wfloqgc5mho.stats.esomniture.com
127.0.0.1 e-2dj6wfmysgdzobo.stats.esomniture.com
127.0.0.1 e-2dj6wgkigpcjedo.stats.esomniture.com
127.0.0.1 e-2dj6wgkisnd5abo.stats.esomniture.com
127.0.0.1 e-2dj6wgkoandzieq.stats.esomniture.com
127.0.0.1 e-2dj6wgkycpcpsgq.stats.esomniture.com
127.0.0.1 e-2dj6wgkyepajmeo.stats.esomniture.com
127.0.0.1 e-2dj6wgkyknd5sko.stats.esomniture.com
127.0.0.1 e-2dj6wgkyomdpalp.stats.esomniture.com
127.0.0.1 e-2dj6whkiandzkko.stats.esomniture.com
127.0.0.1 e-2dj6whkiepd5iho.stats.esomniture.com
127.0.0.1 e-2dj6whkiwjdjwhq.stats.esomniture.com
127.0.0.1 e-2dj6wjk4amd5mfp.stats.esomniture.com
127.0.0.1 e-2dj6wjk4kkcjalp.stats.esomniture.com
127.0.0.1 e-2dj6wjk4ukazebo.stats.esomniture.com
127.0.0.1 e-2dj6wjkosodpmaq.stats.esomniture.com
127.0.0.1 e-2dj6wjkouhd5eao.stats.esomniture.com
127.0.0.1 e-2dj6wjkowhd5ggo.stats.esomniture.com
127.0.0.1 e-2dj6wjkowjajcbo.stats.esomniture.com
127.0.0.1 e-2dj6wjkyandpogq.stats.esomniture.com
127.0.0.1 e-2dj6wjkycpdzckp.stats.esomniture.com
127.0.0.1 e-2dj6wjkyqmdzcgo.stats.esomniture.com
127.0.0.1 e-2dj6wjkysndzigp.stats.esomniture.com
127.0.0.1 e-2dj6wjl4qhd5kdo.stats.esomniture.com
127.0.0.1 e-2dj6wjlichdjoep.stats.esomniture.com
127.0.0.1 e-2dj6wjliehcjglp.stats.esomniture.com
127.0.0.1 e-2dj6wjlignajgaq.stats.esomniture.com
127.0.0.1 e-2dj6wjloagc5oco.stats.esomniture.com
127.0.0.1 e-2dj6wjlougazmao.stats.esomniture.com
127.0.0.1 e-2dj6wjlyamdpogo.stats.esomniture.com
127.0.0.1 e-2dj6wjlyckcpelq.stats.esomniture.com
127.0.0.1 e-2dj6wjlyeodjkcq.stats.esomniture.com
127.0.0.1 e-2dj6wjlygkd5ecq.stats.esomniture.com
127.0.0.1 e-2dj6wjmiekc5olo.stats.esomniture.com
127.0.0.1 e-2dj6wjmyehd5mfo.stats.esomniture.com
127.0.0.1 e-2dj6wjmyooczoeo.stats.esomniture.com
127.0.0.1 e-2dj6wjny-1idzkh.stats.esomniture.com
127.0.0.1 e-2dj6wjnyagcpkko.stats.esomniture.com
127.0.0.1 e-2dj6wjnyeocpcdo.stats.esomniture.com
127.0.0.1 e-2dj6wjnygidjskq.stats.esomniture.com
127.0.0.1 e-2dj6wjnyqkajabp.stats.esomniture.com
127.0.0.1 e-n.y-1shz2prbmdj6wvny-1sez2pra2dj6wjmyepdzadpwudj6x9ny-1seq-2-2.stats.esomniture.com
127.0.0.1 e-ny.a-1shz2prbmdj6wvny-1sez2pra2dj6wjny-1jcpgbowsdj6x9ny-1seq-2-2.stats.esomniture.com
127.0.0.1 e.crashlytics.com
127.0.0.1 easy-web-stats.com
127.0.0.1 ecestats.theglobeandmail.com
127.0.0.1 economisttestcollect.insightfirst.com
127.0.0.1 eds.ca.matchbox.maruhub.com
127.0.0.1 email.positionly.com
127.0.0.1 emea.rel.msn.com
127.0.0.1 engine.cmmeglobal.com
127.0.0.1 enoratraffic.com
127.0.0.1 environmentalgraffiti.uk.intellitxt.com
127.0.0.1 es.optimost.com
127.0.0.1 eu-track.inside-graph.com
127.0.0.1 eus.rubiconproject.com
127.0.0.1 exch.quantserve.com
127.0.0.1 extremereach.com
127.0.0.1 eztrck.com
127.0.0.1 fastcounter.com
127.0.0.1 fastcounter.linkexchange.net
127.0.0.1 fastcounter.linkexchange.nl
127.0.0.1 fastlane.rubiconproject.com
127.0.0.1 fastwebcounter.com
127.0.0.1 fdbdo.com
127.0.0.1 fi.sitestat.com
127.0.0.1 firebaselogging.googleapis.com
127.0.0.1 fl01.ct2.comclick.com
127.0.0.1 flixprice.com
127.0.0.1 flury-ycpi.gycpi.b.yahoodns.net
127.0.0.1 flycast.com
127.0.0.1 formalyzer.com
127.0.0.1 foxcounter.com
127.0.0.1 free.xxxcounter.com
127.0.0.1 freeinvisiblecounters.com
127.0.0.1 freerapid.fr
127.0.0.1 freestats.com
127.0.0.1 freewebcounter.com
127.0.0.1 fs10.fusestats.com
127.0.0.1 ft2.autonomycloud.com
127.0.0.1 gameanalysis.appcpi.net
127.0.0.1 gapl.hit.gemius.pl
127.0.0.1 gator.com
127.0.0.1 gbr-7stars-tracking.adalyser.com
127.0.0.1 gbr-carat-tracking.adalyser.com
127.0.0.1 gbr-mbww-tracking.adalyser.com
127.0.0.1 gbr-smv-tracking.adalyser.com
127.0.0.1 gbr-tbh-tracking.adalyser.com
127.0.0.1 gcounter.hosting4u.net
127.0.0.1 geocounter.net
127.0.0.1 gj.mmstat.com
127.0.0.1 goldstats.com
127.0.0.1 googfle.com
127.0.0.1 googletagservices.com
127.0.0.1 gostats.com
127.0.0.1 grafix.xxxcounter.com
127.0.0.1 gscounters.us1.gigya.com
127.0.0.1 gslbeacon.lijit.com
127.0.0.1 gtcc1.acecounter.com
127.0.0.1 hbopenbid.pubmatic.com
127.0.0.1 hc2.humanclick.com
127.0.0.1 highscanprotect.com
127.0.0.1 hit-counter.udub.com
127.0.0.1 hit.clickaider.com
127.0.0.1 hit10.hotlog.ru
127.0.0.1 hit2.hotlog.ru
127.0.0.1 hit37.chark.dk
127.0.0.1 hit37.chart.dk
127.0.0.1 hit39.chart.dk
127.0.0.1 hit5.hotlog.ru
127.0.0.1 hit8.hotlog.ru
127.0.0.1 hits.guardian.co.uk
127.0.0.1 hits.webstat.com
127.0.0.1 hst.tradedoubler.com
127.0.0.1 htm.freelogs.com
127.0.0.1 i.kissmetrics.com	# http://www.wired.com/epicenter/2011/07/undeletable-cookie/
127.0.0.1 ic.tynt.com
127.0.0.1 iccee.com
127.0.0.1 id.sputniknews.com
127.0.0.1 idm.hit.gemius.pl
127.0.0.1 ieplugin.com
127.0.0.1 iesnare.co.uk
127.0.0.1 iesnare.com		# See http://www.codingthewheel.com/archives/online-gambling-privacy-iesnare
127.0.0.1 ilead.itrack.it
127.0.0.1 images-aud.freshmeat.net
127.0.0.1 images-aud.slashdot.org
127.0.0.1 images-aud.sourceforge.net
127.0.0.1 images.dailydiscounts.com	# "spam bugs"
127.0.0.1 images1.paycounter.com
127.0.0.1 imp.clickability.com
127.0.0.1 impacts.alliancehub.com # "spam bugs"
127.0.0.1 impch.tradedoubler.com
127.0.0.1 impde.tradedoubler.com
127.0.0.1 impdk.tradedoubler.com
127.0.0.1 impes.tradedoubler.com
127.0.0.1 impfr.tradedoubler.com
127.0.0.1 impgb.tradedoubler.com
127.0.0.1 impie.tradedoubler.com
127.0.0.1 impit.tradedouble.com
127.0.0.1 impit.tradedoubler.com
127.0.0.1 impnl.tradedoubler.com
127.0.0.1 impno.tradedoubler.com
127.0.0.1 imprammp.taboola.com
127.0.0.1 impse.tradedoubler.com
127.0.0.1 in.paycounter.com
127.0.0.1 in.treasuredata.com
127.0.0.1 in.webcounter.cc
127.0.0.1 insightfirst.com
127.0.0.1 insightxe.looksmart.com
127.0.0.1 int.sitestat.com
127.0.0.1 intljs.rmtag.com
127.0.0.1 iovation.co.uk
127.0.0.1 iovation.com
127.0.0.1 iplogger.org
127.0.0.1 iprocollect.realmedia.com
127.0.0.1 istat.biz
127.0.0.1 izarc.fr
127.0.0.1 jdownloader.fr
127.0.0.1 jgoyk.cjt1.net
127.0.0.1 jkearns.freestats.com
127.0.0.1 js.cybermonitor.com
127.0.0.1 js.hs-analytics.net
127.0.0.1 js.revsci.net
127.0.0.1 justtrck.com
127.0.0.1 k.clarity.ms
127.0.0.1 kissmetrics.com
127.0.0.1 kqzyfj.com
127.0.0.1 kt4.kliptracker.com
127.0.0.1 lcprd1.samsungcloudsolution.net
127.0.0.1 lcprd2.samsungcloudsolution.net
127.0.0.1 leadpub.com
127.0.0.1 lin31.metriweb.be
127.0.0.1 linkcounter.com
127.0.0.1 linkcounter.pornosite.com
127.0.0.1 linktrack.bravenet.com
127.0.0.1 listen.audiohook.com
127.0.0.1 loadus.exelator.com
127.0.0.1 loc1.hitsprocessor.com
127.0.0.1 lockerdome.com
127.0.0.1 log.btopenworld.com
127.0.0.1 log999.goo.ne.jp
127.0.0.1 loga.xiti.com
127.0.0.1 logc1.xiti.com
127.0.0.1 logc146.xiti.com
127.0.0.1 logc22.xiti.com
127.0.0.1 logc31.xiti.com
127.0.0.1 logi6.xiti.com
127.0.0.1 logi7.xiti.com
127.0.0.1 logi8.xiti.com
127.0.0.1 logp3.xiti.com
127.0.0.1 logs.eresmas.com
127.0.0.1 logs.eresmas.net
127.0.0.1 logv14.xiti.com
127.0.0.1 logv17.xiti.com
127.0.0.1 logv18.xiti.com
127.0.0.1 logv21.xiti.com
127.0.0.1 logv25.xiti.com
127.0.0.1 logv27.xiti.com
127.0.0.1 logv29.xiti.com
127.0.0.1 logv32.xiti.com
127.0.0.1 logv4.xiti.com
127.0.0.1 lpcloudsvr302.com
127.0.0.1 lycoscollect.realmedia.com
127.0.0.1 m1.nedstatbasic.net
127.0.0.1 m1.webstats4u.com
127.0.0.1 mailcheckisp.biz	# "spam bugs"
127.0.0.1 mailfoogae.appspot.com	# Streak email tracker
127.0.0.1 mailtrack.me
127.0.0.1 marketaff.com
127.0.0.1 mature.xxxcounter.com
127.0.0.1 mbox5.offermatica.com
127.0.0.1 media.superstats.com
127.0.0.1 mediatrack.revenue.net
127.0.0.1 metric.infoworld.com
127.0.0.1 metric.nationalgeographic.com
127.0.0.1 metric.nwsource.com
127.0.0.1 metric.olivegarden.com
127.0.0.1 metric.starz.com
127.0.0.1 metrics.accuweather.com
127.0.0.1 metrics.al.com
127.0.0.1 metrics.att.com
127.0.0.1 metrics.brightcove.com
127.0.0.1 metrics.cbc.ca
127.0.0.1 metrics.cleveland.com
127.0.0.1 metrics.cnn.com
127.0.0.1 metrics.csmonitor.com
127.0.0.1 metrics.ctv.ca
127.0.0.1 metrics.dallasnews.com
127.0.0.1 metrics.elle.com
127.0.0.1 metrics.experts-exchange.com
127.0.0.1 metrics.gap.com
127.0.0.1 metrics.health.com
127.0.0.1 metrics.hrblock.com
127.0.0.1 metrics.ireport.com
127.0.0.1 metrics.kgw.com
127.0.0.1 metrics.ktvb.com
127.0.0.1 metrics.landolakes.com
127.0.0.1 metrics.lhj.com
127.0.0.1 metrics.mlive.com
127.0.0.1 metrics.mysanantonio.com
127.0.0.1 metrics.nba.com
127.0.0.1 metrics.nextgov.com
127.0.0.1 metrics.nfl.com
127.0.0.1 metrics.npr.org
127.0.0.1 metrics.oclc.org
127.0.0.1 metrics.oregonlive.com
127.0.0.1 metrics.philly.com
127.0.0.1 metrics.post-gazette.com
127.0.0.1 metrics.rottentomatoes.com
127.0.0.1 metrics.sephora.com
127.0.0.1 metrics.sun.com
127.0.0.1 metrics.theatlantic.com
127.0.0.1 metrics.thedailybeast.com
127.0.0.1 metrics.thefa.com
127.0.0.1 metrics.thefrisky.com
127.0.0.1 metrics.thenation.com
127.0.0.1 metrics.theweathernetwork.com
127.0.0.1 metrics.tmz.com
127.0.0.1 metrics.toyota.com
127.0.0.1 metrics.tulsaworld.com
127.0.0.1 metrics.washingtonpost.com
127.0.0.1 metrics.whitepages.com
127.0.0.1 metrics.womansday.com
127.0.0.1 metrics.yellowpages.com
127.0.0.1 metrics.yousendit.com
127.0.0.1 mktg.actonsoftware.com
127.0.0.1 mmstat.com
127.0.0.1 mng1.clickalyzer.com
127.0.0.1 mobile.webvisor.com
127.0.0.1 mononoteapp.firebaseio.com
127.0.0.1 monster.gostats.com
127.0.0.1 msn1.com
127.0.0.1 msnm.com
127.0.0.1 mt122.mtree.com
127.0.0.1 mtcount.channeladvisor.com
127.0.0.1 mtrcs.popcap.com
127.0.0.1 murdoog.com
127.0.0.1 mvtracker.com
127.0.0.1 mybbc-analytics.files.bbci.co.uk
127.0.0.1 nedstat.s0.nl
127.0.0.1 net-radar.com
127.0.0.1 nethit-free.nl
127.0.0.1 network.leadpub.com
127.0.0.1 neweggstats.com
127.0.0.1 nextgenstats.com
127.0.0.1 nht-2.extreme-dm.com
127.0.0.1 nl.nedstatbasic.net
127.0.0.1 noticias.life
127.0.0.1 notify.bugsnag.com
127.0.0.1 notify1.brucelead.com
127.0.0.1 o.addthis.com
127.0.0.1 objects.tremormedia.com
127.0.0.1 okcounter.com
127.0.0.1 omniture.theglobeandmail.com
127.0.0.1 omtrdc.net
127.0.0.1 one.123counters.com
127.0.0.1 open.oneplus.net
127.0.0.1 other.xxxcounter.com
127.0.0.1 ourtoolbar.com
127.0.0.1 p.addthis.com
127.0.0.1 p.bm23.com
127.0.0.1 p.reuters.com
127.0.0.1 pa-cd.com
127.0.0.1 passpport.com
127.0.0.1 paycounter.com
127.0.0.1 pei-ads.thesmokingjacket.com
127.0.0.1 pf.tradedoubler.com
127.0.0.1 photobox-tracking.adalyser.com
127.0.0.1 pings.blip.tv
127.0.0.1 pituitosus.com
127.0.0.1 pix02.revsci.net
127.0.0.1 pix03.revsci.net
127.0.0.1 pix04.revsci.net
127.0.0.1 pixel-geo.prfct.co
127.0.0.1 pixel.advertising.com
127.0.0.1 pixel.bilinmedia.net
127.0.0.1 pixel.invitemedia.com
127.0.0.1 pixel.staticworld.net
127.0.0.1 pixel.tapad.com
127.0.0.1 pixel.wp.com
127.0.0.1 pn2.adserver.yahoo.com
127.0.0.1 pointclicktrack.com
127.0.0.1 post.update.fbsbx.com
127.0.0.1 postclick.adcentriconline.com
127.0.0.1 postmedia.us.janrainsso.com
127.0.0.1 precisioncounter.com
127.0.0.1 printmail.biz
127.0.0.1 privacy-policy.truste.com
127.0.0.1 prof.estat.com
127.0.0.1 propeller-tracking.com
127.0.0.1 quantcast584928381.s.moatpixel.com
127.0.0.1 quantserve.com #: Ad Tracking, JavaScript, etc.
127.0.0.1 r1-t.trackedlink.net
127.0.0.1 redshell.io
127.0.0.1 rightmedia.net
127.0.0.1 rightstats.com
127.0.0.1 rmcentre.bigfilmproduction.com
127.0.0.1 rr1.xxxcounter.com
127.0.0.1 rr2.xxxcounter.com
127.0.0.1 rts.pgmediaserve.com
127.0.0.1 rts.phn.doublepimp.com
127.0.0.1 s-39.predictvideo.com
127.0.0.1 s.bl-1.com
127.0.0.1 s.clickability.com
127.0.0.1 s.go-mpulse.net
127.0.0.1 s.update.fbsbx.com 
127.0.0.1 s1-tracking.adalyser.com
127.0.0.1 s1.shinystat.it
127.0.0.1 s10.histats.com
127.0.0.1 s2.statcounter.com
127.0.0.1 s290.mxcdn.net
127.0.0.1 s3.hit.stat.pl
127.0.0.1 s4.histats.com
127.0.0.1 s4.shinystat.com
127.0.0.1 sact.atdmt.com
127.0.0.1 sc-analytics.appspot.com
127.0.0.1 sclk.org
127.0.0.1 scorecardresearch.com
127.0.0.1 scribe.twitter.com
127.0.0.1 scrooge.click10.com
127.0.0.1 scrooge.nbc11.com
127.0.0.1 scrooge.nbc4.com
127.0.0.1 scrooge.nbcsandiego.com
127.0.0.1 scrooge.newsnet5.com
127.0.0.1 scrooge.thedenverchannel.com
127.0.0.1 scrooge.theindychannel.com
127.0.0.1 scrooge.wesh.com
127.0.0.1 scrooge.wnbc.com
127.0.0.1 sdc.rbistats.com
127.0.0.1 sdkapi.netmera.com
127.0.0.1 se.sitestat.com
127.0.0.1 searchadv.com
127.0.0.1 secure-dcr.imrworldwide.com
127.0.0.1 secure-drm.imrworldwide.com
127.0.0.1 secure-gg.imrworldwide.com
127.0.0.1 secure-it.imrworldwide.com
127.0.0.1 secure-us.imrworldwide.com
127.0.0.1 secure.quantserve.com
127.0.0.1 server1.opentracker.net
127.0.0.1 server10.opentracker.net
127.0.0.1 server11.opentracker.net
127.0.0.1 server3.web-stat.com
127.0.0.1 service.bfast.com
127.0.0.1 service.maxymiser.net
127.0.0.1 sessions.bugsnag.com
127.0.0.1 sexcounter.com
127.0.0.1 seznam.hit.gemius.pl
127.0.0.1 showads.pubmatic.com
127.0.0.1 showcount.honest.com
127.0.0.1 sideshow.directtrack.com
127.0.0.1 siteimproveanalytics.com
127.0.0.1 sitestat.com
127.0.0.1 sitestats.tiscali.co.uk
127.0.0.1 smartstats.com
127.0.0.1 smetrics.att.com
127.0.0.1 smetrics.tesco.com
127.0.0.1 smetrics.washingtonpost.com
127.0.0.1 softcore.xxxcounter.com
127.0.0.1 softonic.it
127.0.0.1 solamor.com
127.0.0.1 songbird.fr
127.0.0.1 spinbox.versiontracker.com
127.0.0.1 spklds.com
127.0.0.1 ss.tiscali.it
127.0.0.1 st.sageanalyst.net
127.0.0.1 st1.hit.gemius.pl
127.0.0.1 stags.peer39.net
127.0.0.1 startup.mobile.webvisor.com
127.0.0.1 startup.mobile.yandex.net
127.0.0.1 stat.4u.pl
127.0.0.1 stat.alibaba.com
127.0.0.1 stat.netmonitor.fi
127.0.0.1 stat.onestat.com
127.0.0.1 stat.webmedia.pl
127.0.0.1 stat.www.fi
127.0.0.1 stat.yellowtracker.com
127.0.0.1 stat1.z-stat.com
127.0.0.1 stat3.cybermonitor.com
127.0.0.1 statcounter.com
127.0.0.1 static.audienceinsights.net
127.0.0.1 static.kibboko.com
127.0.0.1 static.smni.com		# Santa Monica - popunders
127.0.0.1 static.trackedweb.net
127.0.0.1 statistics.elsevier.nl
127.0.0.1 statistics.reedbusiness.nl
127.0.0.1 statistics.theonion.com
127.0.0.1 statistik-gallup.net
127.0.0.1 stats.24ways.org
127.0.0.1 stats.absol.co.za
127.0.0.1 stats.adlice.com
127.0.0.1 stats.adotube.com
127.0.0.1 stats.adultswim.com
127.0.0.1 stats.airfarewatchdog.com
127.0.0.1 stats.allliquid.com
127.0.0.1 stats.arrowos.net
127.0.0.1 stats.askmen.com
127.0.0.1 stats.bbc.co.uk
127.0.0.1 stats.becu.org
127.0.0.1 stats.big-boards.com
127.0.0.1 stats.blogoscoop.net
127.0.0.1 stats.buysellads.com
127.0.0.1 stats.cafepress.com
127.0.0.1 stats.canalblog.com
127.0.0.1 stats.cartoonnetwork.com
127.0.0.1 stats.clickability.com
127.0.0.1 stats.concierge.com
127.0.0.1 stats.datahjaelp.net
127.0.0.1 stats.dziennik.pl
127.0.0.1 stats.economist.com
127.0.0.1 stats.epicurious.com
127.0.0.1 stats.fairmont.com
127.0.0.1 stats.fastcompany.com
127.0.0.1 stats.foxcounter.com
127.0.0.1 stats.gamestop.com
127.0.0.1 stats.globesports.com
127.0.0.1 stats.groupninetyfour.com
127.0.0.1 stats.ign.com
127.0.0.1 stats.ilsemedia.nl
127.0.0.1 stats.independent.co.uk
127.0.0.1 stats.investors.com
127.0.0.1 stats.iwebtrack.com
127.0.0.1 stats.jippii.com
127.0.0.1 stats.ladotstats.nl
127.0.0.1 stats.ozguryazilim.com.tr
127.0.0.1 stats.paycounter.com
127.0.0.1 stats.popscreen.com
127.0.0.1 stats.resellerratings.com
127.0.0.1 stats.revenue.net
127.0.0.1 stats.superstats.com
127.0.0.1 stats.telegraph.co.uk
127.0.0.1 stats.thoughtcatalog.com
127.0.0.1 stats.townnews.com
127.0.0.1 stats.ultimate-webservices.com
127.0.0.1 stats.unionleader.com
127.0.0.1 stats.unipi.it
127.0.0.1 stats.vodpod.com
127.0.0.1 stats.wordpress.com
127.0.0.1 stats.wp.com
127.0.0.1 stats.www.ibm.com
127.0.0.1 stats1.clicktracks.com
127.0.0.1 stats1.corusradio.com
127.0.0.1 stats2.clicktracks.com
127.0.0.1 stats2.gourmet.com
127.0.0.1 stats2.newyorker.com
127.0.0.1 stats2.rte.ie
127.0.0.1 stats2.vanityfair.com
127.0.0.1 stats4all.com
127.0.0.1 stats5.lightningcast.com
127.0.0.1 stats6.lightningcast.net
127.0.0.1 statse.webtrendslive.com	# Fortune.com among others
127.0.0.1 stl.p.a1.traceworks.com
127.0.0.1 straighttangerine.cz.cc
127.0.0.1 stratus.campaign-image.com.cn
127.0.0.1 sugoicounter.com
127.0.0.1 superstats.com
127.0.0.1 sync.bfmio.com
127.0.0.1 sync.clickonometrics.pl
127.0.0.1 systweak.com
127.0.0.1 t.senaldos.com
127.0.0.1 t.senaluno.com
127.0.0.1 t.signaletre.com
127.0.0.1 t.signauxdeux.com # Another email opentracker from hubspot
127.0.0.1 t.update.fbsbx.com
127.0.0.1 t.yesware.com
127.0.0.1 tag.crsspxl.com
127.0.0.1 tags.bkrtx.com
127.0.0.1 targetnet.com
127.0.0.1 tates.freestats.com
127.0.0.1 tcookie.usatoday.com
127.0.0.1 tcr.tynt.com		# See http://daringfireball.net/2010/05/tynt_copy_paste_jerks
127.0.0.1 telecharger-openoffice.fr
127.0.0.1 tgpcounter.freethumbnailgalleries.com
127.0.0.1 the-counter.net
127.0.0.1 the.sextracker.com
127.0.0.1 themecounter.com
127.0.0.1 tipsurf.com
127.0.0.1 toolbarpartner.com
127.0.0.1 tools.spylog.ru
127.0.0.1 top.mail.ru
127.0.0.1 topstats.com
127.0.0.1 tour.SweetDiscreet.com
127.0.0.1 tour.xxxblackbook.com
127.0.0.1 tr.adinterax.com
127.0.0.1 track.adform.net
127.0.0.1 track.adrevolver.com
127.0.0.1 track.bannerbridge.net
127.0.0.1 track.brucelead.com
127.0.0.1 track.clearsender.com
127.0.0.1 track.construclique.com
127.0.0.1 track.did-it.com
127.0.0.1 track.dotsly.com
127.0.0.1 track.effiliation.com
127.0.0.1 track.eg-innovations.net
127.0.0.1 track.enviodemails.com
127.0.0.1 track.gaug.es
127.0.0.1 track.homestead.com
127.0.0.1 track.lfstmedia.com
127.0.0.1 track.mdirector.com
127.0.0.1 track.mdrctr.com
127.0.0.1 track.msadcenter.afgz.com
127.0.0.1 track.msadcenter.ajfy.com
127.0.0.1 track.msadcenter.ceio.com
127.0.0.1 track.msadcenter.cxtv.com
127.0.0.1 track.msadcenter.dgt.com
127.0.0.1 track.msadcenter.dxr.com
127.0.0.1 track.msadcenter.emee.com
127.0.0.1 track.msadcenter.eqq.com
127.0.0.1 track.msadcenter.hih.com
127.0.0.1 track.msadcenter.hlh.com
127.0.0.1 track.msadcenter.hnsl.com
127.0.0.1 track.msadcenter.igzr.com
127.0.0.1 track.msadcenter.iuf.com
127.0.0.1 track.msadcenter.iuh.com
127.0.0.1 track.msadcenter.jzz.com
127.0.0.1 track.msadcenter.kfgy.com
127.0.0.1 track.msadcenter.kfz.com
127.0.0.1 track.msadcenter.kkal.com
127.0.0.1 track.msadcenter.kpuo.com
127.0.0.1 track.msadcenter.krt.com
127.0.0.1 track.msadcenter.llu.com
127.0.0.1 track.msadcenter.ltp.com
127.0.0.1 track.msadcenter.lyv.com
127.0.0.1 track.msadcenter.lzwp.com
127.0.0.1 track.msadcenter.mjze.com
127.0.0.1 track.msadcenter.mur.com
127.0.0.1 track.msadcenter.nho.com
127.0.0.1 track.msadcenter.nyfg.com
127.0.0.1 track.msadcenter.oah.com
127.0.0.1 track.msadcenter.pcp.com
127.0.0.1 track.msadcenter.pszn.com
127.0.0.1 track.msadcenter.pwpn.com
127.0.0.1 track.msadcenter.qpz.com
127.0.0.1 track.msadcenter.qsvv.com
127.0.0.1 track.msadcenter.qymv.com
127.0.0.1 track.msadcenter.rfjq.com
127.0.0.1 track.msadcenter.sax.com
127.0.0.1 track.msadcenter.sgq.com
127.0.0.1 track.msadcenter.shy.com
127.0.0.1 track.msadcenter.szc.com
127.0.0.1 track.msadcenter.tnuw.com
127.0.0.1 track.msadcenter.toj.com
127.0.0.1 track.msadcenter.tux.com
127.0.0.1 track.msadcenter.usx.com
127.0.0.1 track.msadcenter.vbug.com
127.0.0.1 track.msadcenter.vcf.com
127.0.0.1 track.msadcenter.vrhe.com
127.0.0.1 track.msadcenter.wdm.com
127.0.0.1 track.msadcenter.wfm.com
127.0.0.1 track.msadcenter.wmd.com
127.0.0.1 track.msadcenter.wup.com
127.0.0.1 track.msadcenter.xda.com
127.0.0.1 track.msadcenter.xpp.com
127.0.0.1 track.msadcenter.xxx.com
127.0.0.1 track.msadcenter.xzwy.com
127.0.0.1 track.msadcenter.ybi.com
127.0.0.1 track.msadcenter.ytbp.com
127.0.0.1 track.msadcenter.zepw.com
127.0.0.1 track.msadcenter.zhv.com
127.0.0.1 track.msadcenter.zlx.com
127.0.0.1 track.msadcenter.zmmr.com
127.0.0.1 track.msadcenter.zul.com
127.0.0.1 track.msadcenter.zvjw.com
127.0.0.1 track.msadcenter.zzv.com
127.0.0.1 track.nifty.com
127.0.0.1 track.omg2.com
127.0.0.1 track.pplnk.com
127.0.0.1 track.publeadmedia.com
127.0.0.1 track.rediff.com
127.0.0.1 track.searchignite.com
127.0.0.1 track.vivid.com
127.0.0.1 track.webgains.com
127.0.0.1 track.xapads.com
127.0.0.1 track.zipalerts.com
127.0.0.1 track.ziprecruiter.com
127.0.0.1 track.zulumarketing.com
127.0.0.1 track12.offersbymail.com
127.0.0.1 tracker.bonnint.net
127.0.0.1 tracker.bt.uol.com.br
127.0.0.1 tracker.cl1.fidelizador.com
127.0.0.1 tracker.clicktrade.com
127.0.0.1 tracker.consumerpackage.net
127.0.0.1 tracker.coopt.com
127.0.0.1 tracker.hitmatic.com
127.0.0.1 tracker.mattel.com
127.0.0.1 tracker.netklix.com
127.0.0.1 tracker.remp.impresa.pt
127.0.0.1 tracker.tradedoubler.com
127.0.0.1 tracker1.leadiya.com
127.0.0.1 tracking-lealcobrancaspremium.p-email.net
127.0.0.1 tracking.10e20.com
127.0.0.1 tracking.3com.com
127.0.0.1 tracking.adalyser.com
127.0.0.1 tracking.adgoon.it
127.0.0.1 tracking.adjug.com
127.0.0.1 tracking.arxibs01.com
127.0.0.1 tracking.drsfostersmith.com
127.0.0.1 tracking.engagedigitalmedia.com
127.0.0.1 tracking.fanbridge.com
127.0.0.1 tracking.foxnews.com
127.0.0.1 tracking.gajmp.com
127.0.0.1 tracking.ibexnetwork.com
127.0.0.1 tracking.ilinkmd.com
127.0.0.1 tracking.imagewebdesign.fr
127.0.0.1 tracking.mailtracker.in
127.0.0.1 tracking.motleyfool.com
127.0.0.1 tracking.murdoog.com
127.0.0.1 tracking.myunidays.com
127.0.0.1 tracking.nesox.com
127.0.0.1 tracking.nmemails.com
127.0.0.1 tracking.oerug.com
127.0.0.1 tracking.pennystockpicks.net
127.0.0.1 tracking.percentmobile.com
127.0.0.1 tracking.publicidees.com
127.0.0.1 tracking.quisma.com
127.0.0.1 tracking.searchmarketing.com
127.0.0.1 tracking.stampready.net
127.0.0.1 tracking.summitmedia.co.uk
127.0.0.1 tracking.trafficjunky.net
127.0.0.1 tracking.trutv.com
127.0.0.1 tracking.vindicosuite.com
127.0.0.1 tracking.yohoads.com
127.0.0.1 trackit.vicotech.com
127.0.0.1 tracksurf.daooda.com
127.0.0.1 tradedoubler.com
127.0.0.1 tradedoubler.sonvideopro.com
127.0.0.1 traffic-stats.streamsolutions.co.uk
127.0.0.1 traffic.spot.im
127.0.0.1 trafficopen.com
127.0.0.1 trax.gamespot.com
127.0.0.1 trc.taboolasyndication.com
127.0.0.1 trcko.com
127.0.0.1 treasuredata.com
127.0.0.1 trk.cachemetracking.com
127.0.0.1 trk.kissmetrics.com
127.0.0.1 trk.securesmrt-dt.com
127.0.0.1 trk.tidaltv.com
127.0.0.1 true-counter.com
127.0.0.1 truehits1.gits.net.th
127.0.0.1 tynt.com
127.0.0.1 u.startup.mobile.webvisor.com
127.0.0.1 u1817.16.spylog.com
127.0.0.1 u3102.47.spylog.com
127.0.0.1 u3305.71.spylog.com
127.0.0.1 u3608.20.spylog.com
127.0.0.1 u4056.56.spylog.com
127.0.0.1 u432.77.spylog.com
127.0.0.1 u4396.79.spylog.com
127.0.0.1 u4443.84.spylog.com
127.0.0.1 u4556.11.spylog.com
127.0.0.1 u5234.87.spylog.com
127.0.0.1 u5234.98.spylog.com
127.0.0.1 u5687.48.spylog.com
127.0.0.1 u574.07.spylog.com
127.0.0.1 u604.41.spylog.com
127.0.0.1 u6762.46.spylog.com
127.0.0.1 u6905.71.spylog.com
127.0.0.1 u7748.16.spylog.com
127.0.0.1 u810.15.spylog.com
127.0.0.1 u920.31.spylog.com
127.0.0.1 u977.40.spylog.com
127.0.0.1 udc.msn.com
127.0.0.1 uip.semasio.net
127.0.0.1 uk.cqcounter.com
127.0.0.1 uk.sitestat.com
127.0.0.1 ultimatecounter.com
127.0.0.1 us.2.cqcounter.com
127.0.0.1 us.cqcounter.com
127.0.0.1 usa.nedstat.net
127.0.0.1 users.maxcluster.net
127.0.0.1 v1.nedstatbasic.net
127.0.0.1 v8.analytics.pinsightmedia.com
127.0.0.1 v8engine.pinsightmedia.com
127.0.0.1 v8push.pinsightmedia.com
127.0.0.1 valueclick.com
127.0.0.1 valueclick.net
127.0.0.1 velocecdn.com
127.0.0.1 video-stats.video.google.com
127.0.0.1 vidstat.taboola.com
127.0.0.1 vidstatb.taboola.com
127.0.0.1 vip.clickzs.com
127.0.0.1 vis.sexlist.com
127.0.0.1 visit.theglobeandmail.com # Visits to theglobeandmail.com
127.0.0.1 vitals.vercel-analytics.com
127.0.0.1 voken.eyereturn.com
127.0.0.1 vs.dmtracker.com
127.0.0.1 vsii.spinbox.net
127.0.0.1 w.nativery.com
127.0.0.1 w1.tcr112.tynt.com
127.0.0.1 warlog.info
127.0.0.1 wau.tynt.com
127.0.0.1 web4.realtracker.com
127.0.0.1 webbug.seatreport.com	# web bugs
127.0.0.1 webcounter.com
127.0.0.1 webcounter.goweb.de
127.0.0.1 webcounter.together.net
127.0.0.1 webtrends.thisis.co.uk
127.0.0.1 whentheyopened.com
127.0.0.1 wt.bankmillennium.pl
127.0.0.1 wtnj.worldnow.com
127.0.0.1 www-stats.unipi.it
127.0.0.1 www.0stats.com
127.0.0.1 www.123count.com
127.0.0.1 www.123counter.superstats.com
127.0.0.1 www.123stat.com
127.0.0.1 www.3dstats.com
127.0.0.1 www.adalyser.com
127.0.0.1 www.addfreecounter.com
127.0.0.1 www.addfreestats.com
127.0.0.1 www.addtoany.com
127.0.0.1 www.ademails.com
127.0.0.1 www.affiliatesuccess.net
127.0.0.1 www.bar.ry2002.02-ry014.snpr.hotmx.hair.zaam.net # In spam
127.0.0.1 www.belstat.nl
127.0.0.1 www.betcounter.com
127.0.0.1 www.bluestreak.com
127.0.0.1 www.buglife.com
127.0.0.1 www.c.thecounter.de
127.0.0.1 www.c1.thecounter.de
127.0.0.1 www.c2.thecounter.de
127.0.0.1 www.cig-arrete.com
127.0.0.1 www.clickclick.com
127.0.0.1 www.clickspring.net	#used by a spyware product called PurityScan
127.0.0.1 www.clixgalore.com
127.0.0.1 www.connectionlead.com
127.0.0.1 www.counter.bloke.com
127.0.0.1 www.counter.superstats.com
127.0.0.1 www.counter1.sextracker.be
127.0.0.1 www.counter10.sextracker.be
127.0.0.1 www.counter11.sextracker.be
127.0.0.1 www.counter12.sextracker.be
127.0.0.1 www.counter13.sextracker.be
127.0.0.1 www.counter14.sextracker.be
127.0.0.1 www.counter15.sextracker.be
127.0.0.1 www.counter16.sextracker.be
127.0.0.1 www.counter2.sextracker.be
127.0.0.1 www.counter3.sextracker.be
127.0.0.1 www.counter4.sextracker.be
127.0.0.1 www.counter4all.com
127.0.0.1 www.counter4all.de
127.0.0.1 www.counter5.sextracker.be
127.0.0.1 www.counter6.sextracker.be
127.0.0.1 www.counter7.sextracker.be
127.0.0.1 www.counter8.sextracker.be
127.0.0.1 www.counter9.sextracker.be
127.0.0.1 www.counterguide.com
127.0.0.1 www.cw.nu
127.0.0.1 www.dpbolvw.net
127.0.0.1 www.dwclick.com
127.0.0.1 www.easycounter.com
127.0.0.1 www.fastcounter.linkexchange.nl
127.0.0.1 www.formalyzer.com
127.0.0.1 www.foxcounter.com
127.0.0.1 www.freestats.com
127.0.0.1 www.fxcounters.com
127.0.0.1 www.gator.com
127.0.0.1 www.hitstats.co.uk
127.0.0.1 www.iccee.com
127.0.0.1 www.iesnare.co.uk
127.0.0.1 www.iesnare.com	# See http://www.codingthewheel.com/archives/online-gambling-privacy-iesnare
127.0.0.1 www.iovation.co.uk
127.0.0.1 www.iovation.com
127.0.0.1 www.jellycounter.com
127.0.0.1 www.kqzyfj.com
127.0.0.1 www.lansrv050.com
127.0.0.1 www.leadpub.com
127.0.0.1 www.linkcounter.com
127.0.0.1 www.megacounter.de
127.0.0.1 www.metareward.com		# web bugs in spam
127.0.0.1 www.mnbasd77.com
127.0.0.1 www.nedstat.com
127.0.0.1 www.nextgenstats.com
127.0.0.1 www.ntsearch.com
127.0.0.1 www.onestat.com
127.0.0.1 www.originalicons.com	# installs IE extension
127.0.0.1 www.paycounter.com
127.0.0.1 www.pointclicktrack.com
127.0.0.1 www.precisioncounter.com
127.0.0.1 www.printmail.biz
127.0.0.1 www.quantserve.com #: Ad Tracking, JavaScript, etc.
127.0.0.1 www.rightmedia.net
127.0.0.1 www.rightstats.com
127.0.0.1 www.searchadv.com
127.0.0.1 www.shockcounter.com
127.0.0.1 www.simplecounter.net
127.0.0.1 www.specificclick.com
127.0.0.1 www.specificpop.com
127.0.0.1 www.spklds.com
127.0.0.1 www.statcount.com
127.0.0.1 www.statcounter.com
127.0.0.1 www.statsession.com
127.0.0.1 www.stattrax.com
127.0.0.1 www.stiffnetwork.com
127.0.0.1 www.the-counter.net
127.0.0.1 www.toolbarcounter.com
127.0.0.1 www.tradedoubler.com
127.0.0.1 www.tradingtactics.win
127.0.0.1 www.trafficmagnet.net # web bugs in spam
127.0.0.1 www.trafic.ro
127.0.0.1 www.trendcounter.com
127.0.0.1 www.true-counter.com
127.0.0.1 www.tynt.com
127.0.0.1 www.ultimatecounter.com
127.0.0.1 www.v61.com
127.0.0.1 www.web-stat.com
127.0.0.1 www.webcounter.com
127.0.0.1 www.webstat.com
127.0.0.1 www.xxxcounter.com
127.0.0.1 www1.addfreestats.com
127.0.0.1 www1.counter.bloke.com
127.0.0.1 www1.tynt.com
127.0.0.1 www2.addfreestats.com
127.0.0.1 www2.counter.bloke.com
127.0.0.1 www2.pagecount.com
127.0.0.1 www3.addfreestats.com
127.0.0.1 www3.click-fr.com
127.0.0.1 www3.counter.bloke.com
127.0.0.1 www4.addfreestats.com
127.0.0.1 www4.counter.bloke.com
127.0.0.1 www5.addfreestats.com
127.0.0.1 www5.counter.bloke.com
127.0.0.1 www6.addfreestats.com
127.0.0.1 www6.click-fr.com
127.0.0.1 www6.counter.bloke.com
127.0.0.1 www7.addfreestats.com
127.0.0.1 www7.counter.bloke.com
127.0.0.1 www8.addfreestats.com
127.0.0.1 www8.counter.bloke.com
127.0.0.1 www9.counter.bloke.com
127.0.0.1 xcnn.com
127.0.0.1 xtrasizeoriginal.com.br
127.0.0.1 xxxcounter.com
127.0.0.1 xyz.freelogs.com
127.0.0.1 zc1.campaign-view.com.cn
127.0.0.1 zc1.maillist-manage.com.cn
127.0.0.1 zz.cqcounter.com
#</spyware-sites>
#<malware-sites>

# sites with known trojans, phishing, or other malware
127.0.0.1 0.nextyourcontent.com
127.0.0.1 00000.uno
127.0.0.1 05tz2e9.com
127.0.0.1 1-bmo-client-login.com
127.0.0.1 1-directshipmtdhlsexpress-order.help
127.0.0.1 10-letter-words.com
127.0.0.1 1001paixnidia.fr
127.0.0.1 105915624.com
127.0.0.1 10tide.com
127.0.0.1 1percent.fr
127.0.0.1 2006mindfreaklike.blogspot.com	# Facebook trojan
127.0.0.1 2023cradep0sit.com
127.0.0.1 20linutes.fr
127.0.0.1 20mlinutes.fr
127.0.0.1 237online.fr
127.0.0.1 247blinds.fr
127.0.0.1 2g312kn32qfy-1323053341.cos.ap-bangkok.myqcloud.com
127.0.0.1 2roueselectrique.fr
127.0.0.1 2x1gratis.com
127.0.0.1 3mfrances.fr
127.0.0.1 59-106-20-39.r-bl100.sakura.ne.jp
127.0.0.1 602.lazulya.com
127.0.0.1 69fcb79c002e689734cad7411fe0d2e2000.appwrite.network
127.0.0.1 6range.fr
127.0.0.1 6w1.sharedlinkconnect.com
127.0.0.1 75esession.fr
127.0.0.1 7frenchweb.fr
127.0.0.1 7zip.fr
127.0.0.1 8hj500ro4t7.groovepages.com
127.0.0.1 912.lazulya.com
127.0.0.1 a.kaytri.com
127.0.0.1 a.phormlabs.com
127.0.0.1 a.webwise.org
127.0.0.1 a15172379.alturo-server.de
127.0.0.1 aaam.fr
127.0.0.1 aac-lyon.fr
127.0.0.1 aalocine.fr
127.0.0.1 abchina.fr
127.0.0.1 abetterinternet.com
127.0.0.1 abrittel.fr
127.0.0.1 abrutel.fr
127.0.0.1 abruzzoinitaly.co.uk
127.0.0.1 abshop.fr
127.0.0.1 absolutewrite.fr
127.0.0.1 abyssmedia.fr
127.0.0.1 ac-crerteil.fr
127.0.0.1 ac-strasboourg.fr
127.0.0.1 ac-versdailles.fr
127.0.0.1 aca-languedoc.fr
127.0.0.1 acceptlnterac-email-transfer-online-2fasecure.com
127.0.0.1 account-review.com
127.0.0.1 accounts.secure-ua.website
127.0.0.1 accounts.ukr.net.ssl2.in
127.0.0.1 accrogers-overview.com
127.0.0.1 acessoires-electromenager.fr
127.0.0.1 acglgoa.com
127.0.0.1 acmen.fr
127.0.0.1 acnenomor.com
127.0.0.1 acrtsubmissions.com
127.0.0.1 acsentia.fr
127.0.0.1 activateprofile.info
127.0.0.1 activebeat.fr
127.0.0.1 aculo.fr
127.0.0.1 ad.g-content.bid
127.0.0.1 adblock.fr
127.0.0.1 addthis.fr
127.0.0.1 adebooks.fr
127.0.0.1 adef-residences.fr
127.0.0.1 adexchangetracker.com
127.0.0.1 adn.plxnt.com
127.0.0.1 adolfoqsalondmacha.standard.us-east-1.oortstorages.com
127.0.0.1 adquantum.fr
127.0.0.1 adshufffle.com
127.0.0.1 adwitty.com
127.0.0.1 aesthetist.org
127.0.0.1 africancasting.fr
127.0.0.1 agelocer.fr
127.0.0.1 agla.fr
127.0.0.1 agroeconom.kz
127.0.0.1 aide-pac-national.fr
127.0.0.1 ajouny.com
127.0.0.1 aktiv-mit-ms.fr
127.0.0.1 ale-gratka.pl
127.0.0.1 alert1dhlshipment.info
127.0.0.1 alexyu.fr
127.0.0.1 aliecpress.fr
127.0.0.1 aliexress.fr
127.0.0.1 aljamaa.fr
127.0.0.1 allhqpics.com				# Facebook trojan
127.0.0.1 allkpop.fr
127.0.0.1 allocnie.fr
127.0.0.1 allogarages.fr
127.0.0.1 allomine.fr
127.0.0.1 almaria.fr
127.0.0.1 alocdn.com
127.0.0.1 alojamientocentroleon.es
127.0.0.1 alphardgolf.fr
127.0.0.1 alphlauren.fr
127.0.0.1 alt-mk-sports.com
127.0.0.1 alzy.fr
127.0.0.1 amayaresorts.fr
127.0.0.1 americankitchen.fr
127.0.0.1 amocoeastco.com
127.0.0.1 ams1.ib.adnxs.com
127.0.0.1 ams2.rumourrubicon.com
127.0.0.1 ancree.fr
127.0.0.1 android.bigresource.com
127.0.0.1 androiddev.orkitra.com
127.0.0.1 andromedawallet.com
127.0.0.1 aneralflas.club
127.0.0.1 angers-radioloagie.fr
127.0.0.1 anian1.weebly.com
127.0.0.1 anouslab.cmail20.com
127.0.0.1 answerhub.com
127.0.0.1 antispywareexpert.com
127.0.0.1 antivirus-scanner.com
127.0.0.1 antoinettepoisson.fr
127.0.0.1 aosldz.com
127.0.0.1 apconsultantgroup.com
127.0.0.1 apel3.fr
127.0.0.1 api.inwemo.com
127.0.0.1 apoutong.com
127.0.0.1 app2.letslowbefast.life
127.0.0.1 appale.fr
127.0.0.1 appleld.apple.com.t5j2kdkc88dd2m423-verif.info
127.0.0.1 applez.fr
127.0.0.1 appraw.fr
127.0.0.1 apps-500star.com
127.0.0.1 apsu.fr
127.0.0.1 arbrever.fr
127.0.0.1 archeives-ouvertes.fr
127.0.0.1 archi-facile.fr
127.0.0.1 arcticblast.sa.com
127.0.0.1 area52.fr
127.0.0.1 aresweb.fr
127.0.0.1 argenta.fr
127.0.0.1 armsart.com
127.0.0.1 arrayshift.com
127.0.0.1 arteradio.fr
127.0.0.1 artissanat.fr
127.0.0.1 asd.is
127.0.0.1 asemblee-nationale.fr
127.0.0.1 asentia.fr
127.0.0.1 ashleyfires.fr
127.0.0.1 asianread.com
127.0.0.1 ask-coder.com
127.0.0.1 ask.webatall.com
127.0.0.1 askbot.com
127.0.0.1 askto.net
127.0.0.1 askubal.fr
127.0.0.1 assistcom.fr
127.0.0.1 assodigitale.fr
127.0.0.1 ast-grouope.fr
127.0.0.1 athenea.fr
127.0.0.1 atlanticon.fr
127.0.0.1 atlanticos.fr
127.0.0.1 atlasformrn.fr
127.0.0.1 atlauncher.fr
127.0.0.1 audacity.de
127.0.0.1 audacity.es
127.0.0.1 audacity.fr
127.0.0.1 audacity.it
127.0.0.1 audacity.pl
127.0.0.1 augi.fr
127.0.0.1 auirbnb.fr
127.0.0.1 auth0.vernovls.com
127.0.0.1 autheasywinformationreq.com
127.0.0.1 authscotia-signinscotia.com
127.0.0.1 auto-entrereneur.fr
127.0.0.1 autohipnose.com
127.0.0.1 automedik.fr
127.0.0.1 automobile-magasine.fr
127.0.0.1 autonewsinfo.fr
127.0.0.1 avatar.supearou.in
127.0.0.1 avilis.fr
127.0.0.1 avndrealouer.fr
127.0.0.1 avosstart.fr
127.0.0.1 avsvmcloud.com
127.0.0.1 avtec.fr
127.0.0.1 awuam.com
127.0.0.1 aymxv.com
127.0.0.1 azureus.es
127.0.0.1 b.doloaqywbvq.ru
127.0.0.1 b.webwise.org
127.0.0.1 b2b-update.appwrite.network
127.0.0.1 b8bsb.55002298.click
127.0.0.1 babouche-maroc.fr
127.0.0.1 bac-reunion.fr
127.0.0.1 backlusjumpdur.club
127.0.0.1 bactif.fr
127.0.0.1 badsender.fr
127.0.0.1 bagaboo-bags.fr
127.0.0.1 bagagescabine.fr
127.0.0.1 bannerbuzz.fr
127.0.0.1 bannersnack.fr
127.0.0.1 baselabo.heteml.net
127.0.0.1 baxtel.fr
127.0.0.1 bayyinah.fr
127.0.0.1 bbcode.fr
127.0.0.1 bdsm-fantaisie.fr
127.0.0.1 beauten.fr
127.0.0.1 beautylicieuse.fr
127.0.0.1 beautytemple.fr
127.0.0.1 beboncoin.fr
127.0.0.1 belambre.fr
127.0.0.1 bellybuttons.sa.com
127.0.0.1 benchmarkemail.fr
127.0.0.1 benefitsaccountreport.es
127.0.0.1 benefitsgov.info
127.0.0.1 benefitsorganic.com
127.0.0.1 bergeresdefrance.fr
127.0.0.1 berlinprotocols.shop
127.0.0.1 besacon.fr
127.0.0.1 bestblackhatforum.fr
127.0.0.1 bestoftoday.click
127.0.0.1 bestreview.site
127.0.0.1 bestwebpillplace.com
127.0.0.1 bestwesterne.fr
127.0.0.1 bestwing.org
127.0.0.1 bevilla.fr
127.0.0.1 bgre.kozow.com
127.0.0.1 bhyuu.com
127.0.0.1 biaritz.fr
127.0.0.1 biaugerme.fr
127.0.0.1 bighow.net
127.0.0.1 bioware.fr
127.0.0.1 biserka.xyz
127.0.0.1 bitcoin-upappl.com
127.0.0.1 bitcoinexchangemonero.com
127.0.0.1 bitcoinplus.com
127.0.0.1 bitsoin.fr
127.0.0.1 biucosmetics.fr
127.0.0.1 bizlawpoint.com
127.0.0.1 blablacam.fr
127.0.0.1 blackhat.be
127.0.0.1 bladdergenics.shop
127.0.0.1 blender3d.fr
127.0.0.1 blog.ivup.cn
127.0.0.1 bluepartner.fr
127.0.0.1 bluescreenalert.com
127.0.0.1 blw4-1.com
127.0.0.1 bnvxcfhdgf.blogspot.com.es
127.0.0.1 boardgamearena.fr
127.0.0.1 bobgear.fr
127.0.0.1 bodyfitness-epernon.fr
127.0.0.1 bodyhousse.fr
127.0.0.1 boneville.fr
127.0.0.1 bopstermedia56.com
127.0.0.1 bornprix.fr
127.0.0.1 bougyuestelecom.fr
127.0.0.1 boujois.fr
127.0.0.1 boursidirect.fr
127.0.0.1 bousedirect.fr
127.0.0.1 boutique-papillon.fr
127.0.0.1 bouygiestelecom.fr
127.0.0.1 bpong.fr
127.0.0.1 bracabrac.fr
127.0.0.1 brainns.sa.com
127.0.0.1 breg.fr
127.0.0.1 breitbart.fr
127.0.0.1 breizh-ile.fr
127.0.0.1 bricolage-avec-robert.fr
127.0.0.1 bricolo-blogger.fr
127.0.0.1 brides4you.sa.com
127.0.0.1 bridgebase.fr
127.0.0.1 bridgemanstt.com
127.0.0.1 brightonclick.com
127.0.0.1 brokking.fr
127.0.0.1 brostyles.fr
127.0.0.1 brunga.at	# Facebook phishing attempt
127.0.0.1 bsugars.sa.com
127.0.0.1 bt.webwise.org
127.0.0.1 build.waikatocycleways.info
127.0.0.1 bulletwhiskey.sa.com
127.0.0.1 bundesanzeiger.fr
127.0.0.1 burley.fr
127.0.0.1 buyagift.fr
127.0.0.1 byowner.fr
127.0.0.1 c-martinique.fr
127.0.0.1 c-piscine.fr
127.0.0.1 c-rennes.fr
127.0.0.1 c.webwise.org
127.0.0.1 c0nforama.fr
127.0.0.1 c1i.su
127.0.0.1 ca-biepicardie.fr
127.0.0.1 ca-briepcardie.fr
127.0.0.1 ca-cantreloire.fr
127.0.0.1 ca-centtreloire.fr
127.0.0.1 ca-czntrefrance.fr
127.0.0.1 ca-languedo.fr
127.0.0.1 ca-nm.fr
127.0.0.1 ca-pac.fr
127.0.0.1 ca-touloue31.fr
127.0.0.1 ca-vb.fr
127.0.0.1 cablyshaw.com
127.0.0.1 caeauxfolies.fr
127.0.0.1 cafe-express.fr
127.0.0.1 cafecoc.com
127.0.0.1 cafhanoi.dorps.info
127.0.0.1 cafj.fr
127.0.0.1 cafranchecomte.fr
127.0.0.1 caisse-apargne.fr
127.0.0.1 callfor-articles.com
127.0.0.1 callfor-submissions.com
127.0.0.1 camaieur.fr
127.0.0.1 cambonanza.com
127.0.0.1 campaign.budgethyve.com
127.0.0.1 camping-la-bien-assise.fr
127.0.0.1 camping-oreedelocean.fr
127.0.0.1 camping-pinede.fr
127.0.0.1 campinglespins.fr
127.0.0.1 camplace.fr
127.0.0.1 campus-forprof.fr
127.0.0.1 canada.postcanadakxcif.top
127.0.0.1 canadapost-delivery-reshedule.com
127.0.0.1 canadapost-paymentservice.com
127.0.0.1 canadapost-postescanada.uwpackege.top
127.0.0.1 canadapost.helpdag.top
127.0.0.1 canadapost.postescanadad.xyz
127.0.0.1 canadapostarticle.com
127.0.0.1 capital-invest-can.cropvita.sbs
127.0.0.1 capitalregionusa.fr
127.0.0.1 capostdelivery.com
127.0.0.1 carac-terres.fr
127.0.0.1 carrfefour.fr
127.0.0.1 cartoonnetworkarabic.fr
127.0.0.1 casmundo.fr
127.0.0.1 castelli-cycling.fr
127.0.0.1 castortama.fr
127.0.0.1 cbcare.fr
127.0.0.1 cbt5.sdalfurqanjember.sch.id
127.0.0.1 ccieurope.fr
127.0.0.1 ccs.north-kazakhstan.su
127.0.0.1 ccudl.com
127.0.0.1 cd-elec.fr
127.0.0.1 cd-sport.fr
127.0.0.1 cdn.jquery-uim.download
127.0.0.1 ce-marketing.fr
127.0.0.1 cebue.magmafurnace.top
127.0.0.1 celestia.es
127.0.0.1 celestia.fr
127.0.0.1 cellu-clean.fr
127.0.0.1 cengolio.fr
127.0.0.1 certifiedwinners.today
127.0.0.1 cesdeals.fr
127.0.0.1 cfjln.comfortykive.xyz
127.0.0.1 cguardai.com
127.0.0.1 chaisesprivee.fr
127.0.0.1 chaliehebdo.fr
127.0.0.1 challeges.fr
127.0.0.1 changduk26.com			# Facebook trojan
127.0.0.1 chatroll.fr
127.0.0.1 chch.fr
127.0.0.1 checkfreevideos.net
127.0.0.1 checkout360now.net
127.0.0.1 chelick.net				# Facebook trojan
127.0.0.1 chienvoyageur.fr
127.0.0.1 choisimoncode.fr
127.0.0.1 chrliehebdo.fr
127.0.0.1 chu-bordeau.fr
127.0.0.1 chu-morlaix.fr
127.0.0.1 cibc-oniinecibc.com
127.0.0.1 cibconline-login.com
127.0.0.1 cic-epargnrsalariale.fr
127.0.0.1 cicontents.biz
127.0.0.1 cifw.fr
127.0.0.1 ciiycode.com
127.0.0.1 cinediagonal.fr
127.0.0.1 cinemasouslesetoiles.fr
127.0.0.1 cinforama.fr
127.0.0.1 cioco-froll.com
127.0.0.1 circuitsdelegende.fr
127.0.0.1 claclasse.fr
127.0.0.1 claimcostcobenefits.com
127.0.0.1 clean-mobilephone.com
127.0.0.1 cleanchain.net
127.0.0.1 cleanmobilephone.com
127.0.0.1 click.get-answers-fast.com
127.0.0.1 clicktripz.com
127.0.0.1 climate-actionpayment.com
127.0.0.1 clonezilla.es
127.0.0.1 clonezilla.fr
127.0.0.1 cloudalert.shop
127.0.0.1 cltxhot.fun
127.0.0.1 cm076410.tw1.ru
127.0.0.1 cmcre.fr
127.0.0.1 cndpt.fr
127.0.0.1 cnhv.co
127.0.0.1 cnnews.fr
127.0.0.1 cnrfms.pro
127.0.0.1 cnt-jrs.com
127.0.0.1 cnt.statistic.date
127.0.0.1 codebiogblog.com
127.0.0.1 codeexplain.com
127.0.0.1 codegur.com
127.0.0.1 codelogic.fr
127.0.0.1 codeotel.com
127.0.0.1 coderexception.com
127.0.0.1 coin-have.com
127.0.0.1 coin-hive.com
127.0.0.1 coinerra.com
127.0.0.1 coinhive.com
127.0.0.1 coinimp.com
127.0.0.1 coldcertainchannel.com
127.0.0.1 coldpacific.com
127.0.0.1 colisismo.fr
127.0.0.1 collagenforwellnessandbeauty.com
127.0.0.1 collline.fr
127.0.0.1 coloradosoccerbuddies.acemlna.com
127.0.0.1 colssimo.fr
127.0.0.1 comfortykive.xyz
127.0.0.1 comineeis.vu
127.0.0.1 commax.fr
127.0.0.1 commdev.fr
127.0.0.1 compe-nickel.fr
127.0.0.1 compufixshop.com
127.0.0.1 comsss-56.com
127.0.0.1 con-trnroayl.online
127.0.0.1 conduit.com
127.0.0.1 confg.fr
127.0.0.1 confirm1509account4715.com
127.0.0.1 conseil-coaching-jardinage.fr
127.0.0.1 conseildentaire.fr
127.0.0.1 consorsbank.fr
127.0.0.1 consumerspanel.frge.io
127.0.0.1 cookeatshare.fr
127.0.0.1 coordino.com
127.0.0.1 cosi.iprive.net
127.0.0.1 cosmopolian.fr
127.0.0.1 cosmopolita.fr
127.0.0.1 costco-rewardsaccount1.com
127.0.0.1 costorama.fr
127.0.0.1 countrystore.fr
127.0.0.1 coupondio.fr
127.0.0.1 cp.forest-host.cc
127.0.0.1 cp.liferan.pro
127.0.0.1 cplelangues.fr
127.0.0.1 cra-arc-gc-ca.noads.biz
127.0.0.1 cra-documents.ca
127.0.0.1 cra-etransfer.online
127.0.0.1 crarefundsreview.com
127.0.0.1 crdp-strsbourg.fr
127.0.0.1 creativlonk.fr
127.0.0.1 creditmuteuel.fr
127.0.0.1 creditmutuel-epargesalariale.fr
127.0.0.1 criticals.sa.com
127.0.0.1 criticaltt.shop
127.0.0.1 critiquefilm.fr
127.0.0.1 croissieres.fr
127.0.0.1 crouslyon.fr
127.0.0.1 crpo.fr
127.0.0.1 crrect.sa.com
127.0.0.1 crypto-loot.com
127.0.0.1 ctmsapp.com
127.0.0.1 cuder.fr
127.0.0.1 cullligan.fr
127.0.0.1 culturalfoundation.fr
127.0.0.1 cun.accountcare.cfd
127.0.0.1 curejoint.sa.com
127.0.0.1 cures.ru.com
127.0.0.1 customsoftwaredeveloper.com.au
127.0.0.1 cutesaucepuppy.com
127.0.0.1 cyber20.com
127.0.0.1 cyberpanel.fr
127.0.0.1 cyfe.fr
127.0.0.1 czr.customzonereview.com
127.0.0.1 d.phormlabs.com
127.0.0.1 d2o9ozfswytaqz.cloudfront.net
127.0.0.1 dahenie.accsvc.cfd
127.0.0.1 dailygame.fr
127.0.0.1 dailynewstonight.com
127.0.0.1 dartry.fr
127.0.0.1 data-ng28.com
127.0.0.1 datajobs.fr
127.0.0.1 davidhuynh.fr
127.0.0.1 db-z.fr
127.0.0.1 dbios.org
127.0.0.1 dealerconnection.fr
127.0.0.1 dealiveroo.fr
127.0.0.1 declarateenquiebra.cl
127.0.0.1 decompiler.fr
127.0.0.1 dejoyaux.fr
127.0.0.1 delamaisn.fr
127.0.0.1 delivery-change-reschedule6128.com
127.0.0.1 deloitteca.com
127.0.0.1 delphix.fr
127.0.0.1 deltarviews.bond
127.0.0.1 dentalfix.shop
127.0.0.1 denx.fr
127.0.0.1 department06.fr
127.0.0.1 deposit-cra2023.com
127.0.0.1 deposit-et-1interac.help
127.0.0.1 depositphotos.fr
127.0.0.1 depottool.bond
127.0.0.1 desertdreamtour.com
127.0.0.1 desfans.sportgroup.cl
127.0.0.1 details-update.com
127.0.0.1 devguardmap.org
127.0.0.1 dewinci.fr
127.0.0.1 dfnac.fr
127.0.0.1 dhauzja511.co.cc
127.0.0.1 dhl-closeariu.kaixuankio.cn
127.0.0.1 dhlmyorder82662-info-can.com
127.0.0.1 dig
127.0.0.1 digiclk.com
127.0.0.1 digicub.fr
127.0.0.1 digipote.fr
127.0.0.1 digipsote.fr
127.0.0.1 digitfoto.fr
127.0.0.1 din.prr.mybluehost.me
127.0.0.1 diomedia.fr
127.0.0.1 dirtmountainbike.fr
127.0.0.1 disneyholidays.fr
127.0.0.1 dldyjy.com
127.0.0.1 dns2.net1.it
127.0.0.1 dnythgt.com
127.0.0.1 docs.ukr.net.ssl2.in
127.0.0.1 dogry.fr
127.0.0.1 dogtrace.fr
127.0.0.1 domaine-voyance.fr
127.0.0.1 donforama.fr
127.0.0.1 dontacos.fr
127.0.0.1 dooror.com
127.0.0.1 doors.co.kr
127.0.0.1 dpflyingoncs.top
127.0.0.1 dsbzk.comfortykive.xyz
127.0.0.1 dtcc.fr
127.0.0.1 dveug.comfortykive.xyz
127.0.0.1 e-kern.fr
127.0.0.1 e-lords.fr
127.0.0.1 e-trn-incm.com
127.0.0.1 eaboiretes.com
127.0.0.1 easewave.digital
127.0.0.1 east.05tz2e9.com
127.0.0.1 easyflier.fr
127.0.0.1 easytic.fr
127.0.0.1 eauchan.fr
127.0.0.1 ecantal.fr
127.0.0.1 ecirque.fr
127.0.0.1 eckosport.fr
127.0.0.1 edecideur.fr
127.0.0.1 edisk.ukr.net.ssl2.in
127.0.0.1 edmo.fr
127.0.0.1 education-securiter-routiere.fr
127.0.0.1 eeude.comfortykive.xyz
127.0.0.1 efreedom.net
127.0.0.1 ekomerco.fr
127.0.0.1 elboncoin.fr
127.0.0.1 electroslm.shop
127.0.0.1 elyses.fr
127.0.0.1 emagicone.fr
127.0.0.1 email.headers.digital
127.0.0.1 emperors.bunkerhilltradingco.info
127.0.0.1 emplpoi-store.fr
127.0.0.1 en.btc-trader-app.club
127.0.0.1 en.likefever.org			# Facebook trojan
127.0.0.1 enablement.joethecpa.info
127.0.0.1 enalytics.fr
127.0.0.1 endicia.fr
127.0.0.1 englishcentral.fr
127.0.0.1 entek.fr
127.0.0.1 entuduc.fr
127.0.0.1 eol1.egyptonline.com
127.0.0.1 eondershare.fr
127.0.0.1 equitaine.fr
127.0.0.1 erobot-pisicne.fr
127.0.0.1 erogames.fr
127.0.0.1 ertbaudet.fr
127.0.0.1 escplus.fr
127.0.0.1 eslprologmvp.com
127.0.0.1 eslprotourmvp.com
127.0.0.1 esmoutonsenrages.fr
127.0.0.1 espaceagazines.fr
127.0.0.1 espub.fr
127.0.0.1 et-1nt3rc.com
127.0.0.1 et-interac.etransfers1.com
127.0.0.1 et-mycostcorewards.info
127.0.0.1 etdeposit-interac.com
127.0.0.1 etransfer-23799.com
127.0.0.1 etribunaldunet.fr
127.0.0.1 etronella.bizneswarszawa.info
127.0.0.1 euriosport.fr
127.0.0.1 europr1.fr
127.0.0.1 eurospoprt.fr
127.0.0.1 eurostreaming.myproxy.help
127.0.0.1 eurostreaming.superproxy.lol
127.0.0.1 eviebot.fr
127.0.0.1 ewea.fr
127.0.0.1 exasked.com
127.0.0.1 exchangemarket.fr
127.0.0.1 executiveannualreward.im
127.0.0.1 exelformation.fr
127.0.0.1 exepdia.fr
127.0.0.1 exotic-wax.surge.sh
127.0.0.1 exparint.fr
127.0.0.1 expertland.net
127.0.0.1 expired-antiviruses.com
127.0.0.1 extrashop.fr
127.0.0.1 f-voyance.fr
127.0.0.1 f05098.privacy4browsers.com
127.0.0.1 f18085.privacy4browsers.com
127.0.0.1 fabhabitat.fr
127.0.0.1 facebbook.fr
127.0.0.1 facebook-repto1040s2.ahlamountada.com
127.0.0.1 facebookj.fr
127.0.0.1 faceboook-replyei0ki.montadalitihad.com
127.0.0.1 facemail.com
127.0.0.1 factorship.wcyrkdd.cn
127.0.0.1 fafarge.fr
127.0.0.1 faggotry.com
127.0.0.1 falkcoppercookware.fr
127.0.0.1 fanniemae.fr
127.0.0.1 fasola.fr
127.0.0.1 fclb.fr
127.0.0.1 fdoverbilled.com
127.0.0.1 fedex-rescheduel-date.com
127.0.0.1 fedex-rescheduel-delivery-date.com
127.0.0.1 fedgroceryrebate.com
127.0.0.1 fedi.6751242.cc
127.0.0.1 feedbackexplorer.com
127.0.0.1 femidignity.org
127.0.0.1 fengyixin.com
127.0.0.1 ferreirateixeira.adv.br
127.0.0.1 festicolor.fr
127.0.0.1 ffesm.fr
127.0.0.1 fichier-pdfr.fr
127.0.0.1 fido-team.com
127.0.0.1 figato.fr
127.0.0.1 files.ukr.net.ssl2.in
127.0.0.1 filezilla.fr
127.0.0.1 filosvybfimpsv.ru.gg
127.0.0.1 filter.mediacpc.com
127.0.0.1 filthycricket.com
127.0.0.1 find-your-profithere11.com
127.0.0.1 finessaweight.shop
127.0.0.1 firefox-updater.com
127.0.0.1 firstrowsports.fr
127.0.0.1 fit4form.fr
127.0.0.1 flashrasultats.fr
127.0.0.1 flexfone.fr
127.0.0.1 flightams.fr
127.0.0.1 fnactickets.fr
127.0.0.1 foiegras-groliere.fr
127.0.0.1 foreverprintco.com
127.0.0.1 formumactif.fr
127.0.0.1 fortress.anhcs.info
127.0.0.1 forumdread.com
127.0.0.1 forurm-candaulisme.fr
127.0.0.1 fourtuneo.fr
127.0.0.1 foutuneo.fr
127.0.0.1 foxoptic.fr
127.0.0.1 fqint.comfortykive.xyz
127.0.0.1 francebootball.fr
127.0.0.1 francelbleu.fr
127.0.0.1 frecnhweb.fr
127.0.0.1 free-box.fr
127.0.0.1 free.internetspeedtracker.com
127.0.0.1 free.propdfconverter.com
127.0.0.1 free.videodownloadconverter.com
127.0.0.1 freebos.fr
127.0.0.1 freecontent.bid
127.0.0.1 freedailydownload.com
127.0.0.1 freedon.fr
127.0.0.1 freelanced.fr
127.0.0.1 fref.fr
127.0.0.1 freighttools.live
127.0.0.1 frenchbweb.fr
127.0.0.1 frenesies.fr
127.0.0.1 fresh.sa.com
127.0.0.1 freshzz00.duckdns.org
127.0.0.1 frnafinance.fr
127.0.0.1 froancefootball.fr
127.0.0.1 froling.bee.pl
127.0.0.1 fromru.su
127.0.0.1 ftdownload.com
127.0.0.1 fu.golikeus.net			# Facebook trojan
127.0.0.1 funnysciencediscounts1.blogspot.com
127.0.0.1 fuzzy-afternoon.surge.sh
127.0.0.1 fwbdndyikloaxb68duujcfyudy.appwrite.network
127.0.0.1 g2play.fr
127.0.0.1 gabrielahlavack.samcart.com
127.0.0.1 gadgetsytecnologia.com
127.0.0.1 gagy.fr
127.0.0.1 gaiaherbs.fr
127.0.0.1 gambero3.cs.tin.it
127.0.0.1 game321.fr
127.0.0.1 gamejolt.fr
127.0.0.1 gamelights.ru
127.0.0.1 gamonic.fr
127.0.0.1 garde-d-enfants-ooreka.fr
127.0.0.1 gasasthe.freehostia.com
127.0.0.1 gautmont.fr
127.0.0.1 gazia.fr
127.0.0.1 gcn-1nterc.com
127.0.0.1 gdudh473-chersfeye483.landmarksfeed.su
127.0.0.1 gekowex.com
127.0.0.1 geolantis.fr
127.0.0.1 geopostcodes.fr
127.0.0.1 get-answers-fast.com
127.0.0.1 get24update.link4all.info
127.0.0.1 getdispadsshop.com
127.0.0.1 getnexuscard.com
127.0.0.1 gglcash4u.info	# twitter worm
127.0.0.1 gifii.fr
127.0.0.1 giftcard.cx
127.0.0.1 gigaonclick.com
127.0.0.1 gimp.es
127.0.0.1 girlownedbypolicelike.blogspot.com	# Facebook trojan
127.0.0.1 giulli.fr
127.0.0.1 glassjaw.fr
127.0.0.1 globaldrugsurvey.fr
127.0.0.1 glucont.shop
127.0.0.1 gmailapcq6.eblink5.com
127.0.0.1 go.deliverymodo.com
127.0.0.1 goggle.com
127.0.0.1 gondesss.albarikfabric.com
127.0.0.1 goobbe.com
127.0.0.1 goodreader.fr
127.0.0.1 goolgueule.fr
127.0.0.1 gorange.fr
127.0.0.1 gotinder.fr
127.0.0.1 gparted.fr
127.0.0.1 grandtheftwiki.fr
127.0.0.1 greatarcadehits.com
127.0.0.1 greeninst.com
127.0.0.1 greenshot.fr
127.0.0.1 greffetc-paris.fr
127.0.0.1 grooveshark.fr
127.0.0.1 grossiste3d.fr
127.0.0.1 groupeauto.fr
127.0.0.1 groupom.fr
127.0.0.1 growhairs.shop
127.0.0.1 gstscra.com
127.0.0.1 gtamoding.fr
127.0.0.1 gtiruto.shop
127.0.0.1 guangjiemiao.com
127.0.0.1 guidelon.fr
127.0.0.1 guiltygear.fr
127.0.0.1 guthealth.sa.com
127.0.0.1 gv-1nt3rc.com
127.0.0.1 gwene.com.slackware.alien.blog
127.0.0.1 gwklaser.fr
127.0.0.1 gyros.es
127.0.0.1 h9tkd.rdtk.io
127.0.0.1 habboss.fr
127.0.0.1 hackconsole.fr
127.0.0.1 hackerz.ir
127.0.0.1 hajoopteg.com
127.0.0.1 hakerzy.net
127.0.0.1 hakuba.janis.or.jp
127.0.0.1 handbrake.es
127.0.0.1 happyfresh.fr
127.0.0.1 hartamann.fr
127.0.0.1 hashing.win
127.0.0.1 hatdfg-rhgreh684.frge.io
127.0.0.1 hatrecord.ru				# Facebook trojan
127.0.0.1 hcg82f2b.com
127.0.0.1 headization.lexkd.cn
127.0.0.1 healpublic.best
127.0.0.1 hefever.fr
127.0.0.1 hellomobile.fr
127.0.0.1 helpmedb.com
127.0.0.1 hentavost.fr
127.0.0.1 heritagebathrooms.fr
127.0.0.1 heshun.com.tw
127.0.0.1 heuither.sbs
127.0.0.1 hfrni.comfortykive.xyz
127.0.0.1 hibody.fr
127.0.0.1 hie.li
127.0.0.1 hifa.fr
127.0.0.1 himicrosoft.com
127.0.0.1 hintonsfeetred.info
127.0.0.1 hiphip.fr
127.0.0.1 hireproplus.com
127.0.0.1 hirsch-ille.fr
127.0.0.1 hiteck.fr
127.0.0.1 hiuinder.beauty
127.0.0.1 hlhtylivs.shop
127.0.0.1 hlthiliv.shop
127.0.0.1 hltuup.za.com
127.0.0.1 hocolats-voisin.fr
127.0.0.1 homecaremovers-com-wp-admin-img-wp-ico.appwrite.network
127.0.0.1 hommetendance.fr
127.0.0.1 honeyburn.za.com
127.0.0.1 hostify.fr
127.0.0.1 hostiko.fr
127.0.0.1 hot24profit.life
127.0.0.1 hotchix.servepics.com
127.0.0.1 hotdesertknights.fr
127.0.0.1 hotel-leparc.fr
127.0.0.1 hotelboard.org
127.0.0.1 hoteldesventesantilles.fr
127.0.0.1 hotelissimo.fr
127.0.0.1 hotvideos.fr
127.0.0.1 houseofkids.fr
127.0.0.1 how-tosolve.com
127.0.0.1 howtobuildsoftware.com
127.0.0.1 hp.myway.com
127.0.0.1 hradware.fr
127.0.0.1 hsb-canada.com	# phishing site for hsbc.ca
127.0.0.1 https-ticketnotice.com
127.0.0.1 huffingtopost.fr
127.0.0.1 hunkemoeller.fr
127.0.0.1 hunkemuller.fr
127.0.0.1 hwgda.comfortykive.xyz
127.0.0.1 i.ua-passport.top
127.0.0.1 icecars.com
127.0.0.1 ichisushi.fr
127.0.0.1 iconfitness.fr
127.0.0.1 id-unconfirmeduser.frge.io
127.0.0.1 iedalo.fr
127.0.0.1 ieurope1.fr
127.0.0.1 ignitioncasino.fr
127.0.0.1 iledefrance-mutualite.fr
127.0.0.1 imagecenter.fr
127.0.0.1 imago-tv.fr
127.0.0.1 imotors.fr
127.0.0.1 in-aoke.com
127.0.0.1 inateck.fr
127.0.0.1 incuirfes.beauty
127.0.0.1 info-sectes.fr
127.0.0.1 infodjour.fr
127.0.0.1 infographicworld.fr
127.0.0.1 infopaypal.com
127.0.0.1 informereng.com
127.0.0.1 ingedus.fr
127.0.0.1 init-kqt.com
127.0.0.1 inkscape.es
127.0.0.1 inkscape.fr
127.0.0.1 innoveox.fr
127.0.0.1 inoreader.fr
127.0.0.1 inseee.fr
127.0.0.1 instabook.fr
127.0.0.1 install.myvideotab.com
127.0.0.1 installmac.com
127.0.0.1 instantstreetview.fr
127.0.0.1 intelcom-on.progressionlive.com
127.0.0.1 intelcomasfcmscta.com
127.0.0.1 interac-etransfer.net
127.0.0.1 interac1-ssl2.info
127.0.0.1 interacpayment-cra.com
127.0.0.1 interhomes.fr
127.0.0.1 interimairesssante.fr
127.0.0.1 internwise.fr
127.0.0.1 interpretation-reves.fr
127.0.0.1 intevry.fr
127.0.0.1 invelaconstructora.com
127.0.0.1 invite.gezinti.com
127.0.0.1 ipi9.fr
127.0.0.1 iqmatrix.fr
127.0.0.1 irony.world
127.0.0.1 istartsurf.com
127.0.0.1 iswwwup.com
127.0.0.1 itbeginner.fr
127.0.0.1 itc.InsightTrailco.com
127.0.0.1 itprfft.sa.com
127.0.0.1 itssure.shop
127.0.0.1 ivgault.fr
127.0.0.1 ivoirmixdj.fr
127.0.0.1 izli.fr
127.0.0.1 jacques-brinat.fr
127.0.0.1 janezk.50webs.co
127.0.0.1 jardinonssolsvivant.fr
127.0.0.1 jasperrcorporation.com
127.0.0.1 jessieu.fr
127.0.0.1 jetem.fr
127.0.0.1 jeu-jeux.fr
127.0.0.1 jeupicard.fr
127.0.0.1 jobfreelance.fr
127.0.0.1 joomlaworks.fr
127.0.0.1 joshan.fun
127.0.0.1 juegosdechicas.fr
127.0.0.1 juliettehasagun.fr
127.0.0.1 juliyea.sbs
127.0.0.1 jump.ewoss.net
127.0.0.1 juste.ru	# Twitter trojan
127.0.0.1 juventuis.fr
127.0.0.1 jzyygl.com
127.0.0.1 kabookk.fr
127.0.0.1 kanojo.fr
127.0.0.1 kantoexuziiv.com
127.0.0.1 kartables.fr
127.0.0.1 kaytri.com
127.0.0.1 keepass.com
127.0.0.1 keepass.fr
127.0.0.1 keepinfit.net
127.0.0.1 kevlaardiet.fr
127.0.0.1 keybinary.com
127.0.0.1 kiabo.fr
127.0.0.1 kiaby.fr
127.0.0.1 kiassure.fr
127.0.0.1 kicherchekoi.fr
127.0.0.1 kiclq.comfortykive.xyz
127.0.0.1 kirgo.at	# Facebook phishing attempt
127.0.0.1 kitchenmagic.fr
127.0.0.1 klefigaro.fr
127.0.0.1 kleinfelder.fr
127.0.0.1 kliniksam.com
127.0.0.1 klove.fr
127.0.0.1 klowns4phun.com
127.0.0.1 kluspro.com
127.0.0.1 konflow.com				# Facebook trojan
127.0.0.1 korodrogerie.fr
127.0.0.1 kosatec.fr
127.0.0.1 kplusd.far.ru
127.0.0.1 kpremium.com
127.0.0.1 krakragames.com
127.0.0.1 kuder.fr
127.0.0.1 kweiqox.beauty
127.0.0.1 l-histoire.fr
127.0.0.1 l.wl.co
127.0.0.1 l2.cuyouthmusic.com
127.0.0.1 la1dwne9cn5c.com
127.0.0.1 laatribune.fr
127.0.0.1 labanquepoqtale.fr
127.0.0.1 labanqueposttale.fr
127.0.0.1 laboiteorse.fr
127.0.0.1 lacentrrale.fr
127.0.0.1 lacetrale.fr
127.0.0.1 lactell.fr
127.0.0.1 ladepehe.fr
127.0.0.1 lagazette-dgi.fr
127.0.0.1 lagranderecr.fr
127.0.0.1 laiberation.fr
127.0.0.1 lajna.fr
127.0.0.1 laleh.itrc.ac.ir
127.0.0.1 lama-ole-nydahl.fr
127.0.0.1 lamlsace.fr
127.0.0.1 lamutellegenerale.fr
127.0.0.1 landing.aaroninjections.com
127.0.0.1 landingairquality.airlite.com
127.0.0.1 lank.ru
127.0.0.1 laphoceen.fr
127.0.0.1 laredoutee.fr
127.0.0.1 laredoutre.fr
127.0.0.1 lareplubliquedespyrenees.fr
127.0.0.1 larusse.fr
127.0.0.1 lasopabowl158.weebly.com
127.0.0.1 latribuen.fr
127.0.0.1 latrubune.fr
127.0.0.1 lavoixedunord.fr
127.0.0.1 laxifoot.fr
127.0.0.1 lbouyguestelecom.fr
127.0.0.1 lbrtry.com
127.0.0.1 lcastorama.fr
127.0.0.1 lcolissimo.fr
127.0.0.1 lcpr.fr
127.0.0.1 lcwkj.com
127.0.0.1 le-chineur.fr
127.0.0.1 le-recendement-et-moi.fr
127.0.0.1 le-recenement-et-moi.fr
127.0.0.1 le-tchat-bdsm.fr
127.0.0.1 leboncoan.fr
127.0.0.1 lebopncoin.fr
127.0.0.1 leelynx.fr
127.0.0.1 leficaro.fr
127.0.0.1 lefigarao.fr
127.0.0.1 lefigarop.fr
127.0.0.1 lefiogaro.fr
127.0.0.1 lefirgaro.fr
127.0.0.1 lefsechos.fr
127.0.0.1 legfigaro.fr
127.0.0.1 legrando.fr
127.0.0.1 leighties.fr
127.0.0.1 leket.fr
127.0.0.1 lemnode.fr
127.0.0.1 lemondde.fr
127.0.0.1 lemovnde.fr
127.0.0.1 leojblog.com
127.0.0.1 leomonde.fr
127.0.0.1 leparirien.fr
127.0.0.1 leparisein.fr
127.0.0.1 leparisin.fr
127.0.0.1 lepatisien.fr
127.0.0.1 lepoinf.fr
127.0.0.1 leponde.fr
127.0.0.1 leroymerln.fr
127.0.0.1 leroymrlin.fr
127.0.0.1 les-bagatelles.fr
127.0.0.1 les-crisis.fr
127.0.0.1 les-oncheres.fr
127.0.0.1 les-toiles-cinema.fr
127.0.0.1 lesecchos.fr
127.0.0.1 lesechoss.fr
127.0.0.1 lesindesradio.fr
127.0.0.1 lesmonde.fr
127.0.0.1 leuquipe.fr
127.0.0.1 levigilant.fr
127.0.0.1 lezboncoin.fr
127.0.0.1 lezpress.fr
127.0.0.1 lhycc.com
127.0.0.1 liberatiuon.fr
127.0.0.1 liberaztion.fr
127.0.0.1 liberland.fr
127.0.0.1 library.roadring.info
127.0.0.1 licasd.com
127.0.0.1 lieberation.fr
127.0.0.1 liemonde.fr
127.0.0.1 lien-social.fr
127.0.0.1 lifchnger.ru.com
127.0.0.1 lifefoot.fr
127.0.0.1 lifeofpie.fr
127.0.0.1 lifigaro.fr
127.0.0.1 lifsfer.shop
127.0.0.1 like.likewut.net
127.0.0.1 likeportal.com			# Facebook trojan
127.0.0.1 likespike.com				# Facebook trojan
127.0.0.1 likethis.mbosoft.com			# Facebook trojan
127.0.0.1 likethislist.biz			# Facebook trojan
127.0.0.1 lindependnant.fr
127.0.0.1 lindependnt.fr
127.0.0.1 lingintirejohny.club
127.0.0.1 lisaa.fr
127.0.0.1 listenonrepeat.fr
127.0.0.1 littleduck.fr
127.0.0.1 livesfoot.fr
127.0.0.1 livezfoot.fr
127.0.0.1 livhlthy.sa.com
127.0.0.1 livreral.fr
127.0.0.1 livrval.fr
127.0.0.1 livsffer.sa.com
127.0.0.1 livsfs.today
127.0.0.1 localo.fr
127.0.0.1 login.belladermaco.com
127.0.0.1 login.creditals-email.space
127.0.0.1 logitrave.fr
127.0.0.1 loirs.fr
127.0.0.1 lonaci.fr
127.0.0.1 longrich.fr
127.0.0.1 love-quest.blog
127.0.0.1 loytec.fr
127.0.0.1 lp.cleanmymac.online
127.0.0.1 lpoint.fr
127.0.0.1 lrpoint.fr
127.0.0.1 lrt7a.coldcertainchannel.com
127.0.0.1 lucklayed.info
127.0.0.1 lueway.fr
127.0.0.1 luminae.fr
127.0.0.1 luniko.fr
127.0.0.1 luxdiscount.zone
127.0.0.1 lyceebrequigny.fr
127.0.0.1 lyophililse.fr
127.0.0.1 m01.webwise.org
127.0.0.1 m02.webwise.org
127.0.0.1 maanageo.fr
127.0.0.1 mabtech.fr
127.0.0.1 mac-osx.message-warning.net
127.0.0.1 macfs.fr
127.0.0.1 madwell.fr
127.0.0.1 maewan.fr
127.0.0.1 magasine-omnicuiseur.fr
127.0.0.1 magento-analytics.com
127.0.0.1 magic-flight.fr
127.0.0.1 magicpayrecharge.com
127.0.0.1 maia-asso.fr
127.0.0.1 mail-en-marche.fr
127.0.0.1 mail.bangla.net
127.0.0.1 mail.cyberh.fr
127.0.0.1 mail.hallym.ac.kr
127.0.0.1 mail.imamu.edu.sa
127.0.0.1 mail.interq.or.jp
127.0.0.1 mail.ioc.ac.ru
127.0.0.1 mail.issas.ac.cn
127.0.0.1 mail.pmo.ac.cn
127.0.0.1 mail.siom.ac.cn
127.0.0.1 mail.tropmet.res.in
127.0.0.1 mail1.371.net
127.0.0.1 maillots-ffoot-actu.fr
127.0.0.1 mailofficeonline.shop
127.0.0.1 mailtrack.fr
127.0.0.1 main.exosrv.com
127.0.0.1 maisonstravaux.fr
127.0.0.1 maisonvalentina.fr
127.0.0.1 makeitmedia.fr
127.0.0.1 makerblog.fr
127.0.0.1 makesushi.fr
127.0.0.1 manage2-phone7alerts.com
127.0.0.1 mandialrelay.fr
127.0.0.1 mappyt.fr
127.0.0.1 marathondulacduder.fr
127.0.0.1 marble.travelhealthreport.info
127.0.0.1 marie-gerardmer.fr
127.0.0.1 marigo.redbacksburger.info
127.0.0.1 marinescence.fr
127.0.0.1 marketgameland.com
127.0.0.1 massage-v-almaty.kz
127.0.0.1 matcheendirect.fr
127.0.0.1 matchendirectr.fr
127.0.0.1 matchendiredt.fr
127.0.0.1 matchwomanreal.com
127.0.0.1 max-wangcai28.com
127.0.0.1 mbi3.kuicr.kyoto-u.ac.jp
127.0.0.1 mcleaks.fr
127.0.0.1 mdjdg.girlssohorny.net
127.0.0.1 media-match.com
127.0.0.1 mediaterre.fr
127.0.0.1 medicalhero.fr
127.0.0.1 mediterraneanroom.org
127.0.0.1 meetics.fr
127.0.0.1 melthy.fr
127.0.0.1 memecosmetic.fr
127.0.0.1 mes-bon-plans.fr
127.0.0.1 messagerie-lcl.fr
127.0.0.1 mesurelettre.fr
127.0.0.1 meta.osqa.net
127.0.0.1 metcoc5cm.clarent.com
127.0.0.1 meteof.fr
127.0.0.1 metrx.fr
127.0.0.1 meuble-bois-massif.fr
127.0.0.1 mgpl.fr
127.0.0.1 mguide-piscine.fr
127.0.0.1 mhhn.fr
127.0.0.1 michelinb2b.fr
127.0.0.1 microsoftsupport.xyz
127.0.0.1 mideal.fr
127.0.0.1 miercuri.gq
127.0.0.1 mightyfungi.fr
127.0.0.1 mije.fr
127.0.0.1 mikvr.comfortykive.xyz
127.0.0.1 mimikacooney.acemlnc.com
127.0.0.1 mindshareworld.fr
127.0.0.1 mineacraft.fr
127.0.0.1 minecraft-frannce.fr
127.0.0.1 minecraftfrance.fr
127.0.0.1 minecraftr.fr
127.0.0.1 minecraftt.fr
127.0.0.1 minefieald.fr
127.0.0.1 minemytraffic.com
127.0.0.1 minence.fr
127.0.0.1 minencraft.fr
127.0.0.1 miner.pr0gramm.com
127.0.0.1 minero-proxy-01.now.sh
127.0.0.1 minero-proxy-02.now.sh
127.0.0.1 minero-proxy-03.now.sh
127.0.0.1 minero.pw
127.0.0.1 minr.pw
127.0.0.1 mipay.fr
127.0.0.1 mipsa.ciae.ac.cn
127.0.0.1 mirillis.fr
127.0.0.1 missdiva.fr
127.0.0.1 missetam.fr
127.0.0.1 mk.wiremanse.hair
127.0.0.1 mlefigaro.fr
127.0.0.1 mlpoo11-secondary.z13.web.core.windows.net
127.0.0.1 mn.mn.co.cu
127.0.0.1 mnecraft.fr
127.0.0.1 mnutan.fr
127.0.0.1 mobevo.fr
127.0.0.1 mobile.parkandpay-ca.com
127.0.0.1 mobilesoft.fr
127.0.0.1 mobpushup.com
127.0.0.1 moddb.fr
127.0.0.1 mojn.com
127.0.0.1 momatyn.store
127.0.0.1 momentspa.fr
127.0.0.1 mon-conertisseur.fr
127.0.0.1 monbureaunumeriques.fr
127.0.0.1 moncialrelay.fr
127.0.0.1 mondespersistants.fr
127.0.0.1 mondialrealy.fr
127.0.0.1 mondiarelay.fr
127.0.0.1 moneuvre.fr
127.0.0.1 monkeyball.osa.pl
127.0.0.1 monopris.fr
127.0.0.1 monppaiement.fr
127.0.0.1 montig.fr
127.0.0.1 morning-croissant.fr
127.0.0.1 motoetloisir.fr
127.0.0.1 movies.701pages.com
127.0.0.1 moviestarpllanet.fr
127.0.0.1 movvx.accunit.cfd
127.0.0.1 mp3red.cc
127.0.0.1 mpappy.fr
127.0.0.1 mr-ginseng.fr
127.0.0.1 ms-shoponline.top
127.0.0.1 ms-shopplus.su
127.0.0.1 mshelp247.weebly.com
127.0.0.1 msssante.fr
127.0.0.1 msx.lumena.cfd
127.0.0.1 mughal.sobiratel.info
127.0.0.1 mundilite.fr
127.0.0.1 murcia-ban.es
127.0.0.1 musculaation.fr
127.0.0.1 muttuelle.fr
127.0.0.1 muwuo.comfortykive.xyz
127.0.0.1 mv0129.stream
127.0.0.1 mvspjwd.com
127.0.0.1 mx1.freemail.ne.jp
127.0.0.1 mybancoschiles.gets-it.net
127.0.0.1 mycaal.fr
127.0.0.1 mycnal.fr
127.0.0.1 mydreamday.fr
127.0.0.1 myedebred.fr
127.0.0.1 myhst2024.com
127.0.0.1 mylike.co.uk				# Facebook trojan
127.0.0.1 myornamenti.com
127.0.0.1 myprivateemails.com
127.0.0.1 myquiz.fr
127.0.0.1 myrogers-dashboard-signin.net
127.0.0.1 mytee.fr
127.0.0.1 mywifiext.fr
127.0.0.1 n1up.fr
127.0.0.1 nactx.com
127.0.0.1 naissaance.fr
127.0.0.1 nakshatra.northeastrail.info
127.0.0.1 nameketathar.pro
127.0.0.1 nantesmetrople.fr
127.0.0.1 nantilus.fr
127.0.0.1 natashyabaydesign.com
127.0.0.1 nathna.fr
127.0.0.1 naturephotographie.fr
127.0.0.1 nauf.fr
127.0.0.1 navegador.oi.com.br
127.0.0.1 navegador.telefonica.com.br
127.0.0.1 nbtp1.sa.com
127.0.0.1 ncore.ink
127.0.0.1 ncorecc.me
127.0.0.1 ncoremeghivo.net
127.0.0.1 ncsf.fr
127.0.0.1 ndl1pp1-a-fixed.sancharnet.in
127.0.0.1 neaclub.fr
127.0.0.1 needlepoint.fr
127.0.0.1 neko-scan.fr
127.0.0.1 neon-genesis-evangelion-online.fr
127.0.0.1 neowordprss.fr
127.0.0.1 netflix-memberships.com
127.0.0.1 netflix-updateinfo.com
127.0.0.1 netflix.apple-green.net
127.0.0.1 netflixca-updateprofilehelp.com
127.0.0.1 netflixe.kundensupport-kundensupport.de
127.0.0.1 new-ramboplay.com
127.0.0.1 new-vid-zone-1.blogspot.com.au
127.0.0.1 newouest.fr
127.0.0.1 newsmagic.net
127.0.0.1 newsquest.fr
127.0.0.1 nextbitcorp.com
127.0.0.1 nguyennghi.info
127.0.0.1 niche247.trade
127.0.0.1 nikeinc.fr
127.0.0.1 nimes-olympique.fr
127.0.0.1 nitricbast.shop
127.0.0.1 nnavigo.fr
127.0.0.1 noella-voyance.fr
127.0.0.1 nosdeoirs.fr
127.0.0.1 notepad2.com
127.0.0.1 novemberrainx.com
127.0.0.1 ns.cac.com.cn
127.0.0.1 ns.nint.ac.cn
127.0.0.1 ns1.multi.net.pk
127.0.0.1 ns1.webwise.org
127.0.0.1 ns2.webwise.org
127.0.0.1 ns2.xidian.edu.cn
127.0.0.1 nt.new-cars.com.es
127.0.0.1 ntralpenedhy.pro
127.0.0.1 nuclandary.qnfbfs.cn
127.0.0.1 nuitphilo-ens.fr
127.0.0.1 oclopes.fr
127.0.0.1 oechestra.fr
127.0.0.1 of3d.fr
127.0.0.1 ofdb.fr
127.0.0.1 office.officenet.co.kr
127.0.0.1 ofracosmetics.fr
127.0.0.1 ois.is
127.0.0.1 oix.com
127.0.0.1 oix.net
127.0.0.1 oj.likewut.net
127.0.0.1 okidata.fr
127.0.0.1 old.umcl.us
127.0.0.1 onclickprediction.com
127.0.0.1 ondialrelay.fr
127.0.0.1 onemanga.fr
127.0.0.1 onepager.fr
127.0.0.1 onilne.fr
127.0.0.1 online.analytiks.click
127.0.0.1 onlinewebfind.com
127.0.0.1 onyxboox.fr
127.0.0.1 oolo.fr
127.0.0.1 ooutube.fr
127.0.0.1 opcwdns.opcw.nl
127.0.0.1 openais.maricosnc.it
127.0.0.1 openinternetexchange.com
127.0.0.1 openinternetexchange.net
127.0.0.1 openoverflow.com
127.0.0.1 optionmodifycanitem.info
127.0.0.1 orange.npix.net
127.0.0.1 orangemali.fr
127.0.0.1 orangf.fr
127.0.0.1 orbit.benchmarx.info
127.0.0.1 ordersildenafil.com
127.0.0.1 ordremek.fr
127.0.0.1 orientationpour-tous.fr
127.0.0.1 orion.platino.gov.ve
127.0.0.1 orner.fr
127.0.0.1 orowy.comfortykive.xyz
127.0.0.1 ortange.fr
127.0.0.1 osonscomprendre.fr
127.0.0.1 osqa.com
127.0.0.1 osqa.net
127.0.0.1 ostalgie.fr
127.0.0.1 otsserver.com
127.0.0.1 outerinfo.com
127.0.0.1 ownpathway.digital
127.0.0.1 oyrfo.comfortykive.xyz
127.0.0.1 p.algovid.com
127.0.0.1 p.ttwitter.com
127.0.0.1 pa-voyance.fr
127.0.0.1 paalp.fr
127.0.0.1 pages-annuaire.fr
127.0.0.1 pages-perso-orange.fr
127.0.0.1 pagesjauenes.fr
127.0.0.1 pagesperso-ortange.fr
127.0.0.1 paincake.yoll.net
127.0.0.1 paintnet.es
127.0.0.1 paintnet.fr
127.0.0.1 pamini.fr
127.0.0.1 panimi.fr
127.0.0.1 pantaya.fr
127.0.0.1 paradise.homemortgageblog.info
127.0.0.1 paris-banlieue-meetinggame.fr
127.0.0.1 passport.acla.org.cn
127.0.0.1 passportindex.fr
127.0.0.1 payments-details.com
127.0.0.1 payplintelverify3.site
127.0.0.1 paysdepieces.fr
127.0.0.1 paytel.fr
127.0.0.1 paytrtrollsteamworkspace.myclickfunnels.com
127.0.0.1 pbworks.fr
127.0.0.1 pc-apps-kaiyunsports.com
127.0.0.1 pcblibraries.fr
127.0.0.1 pckgatups.bond
127.0.0.1 pclt.net
127.0.0.1 pdns.nudt.edu.cn
127.0.0.1 pearlfeet.fr
127.0.0.1 peircing-street.fr
127.0.0.1 penseedepascal.fr
127.0.0.1 peomod.fr
127.0.0.1 peoplefinders.fr
127.0.0.1 percantil.fr
127.0.0.1 peremiere.fr
127.0.0.1 perfecct.sa.com
127.0.0.1 petra.nic.gov.jo
127.0.0.1 pexkr.comfortykive.xyz
127.0.0.1 pfepfe.cc
127.0.0.1 phising-initiative.fr
127.0.0.1 phorm.ch
127.0.0.1 phorm.co.uk
127.0.0.1 phorm.com
127.0.0.1 phorm.dk
127.0.0.1 phormchina.com
127.0.0.1 phormlabs.com
127.0.0.1 phpancake.com
127.0.0.1 pianolessons.fr
127.0.0.1 picture-uploads.com
127.0.0.1 pidoco.fr
127.0.0.1 piecediscount24.fr
127.0.0.1 pier-import.fr
127.0.0.1 pigredoben12.sytes.net
127.0.0.1 pigu.accbacknow.cfd
127.0.0.1 pillowpets.fr
127.0.0.1 pkia.fr
127.0.0.1 plagtracker.fr
127.0.0.1 plains.fr
127.0.0.1 planetside2.fr
127.0.0.1 planrecanpost1.info
127.0.0.1 plasticker.fr
127.0.0.1 platinmods.fr
127.0.0.1 playbaspresse.fr
127.0.0.1 playmobill.fr
127.0.0.1 playstogether.live
127.0.0.1 playzee.fr
127.0.0.1 plusjamaisdacne.fr
127.0.0.1 pocoty.fr
127.0.0.1 poemhunter.fr
127.0.0.1 poetryfoundation.fr
127.0.0.1 poetsofthefall.fr
127.0.0.1 pointerpointer.fr
127.0.0.1 polelemploi.fr
127.0.0.1 politiquemania.fr
127.0.0.1 poolin.fr
127.0.0.1 poonstwifterspick.work
127.0.0.1 portdusoleil.fr
127.0.0.1 posicionamientonatural.es
127.0.0.1 post-canada-delivery2023.com
127.0.0.1 post-canada-reschedule2024.com
127.0.0.1 post.mil-gov.space
127.0.0.1 postbox.mos.ru
127.0.0.1 postcanada.ship-express.info
127.0.0.1 postcanada.ship-priority.info
127.0.0.1 postecan-canpost.confrm942.link
127.0.0.1 postecan-canpost.updt491.link
127.0.0.1 postis.fr
127.0.0.1 poundporter.best
127.0.0.1 poweroff.pt
127.0.0.1 powertrfic.fr
127.0.0.1 ppoi.org
127.0.0.1 ppures.shop
127.0.0.1 pr-wealth.in
127.0.0.1 predictiondisplay.com
127.0.0.1 predictivadnetwork.com
127.0.0.1 premium-live-scan.com
127.0.0.1 premiumvideoupdates.com
127.0.0.1 pressealgerei.fr
127.0.0.1 pressesdesciences-po.fr
127.0.0.1 pressmedieda.info
127.0.0.1 prfcttit.za.com
127.0.0.1 priosante.fr
127.0.0.1 private-sportshop.fr
127.0.0.1 prk.roverinvolv.bid
127.0.0.1 pro-accesssoires.fr
127.0.0.1 probikesshop.fr
127.0.0.1 proclickpacket.com
127.0.0.1 profileconfirm.info
127.0.0.1 profilenetflix.com
127.0.0.1 profilenotice.info
127.0.0.1 profit-btc.org
127.0.0.1 proflashdata.com			# Facebook trojan
127.0.0.1 proidees.fr
127.0.0.1 projectpoi.com
127.0.0.1 promogrim.fr
127.0.0.1 promojustforyou.click
127.0.0.1 propitea.fr
127.0.0.1 propk.sa.com
127.0.0.1 provence-ouyillage.fr
127.0.0.1 provenfeedback.com
127.0.0.1 psycho-test.fr
127.0.0.1 ptagercity.fr
127.0.0.1 pub-251d6c694a0641dd9e95aeca9e3219e8.r2.dev
127.0.0.1 pullipstyle.fr
127.0.0.1 puppygames.fr
127.0.0.1 puppylover.fr
127.0.0.1 purchasingpower.fr
127.0.0.1 purepods.fr
127.0.0.1 pvt2202--deab86120ff311f1b0c142dde27851f2.web.val.run
127.0.0.1 qbittorrent.com
127.0.0.1 qdssy.balistrera.sbs
127.0.0.1 qevia.doubleclick.bond
127.0.0.1 qfsya.comfortykive.xyz
127.0.0.1 qouv.fr
127.0.0.1 quaidesbulles.fr
127.0.0.1 question2answer.com
127.0.0.1 questrade-pypip.com
127.0.0.1 quickchess.fr
127.0.0.1 quicksaledeal.su
127.0.0.1 quirinale.fr
127.0.0.1 qyh.co.ua
127.0.0.1 racingfamilyvillage.com
127.0.0.1 radio42.fr
127.0.0.1 randki-sex.com
127.0.0.1 rapid-glade-cde8.asoumare042024.workers.dev
127.0.0.1 raptp.fr
127.0.0.1 rb-on1in-sec.com
127.0.0.1 rbc-anth-ogrn.com
127.0.0.1 rbc-clientsupport1.com
127.0.0.1 reacherinst.com
127.0.0.1 realstar.fr
127.0.0.1 recettes-vegetariennes.fr
127.0.0.1 recevoirlatntn.fr
127.0.0.1 recover-subscription.com
127.0.0.1 redeastbay.com
127.0.0.1 redelivauthcentre.com
127.0.0.1 redelivercadpost.com
127.0.0.1 redelivtls.online
127.0.0.1 redf.fr
127.0.0.1 redircpapp.co.za
127.0.0.1 redline-boutique.fr
127.0.0.1 redrocks.fr
127.0.0.1 reductions-impots.fr
127.0.0.1 refund-int3rac.com
127.0.0.1 regclassboard.com
127.0.0.1 reliezvous.fr
127.0.0.1 renacious.nwwadq.cn
127.0.0.1 renov-landes.fr
127.0.0.1 rentacars.fr
127.0.0.1 rentamotorcycle.fr
127.0.0.1 resetcibc-logincibc.com
127.0.0.1 residence.bunkerhilltradingco.info
127.0.0.1 reskins.fr
127.0.0.1 restriia.shop
127.0.0.1 resulabi.fr
127.0.0.1 resultatspmu.fr
127.0.0.1 resumekeeper.com
127.0.0.1 retaildetail.fr
127.0.0.1 retrofuture.fr
127.0.0.1 return2025costco.com
127.0.0.1 rev-cvnada-dep.com
127.0.0.1 rezeptwelt.fr
127.0.0.1 rgp-ign.fr
127.0.0.1 rickrolling.com
127.0.0.1 rifec.co
127.0.0.1 rimnow.fr
127.0.0.1 ringcleas.sa.com
127.0.0.1 riosaladohp.com
127.0.0.1 robertgraham.fr
127.0.0.1 rockrose.fr
127.0.0.1 rocks.io
127.0.0.1 rockthebretzel.fr
127.0.0.1 rogers-wirelessphone.com
127.0.0.1 roivant.fr
127.0.0.1 rojadirectatv.fr
127.0.0.1 romdiscover.com
127.0.0.1 rootbuzz.com
127.0.0.1 rottentomatoes.fr
127.0.0.1 rrg2mrb.matchwomanreal.com
127.0.0.1 rrtougao.com
127.0.0.1 rtag.fr
127.0.0.1 rubgyrama.fr
127.0.0.1 ruchika29access55824.acemlna.com
127.0.0.1 runnerswolrd.fr
127.0.0.1 runtnc.net
127.0.0.1 russian-sex.com
127.0.0.1 ryther.fr
127.0.0.1 s.pubmine.com
127.0.0.1 s3-ap-southeast-1-amazonaws.com
127.0.0.1 s3-ap-southeast-2-amazonaws.com
127.0.0.1 s4d.in
127.0.0.1 safes.ru.com
127.0.0.1 saicmotor.fr
127.0.0.1 sajour.fr
127.0.0.1 salebestever.su
127.0.0.1 salezone.sa.com
127.0.0.1 sanbuzs.com
127.0.0.1 santanderbank.fr
127.0.0.1 saouryadi.in
127.0.0.1 sartoriz.fr
127.0.0.1 sbh9hu4trk.com
127.0.0.1 scei-concour.fr
127.0.0.1 schlaukopf.fr
127.0.0.1 sciencesetlavenir.fr
127.0.0.1 scoietegenerale.fr
127.0.0.1 scotiahelp-loginscotia.com
127.0.0.1 scotiaonline-verification.com
127.0.0.1 scottishstuff-online.com	# Canadian bank phishing site
127.0.0.1 scr-jiebaoscore.com
127.0.0.1 screenaddict.thewhizproducts.com
127.0.0.1 screencast-o-matic.fr
127.0.0.1 scribbens.fr
127.0.0.1 scribe.ttwitter.com
127.0.0.1 scure-royaibamk.com
127.0.0.1 scwharzkopf.fr
127.0.0.1 scyxj.comfortykive.xyz
127.0.0.1 sea.net.edu.cn
127.0.0.1 search.buzzdock.com
127.0.0.1 search.conduit.com
127.0.0.1 search.privitize.com
127.0.0.1 secret.xn--oogle-wmc.com
127.0.0.1 secretosdelagua.fr
127.0.0.1 secure-accept-e-transfer-interac.info
127.0.0.1 secure-fidosolutions.com
127.0.0.1 secure-royaibnk.com
127.0.0.1 securedeposit-et.com
127.0.0.1 securielite.com
127.0.0.1 security.schwab-5.click
127.0.0.1 securityscan.us
127.0.0.1 seebox.fr
127.0.0.1 seeques.com
127.0.0.1 seezeit.fr
127.0.0.1 segob.gob.mx
127.0.0.1 selarbiosites.fr
127.0.0.1 selfhtml.fr
127.0.0.1 seniului.v6.navy
127.0.0.1 sensahome.fr
127.0.0.1 sephor.fr
127.0.0.1 serff.fr
127.0.0.1 serv-canada2024.com
127.0.0.1 servpro.fr
127.0.0.1 setup-mydelivery-date6437-fedex.com
127.0.0.1 sgluco.shop
127.0.0.1 shapado.com
127.0.0.1 sharelink.fr
127.0.0.1 shiiva.fr
127.0.0.1 shoalike.fr
127.0.0.1 shop-pharmaccie.fr
127.0.0.1 shop.skin-safety.com
127.0.0.1 shopfix.fr
127.0.0.1 shopigo.fr
127.0.0.1 shopkeep.fr
127.0.0.1 shopsm.fr
127.0.0.1 shoptrends.fr
127.0.0.1 shrsgame.com
127.0.0.1 siexrlypbbvt.com
127.0.0.1 sig.tecnologicosucre.edu.ec
127.0.0.1 siliconf.fr
127.0.0.1 sinera.org
127.0.0.1 sinochem.fr
127.0.0.1 sinu24.de
127.0.0.1 sinu24.ee
127.0.0.1 siteliner.fr
127.0.0.1 sitesofa.za.com
127.0.0.1 sitrion.fr
127.0.0.1 sjgoodandcompany.com
127.0.0.1 slavyangrad.fr
127.0.0.1 slideboc.fr
127.0.0.1 sllate.fr
127.0.0.1 smartcart.fr
127.0.0.1 smicaval.fr
127.0.0.1 smile-angel.com
127.0.0.1 smosh.fr
127.0.0.1 snscf.fr
127.0.0.1 sociagil.fr
127.0.0.1 societegernerale.fr
127.0.0.1 societergenerale.fr
127.0.0.1 sofaglobal.best
127.0.0.1 sofia.whatcaniseeinkiev.info
127.0.0.1 software-updates.co
127.0.0.1 software-wenc.co.cc
127.0.0.1 soidog.fr
127.0.0.1 solarswitch4all.com
127.0.0.1 solarwindow.fr
127.0.0.1 soloprodottiitaliani.fr
127.0.0.1 soluclim.fr
127.0.0.1 solutionscore.com
127.0.0.1 solveseek.com
127.0.0.1 sonatns.sonatrach.dz
127.0.0.1 songsar.com
127.0.0.1 soniksports.fr
127.0.0.1 soports.fr
127.0.0.1 sorbone.fr
127.0.0.1 sosohus.ink
127.0.0.1 speakplanet.fr
127.0.0.1 specialworld.com.au
127.0.0.1 speechpad.fr
127.0.0.1 speedycourse.fr
127.0.0.1 spotchannel02.com
127.0.0.1 srothuynguyen.com
127.0.0.1 ssephora.fr
127.0.0.1 stackoverflow.xyz
127.0.0.1 star-iptv.fr
127.0.0.1 starbuckssurvey.life
127.0.0.1 startmarket.su
127.0.0.1 stationpack.de
127.0.0.1 statutorjuihui.site
127.0.0.1 stay.decentralappps.com
127.0.0.1 steelbitepro24.com
127.0.0.1 stellarium.fr
127.0.0.1 steveberry.fr
127.0.0.1 stilnovo.fr
127.0.0.1 stopphoulplay.com
127.0.0.1 strategies360.fr
127.0.0.1 strrget.za.com
127.0.0.1 stswen.fr
127.0.0.1 studywithab.com
127.0.0.1 subcreation.fr
127.0.0.1 suddenplot.com
127.0.0.1 suenosurcolchones.com.ar.abakotest.com.ar
127.0.0.1 suicidaltendencies.fr
127.0.0.1 sumofus.fr
127.0.0.1 sunhe.jinr.ru
127.0.0.1 suocietegenerale.fr
127.0.0.1 supernaturalart.com
127.0.0.1 survarium.fr
127.0.0.1 susm0q6jys.com
127.0.0.1 sussi.cressoft.com.pk
127.0.0.1 suxap.comfortykive.xyz
127.0.0.1 suzukiauto.fr
127.0.0.1 sverd.net
127.0.0.1 swflightinfo.bond
127.0.0.1 swiftype.fr
127.0.0.1 swisslide.fr
127.0.0.1 sxthxf.com
127.0.0.1 sybonymo.fr
127.0.0.1 syngeta.fr
127.0.0.1 synthroid.fr
127.0.0.1 systadin.fr
127.0.0.1 systematixinfotech.fr
127.0.0.1 szfr.fr
127.0.0.1 tahoesup.com
127.0.0.1 tanieaukcje.com
127.0.0.1 taniezakupy.pl
127.0.0.1 taotaolm.com
127.0.0.1 tarbosau.bbqpitcleaners.info
127.0.0.1 tattooshaha.info			# Facebook trojan
127.0.0.1 tax-canada2023.co
127.0.0.1 tbebestknives.fr
127.0.0.1 teak.gen.tr
127.0.0.1 teamsport-philipp.fr
127.0.0.1 tearbelt.com
127.0.0.1 technicalconsumerreports.com
127.0.0.1 technocite.fr
127.0.0.1 technoit.fr
127.0.0.1 techques.com
127.0.0.1 telephone-voyance.fr
127.0.0.1 telephoner-voyance.fr
127.0.0.1 telpay.fr
127.0.0.1 tenispro.fr
127.0.0.1 terricole.fr
127.0.0.1 test.gutir.ru
127.0.0.1 test.ishvara-yoga.com
127.0.0.1 testbook.fr
127.0.0.1 textbrokr.fr
127.0.0.1 textion.g9y18u.cn
127.0.0.1 thailandtravel.live
127.0.0.1 thainationalparks.fr
127.0.0.1 thalasur.fr
127.0.0.1 thebestknifes.fr
127.0.0.1 thebestone.click
127.0.0.1 thebestwebpillplace.com
127.0.0.1 thechive.fr
127.0.0.1 thedatesafe.com			# Facebook trojan
127.0.0.1 themusicnetwork.co.uk
127.0.0.1 thenewswire.fr
127.0.0.1 thesimsresource.fr
127.0.0.1 thetorrentz.fr
127.0.0.1 thickporter.sa.com
127.0.0.1 thislocalhost.com
127.0.0.1 thisone.online
127.0.0.1 thomasmore.fr
127.0.0.1 thunderbird.es
127.0.0.1 tibs.fr
127.0.0.1 ticketforchange.fr
127.0.0.1 ticketpayfee.com
127.0.0.1 ticketspy.fr
127.0.0.1 tiku.io
127.0.0.1 timberlande.fr
127.0.0.1 tip-leisusports.com
127.0.0.1 tiplanet.fr
127.0.0.1 tlio.forskningsnytt.info
127.0.0.1 tnews.day
127.0.0.1 toknowall.com
127.0.0.1 tomorrownewstoday.com	# I'm not sure what it does, but it seems to be associated with a phishing attempt on Facebook
127.0.0.1 toppillstore.com
127.0.0.1 toprxshopplace.com
127.0.0.1 topshoponline.ru
127.0.0.1 toptypeonlinetheclicks.icu
127.0.0.1 torjackan.info
127.0.0.1 totaldebrid.fr
127.0.0.1 tourismelenslievin.fr
127.0.0.1 tr-red.lamanoqueayuda.org
127.0.0.1 tradedealvip.su
127.0.0.1 tradeinn.fr
127.0.0.1 traffic-bam.link
127.0.0.1 traffic.adwitty.com
127.0.0.1 tranisere.fr
127.0.0.1 trauiqce.click
127.0.0.1 trevia.za.com
127.0.0.1 trifama.com
127.0.0.1 trioadvisor.fr
127.0.0.1 trk.arenachat.xyz
127.0.0.1 trk.wizzdeal.trade
127.0.0.1 trouveunfilm.fr
127.0.0.1 trovi.com
127.0.0.1 truecrypt.fr
127.0.0.1 trusturl.top
127.0.0.1 tubero.ellystegge.info
127.0.0.1 tubr8.fr
127.0.0.1 tuniaf.com
127.0.0.1 turfomani.fr
127.0.0.1 tv-jiangnantiyu.com
127.0.0.1 tvshowslist.com
127.0.0.1 tweetdeck.fr
127.0.0.1 twitchindoor.best
127.0.0.1 twitpic.fr
127.0.0.1 tx.micro.net.pk
127.0.0.1 tx2returnhome.com
127.0.0.1 typewriter.fr
127.0.0.1 tyyvps.com
127.0.0.1 tzmqyj.com
127.0.0.1 u-pssud.fr
127.0.0.1 ua-consumerpanel.frge.io
127.0.0.1 ubuntu-fr.fr
127.0.0.1 udgth.comfortykive.xyz
127.0.0.1 ufpcdn.com
127.0.0.1 ui.chelepi.contractors
127.0.0.1 umgpjdlllhl.ru
127.0.0.1 un-ruly.fr
127.0.0.1 unetbootin.net
127.0.0.1 unetbootin.org
127.0.0.1 uni-littoral.fr
127.0.0.1 uniguide.fr
127.0.0.1 unitdotto.club
127.0.0.1 united-domaine.tech
127.0.0.1 univ-murs.fr
127.0.0.1 univ-paris-didero.fr
127.0.0.1 univ-pars1.fr
127.0.0.1 univ6lehavre.fr
127.0.0.1 univevry.fr
127.0.0.1 unme-asso.fr
127.0.0.1 unodieuxconnard.fr
127.0.0.1 update-expiry-notification-report.appwrite.network
127.0.0.1 updateauto.preparevideosafesystem4unow.space
127.0.0.1 uqz.com
127.0.0.1 urbact.fr
127.0.0.1 url3781.host.inreception.com
127.0.0.1 url9810.tokocrypto.com
127.0.0.1 urssff.fr
127.0.0.1 urzl.fr
127.0.0.1 usbf.fr
127.0.0.1 usdeeds.acemlna.com
127.0.0.1 users16.jabry.com
127.0.0.1 usoasopersbe.xyz
127.0.0.1 ut1-capitole.fr
127.0.0.1 ut1capitole.fr
127.0.0.1 utauniv-lyon2.fr
127.0.0.1 utenti.lycos.it
127.0.0.1 utrace.fr
127.0.0.1 van-city-sign-on.com
127.0.0.1 vc-login.com
127.0.0.1 vcarrefour.fr
127.0.0.1 vendhelpuous.pgvjmp.cn
127.0.0.1 venturead.com
127.0.0.1 verify.rambler-profile.site
127.0.0.1 versbaudet.fr
127.0.0.1 vfzzs.comfortykive.xyz
127.0.0.1 vgsnf.comfortykive.xyz
127.0.0.1 vi-improved.org
127.0.0.1 viad.fr
127.0.0.1 videoamp.com
127.0.0.1 videofitness.fr
127.0.0.1 videovor.fr
127.0.0.1 vieques.fr
127.0.0.1 viessman.fr
127.0.0.1 vietnamdiscovery.fr
127.0.0.1 viglink.fr
127.0.0.1 villepariis.fr
127.0.0.1 vinoscout.fr
127.0.0.1 vins-bourgorne.fr
127.0.0.1 viowyf.khaiafi.com
127.0.0.1 vip.fortunatetime.xyz
127.0.0.1 vipon.fr
127.0.0.1 virewin.com
127.0.0.1 viriginradio.fr
127.0.0.1 visana.fr
127.0.0.1 visualsonics.fr
127.0.0.1 vitemadose.fr
127.0.0.1 vivalife.fr
127.0.0.1 vivgilance.fr
127.0.0.1 vjpwe.comfortykive.xyz
127.0.0.1 vlc.de
127.0.0.1 voiciu.fr
127.0.0.1 voil-le-travail.fr
127.0.0.1 voipwise.fr
127.0.0.1 volksvagen.fr
127.0.0.1 volkswagens.fr
127.0.0.1 vs-wending.com
127.0.0.1 vxiframe.biz
127.0.0.1 w3facility.org
127.0.0.1 wagsandwhiskers.fr
127.0.0.1 wahm.fr
127.0.0.1 wait3sec.org
127.0.0.1 waldenfarms.com
127.0.0.1 wanadzoo.fr
127.0.0.1 wanatoo.fr
127.0.0.1 watch-netfiix.com
127.0.0.1 watchpro.fr
127.0.0.1 waterstudio.fr
127.0.0.1 waudeesestew.com
127.0.0.1 wealthsimple-dwvip.com
127.0.0.1 weapfuh.originalriver-tone.top
127.0.0.1 web.almestin.ru
127.0.0.1 webassembly.stream
127.0.0.1 webatic.fr
127.0.0.1 webmail.grahachemical.co.id
127.0.0.1 webmedic.fr
127.0.0.1 webnetra.entelnet.bo
127.0.0.1 webpaypal.com
127.0.0.1 webserv.mos.ru
127.0.0.1 webwikis.fr
127.0.0.1 webwise.com
127.0.0.1 webwise.net
127.0.0.1 webwise.org
127.0.0.1 weddinglovers.pl
127.0.0.1 wenda.io
127.0.0.1 west.05tz2e9.com
127.0.0.1 westerdayeol.site
127.0.0.1 wetter24.fr
127.0.0.1 wewillrocknow.com
127.0.0.1 wfflxx.com
127.0.0.1 whiscas.fr
127.0.0.1 whiteenamel.fr
127.0.0.1 whqxzx.com
127.0.0.1 wikidevs.com
127.0.0.1 wileprefgurad.net
127.0.0.1 willysy.com
127.0.0.1 winns.fr
127.0.0.1 with-anbo.com
127.0.0.1 wizzshop.trade
127.0.0.1 wk4x5rdtoz2tn0.com
127.0.0.1 wnathan.fr
127.0.0.1 wolverineworldwide.fr
127.0.0.1 woodplans.sa.com
127.0.0.1 worldcommunitygrid.fr
127.0.0.1 worldwidefestival.fr
127.0.0.1 wpad # For reference: https://www.youtube.com/watch?v=uwsykPWa5Lc
127.0.0.1 wpcgt.comfortykive.xyz
127.0.0.1 wrontonshatbona.pro
127.0.0.1 ws05.crypto-loot.com
127.0.0.1 ws06.crypto-loot.com
127.0.0.1 ws07.crypto-loot.com
127.0.0.1 ws08.crypto-loot.com
127.0.0.1 ws09.crypto-loot.com
127.0.0.1 ws23.crypto-loot.com
127.0.0.1 ws24.crypto-loot.com
127.0.0.1 ws25.crypto-loot.com
127.0.0.1 ws42.crypto-loot.com
127.0.0.1 ws48.crypto-loot.com
127.0.0.1 ws49.crypto-loot.com
127.0.0.1 ws50.crypto-loot.com
127.0.0.1 wwnc.xyz
127.0.0.1 www.316ee.com
127.0.0.1 www.7zip.fr
127.0.0.1 www.991abc.com
127.0.0.1 www.a2uu36g43l.download
127.0.0.1 www.aagofwi.com
127.0.0.1 www.aaringtone.com
127.0.0.1 www.abetterinternet.com
127.0.0.1 www.abnehmenkabofit.de
127.0.0.1 www.aconchoe.com
127.0.0.1 www.activetrap.com
127.0.0.1 www.adacoustics.com
127.0.0.1 www.adblock.fr
127.0.0.1 www.adselector.com
127.0.0.1 www.adshufffle.com
127.0.0.1 www.aerodriftcore.uk
127.0.0.1 www.agreementnow.com
127.0.0.1 www.airmedcarennetwork.com
127.0.0.1 www.airybotsh.pro
127.0.0.1 www.airypathsq.name
127.0.0.1 www.akundu.com
127.0.0.1 www.alexyastro.com
127.0.0.1 www.alittlelewd.com
127.0.0.1 www.allhqpics.com			# Facebook trojan
127.0.0.1 www.allscrabble.com
127.0.0.1 www.allstateproteectionplans.com
127.0.0.1 www.allusermanual.com
127.0.0.1 www.altunyapimarket.com
127.0.0.1 www.amerenallieshvac.com
127.0.0.1 www.americanresortresolutions.com
127.0.0.1 www.amintart.com
127.0.0.1 www.amomales.com
127.0.0.1 www.anatol.com
127.0.0.1 www.anyik.com
127.0.0.1 www.apcort.com
127.0.0.1 www.apkfuuny.com
127.0.0.1 www.aqualakefy.name
127.0.0.1 www.aramcom.space
127.0.0.1 www.arfrepuestos.com
127.0.0.1 www.arknasasbluecross.com
127.0.0.1 www.artdualdesign.com
127.0.0.1 www.asianread.com
127.0.0.1 www.assistdocklane.uk
127.0.0.1 www.atightschedule.com
127.0.0.1 www.audacity.es
127.0.0.1 www.audacity.fr
127.0.0.1 www.audionoisereducer.com
127.0.0.1 www.auditprint.com
127.0.0.1 www.auto-runmz.com
127.0.0.1 www.autoinkoopbedrijf.com
127.0.0.1 www.availablefiles.com
127.0.0.1 www.avemoo.com
127.0.0.1 www.azureus.es
127.0.0.1 www.backingguitar.garden
127.0.0.1 www.bahartonu.com
127.0.0.1 www.baiakstyle.com
127.0.0.1 www.balassst.com
127.0.0.1 www.bandexperts.com
127.0.0.1 www.bankofcounty.com
127.0.0.1 www.barjacity.com
127.0.0.1 www.basealloys.com
127.0.0.1 www.baseequip.com
127.0.0.1 www.bayareafyuerzk.com
127.0.0.1 www.bazarusmassazha.com
127.0.0.1 www.bbyjgkkdihiyxy.com
127.0.0.1 www.bcwars.net
127.0.0.1 www.be4life.ru
127.0.0.1 www.behdja.com
127.0.0.1 www.bellamhair.com
127.0.0.1 www.bernoussiphone.com
127.0.0.1 www.bestlabour.com
127.0.0.1 www.bevisgame.com
127.0.0.1 www.bicyclefan.com
127.0.0.1 www.bigantstore.com
127.0.0.1 www.bigpremiere.com
127.0.0.1 www.blanknightsmfg.com
127.0.0.1 www.blazesemipvp.com
127.0.0.1 www.blender3d.fr
127.0.0.1 www.blogmaking.com
127.0.0.1 www.bloomifllowers.com
127.0.0.1 www.blueadvantagearkasas.com
127.0.0.1 www.bluecollarparanormal.com
127.0.0.1 www.blueridgecpp.com
127.0.0.1 www.bmrneswk.com
127.0.0.1 www.board-ly.com
127.0.0.1 www.bonuxsarrive.com
127.0.0.1 www.bookstadium.com
127.0.0.1 www.borocade.com
127.0.0.1 www.boysstrongly.living
127.0.0.1 www.brandsclothingco.com
127.0.0.1 www.breaksdown.lol
127.0.0.1 www.breakslavery.com
127.0.0.1 www.brghterimagelab.com
127.0.0.1 www.brightqz.com
127.0.0.1 www.brightstardv.pro
127.0.0.1 www.briidgeapp.com
127.0.0.1 www.briskappmu.name
127.0.0.1 www.briskshadeyv.com
127.0.0.1 www.brooksrunningdeals.com
127.0.0.1 www.bucahssana.com
127.0.0.1 www.builtinfo.com
127.0.0.1 www.bumerang.cc
127.0.0.1 www.bvcnle.cfd
127.0.0.1 www.cablyshaw.com
127.0.0.1 www.calmde.com
127.0.0.1 www.calmdockpb.name
127.0.0.1 www.calnanflack.com
127.0.0.1 www.cambonanza.com
127.0.0.1 www.camtory.com
127.0.0.1 www.canadianshawid.com
127.0.0.1 www.caothusohoc.com
127.0.0.1 www.caramail.com
127.0.0.1 www.careertake.com
127.0.0.1 www.carehigher.com
127.0.0.1 www.carolmassoterapia.com
127.0.0.1 www.casinorankerhub.com
127.0.0.1 www.casinostarluck.net
127.0.0.1 www.cassink.com
127.0.0.1 www.catabcde.com
127.0.0.1 www.catjre.com
127.0.0.1 www.celestia.es
127.0.0.1 www.celestia.fr
127.0.0.1 www.cemerhealth.com
127.0.0.1 www.centeralbidding.com
127.0.0.1 www.checkdrivers.com
127.0.0.1 www.checkpics.com
127.0.0.1 www.chelick.net			# Facebook trojan
127.0.0.1 www.chichomods.com
127.0.0.1 www.chiefsale.com
127.0.0.1 www.chinesehollywood.com
127.0.0.1 www.cidadelobito.com
127.0.0.1 www.ciderbayoulg.pro
127.0.0.1 www.ciderglowcm.site
127.0.0.1 www.cidersunjt.com
127.0.0.1 www.cjkassociates.co.in
127.0.0.1 www.claimedmoney.com
127.0.0.1 www.cleanvvlife.com
127.0.0.1 www.cleanvvmagic.com
127.0.0.1 www.clearacreonline.com
127.0.0.1 www.clearalgorithm.com
127.0.0.1 www.clickrents.com
127.0.0.1 www.clipsfan.com
127.0.0.1 www.clonezilla.es
127.0.0.1 www.clonezilla.fr
127.0.0.1 www.cloudverge.uk
127.0.0.1 www.clovercraftshop.com
127.0.0.1 www.clubplanning.com
127.0.0.1 www.coconutsport.com
127.0.0.1 www.coinimp.com
127.0.0.1 www.combinebasic.com
127.0.0.1 www.comfortykive.xyz
127.0.0.1 www.commuteinfo.com
127.0.0.1 www.compufixshop.com
127.0.0.1 www.conclusioncompeting.bond
127.0.0.1 www.conservativedeeper.garden
127.0.0.1 www.consultingbyelevate.com
127.0.0.1 www.continuedlincoln.bond
127.0.0.1 www.controlpop.com
127.0.0.1 www.cookoven.com
127.0.0.1 www.coolrextintshop.com
127.0.0.1 www.corlythra.uk
127.0.0.1 www.corvettiortho.com
127.0.0.1 www.courtneydowns.com
127.0.0.1 www.cpatglobal.com
127.0.0.1 www.cprcar.com
127.0.0.1 www.cqwallpaper.com
127.0.0.1 www.creativesaftysupply.com
127.0.0.1 www.crediainternational.com
127.0.0.1 www.crowdnestfun.com
127.0.0.1 www.crystalbranchtw.blog
127.0.0.1 www.ctlcai.com
127.0.0.1 www.dailyazure.com
127.0.0.1 www.dangdangflow.com
127.0.0.1 www.darkrro.com
127.0.0.1 www.dartya.com
127.0.0.1 www.dayanitastore.com
127.0.0.1 www.daytonjaxx.com
127.0.0.1 www.dealresponse.com
127.0.0.1 www.dealsrate.com
127.0.0.1 www.deashi.com
127.0.0.1 www.defailermu.com
127.0.0.1 www.dejamesertuvoz.com
127.0.0.1 www.dentistkids.com
127.0.0.1 www.deperiodista.com
127.0.0.1 www.desirymart.com
127.0.0.1 www.dewcoreaj.pro
127.0.0.1 www.dewwillowwj.site
127.0.0.1 www.diamondconnections.living
127.0.0.1 www.dictadosonline.com
127.0.0.1 www.didata.bw
127.0.0.1 www.diffuselec.com
127.0.0.1 www.digimininggame.com
127.0.0.1 www.digisubmission.com
127.0.0.1 www.digitalbigger.garden
127.0.0.1 www.digitalcoachpro.name
127.0.0.1 www.dkpmsa.cfd
127.0.0.1 www.dlinktour.com
127.0.0.1 www.dorminvaders.com
127.0.0.1 www.drivegoals.com
127.0.0.1 www.dualeotruyenno.com
127.0.0.1 www.duotrader.com
127.0.0.1 www.dustinjonesgolfacademy.com
127.0.0.1 www.dymor.cfd
127.0.0.1 www.dynamictyres.com
127.0.0.1 www.dzzzsc.com
127.0.0.1 www.e-transfer-cra.com
127.0.0.1 www.eaglesfanclub.com
127.0.0.1 www.eamazondigital.com
127.0.0.1 www.edashealthcare.com
127.0.0.1 www.edwardmartino.com
127.0.0.1 www.ekkekkocapital.com
127.0.0.1 www.elanactivewear.com
127.0.0.1 www.electrobell.com
127.0.0.1 www.eljaleomedellin.com
127.0.0.1 www.emailspend.com
127.0.0.1 www.energiazoque.com
127.0.0.1 www.eqarati.com
127.0.0.1 www.eremplacementparts.com
127.0.0.1 www.esjetonline.com
127.0.0.1 www.ethicsstore.com
127.0.0.1 www.europelinen.com
127.0.0.1 www.exactpharm.com
127.0.0.1 www.exambased.com
127.0.0.1 www.exceleratehelp.com
127.0.0.1 www.exoticainmotion.com
127.0.0.1 www.expolearn.com
127.0.0.1 www.exposhot.com
127.0.0.1 www.expressmails.com
127.0.0.1 www.exteriorteam.com
127.0.0.1 www.extrabrick.com
127.0.0.1 www.exvaro.cfd
127.0.0.1 www.faggotry.com
127.0.0.1 www.farmacyty.com
127.0.0.1 www.farnazinternational.com
127.0.0.1 www.fashiongown.com
127.0.0.1 www.feelimprove.bond
127.0.0.1 www.fenquavo.com
127.0.0.1 www.ferreteriamaracopa.com
127.0.0.1 www.fhtmmeeting.com
127.0.0.1 www.filezilla.fr
127.0.0.1 www.findalgorithm.com
127.0.0.1 www.findalign.com
127.0.0.1 www.findlobster.com
127.0.0.1 www.fingertimer.com
127.0.0.1 www.firsttrchfed.com
127.0.0.1 www.fischereszter.hu
127.0.0.1 www.fixedshine.com
127.0.0.1 www.fixingfast.com
127.0.0.1 www.flaglergrill.com
127.0.0.1 www.flexibleadmin.com
127.0.0.1 www.fluffyappyp.com
127.0.0.1 www.fluidfiber.com
127.0.0.1 www.flydrivenest.com
127.0.0.1 www.fmoviehd.com
127.0.0.1 www.forexhelps.com
127.0.0.1 www.forexwood.com
127.0.0.1 www.formalcenter.com
127.0.0.1 www.fortunoxx.com
127.0.0.1 www.francesportisas-fr.com
127.0.0.1 www.frbonusjeux.com
127.0.0.1 www.freeaquarium.com
127.0.0.1 www.freecontent.bid
127.0.0.1 www.freedailydownload.com
127.0.0.1 www.fripta.com
127.0.0.1 www.froling.bee.pl
127.0.0.1 www.funkycovers.com
127.0.0.1 www.furcomics.com
127.0.0.1 www.futuredecide.com
127.0.0.1 www.futureowned.com
127.0.0.1 www.gadgetbonanzamarket.com
127.0.0.1 www.gaicodon.com
127.0.0.1 www.gainwintz.com
127.0.0.1 www.gamelthae.com
127.0.0.1 www.gameltjae.com
127.0.0.1 www.gamemeltbe.com
127.0.0.1 www.gameqnt.com
127.0.0.1 www.gamersigns.com
127.0.0.1 www.gandiatv.com
127.0.0.1 www.gangtaylor.property
127.0.0.1 www.gavelandcap.com
127.0.0.1 www.gekkstoyou.com
127.0.0.1 www.gekorn.com
127.0.0.1 www.generaldocs.com
127.0.0.1 www.gentleshadeox.pro
127.0.0.1 www.getnexuscard.com
127.0.0.1 www.gezinti.com
127.0.0.1 www.ggdark.net
127.0.0.1 www.giadungnguyennhat.com
127.0.0.1 www.gildedrosens.name
127.0.0.1 www.gimp.es
127.0.0.1 www.glassygrovefy.pro
127.0.0.1 www.globalbuffer.com
127.0.0.1 www.goggle.com
127.0.0.1 www.goldendoodlez.com
127.0.0.1 www.goldentopics.com
127.0.0.1 www.gooddeserve.skin
127.0.0.1 www.googdiy.com
127.0.0.1 www.gotorobeks.com
127.0.0.1 www.gparted.fr
127.0.0.1 www.gpolitico.com
127.0.0.1 www.gracefulmeaduu.online
127.0.0.1 www.gradedoctortutoring.com
127.0.0.1 www.grandtables.com
127.0.0.1 www.greatdeposit.com
127.0.0.1 www.greenshot.fr
127.0.0.1 www.greenvistazj.pro
127.0.0.1 www.griffinlist.com
127.0.0.1 www.grocreyoutlet.com
127.0.0.1 www.groundofsuccess.com
127.0.0.1 www.grouphappy.com
127.0.0.1 www.growthbuilder.name
127.0.0.1 www.guaranteeservice.lat
127.0.0.1 www.hajoopteg.com
127.0.0.1 www.hakerzy.net
127.0.0.1 www.handbrake.es
127.0.0.1 www.happystonezk.pro
127.0.0.1 www.hardlyterrible.bond
127.0.0.1 www.hashing.win
127.0.0.1 www.hauloot.com
127.0.0.1 www.healthcompeting.rest
127.0.0.1 www.helvax.cfd
127.0.0.1 www.helvora.help
127.0.0.1 www.hiewa.com.my
127.0.0.1 www.higherteam.com
127.0.0.1 www.hindudirectory.com
127.0.0.1 www.hitchedbridalandformalwear.com
127.0.0.1 www.hits-football.com
127.0.0.1 www.hocxaydung.com
127.0.0.1 www.homininfossil.cfd
127.0.0.1 www.hotelsdetermine.bond
127.0.0.1 www.hotpanic.net
127.0.0.1 www.hoursales.com
127.0.0.1 www.hugesector.com
127.0.0.1 www.hunterspeed.com
127.0.0.1 www.hypeprop.com
127.0.0.1 www.hypetrust.com
127.0.0.1 www.icecars.com
127.0.0.1 www.icygrovejn.com
127.0.0.1 www.icyhivemy.name
127.0.0.1 www.iejonline.com
127.0.0.1 www.iepelnazareno.com
127.0.0.1 www.igameup.com
127.0.0.1 www.indexprofile.com
127.0.0.1 www.infopaypal.com
127.0.0.1 www.informecadastral.com
127.0.0.1 www.informereng.com
127.0.0.1 www.inkscape.es
127.0.0.1 www.inkscape.fr
127.0.0.1 www.inpicklenaton.com
127.0.0.1 www.instantcross.com
127.0.0.1 www.invitegame.com
127.0.0.1 www.iovenesweb.com
127.0.0.1 www.irony.world
127.0.0.1 www.iwantclothing.com
127.0.0.1 www.jackpotcasinojeux.com
127.0.0.1 www.janushnderson.com
127.0.0.1 www.jerseyoffers.com
127.0.0.1 www.jessicalonda.com
127.0.0.1 www.jeuxfortuna.com
127.0.0.1 www.jeuxjackpotcasino.com
127.0.0.1 www.jhsmiami.com
127.0.0.1 www.jnhjf.com
127.0.0.1 www.joinfx.net
127.0.0.1 www.jovareo.com
127.0.0.1 www.justdebug.com
127.0.0.1 www.jvidzaixian.com
127.0.0.1 www.jvzoo.com
127.0.0.1 www.kahramananas.com
127.0.0.1 www.karazah.com
127.0.0.1 www.keepass.com
127.0.0.1 www.keepass.fr
127.0.0.1 www.kencorporation.property
127.0.0.1 www.kesau.com
127.0.0.1 www.keybinary.com
127.0.0.1 www.khanomtour.com
127.0.0.1 www.kinderstampo.com
127.0.0.1 www.kindnations.com
127.0.0.1 www.kindwebdg.site
127.0.0.1 www.kittayaroyalbeauty.com
127.0.0.1 www.kiwicares.com
127.0.0.1 www.knowinteractive.com
127.0.0.1 www.knoxmenus.com
127.0.0.1 www.kobotausa.com
127.0.0.1 www.kpremium.com
127.0.0.1 www.kryzantor.uk
127.0.0.1 www.lacocinany.com
127.0.0.1 www.lahoreautismcentre.com
127.0.0.1 www.lanaita.com
127.0.0.1 www.langleyantiques.com
127.0.0.1 www.launchbuffer.com
127.0.0.1 www.learngears.com
127.0.0.1 www.learnnessy.com
127.0.0.1 www.learntechno.com
127.0.0.1 www.ledfaucetlight.com
127.0.0.1 www.leeucode.com
127.0.0.1 www.lemoncascadexq.name
127.0.0.1 www.libanco.com
127.0.0.1 www.lightcontest.com
127.0.0.1 www.lightstylist.com
127.0.0.1 www.likeportal.com			# Facebook trojan
127.0.0.1 www.likespike.com			# Facebook trojan
127.0.0.1 www.likethis.mbosoft.com		# Facebook trojan
127.0.0.1 www.likethislist.biz			# Facebook trojan
127.0.0.1 www.liveorigamirisk.com
127.0.0.1 www.loansfield.com
127.0.0.1 www.lockupouseburn.com
127.0.0.1 www.loginhunter.com
127.0.0.1 www.logoradar.com
127.0.0.1 www.logoswitch.com
127.0.0.1 www.lomalindasda.org			# Facebook trojan
127.0.0.1 www.lookimpression.beer
127.0.0.1 www.lostbestsgames.com
127.0.0.1 www.loveromantic.com
127.0.0.1 www.lowestincreases.bond
127.0.0.1 www.lunargrovefx.com
127.0.0.1 www.luxeforher.com
127.0.0.1 www.madnesscase.com
127.0.0.1 www.magento-analytics.com
127.0.0.1 www.maiecaffe.com
127.0.0.1 www.maillazy.com
127.0.0.1 www.makearestaurant.com
127.0.0.1 www.makeupglobal.com
127.0.0.1 www.manoces.waw.pl
127.0.0.1 www.markethelper.name
127.0.0.1 www.marketinghwy.com
127.0.0.1 www.match3quests.com
127.0.0.1 www.matifi.com
127.0.0.1 www.meantvictim.lat
127.0.0.1 www.mediamindpolska.com
127.0.0.1 www.meecheck.com
127.0.0.1 www.meeseger.com
127.0.0.1 www.megapurchase.com
127.0.0.1 www.memorieson.com
127.0.0.1 www.mexdrugs.com
127.0.0.1 www.mightpays.lol
127.0.0.1 www.mikras.nl
127.0.0.1 www.mildpost.com
127.0.0.1 www.milgaard.com
127.0.0.1 www.milkycascadeut.site
127.0.0.1 www.minr.pw
127.0.0.1 www.miocardite.com
127.0.0.1 www.mixsorts.garden
127.0.0.1 www.miziko.com
127.0.0.1 www.modelsailboat.net
127.0.0.1 www.moncasinoonline.com
127.0.0.1 www.monkeyball.osa.pl
127.0.0.1 www.monkikitchen.com
127.0.0.1 www.monstervits.com
127.0.0.1 www.morvalent.uk
127.0.0.1 www.mostexchange.com
127.0.0.1 www.movielocks.com
127.0.0.1 www.mshelp247.weebly.com
127.0.0.1 www.msmithguitarstudio.com
127.0.0.1 www.msmpokergamer.com
127.0.0.1 www.msxzff.com
127.0.0.1 www.multiceps.com
127.0.0.1 www.myalegent07.com
127.0.0.1 www.mycitycue.com
127.0.0.1 www.mycolonialpenm.com
127.0.0.1 www.mycontentlocker.com
127.0.0.1 www.myexotel.com
127.0.0.1 www.myfavcouponstore.com
127.0.0.1 www.myfurnituresirplus.com
127.0.0.1 www.myhucadvantage.com
127.0.0.1 www.mylike.co.uk			# Facebook trojan
127.0.0.1 www.mylovecards.com
127.0.0.1 www.nabtapharma.com
127.0.0.1 www.nanohistory.com
127.0.0.1 www.naturalmovementz.com
127.0.0.1 www.nearestsalon.com
127.0.0.1 www.necklaceu.com
127.0.0.1 www.neonpack.com
127.0.0.1 www.neonracketpro.com
127.0.0.1 www.new2crypto.com
127.0.0.1 www.newshello.com
127.0.0.1 www.nextfeatures.com
127.0.0.1 www.nftnavigator.com
127.0.0.1 www.nigja.com
127.0.0.1 www.nnews.net
127.0.0.1 www.nobetsjustfun.com
127.0.0.1 www.noithatphanthinh.com
127.0.0.1 www.northvalesgrids.uk
127.0.0.1 www.notepad2.com
127.0.0.1 www.novemberrainx.com
127.0.0.1 www.novosantiago.com
127.0.0.1 www.nowreact.com
127.0.0.1 www.nu26.com
127.0.0.1 www.nuntioz.com
127.0.0.1 www.nursse.com
127.0.0.1 www.nwbidrtb.com
127.0.0.1 www.nzgamingworld.com
127.0.0.1 www.oakog.com
127.0.0.1 www.oakridgeflows.uk
127.0.0.1 www.objectopoly.info
127.0.0.1 www.occoquananimalhospital.com
127.0.0.1 www.officerreport.com
127.0.0.1 www.ogopond.com
127.0.0.1 www.oilbasics.com
127.0.0.1 www.oix.com
127.0.0.1 www.oletipmegroup.com
127.0.0.1 www.olimpgokart.com
127.0.0.1 www.oliviathemes.com
127.0.0.1 www.onlinebidnow.com
127.0.0.1 www.onlinehint.com
127.0.0.1 www.opalcasinohotel.com
127.0.0.1 www.opencharms.com
127.0.0.1 www.openinternetexchange.com
127.0.0.1 www.oppery.com
127.0.0.1 www.orangesalonboise.com
127.0.0.1 www.otsserver.com
127.0.0.1 www.outonixan.com
127.0.0.1 www.pagibigfundservicers.com
127.0.0.1 www.paidsecure.com
127.0.0.1 www.paidtheme.com
127.0.0.1 www.paintballpins.com
127.0.0.1 www.paintingoccasion.living
127.0.0.1 www.paintnet.es
127.0.0.1 www.paintnet.fr
127.0.0.1 www.palaceskateboard.com
127.0.0.1 www.paramutplus.com
127.0.0.1 www.parejaamateur.com
127.0.0.1 www.partsttown.com
127.0.0.1 www.paseyourself.com
127.0.0.1 www.paviro.cfd
127.0.0.1 www.pcfixguide.help
127.0.0.1 www.pdrill.com
127.0.0.1 www.pdxsenior.com
127.0.0.1 www.peachysailwv.pro
127.0.0.1 www.pearlyappss.pro
127.0.0.1 www.peopleesbancorp.com
127.0.0.1 www.pepernity.com
127.0.0.1 www.perimentu.com
127.0.0.1 www.phantomluck.com
127.0.0.1 www.phormlabs.com
127.0.0.1 www.photomagicapp.com
127.0.0.1 www.pickupclean.com
127.0.0.1 www.picture-uploads.com
127.0.0.1 www.pinbroksup.com
127.0.0.1 www.pintransup.com
127.0.0.1 www.pintravelup.com
127.0.0.1 www.pinuperblog.com
127.0.0.1 www.pinupspinup.com
127.0.0.1 www.pipepractice.world
127.0.0.1 www.pixquestion.com
127.0.0.1 www.play-fever.com
127.0.0.1 www.playbestnet.com
127.0.0.1 www.playnowse.com
127.0.0.1 www.playroyaluk.com
127.0.0.1 www.playtactics-hub.com
127.0.0.1 www.pluseconomy.com
127.0.0.1 www.ponhap.com
127.0.0.1 www.portaldimensional.com
127.0.0.1 www.portlanfleathergoods.com
127.0.0.1 www.portutopcas.com
127.0.0.1 www.postsavings.com
127.0.0.1 www.poukladanyswiat.com
127.0.0.1 www.ppoi.org
127.0.0.1 www.premiumbrandszonalibre.com
127.0.0.1 www.presidency.site
127.0.0.1 www.prgwbn.cfd
127.0.0.1 www.primecrestnq.name
127.0.0.1 www.primitivecountrydecor.com
127.0.0.1 www.princessuppies.com
127.0.0.1 www.proflashdata.com			# Facebook trojan
127.0.0.1 www.promoskills.com
127.0.0.1 www.properrayam.pro
127.0.0.1 www.proxionet.com
127.0.0.1 www.proxygeni.com
127.0.0.1 www.pruialoatpmye.xyz
127.0.0.1 www.psychics-readings-for-free.com
127.0.0.1 www.ptcasinoonline.com
127.0.0.1 www.puppywoodshihtzu.com
127.0.0.1 www.purchaseproof.com
127.0.0.1 www.pure-glance.com
127.0.0.1 www.qateee.com
127.0.0.1 www.qbittorrent.com
127.0.0.1 www.qualitygamer.com
127.0.0.1 www.quartersnorth.lat
127.0.0.1 www.quarvions.com
127.0.0.1 www.quintingwatches.com
127.0.0.1 www.rackusread.com
127.0.0.1 www.rajtoursdubai.com
127.0.0.1 www.randki-sex.com
127.0.0.1 www.randrongames.com
127.0.0.1 www.raremosssr.name
127.0.0.1 www.raspberryketoneslim.com
127.0.0.1 www.reachtaxi.com
127.0.0.1 www.readyviews.com
127.0.0.1 www.realdrjudy.com
127.0.0.1 www.reandrogames.com
127.0.0.1 www.recallblog.com
127.0.0.1 www.regulationprofit.bond
127.0.0.1 www.rekonsise.com
127.0.0.1 www.relaxingcafe.com
127.0.0.1 www.reliaslearrning.com
127.0.0.1 www.renderfoest.com
127.0.0.1 www.rerminix.com
127.0.0.1 www.revivemore.com
127.0.0.1 www.rhemacorp.com
127.0.0.1 www.rickrolling.com
127.0.0.1 www.ricontools.com
127.0.0.1 www.rightchanges.com
127.0.0.1 www.risedirectly.living
127.0.0.1 www.riversidefr.com
127.0.0.1 www.rnleonard.com
127.0.0.1 www.rnodernssolution.com
127.0.0.1 www.robkellysurf.com
127.0.0.1 www.romanticdemands.bond
127.0.0.1 www.rplconnect.com
127.0.0.1 www.rtkmyz.cfd
127.0.0.1 www.rtpbolaslotjago.com
127.0.0.1 www.russian-sex.com
127.0.0.1 www.sailpirate.com
127.0.0.1 www.salliemaebenefits.com
127.0.0.1 www.salttm.com
127.0.0.1 www.sandybellxb.site
127.0.0.1 www.sandybrookyt.name
127.0.0.1 www.sauteenacoochee.com
127.0.0.1 www.scrapzoneauto.com
127.0.0.1 www.securityplusproducts.com
127.0.0.1 www.securityscan.us
127.0.0.1 www.seedschaos.garden
127.0.0.1 www.sellpetrol.com
127.0.0.1 www.sellrubber.com
127.0.0.1 www.shinilchurch.net	# domain was hacked and had a trojan installed
127.0.0.1 www.shinyechogz.name
127.0.0.1 www.shootingeffectively.skin
127.0.0.1 www.shopvisitors.com
127.0.0.1 www.sidneyman.com
127.0.0.1 www.silebah.com
127.0.0.1 www.silentgateck.site
127.0.0.1 www.silverboxcreativestudio.com
127.0.0.1 www.simplyartful.com
127.0.0.1 www.simplyhelper.com
127.0.0.1 www.sinera.org
127.0.0.1 www.sizecart.com
127.0.0.1 www.skibidihotel.com
127.0.0.1 www.skyonlinegratis.com
127.0.0.1 www.slidingdoorlocks.com
127.0.0.1 www.smashchampionsat.com
127.0.0.1 www.smionecare.com
127.0.0.1 www.smokyshadecj.name
127.0.0.1 www.snkido.com
127.0.0.1 www.snowhandball.com
127.0.0.1 www.snugbirdjq.blog
127.0.0.1 www.snurrlyspin.com
127.0.0.1 www.soctoni.com
127.0.0.1 www.softcarp.com
127.0.0.1 www.softmillon.com
127.0.0.1 www.softpebble.com
127.0.0.1 www.softwarebeginner.com
127.0.0.1 www.sohailpc.com
127.0.0.1 www.sonparks.skin
127.0.0.1 www.spectrumhomehealthinc.com
127.0.0.1 www.spiritentertainment.homes
127.0.0.1 www.spojrzenia.com
127.0.0.1 www.sporttile.com
127.0.0.1 www.ssdede.com
127.0.0.1 www.ssl2.in
127.0.0.1 www.startupsforstartups.com
127.0.0.1 www.statsff.com
127.0.0.1 www.steelbucks.com
127.0.0.1 www.stellarium.fr
127.0.0.1 www.stihil.com
127.0.0.1 www.stocksrate.com
127.0.0.1 www.stopphoulplay.com
127.0.0.1 www.stormhelix.uk
127.0.0.1 www.stricklyhouses.com
127.0.0.1 www.strongarchzu.com
127.0.0.1 www.studioorientbay.com
127.0.0.1 www.stylistnet.com
127.0.0.1 www.styxwise.com
127.0.0.1 www.subwayfast.com
127.0.0.1 www.suchnasty.skin
127.0.0.1 www.sumgaydigital.com
127.0.0.1 www.sunglassesfor.com
127.0.0.1 www.supereeego.com
127.0.0.1 www.supportnestframe.uk
127.0.0.1 www.supportwindowlane.uk
127.0.0.1 www.svipfulishipin.com
127.0.0.1 www.swallowwire.sa.com
127.0.0.1 www.sweetdominique.com
127.0.0.1 www.sweetdreamiu.com
127.0.0.1 www.sweetiesecrets.com
127.0.0.1 www.tanger.com.br
127.0.0.1 www.tattnexa.tattoo
127.0.0.1 www.tattooshaha.info			# Facebook trojan
127.0.0.1 www.teacherblogit.com
127.0.0.1 www.teafortune.com
127.0.0.1 www.techadvisorpro.name
127.0.0.1 www.technocost.com
127.0.0.1 www.technygrow.com
127.0.0.1 www.techyscope.com
127.0.0.1 www.tenantbackgronudsearch.com
127.0.0.1 www.teresinaapartment.com
127.0.0.1 www.textdynamics.com
127.0.0.1 www.thecollectiverd.com
127.0.0.1 www.thedatesafe.com			# Facebook trojan
127.0.0.1 www.thefriday.net
127.0.0.1 www.thegioibaove.com
127.0.0.1 www.thelaferianews.com
127.0.0.1 www.themesets.com
127.0.0.1 www.theprimeindia.com
127.0.0.1 www.thesecuredtrader.com
127.0.0.1 www.theskinnyschool.com
127.0.0.1 www.thisplanet.net
127.0.0.1 www.thunderbird.es
127.0.0.1 www.timelyworks.com
127.0.0.1 www.tinkfrog.com
127.0.0.1 www.tiompanalley.com
127.0.0.1 www.tntadfacts.com
127.0.0.1 www.totalencomenda.com
127.0.0.1 www.toysmetaverse.com
127.0.0.1 www.tradesasa.com
127.0.0.1 www.tradewinning.com
127.0.0.1 www.traficsigntest.com
127.0.0.1 www.trucktirehotline.com
127.0.0.1 www.truecrypt.fr
127.0.0.1 www.trueshelterju.pro
127.0.0.1 www.ttcgg.com
127.0.0.1 www.tuningcentar.com
127.0.0.1 www.tvccpt.com
127.0.0.1 www.tvrails.com
127.0.0.1 www.tvshowslist.com
127.0.0.1 www.ultratemps.com
127.0.0.1 www.underobviously.garden
127.0.0.1 www.unetbootin.net
127.0.0.1 www.unetbootin.org
127.0.0.1 www.upgradebasic.com
127.0.0.1 www.upi6.pillsstore-c.com		# Facebook trojan
127.0.0.1 www.uqz.com
127.0.0.1 www.urldelivery.com
127.0.0.1 www.vacnleefarpels.com
127.0.0.1 www.vbttech.com
127.0.0.1 www.vebprostopinup.com
127.0.0.1 www.vecchiopools.com
127.0.0.1 www.ventilationdirec.com
127.0.0.1 www.venturead.com
127.0.0.1 www.vetmanevi.com
127.0.0.1 www.videolove.clanteam.com
127.0.0.1 www.videonhadat.com
127.0.0.1 www.videostan.ru
127.0.0.1 www.vipnac.com
127.0.0.1 www.vkvmotion.com
127.0.0.1 www.vnailssanclemente.com
127.0.0.1 www.volvce.com
127.0.0.1 www.voolat.com
127.0.0.1 www.walkhelp.net
127.0.0.1 www.wantsfly.com
127.0.0.1 www.wapersab.com
127.0.0.1 www.wardhotels.com
127.0.0.1 www.warrenmovers.net
127.0.0.1 www.watchesnew.com
127.0.0.1 www.waterchalk.com
127.0.0.1 www.waterchamber.com
127.0.0.1 www.webassembly.stream
127.0.0.1 www.webdevotee.com
127.0.0.1 www.webmicrostores.com
127.0.0.1 www.webpartition.com
127.0.0.1 www.websrruss.com
127.0.0.1 www.webwise.com
127.0.0.1 www.webwise.org
127.0.0.1 www.weknow.ac
127.0.0.1 www.wewillrocknow.com
127.0.0.1 www.wezelco.com
127.0.0.1 www.wgmarketingdigital.com
127.0.0.1 www.whatsappvido.com
127.0.0.1 www.whiskeyallys.com
127.0.0.1 www.white-dock.net
127.0.0.1 www.wholesaleorganix.com
127.0.0.1 www.wifimarfixhotspot.com
127.0.0.1 www.wildriderfuns.com
127.0.0.1 www.wildroostli.com
127.0.0.1 www.willysy.com
127.0.0.1 www.winecrazydesigns.com
127.0.0.1 www.wingfoilmargarita.com
127.0.0.1 www.winlottofrequently.com
127.0.0.1 www.wiseknows.bond
127.0.0.1 www.wjldfm.com
127.0.0.1 www.wontake.skin
127.0.0.1 www.woodycrystaljo.name
127.0.0.1 www.workschat.com
127.0.0.1 www.wraploans.com
127.0.0.1 www.wrestlewebnews.com
127.0.0.1 www.wwwhwgo.com
127.0.0.1 www.wwwmyboostnow.com
127.0.0.1 www.wwwpaipal.com
127.0.0.1 www.wwwtsg.com
127.0.0.1 www.xandermaker.com
127.0.0.1 www.xdesimbi.com
127.0.0.1 www.xtremetechcr.com
127.0.0.1 www.yellowquartzkr.name
127.0.0.1 www.yendermsoul.com
127.0.0.1 www.yixiudn.com
127.0.0.1 www.ylgj789.com
127.0.0.1 www.yoolyes.com
127.0.0.1 www.youfiletor.com
127.0.0.1 www.yreta.com
127.0.0.1 www.zenithvault.uk
127.0.0.1 www.zephyrvineky.online
127.0.0.1 www.zippylakeri.name
127.0.0.1 www1-van-city-signon.com
127.0.0.1 wyoutube.fr
127.0.0.1 xcdkb.comfortykive.xyz
127.0.0.1 xen-media.com
127.0.0.1 xmssxx.com
127.0.0.1 xn--80afden1bnch4a.xn--p1ai
127.0.0.1 xn--oogle-wmc.com
127.0.0.1 xpx7heciz9.com
127.0.0.1 xxlargepop.com
127.0.0.1 yachtingmagazine.fr
127.0.0.1 yama.myfixhub.cfd
127.0.0.1 yanteaviation.com
127.0.0.1 ycapital.fr
127.0.0.1 yev.moviesdirectpro.com
127.0.0.1 yexex.comfortykive.xyz
127.0.0.1 ykjure.com
127.0.0.1 ykocr.comfortykive.xyz
127.0.0.1 yllvye.com
127.0.0.1 ymail-activate1.bugs3.com
127.0.0.1 yogamagazine.fr
127.0.0.1 you-fm.fr
127.0.0.1 youcanoptout.com
127.0.0.1 youmakeashion.fr
127.0.0.1 yourdailytrailer.yournewtab.com
127.0.0.1 yourhlth.ru.com
127.0.0.1 yourmailservice.com
127.0.0.1 yourofficialsurveysplace.store
127.0.0.1 youvisit.fr
127.0.0.1 yrwap.cn
127.0.0.1 yummie.fr
127.0.0.1 yves-rocker.fr
127.0.0.1 yyanluo.com
127.0.0.1 z3.skdfoiqwjelmdkfser.ru
127.0.0.1 zalanado.fr
127.0.0.1 zalandon.fr
127.0.0.1 zb1.zeroredirect1.com
127.0.0.1 zealous-push.surge.sh
127.0.0.1 zendictees.fr
127.0.0.1 zenigameblinger.org
127.0.0.1 zettapetta.com
127.0.0.1 zhunhesh.com
127.0.0.1 zimmernroofingservices.com
127.0.0.1 zip.er.cz
127.0.0.1 zjchao.com
127.0.0.1 zjgaoergao.com
127.0.0.1 ztriskl.divisionfair.homes
127.0.0.1 zzhc.vnet.cn
127.0.0.1 zzkwg.comfortykive.xyz
#</malware-sites>

#<doubleclick-sites>

#127.0.0.1 pubads.g.doubleclick.net	#interferes with video on cwtv.com
127.0.0.1 ad-emea.doubleclick.net
127.0.0.1 ad-g.doubleclick.net
127.0.0.1 ad.ae.doubleclick.net
127.0.0.1 ad.be.doubleclick.net
127.0.0.1 ad.br.doubleclick.net
127.0.0.1 ad.de.doubleclick.net
127.0.0.1 ad.dk.doubleclick.net
127.0.0.1 ad.doubleclick.net
127.0.0.1 ad.es.doubleclick.net
127.0.0.1 ad.fi.doubleclick.net
127.0.0.1 ad.fr.doubleclick.net
127.0.0.1 ad.it.doubleclick.net
127.0.0.1 ad.jp.doubleclick.net
127.0.0.1 ad.mo.doubleclick.net
127.0.0.1 ad.n2434.doubleclick.net
127.0.0.1 ad.nl.doubleclick.net
127.0.0.1 ad.no.doubleclick.net
127.0.0.1 ad.nz.doubleclick.net
127.0.0.1 ad.pl.doubleclick.net
127.0.0.1 ad.se.doubleclick.net
127.0.0.1 ad.sg.doubleclick.net
127.0.0.1 ad.uk.doubleclick.net
127.0.0.1 ad.ve.doubleclick.net
127.0.0.1 ad.za.doubleclick.net
127.0.0.1 ad2.doubleclick.net
127.0.0.1 adclick.g.doubleclick.net
127.0.0.1 cm.g.doubleclick.net
127.0.0.1 creative.cc-dt.com
127.0.0.1 doubleclick.com
127.0.0.1 doubleclick.de
127.0.0.1 doubleclick.net
127.0.0.1 feedads.g.doubleclick.net
127.0.0.1 fls.doubleclick.net
127.0.0.1 googleads.g.doubleclick.net
127.0.0.1 iv.doubleclick.net
127.0.0.1 m.2mdn.net
127.0.0.1 m.doubleclick.net
127.0.0.1 m1.2mdn.net
127.0.0.1 n479ad.doubleclick.net
127.0.0.1 pagead.l.doubleclick.net
127.0.0.1 pagead46.l.doubleclick.net
127.0.0.1 stats.g.doubleclick.net
127.0.0.1 stats.l.doubleclick.net
127.0.0.1 ukrpts.net
#</doubleclick-sites>

#<intellitxt-sites>

127.0.0.1 contactmusic.uk.intellitxt.com
127.0.0.1 ferrago.uk.intellitxt.com
127.0.0.1 freedownloadcenter.uk.intellitxt.com
127.0.0.1 gadgets.fosfor.se.intellitxt.com
127.0.0.1 images.intellitxt.com
127.0.0.1 k.intellitxt.com
127.0.0.1 maccity.it.intellitxt.com
127.0.0.1 macuser.uk.intellitxt.com
127.0.0.1 macworld.uk.intellitxt.com
127.0.0.1 metro.uk.intellitxt.com
127.0.0.1 monstersandcritics.uk.intellitxt.com
127.0.0.1 moviesonline.ca.intellitxt.com
127.0.0.1 newcarnet.uk.intellitxt.com
127.0.0.1 newlaunches.uk.intellitxt.com
127.0.0.1 pcadvisor.uk.intellitxt.com
127.0.0.1 pcgameshardware.de.intellitxt.com
127.0.0.1 physorg.uk.intellitxt.com
127.0.0.1 playfuls.uk.intellitxt.com
127.0.0.1 pocketlint.uk.intellitxt.com
127.0.0.1 pspcave.uk.intellitxt.com
127.0.0.1 softpedia.uk.intellitxt.com
127.0.0.1 splashnews.uk.intellitxt.com
127.0.0.1 wi-fitechnology.uk.intellitxt.com
#</intellitxt-sites>

#<red-sheriff-sites>

# Red Sheriff and imrworldwide.com  -- server side tracking
#127.0.0.1 secure-au.imrworldwide.com
127.0.0.1 fe-au.imrworldwide.com
127.0.0.1 fe1-au.imrworldwide.com
127.0.0.1 fe2-au.imrworldwide.com
127.0.0.1 fe3-au.imrworldwide.com
127.0.0.1 imrworldwide.com
127.0.0.1 lycos-eu.imrworldwide.com
127.0.0.1 ninemsn.imrworldwide.com
127.0.0.1 rc-au.imrworldwide.com
127.0.0.1 redsheriff.com
127.0.0.1 secure-jp.imrworldwide.com
127.0.0.1 secure-nz.imrworldwide.com
127.0.0.1 secure-uk.imrworldwide.com
127.0.0.1 secure-za.imrworldwide.com
127.0.0.1 server-au.imrworldwide.com
127.0.0.1 server-br.imrworldwide.com
127.0.0.1 server-by.imrworldwide.com
127.0.0.1 server-de.imrworldwide.com
127.0.0.1 server-dk.imrworldwide.com
127.0.0.1 server-ee.imrworldwide.com
127.0.0.1 server-fi.imrworldwide.com
127.0.0.1 server-fr.imrworldwide.com
127.0.0.1 server-hk.imrworldwide.com
127.0.0.1 server-it.imrworldwide.com
127.0.0.1 server-jp.imrworldwide.com
127.0.0.1 server-lt.imrworldwide.com
127.0.0.1 server-lv.imrworldwide.com
127.0.0.1 server-no.imrworldwide.com
127.0.0.1 server-nz.imrworldwide.com
127.0.0.1 server-oslo.imrworldwide.com
127.0.0.1 server-pl.imrworldwide.com
127.0.0.1 server-ru.imrworldwide.com
127.0.0.1 server-se.imrworldwide.com
127.0.0.1 server-sg.imrworldwide.com
127.0.0.1 server-stockh.imrworldwide.com
127.0.0.1 server-ua.imrworldwide.com
127.0.0.1 server-uk.imrworldwide.com
127.0.0.1 server-us.imrworldwide.com
127.0.0.1 telstra.imrworldwide.com
127.0.0.1 www.redsheriff.com
#</red-sheriff-sites>

#<cydoor-sites>

# cydoor -- server side tracking
127.0.0.1 cydoor.com
127.0.0.1 j.2004cms.com
127.0.0.1 jbaventures.cjt1.net
127.0.0.1 jbeet.cjt1.net
127.0.0.1 jbit.cjt1.net
127.0.0.1 jcollegehumor.cjt1.net
127.0.0.1 jdownloadacc.cjt1.net
127.0.0.1 jgen1.cjt1.net
127.0.0.1 jgen10.cjt1.net
127.0.0.1 jgen11.cjt1.net
127.0.0.1 jgen12.cjt1.net
127.0.0.1 jgen13.cjt1.net
127.0.0.1 jgen14.cjt1.net
127.0.0.1 jgen15.cjt1.net
127.0.0.1 jgen16.cjt1.net
127.0.0.1 jgen17.cjt1.net
127.0.0.1 jgen18.cjt1.net
127.0.0.1 jgen19.cjt1.net
127.0.0.1 jgen2.cjt1.net
127.0.0.1 jgen20.cjt1.net
127.0.0.1 jgen21.cjt1.net
127.0.0.1 jgen22.cjt1.net
127.0.0.1 jgen23.cjt1.net
127.0.0.1 jgen24.cjt1.net
127.0.0.1 jgen25.cjt1.net
127.0.0.1 jgen26.cjt1.net
127.0.0.1 jgen27.cjt1.net
127.0.0.1 jgen28.cjt1.net
127.0.0.1 jgen29.cjt1.net
127.0.0.1 jgen3.cjt1.net
127.0.0.1 jgen30.cjt1.net
127.0.0.1 jgen31.cjt1.net
127.0.0.1 jgen32.cjt1.net
127.0.0.1 jgen33.cjt1.net
127.0.0.1 jgen34.cjt1.net
127.0.0.1 jgen35.cjt1.net
127.0.0.1 jgen36.cjt1.net
127.0.0.1 jgen37.cjt1.net
127.0.0.1 jgen38.cjt1.net
127.0.0.1 jgen39.cjt1.net
127.0.0.1 jgen4.cjt1.net
127.0.0.1 jgen40.cjt1.net
127.0.0.1 jgen41.cjt1.net
127.0.0.1 jgen42.cjt1.net
127.0.0.1 jgen43.cjt1.net
127.0.0.1 jgen44.cjt1.net
127.0.0.1 jgen45.cjt1.net
127.0.0.1 jgen46.cjt1.net
127.0.0.1 jgen47.cjt1.net
127.0.0.1 jgen48.cjt1.net
127.0.0.1 jgen49.cjt1.net
127.0.0.1 jgen5.cjt1.net
127.0.0.1 jgen6.cjt1.net
127.0.0.1 jgen7.cjt1.net
127.0.0.1 jgen8.cjt1.net
127.0.0.1 jgen9.cjt1.net
127.0.0.1 jhumour.cjt1.net
127.0.0.1 jmbi58.cjt1.net
127.0.0.1 jnova.cjt1.net
127.0.0.1 jpirate.cjt1.net
127.0.0.1 jsandboxer.cjt1.net
127.0.0.1 jumcna.cjt1.net
127.0.0.1 jwebbsense.cjt1.net
127.0.0.1 www.cydoor.com
#</cydoor-sites>

#<2o7-sites>

# 2o7.net -- server side tracking
#127.0.0.1 appleglobal.112.2o7.net	#breaks apple.com
#127.0.0.1 applestoreus.112.2o7.net	#breaks apple.com
127.0.0.1 102.112.2o7.net
127.0.0.1 102.122.2o7.net
127.0.0.1 112.2o7.net
127.0.0.1 122.2o7.net
127.0.0.1 192.168.112.2o7.net
127.0.0.1 2o7.net
127.0.0.1 actforvictory.112.2o7.net
127.0.0.1 adbrite.112.2o7.net
127.0.0.1 adbrite.122.2o7.net
127.0.0.1 aehistory.112.2o7.net
127.0.0.1 aetv.112.2o7.net
127.0.0.1 agamgreetingscom.112.2o7.net
127.0.0.1 allbritton.122.2o7.net
127.0.0.1 americanbaby.112.2o7.net
127.0.0.1 ancestrymsn.112.2o7.net
127.0.0.1 ancestryuki.112.2o7.net
127.0.0.1 and.co.uk.102.122.2o7.net
127.0.0.1 angiba.112.2o7.net
127.0.0.1 angmar.112.2o7.net
127.0.0.1 angtr.112.2o7.net
127.0.0.1 angts.112.2o7.net
127.0.0.1 angvac.112.2o7.net
127.0.0.1 anm.112.2o7.net
127.0.0.1 aolcareers.122.2o7.net
127.0.0.1 aoldlama.122.2o7.net
127.0.0.1 aoljournals.122.2o7.net
127.0.0.1 aolnsnews.122.2o7.net
127.0.0.1 aolpf.122.2o7.net
127.0.0.1 aolpolls.112.2o7.net
127.0.0.1 aolpolls.122.2o7.net
127.0.0.1 aolsearch.122.2o7.net
127.0.0.1 aolsvc.122.2o7.net
127.0.0.1 aoltmz.122.2o7.net
127.0.0.1 aolturnercnnmoney.112.2o7.net
127.0.0.1 aolturnercnnmoney.122.2o7.net
127.0.0.1 aolturnersi.122.2o7.net
127.0.0.1 aolukglobal.122.2o7.net
127.0.0.1 aolwinamp.122.2o7.net
127.0.0.1 aolwpaim.112.2o7.net
127.0.0.1 aolwpicq.122.2o7.net
127.0.0.1 aolwpmq.112.2o7.net
127.0.0.1 aolwpmqnoban.112.2o7.net
127.0.0.1 apdigitalorg.112.2o7.net
127.0.0.1 apdigitalorgovn.112.2o7.net
127.0.0.1 apnonline.112.2o7.net
127.0.0.1 atlassian.122.2o7.net
127.0.0.1 autobytel.112.2o7.net
127.0.0.1 autoweb.112.2o7.net
127.0.0.1 bbcnewscouk.112.2o7.net
127.0.0.1 bellca.112.2o7.net
127.0.0.1 bellglobemediapublishing.122.2o7.net
127.0.0.1 bellglovemediapublishing.122.2o7.net
127.0.0.1 bellserviceeng.112.2o7.net
127.0.0.1 betterhg.112.2o7.net
127.0.0.1 bhgmarketing.112.2o7.net
127.0.0.1 bidentonrccom.122.2o7.net
127.0.0.1 biwwltvcom.112.2o7.net
127.0.0.1 biwwltvcom.122.2o7.net
127.0.0.1 blackpress.122.2o7.net
127.0.0.1 bnkr8dev.112.2o7.net
127.0.0.1 bntbcstglobal.112.2o7.net
127.0.0.1 bosecom.112.2o7.net
127.0.0.1 brightcove.112.2o7.net
127.0.0.1 bulldog.122.2o7.net
127.0.0.1 businessweekpoc.112.2o7.net
127.0.0.1 bzresults.122.2o7.net
127.0.0.1 cablevision.112.2o7.net
127.0.0.1 canwest.112.2o7.net
127.0.0.1 canwestcom.112.2o7.net
127.0.0.1 canwestglobal.112.2o7.net
127.0.0.1 capcityadvcom.112.2o7.net
127.0.0.1 capcityadvcom.122.2o7.net
127.0.0.1 careers.112.2o7.net
127.0.0.1 cartoonnetwork.122.2o7.net
127.0.0.1 cbaol.112.2o7.net
127.0.0.1 cbc.122.2o7.net
127.0.0.1 cbcca.112.2o7.net
127.0.0.1 cbcca.122.2o7.net
127.0.0.1 cbcincinnatienquirer.112.2o7.net
127.0.0.1 cbmsn.112.2o7.net
127.0.0.1 cbs.112.2o7.net
127.0.0.1 cbsncaasports.112.2o7.net
127.0.0.1 cbsnfl.112.2o7.net
127.0.0.1 cbspgatour.112.2o7.net
127.0.0.1 cbsspln.112.2o7.net
127.0.0.1 ccrbudgetca.112.2o7.net
127.0.0.1 ccrgaviscom.112.2o7.net
127.0.0.1 cfrfa.112.2o7.net
127.0.0.1 chicagosuntimes.122.2o7.net
127.0.0.1 chumtv.122.2o7.net
127.0.0.1 classifiedscanada.112.2o7.net
127.0.0.1 classmatescom.112.2o7.net
127.0.0.1 cmpglobalvista.112.2o7.net
127.0.0.1 cnetasiapacific.122.2o7.net
127.0.0.1 cnetaustralia.122.2o7.net
127.0.0.1 cneteurope.122.2o7.net
127.0.0.1 cnetnews.112.2o7.net
127.0.0.1 cnetzdnet.112.2o7.net
127.0.0.1 cnhienid.122.2o7.net
127.0.0.1 cnhimcalesternews.122.2o7.net
127.0.0.1 cnhipicayuneitemv.112.2o7.net
127.0.0.1 cnhitribunestar.122.2o7.net
127.0.0.1 cnhitribunestara.122.2o7.net
127.0.0.1 cnhregisterherald.122.2o7.net
127.0.0.1 cnn.122.2o7.net
127.0.0.1 computerworldcom.112.2o7.net
127.0.0.1 condenast.112.2o7.net
127.0.0.1 coxnetmasterglobal.112.2o7.net
127.0.0.1 coxpalmbeachpost.112.2o7.net
127.0.0.1 csoonlinecom.112.2o7.net
127.0.0.1 ctvcrimelibrary.112.2o7.net
127.0.0.1 ctvsmokinggun.112.2o7.net
127.0.0.1 cxociocom.112.2o7.net
127.0.0.1 denverpost.112.2o7.net
127.0.0.1 diginet.112.2o7.net
127.0.0.1 digitalhomediscountptyltd.122.2o7.net
127.0.0.1 disccglobal.112.2o7.net
127.0.0.1 disccstats.112.2o7.net
127.0.0.1 dischannel.112.2o7.net
127.0.0.1 divx.112.2o7.net
127.0.0.1 dixonslnkcouk.112.2o7.net
127.0.0.1 dogpile.112.2o7.net
127.0.0.1 donval.112.2o7.net
127.0.0.1 dowjones.122.2o7.net
127.0.0.1 dreammates.112.2o7.net
127.0.0.1 eaeacom.112.2o7.net
127.0.0.1 eagamesuk.112.2o7.net
127.0.0.1 earthlnkpsplive.122.2o7.net
127.0.0.1 ebay1.112.2o7.net
127.0.0.1 ebaynonreg.112.2o7.net
127.0.0.1 ebayreg.112.2o7.net
127.0.0.1 ebayus.112.2o7.net
127.0.0.1 ebcom.112.2o7.net
127.0.0.1 ectestlampsplus1.112.2o7.net
127.0.0.1 edietsmain.112.2o7.net
127.0.0.1 edmundsinsideline.112.2o7.net
127.0.0.1 edsa.112.2o7.net
127.0.0.1 ehg-moma.hitbox.com.112.2o7.net
127.0.0.1 emc.122.2o7.net
127.0.0.1 employ22.112.2o7.net
127.0.0.1 employ26.112.2o7.net
127.0.0.1 employment.112.2o7.net
127.0.0.1 enterprisenewsmedia.122.2o7.net
127.0.0.1 epost.122.2o7.net
127.0.0.1 ewsnaples.112.2o7.net
127.0.0.1 ewstcpalm.112.2o7.net
127.0.0.1 examinercom.122.2o7.net
127.0.0.1 execulink.112.2o7.net
127.0.0.1 expedia.ca.112.2o7.net
127.0.0.1 expedia4.112.2o7.net
127.0.0.1 f2ncracker.112.2o7.net
127.0.0.1 f2nsmh.112.2o7.net
127.0.0.1 f2ntheage.112.2o7.net
127.0.0.1 faceoff.112.2o7.net
127.0.0.1 fbkmnr.112.2o7.net
127.0.0.1 forbesattache.112.2o7.net
127.0.0.1 forbesauto.112.2o7.net
127.0.0.1 forbesautos.112.2o7.net
127.0.0.1 forbescom.112.2o7.net
127.0.0.1 ford.112.2o7.net
127.0.0.1 foxcom.112.2o7.net
127.0.0.1 foxsimpsons.112.2o7.net
127.0.0.1 georgewbush.112.2o7.net
127.0.0.1 georgewbushcom.112.2o7.net
127.0.0.1 gettyimages.122.2o7.net
127.0.0.1 gjfastcompanycom.112.2o7.net
127.0.0.1 gmchevyapprentice.112.2o7.net
127.0.0.1 gmhummer.112.2o7.net
127.0.0.1 gntbcstglobal.112.2o7.net
127.0.0.1 gntbcstkxtv.112.2o7.net
127.0.0.1 gntbcstwtsp.112.2o7.net
127.0.0.1 gpaper104.112.2o7.net
127.0.0.1 gpaper105.112.2o7.net
127.0.0.1 gpaper107.112.2o7.net
127.0.0.1 gpaper108.112.2o7.net
127.0.0.1 gpaper109.112.2o7.net
127.0.0.1 gpaper110.112.2o7.net
127.0.0.1 gpaper111.112.2o7.net
127.0.0.1 gpaper112.112.2o7.net
127.0.0.1 gpaper113.112.2o7.net
127.0.0.1 gpaper114.112.2o7.net
127.0.0.1 gpaper115.112.2o7.net
127.0.0.1 gpaper116.112.2o7.net
127.0.0.1 gpaper117.112.2o7.net
127.0.0.1 gpaper118.112.2o7.net
127.0.0.1 gpaper119.112.2o7.net
127.0.0.1 gpaper120.112.2o7.net
127.0.0.1 gpaper121.112.2o7.net
127.0.0.1 gpaper122.112.2o7.net
127.0.0.1 gpaper123.112.2o7.net
127.0.0.1 gpaper124.112.2o7.net
127.0.0.1 gpaper125.112.2o7.net
127.0.0.1 gpaper126.112.2o7.net
127.0.0.1 gpaper127.112.2o7.net
127.0.0.1 gpaper128.112.2o7.net
127.0.0.1 gpaper129.112.2o7.net
127.0.0.1 gpaper131.112.2o7.net
127.0.0.1 gpaper132.112.2o7.net
127.0.0.1 gpaper133.112.2o7.net
127.0.0.1 gpaper138.112.2o7.net
127.0.0.1 gpaper139.112.2o7.net
127.0.0.1 gpaper140.112.2o7.net
127.0.0.1 gpaper141.112.2o7.net
127.0.0.1 gpaper142.112.2o7.net
127.0.0.1 gpaper144.112.2o7.net
127.0.0.1 gpaper145.112.2o7.net
127.0.0.1 gpaper147.112.2o7.net
127.0.0.1 gpaper149.112.2o7.net
127.0.0.1 gpaper151.112.2o7.net
127.0.0.1 gpaper154.112.2o7.net
127.0.0.1 gpaper156.112.2o7.net
127.0.0.1 gpaper157.112.2o7.net
127.0.0.1 gpaper158.112.2o7.net
127.0.0.1 gpaper162.112.2o7.net
127.0.0.1 gpaper164.112.2o7.net
127.0.0.1 gpaper166.112.2o7.net
127.0.0.1 gpaper167.112.2o7.net
127.0.0.1 gpaper169.112.2o7.net
127.0.0.1 gpaper170.112.2o7.net
127.0.0.1 gpaper171.112.2o7.net
127.0.0.1 gpaper172.112.2o7.net
127.0.0.1 gpaper173.112.2o7.net
127.0.0.1 gpaper174.112.2o7.net
127.0.0.1 gpaper176.112.2o7.net
127.0.0.1 gpaper177.112.2o7.net
127.0.0.1 gpaper180.112.2o7.net
127.0.0.1 gpaper183.112.2o7.net
127.0.0.1 gpaper184.112.2o7.net
127.0.0.1 gpaper191.112.2o7.net
127.0.0.1 gpaper192.112.2o7.net
127.0.0.1 gpaper193.112.2o7.net
127.0.0.1 gpaper194.112.2o7.net
127.0.0.1 gpaper195.112.2o7.net
127.0.0.1 gpaper196.112.2o7.net
127.0.0.1 gpaper197.112.2o7.net
127.0.0.1 gpaper198.112.2o7.net
127.0.0.1 gpaper202.112.2o7.net
127.0.0.1 gpaper204.112.2o7.net
127.0.0.1 gpaper205.112.2o7.net
127.0.0.1 gpaper212.112.2o7.net
127.0.0.1 gpaper214.112.2o7.net
127.0.0.1 gpaper219.112.2o7.net
127.0.0.1 gpaper223.112.2o7.net
127.0.0.1 harpo.122.2o7.net
127.0.0.1 hchrmain.112.2o7.net
127.0.0.1 heavycom.112.2o7.net
127.0.0.1 heavycom.122.2o7.net
127.0.0.1 homesclick.112.2o7.net
127.0.0.1 hostdomainpeople.112.2o7.net
127.0.0.1 hostdomainpeopleca.112.2o7.net
127.0.0.1 hostpowermedium.112.2o7.net
127.0.0.1 hpglobal.112.2o7.net
127.0.0.1 hphqglobal.112.2o7.net
127.0.0.1 hphqsearch.112.2o7.net
127.0.0.1 infomart.ca.112.2o7.net
127.0.0.1 infospace.com.112.2o7.net
127.0.0.1 intelcorpcim.112.2o7.net
127.0.0.1 intelglobal.112.2o7.net
127.0.0.1 ivillageglobal.112.2o7.net
127.0.0.1 jijsonline.122.2o7.net
127.0.0.1 jitmj4.122.2o7.net
127.0.0.1 johnlewis.112.2o7.net
127.0.0.1 journalregistercompany.122.2o7.net
127.0.0.1 kddi.122.2o7.net
127.0.0.1 krafteurope.112.2o7.net
127.0.0.1 ktva.112.2o7.net
127.0.0.1 ladieshj.112.2o7.net
127.0.0.1 laptopmag.122.2o7.net
127.0.0.1 laxnws.112.2o7.net
127.0.0.1 laxprs.112.2o7.net
127.0.0.1 laxpsd.112.2o7.net
127.0.0.1 ldsfch.112.2o7.net
127.0.0.1 leeenterprises.112.2o7.net
127.0.0.1 lenovo.112.2o7.net
127.0.0.1 logoworksdev.112.2o7.net
127.0.0.1 losu.112.2o7.net
127.0.0.1 mailtribune.112.2o7.net
127.0.0.1 maxim.122.2o7.net
127.0.0.1 maxvr.112.2o7.net
127.0.0.1 mdamarillo.112.2o7.net
127.0.0.1 mdjacksonville.112.2o7.net
127.0.0.1 mdtopeka.112.2o7.net
127.0.0.1 mdwardmore.112.2o7.net
127.0.0.1 mdwsavannah.112.2o7.net
127.0.0.1 medbroadcast.112.2o7.net
127.0.0.1 mediabistrocom.112.2o7.net
127.0.0.1 mediamatters.112.2o7.net
127.0.0.1 meetupcom.112.2o7.net
127.0.0.1 metacafe.122.2o7.net
127.0.0.1 metro.co.uk.102.122.2o7.net
127.0.0.1 mgjournalnow.112.2o7.net
127.0.0.1 mgtbo.112.2o7.net
127.0.0.1 mgtimesdispatch.112.2o7.net
127.0.0.1 mgwsls.112.2o7.net
127.0.0.1 mgwspa.112.2o7.net
127.0.0.1 microsoftconsumermarketing.112.2o7.net
127.0.0.1 microsofteup.112.2o7.net
127.0.0.1 microsoftwindows.112.2o7.net
127.0.0.1 midala.112.2o7.net
127.0.0.1 midar.112.2o7.net
127.0.0.1 midsen.112.2o7.net
127.0.0.1 mlbastros.112.2o7.net
127.0.0.1 mlbcolorado.112.2o7.net
127.0.0.1 mlbcom.112.2o7.net
127.0.0.1 mlbglobal.112.2o7.net
127.0.0.1 mlbglobal08.112.2o7.net
127.0.0.1 mlbhouston.112.2o7.net
127.0.0.1 mlbstlouis.112.2o7.net
127.0.0.1 mlbtoronto.112.2o7.net
127.0.0.1 mmsshopcom.112.2o7.net
127.0.0.1 mnfidnahub.112.2o7.net
127.0.0.1 mngidmn.112.2o7.net
127.0.0.1 mngirockymtnnews.112.2o7.net
127.0.0.1 mngislctrib.112.2o7.net
127.0.0.1 mngiyrkdr.112.2o7.net
127.0.0.1 mseuppremain.112.2o7.net
127.0.0.1 msnmercom.112.2o7.net
127.0.0.1 msnportal.112.2o7.net
127.0.0.1 mtvn.112.2o7.net
127.0.0.1 mtvu.112.2o7.net
127.0.0.1 mxmacromedia.112.2o7.net
127.0.0.1 myfamilyancestry.112.2o7.net
127.0.0.1 nasdaq.122.2o7.net
127.0.0.1 natgeoeditco.112.2o7.net
127.0.0.1 natgeoeditcom.112.2o7.net
127.0.0.1 natgeonews.112.2o7.net
127.0.0.1 natgeongmcom.112.2o7.net
127.0.0.1 nationalpost.112.2o7.net
127.0.0.1 nba.112.2o7.net
127.0.0.1 neber.112.2o7.net
127.0.0.1 netrp.112.2o7.net
127.0.0.1 netsdartboards.122.2o7.net
127.0.0.1 newsinteractive.112.2o7.net
127.0.0.1 newstimeslivecom.112.2o7.net
127.0.0.1 nike.112.2o7.net
127.0.0.1 nikeplus.112.2o7.net
127.0.0.1 nmanchorage.112.2o7.net
127.0.0.1 nmbrampton.112.2o7.net
127.0.0.1 nmcommancomedia.112.2o7.net
127.0.0.1 nmfresno.112.2o7.net
127.0.0.1 nmhiltonhead.112.2o7.net
127.0.0.1 nmkawartha.112.2o7.net
127.0.0.1 nmminneapolis.112.2o7.net
127.0.0.1 nmmississauga.112.2o7.net
127.0.0.1 nmnandomedia.112.2o7.net
127.0.0.1 nmraleigh.112.2o7.net
127.0.0.1 nmrockhill.112.2o7.net
127.0.0.1 nmsacramento.112.2o7.net
127.0.0.1 nmtoronto.112.2o7.net
127.0.0.1 nmtricity.112.2o7.net
127.0.0.1 nmyork.112.2o7.net
127.0.0.1 novellcom.112.2o7.net
127.0.0.1 nytbglobe.112.2o7.net
127.0.0.1 nytglobe.112.2o7.net
127.0.0.1 nythglobe.112.2o7.net
127.0.0.1 nytimesglobal.112.2o7.net
127.0.0.1 nytimesnonsampled.112.2o7.net
127.0.0.1 nytimesnoonsampled.112.2o7.net
127.0.0.1 nytmembercenter.112.2o7.net
127.0.0.1 nytrflorence.112.2o7.net
127.0.0.1 nytrgadsden.112.2o7.net
127.0.0.1 nytrgainseville.112.2o7.net
127.0.0.1 nytrhendersonville.112.2o7.net
127.0.0.1 nytrhouma.112.2o7.net
127.0.0.1 nytrlakeland.112.2o7.net
127.0.0.1 nytrsantarosa.112.2o7.net
127.0.0.1 nytrsarasota.112.2o7.net
127.0.0.1 nytrwilmington.112.2o7.net
127.0.0.1 nyttechnology.112.2o7.net
127.0.0.1 omniture.112.2o7.net
127.0.0.1 omnitureglobal.112.2o7.net
127.0.0.1 onlineindigoca.112.2o7.net
127.0.0.1 oracle.112.2o7.net
127.0.0.1 oraclecom.112.2o7.net
127.0.0.1 overstock.com.112.2o7.net
127.0.0.1 overturecomvista.112.2o7.net
127.0.0.1 paypal.112.2o7.net
127.0.0.1 poacprod.122.2o7.net
127.0.0.1 poconorecordcom.112.2o7.net
127.0.0.1 projectorpeople.112.2o7.net
127.0.0.1 publicationsunbound.112.2o7.net
127.0.0.1 pulharktheherald.112.2o7.net
127.0.0.1 pulpantagraph.112.2o7.net
127.0.0.1 rckymtnnws.112.2o7.net
127.0.0.1 recordnetcom.112.2o7.net
127.0.0.1 recordonlinecom.112.2o7.net
127.0.0.1 rey3935.112.2o7.net
127.0.0.1 rezrezwhistler.112.2o7.net
127.0.0.1 riptownmedia.122.2o7.net
127.0.0.1 rncgopcom.122.2o7.net
127.0.0.1 roxio.112.2o7.net
127.0.0.1 salesforce.122.2o7.net
127.0.0.1 santacruzsentinel.112.2o7.net
127.0.0.1 sciamglobal.112.2o7.net
127.0.0.1 scrippsbathvert.112.2o7.net
127.0.0.1 scrippsfoodnet.112.2o7.net
127.0.0.1 scrippswfts.112.2o7.net
127.0.0.1 scrippswxyz.112.2o7.net
127.0.0.1 seacoastonlinecom.112.2o7.net
127.0.0.1 searscom.112.2o7.net
127.0.0.1 smibs.112.2o7.net
127.0.0.1 smwww.112.2o7.net
127.0.0.1 sonycorporate.122.2o7.net
127.0.0.1 sonyglobal.112.2o7.net
127.0.0.1 southcoasttoday.112.2o7.net
127.0.0.1 spiketv.112.2o7.net
127.0.0.1 stpetersburgtimes.122.2o7.net
127.0.0.1 suncom.112.2o7.net
127.0.0.1 sunglobal.112.2o7.net
127.0.0.1 sunonesearch.112.2o7.net
127.0.0.1 survey.112.2o7.net
127.0.0.1 sympmsnsports.112.2o7.net
127.0.0.1 techreview.112.2o7.net
127.0.0.1 thestar.122.2o7.net
127.0.0.1 thestardev.122.2o7.net
127.0.0.1 thinkgeek.112.2o7.net
127.0.0.1 timebus2.112.2o7.net
127.0.0.1 timecom.112.2o7.net
127.0.0.1 timeew.122.2o7.net
127.0.0.1 timefortune.112.2o7.net
127.0.0.1 timehealth.112.2o7.net
127.0.0.1 timeofficepirates.122.2o7.net
127.0.0.1 timepeople.122.2o7.net
127.0.0.1 timepopsci.122.2o7.net
127.0.0.1 timerealsimple.112.2o7.net
127.0.0.1 timewarner.122.2o7.net
127.0.0.1 tmsscion.112.2o7.net
127.0.0.1 tmstoyota.112.2o7.net
127.0.0.1 tnttv.112.2o7.net
127.0.0.1 torstardigital.122.2o7.net
127.0.0.1 travidiathebrick.112.2o7.net
127.0.0.1 tribuneinteractive.122.2o7.net
127.0.0.1 usatoday1.112.2o7.net
127.0.0.1 usnews.122.2o7.net
127.0.0.1 usun.112.2o7.net
127.0.0.1 vanns.112.2o7.net
127.0.0.1 verisignwildcard.112.2o7.net
127.0.0.1 verisonwildcard.112.2o7.net
127.0.0.1 vh1com.112.2o7.net
127.0.0.1 viaatomvideo.112.2o7.net
127.0.0.1 viacomedycentralrl.112.2o7.net
127.0.0.1 viagametrailers.112.2o7.net
127.0.0.1 viamtvcom.112.2o7.net
127.0.0.1 viasyndimedia.112.2o7.net
127.0.0.1 viavh1com.112.2o7.net
127.0.0.1 viay2m.112.2o7.net
127.0.0.1 vintacom.112.2o7.net
127.0.0.1 viralvideo.112.2o7.net
127.0.0.1 walmartcom.112.2o7.net
127.0.0.1 westjet.112.2o7.net
127.0.0.1 wileydumcom.112.2o7.net
127.0.0.1 wmg.112.2o7.net
127.0.0.1 wmgmulti.112.2o7.net
127.0.0.1 workopolis.122.2o7.net
127.0.0.1 wpni.112.2o7.net
127.0.0.1 xhealthmobiletools.112.2o7.net
127.0.0.1 youtube.112.2o7.net
127.0.0.1 yrkeve.112.2o7.net
127.0.0.1 ziffdavisglobal.112.2o7.net
127.0.0.1 ziffdavispennyarcade.112.2o7.net
#</2o7-sites>

#<oewabox-sites>

# oewabox.at -- 'Austrian Webanalysis Society'
127.0.0.1 1000ps.oewabox.at
127.0.0.1 afinder.oewabox.at
127.0.0.1 alphalux.oewabox.at
127.0.0.1 apodir.oewabox.at
127.0.0.1 arboe.oewabox.at
127.0.0.1 aschreib.oewabox.at
127.0.0.1 ascout24.oewabox.at
127.0.0.1 atvplus.oewabox.at
127.0.0.1 audi4e.oewabox.at
127.0.0.1 austria.oewabox.at
127.0.0.1 automobi.oewabox.at
127.0.0.1 automoto.oewabox.at
127.0.0.1 babyf.oewabox.at
127.0.0.1 bazar.oewabox.at
127.0.0.1 bdb.oewabox.at
127.0.0.1 bliga.oewabox.at
127.0.0.1 buschen.oewabox.at
127.0.0.1 car4you.oewabox.at
127.0.0.1 cinplex.oewabox.at
127.0.0.1 derstand.oewabox.at
127.0.0.1 dispatcher.oewabox.at
127.0.0.1 docfind.oewabox.at
127.0.0.1 doodle.oewabox.at
127.0.0.1 drei.oewabox.at
127.0.0.1 dropkick.oewabox.at
127.0.0.1 enerweb.oewabox.at
127.0.0.1 falstaff.oewabox.at
127.0.0.1 fanrep.oewabox.at
127.0.0.1 fflotte.oewabox.at
127.0.0.1 fitges.oewabox.at
127.0.0.1 fondprof.oewabox.at
127.0.0.1 fratz.oewabox.at
127.0.0.1 fscout24.oewabox.at
127.0.0.1 gamesw.oewabox.at
127.0.0.1 geizhals.oewabox.at
127.0.0.1 gillout.oewabox.at
127.0.0.1 gkueche.oewabox.at
127.0.0.1 gmx.oewabox.at
127.0.0.1 gofem.oewabox.at
127.0.0.1 heute.oewabox.at
127.0.0.1 immobili.oewabox.at
127.0.0.1 immosuch.oewabox.at
127.0.0.1 indumag.oewabox.at
127.0.0.1 induweb.oewabox.at
127.0.0.1 issges.oewabox.at
127.0.0.1 jobwohn.oewabox.at
127.0.0.1 karriere.oewabox.at
127.0.0.1 kinder.oewabox.at
127.0.0.1 kinowelt.oewabox.at
127.0.0.1 krone.oewabox.at
127.0.0.1 kronehit.oewabox.at
127.0.0.1 landwirt.oewabox.at
127.0.0.1 liportal.oewabox.at
127.0.0.1 mamilade.oewabox.at
127.0.0.1 manntv.oewabox.at
127.0.0.1 medpop.oewabox.at
127.0.0.1 megaplex.oewabox.at
127.0.0.1 metropol.oewabox.at
127.0.0.1 mmarkt.oewabox.at
127.0.0.1 monitor.oewabox.at
127.0.0.1 motorl.oewabox.at
127.0.0.1 msn.oewabox.at
127.0.0.1 newsnetw.oewabox.at
127.0.0.1 nickde.oewabox.at
127.0.0.1 noen.oewabox.at
127.0.0.1 notori.oewabox.at
127.0.0.1 oe24.oewabox.at
127.0.0.1 oeamtc.oewabox.at
127.0.0.1 oewa.oewabox.at
127.0.0.1 ooen.oewabox.at
127.0.0.1 orf.oewabox.at
127.0.0.1 parent.oewabox.at
127.0.0.1 radioat.oewabox.at
127.0.0.1 rtl.oewabox.at
127.0.0.1 salzburg.oewabox.at
127.0.0.1 schlager.oewabox.at
127.0.0.1 sdo.oewabox.at
127.0.0.1 seibli.oewabox.at
127.0.0.1 servustv.oewabox.at
127.0.0.1 skip.oewabox.at
127.0.0.1 skysport.oewabox.at
127.0.0.1 smedizin.oewabox.at
127.0.0.1 sms.oewabox.at
127.0.0.1 solidbau.oewabox.at
127.0.0.1 speising.oewabox.at
127.0.0.1 sportat.oewabox.at
127.0.0.1 ssl-compass.oewabox.at
127.0.0.1 ssl-geizhals.oewabox.at
127.0.0.1 ssl-helpgvat.oewabox.at
127.0.0.1 ssl-karriere.oewabox.at
127.0.0.1 ssl-msn.oewabox.at
127.0.0.1 ssl-top.oewabox.at
127.0.0.1 ssl-uspgvat.oewabox.at
127.0.0.1 ssl-willhab.oewabox.at
127.0.0.1 ssl-wko.oewabox.at
127.0.0.1 starchat.oewabox.at
127.0.0.1 sunny.oewabox.at
127.0.0.1 super.oewabox.at
127.0.0.1 supermed.oewabox.at
127.0.0.1 svpro7.oewabox.at
127.0.0.1 szene1.oewabox.at
127.0.0.1 tagpress.oewabox.at
127.0.0.1 tele.oewabox.at
127.0.0.1 tennis.oewabox.at
127.0.0.1 tips.oewabox.at
127.0.0.1 tirolcom.oewabox.at
127.0.0.1 top.oewabox.at
127.0.0.1 tramarkt.oewabox.at
127.0.0.1 tripwolf.oewabox.at
127.0.0.1 uncut.oewabox.at
127.0.0.1 unimed.oewabox.at
127.0.0.1 uwz.oewabox.at
127.0.0.1 vcm.oewabox.at
127.0.0.1 via.oewabox.at
127.0.0.1 viacom.oewabox.at
127.0.0.1 warda.oewabox.at
127.0.0.1 webprog.oewabox.at
127.0.0.1 wfussb.oewabox.at
127.0.0.1 wienerz.oewabox.at
127.0.0.1 wiengvat.oewabox.at
127.0.0.1 willhab.oewabox.at
127.0.0.1 wirtvlg.oewabox.at
127.0.0.1 woche.oewabox.at
127.0.0.1 wohnnet.oewabox.at
127.0.0.1 zfm.oewabox.at
#</oewabox-sites>

#<pegasus-spyware-sites>

# Pegasus spyware sites.
127.0.0.1 24-7clinic.com
127.0.0.1 365redirect.co
127.0.0.1 a-redirect.com
127.0.0.1 a-resolver.com
127.0.0.1 accomodation-tastes.net
127.0.0.1 accountcanceled.com
127.0.0.1 accountnotify.com
127.0.0.1 accounts.mx
127.0.0.1 accountsections.com
127.0.0.1 active-folders.com
127.0.0.1 actu24.online
127.0.0.1 ad-generator.net
127.0.0.1 ad-switcher.com
127.0.0.1 addresstimeframe.com
127.0.0.1 adscreator.net
127.0.0.1 adsload.co
127.0.0.1 advert-time.com
127.0.0.1 advert-track.com
127.0.0.1 afriquenouvelle.com
127.0.0.1 agilityprocessing.net
127.0.0.1 alignmentdisabled.net
127.0.0.1 apiapple.com
127.0.0.1 appleleaveit.co
127.0.0.1 appointments-online.com
127.0.0.1 arabnews365.com
127.0.0.1 asrarrarabiya.com
127.0.0.1 assembled-battery.com
127.0.0.1 authenticangry.com
127.0.0.1 authenticated-origin.com
127.0.0.1 av-scanner.com
127.0.0.1 babies-bottles.com
127.0.0.1 balancewreckpoint.com
127.0.0.1 bankportal.net
127.0.0.1 baramije.net
127.0.0.1 bargainservice.online
127.0.0.1 bdaynotes.com
127.0.0.1 beanbounce.net
127.0.0.1 becomeiguana.com
127.0.0.1 bestcandyever.com
127.0.0.1 bestfoods.co
127.0.0.1 bestheadphones4u.com
127.0.0.1 beststores4u.com
127.0.0.1 bestsushiever.com
127.0.0.1 bigseatsout.net
127.0.0.1 biscuit-taste.net
127.0.0.1 bitanalysis.net
127.0.0.1 black-bricks.net
127.0.0.1 blackwhitebags.com
127.0.0.1 blindlydivision.com
127.0.0.1 blockedsituation.net
127.0.0.1 blogreseller.net
127.0.0.1 boldconclusion.com
127.0.0.1 bottlehere.com
127.0.0.1 boxes-mix.net
127.0.0.1 brand-tech.net
127.0.0.1 breaking-news.co
127.0.0.1 breakingnewsasia.com
127.0.0.1 bubblesmoke.net
127.0.0.1 bubblesweetcake.com
127.0.0.1 buildingcarpet.com
127.0.0.1 buildyourdata.com
127.0.0.1 bulksender.info
127.0.0.1 bulktheft.com
127.0.0.1 bullgame.net
127.0.0.1 bustimer.net
127.0.0.1 butterdogchange.com
127.0.0.1 cablegirls.net
127.0.0.1 calculatesymbols.com
127.0.0.1 cars-to-buy.com
127.0.0.1 cashandlife.com
127.0.0.1 cdnwa.com
127.0.0.1 centersession.com
127.0.0.1 cheapapartmentsaroundme.com
127.0.0.1 chickenwaves.com
127.0.0.1 chubaka.org
127.0.0.1 clickrighthere.online
127.0.0.1 clicktrack247.com
127.0.0.1 clients-access.com
127.0.0.1 closefly.com
127.0.0.1 cloudads.net
127.0.0.1 cloudbiggest.com
127.0.0.1 clubloading.net
127.0.0.1 clubsforus.net
127.0.0.1 cnn-africa.co
127.0.0.1 coffee2go.org
127.0.0.1 colorfulnotebooks.com
127.0.0.1 colorsoflife.online
127.0.0.1 connecting-to.com
127.0.0.1 contacting-customer.com
127.0.0.1 contentsbycase.com
127.0.0.1 crownsafe.net
127.0.0.1 cryptocurrecny.com
127.0.0.1 cryptokoinz.com
127.0.0.1 dashboardprompt.com
127.0.0.1 data-formula.com
127.0.0.1 deal4unow.com
127.0.0.1 designednetwork.com
127.0.0.1 devicer.co
127.0.0.1 dhcpserver.net
127.0.0.1 diagram-shape.com
127.0.0.1 diaspora-news.com
127.0.0.1 discountads.net
127.0.0.1 displaytag.net
127.0.0.1 dns-analytics.com
127.0.0.1 dns-upload.com
127.0.0.1 dnsclocknow.com
127.0.0.1 dnslogs.net
127.0.0.1 dnsmachinefork.com
127.0.0.1 dnsprotector.net
127.0.0.1 doitformom.com
127.0.0.1 domain-control.net
127.0.0.1 domainloading.net
127.0.0.1 domainport.net
127.0.0.1 domains-resolver.net
127.0.0.1 domesticwindow.com
127.0.0.1 dowhatyouneed.com
127.0.0.1 downgradeproduct.com
127.0.0.1 dramatic-challenge.com
127.0.0.1 dynamic-dns.net
127.0.0.1 e-loading.biz
127.0.0.1 easy-pay.info
127.0.0.1 effectivespeech.net
127.0.0.1 emonitoring-paczki.pl
127.0.0.1 enoughtoday.org
127.0.0.1 estatearea.net
127.0.0.1 exchangenerate.com
127.0.0.1 existingpass.com
127.0.0.1 expiredsession.com
127.0.0.1 exploreemail.net
127.0.0.1 externalprivacy.com
127.0.0.1 extractsight.com
127.0.0.1 extrahoney.net
127.0.0.1 eyestoip.com
127.0.0.1 fallround.com
127.0.0.1 familyabroad.net
127.0.0.1 fashion-online.net
127.0.0.1 fashioncontainer.net
127.0.0.1 fatpop.net
127.0.0.1 fb-accounts.com
127.0.0.1 fbsecurity.co
127.0.0.1 feature-publish.net
127.0.0.1 feelbonesbag.com
127.0.0.1 feeltrail.com
127.0.0.1 fetchlink.net
127.0.0.1 files-downloads.com
127.0.0.1 findgoodfood.co
127.0.0.1 fitness-for-ever.com
127.0.0.1 foodeveryhour.com
127.0.0.1 formattingcells.com
127.0.0.1 forward-page.com
127.0.0.1 forward5costume.com
127.0.0.1 free247downloads.com
127.0.0.1 freedominfo.net
127.0.0.1 freeshoemoon.com
127.0.0.1 functionalcover.com
127.0.0.1 funintheuk.com
127.0.0.1 gadgetproof.net
127.0.0.1 getoutofyourmind.com
127.0.0.1 getpoints.net
127.0.0.1 glassesofwine.com
127.0.0.1 glasstaken.com
127.0.0.1 glittercases.net
127.0.0.1 global-redirect.net
127.0.0.1 globalnews247.net
127.0.0.1 good-games.org
127.0.0.1 goroskop.co
127.0.0.1 gossipsbollywoods.com
127.0.0.1 greensmallcanvas.com
127.0.0.1 greenwatermovement.com
127.0.0.1 growstart.net
127.0.0.1 halal-place.com
127.0.0.1 handcraftedformat.com
127.0.0.1 hatsampledc.com
127.0.0.1 health-club.online
127.0.0.1 healthykids-food.com
127.0.0.1 heavy-flood.com
127.0.0.1 hillsaround.com
127.0.0.1 hitrafficip.com
127.0.0.1 hmizat.co
127.0.0.1 holdstory.com
127.0.0.1 holecatorange.com
127.0.0.1 homeishere.co
127.0.0.1 host-redirect.net
127.0.0.1 hotinfosource.com
127.0.0.1 housesfurniture.com
127.0.0.1 htmlmetrics.com
127.0.0.1 httpaccess.com
127.0.0.1 humblebenefit.com
127.0.0.1 icrcworld.com
127.0.0.1 in-weather.com
127.0.0.1 in2date.com
127.0.0.1 inbox-messages.net
127.0.0.1 industry-specialist.com
127.0.0.1 ineediscounts.com
127.0.0.1 infospress.com
127.0.0.1 investormanage.net
127.0.0.1 ipjackets.com
127.0.0.1 islamiyaat.com
127.0.0.1 jeeyarworld.com
127.0.0.1 judgeauthority.com
127.0.0.1 kaidee.info
127.0.0.1 khaleejtimes.online
127.0.0.1 kingdom-news.com
127.0.0.1 knowseminar.com
127.0.0.1 last-chainleash.net
127.0.0.1 latest-songs.com
127.0.0.1 lawlowvat.net
127.0.0.1 layerprotect.com
127.0.0.1 layoutfill.com
127.0.0.1 leavehomego.com
127.0.0.1 letyoufall.com
127.0.0.1 levelsteelwhite.com
127.0.0.1 lifenoonkid.com
127.0.0.1 link-crawler.com
127.0.0.1 link-scan.net
127.0.0.1 lizzardsnail.com
127.0.0.1 loading-domain.com
127.0.0.1 loading-page.net
127.0.0.1 loading-url.net
127.0.0.1 loadthatpage.com
127.0.0.1 lowervalues.com
127.0.0.1 maghrebfoot.com
127.0.0.1 magicalipone.com
127.0.0.1 mainredirecter.com
127.0.0.1 maphonortea.com
127.0.0.1 mapupdatezone.com
127.0.0.1 martinipicnic.com
127.0.0.1 mealrentyard.com
127.0.0.1 medical-updates.com
127.0.0.1 medicalcircle.net
127.0.0.1 merchant-businesses.com
127.0.0.1 mergeandcenter.com
127.0.0.1 mobilebrowsing.net
127.0.0.1 monawa3ate.org
127.0.0.1 mondaymornings.co
127.0.0.1 morning-maps.com
127.0.0.1 motivation-go.com
127.0.0.1 mozillaname.com
127.0.0.1 multiplecurrencies.com
127.0.0.1 mybrightidea.co
127.0.0.1 mygummyjelly.com
127.0.0.1 myheartbuild.com
127.0.0.1 mylovelypet.net
127.0.0.1 nation-news.com
127.0.0.1 net-protector.com
127.0.0.1 netvisualizer.com
127.0.0.1 networkinfo.org
127.0.0.1 networkingproperty.com
127.0.0.1 neutralpages.com
127.0.0.1 newandfresh.com
127.0.0.1 newandroidapps.net
127.0.0.1 newarrivals.club
127.0.0.1 newip-info.com
127.0.0.1 news-flash.net
127.0.0.1 news-news.co
127.0.0.1 newscurrent.info
127.0.0.1 newsofgames.com
127.0.0.1 newworld-news.com
127.0.0.1 noextramoney.com
127.0.0.1 nomorewarnow.com
127.0.0.1 normal-strength.com
127.0.0.1 normalseason.com
127.0.0.1 nouvelles247.com
127.0.0.1 novosti247.com
127.0.0.1 now-online.net
127.0.0.1 nsoqa.com
127.0.0.1 offspringperform.net
127.0.0.1 old-glasses.net
127.0.0.1 online-loading.com
127.0.0.1 onlycart.net
127.0.0.1 onlytoday.biz
127.0.0.1 openingquestion.org
127.0.0.1 opera-van.com
127.0.0.1 operatingnews.com
127.0.0.1 opposedarrangement.net
127.0.0.1 optionstoreplace.com
127.0.0.1 orange-updates.com
127.0.0.1 ourorder.info
127.0.0.1 page-host.net
127.0.0.1 page-info.com
127.0.0.1 pageisloading.net
127.0.0.1 pageredirect.co
127.0.0.1 pageupdate.co
127.0.0.1 painting-walls.com
127.0.0.1 pastesbin.com
127.0.0.1 permalinking.com
127.0.0.1 pleaseusenew.net
127.0.0.1 popagency.net
127.0.0.1 port-connection.com
127.0.0.1 portredirect.net
127.0.0.1 posta.news
127.0.0.1 pourcentfilers.com
127.0.0.1 poweredlock.com
127.0.0.1 pprocessor.net
127.0.0.1 practicehazard.com
127.0.0.1 presidentialagent.com
127.0.0.1 preventadmission.com
127.0.0.1 primarystrike.net
127.0.0.1 projectgoals.net
127.0.0.1 quitmyjob.xyz
127.0.0.1 randomlane.net
127.0.0.1 rapidredirecting.com
127.0.0.1 readirectly.com
127.0.0.1 reception-desk.net
127.0.0.1 recordinglamping.com
127.0.0.1 redemptionphrase.com
127.0.0.1 redirect-connection.com
127.0.0.1 redirect-link.com
127.0.0.1 redirect-net.com
127.0.0.1 redirect-protocol.com
127.0.0.1 redirect-systems.com
127.0.0.1 redirect-tunnel.net
127.0.0.1 redirect2url.net
127.0.0.1 redirectchannel.net
127.0.0.1 redirectcheck.net
127.0.0.1 redirectconnection.net
127.0.0.1 redirecteur.net
127.0.0.1 redirecting-url.com
127.0.0.1 redirectit.net
127.0.0.1 redirectload.com
127.0.0.1 redirectnet.net
127.0.0.1 redirectprotocol.net
127.0.0.1 redirectshare.com
127.0.0.1 redstarnews.net
127.0.0.1 regionews.net
127.0.0.1 related-ads.com
127.0.0.1 reload-url.com
127.0.0.1 reload-url.net
127.0.0.1 reloading-page1.com
127.0.0.1 reloadinput.com
127.0.0.1 reloadpage.net
127.0.0.1 rentalindustries.com
127.0.0.1 reservationszone.com
127.0.0.1 restaurantsstar.com
127.0.0.1 revoke-dashboard.com
127.0.0.1 roadwide.net
127.0.0.1 robotscan.net
127.0.0.1 rosesforus.com
127.0.0.1 sabafon.info
127.0.0.1 safe-mondays.net
127.0.0.1 saltyapplepie.com
127.0.0.1 sec-checker.com
127.0.0.1 secretgirlfriend.net
127.0.0.1 securedloading.com
127.0.0.1 securedlogin.org
127.0.0.1 securisurf.com
127.0.0.1 send2url.com
127.0.0.1 sendhtml.net
127.0.0.1 sendingurl.com
127.0.0.1 sendingurl.net
127.0.0.1 servingshade.com
127.0.0.1 severalheroes.com
127.0.0.1 shortredirect.com
127.0.0.1 signpetition.co
127.0.0.1 simplycode.co
127.0.0.1 skillsforest.net
127.0.0.1 smoothurl.com
127.0.0.1 sms-sending.net
127.0.0.1 smscentro.com
127.0.0.1 smser.net
127.0.0.1 somuchrain.com
127.0.0.1 speedservicenow.com
127.0.0.1 spiritualbrakes.com
127.0.0.1 sportssaint.net
127.0.0.1 sportupdates.info
127.0.0.1 sslbind.com
127.0.0.1 standartsheet.com
127.0.0.1 standstock.net
127.0.0.1 starreturned.com
127.0.0.1 startupsservices.net
127.0.0.1 stopsms.biz
127.0.0.1 storelive.co
127.0.0.1 sunrise-brink.net
127.0.0.1 sunsetdnsnow.com
127.0.0.1 superlinks4u.com
127.0.0.1 sweet-water.org
127.0.0.1 syncingprocess.com
127.0.0.1 systemtrees.com
127.0.0.1 t-support.net
127.0.0.1 takemallelectric.com
127.0.0.1 techhelping.net
127.0.0.1 telangana-news24.com
127.0.0.1 telecom-info.com
127.0.0.1 thainews.asia
127.0.0.1 thankstossl.com
127.0.0.1 theappanalytics.com
127.0.0.1 thecoffeeilove.com
127.0.0.1 theredirect.net
127.0.0.1 thesimplestairs.com
127.0.0.1 tibetnews365.net
127.0.0.1 timelesscelebrity.com
127.0.0.1 timeofflife.com
127.0.0.1 tobepure.com
127.0.0.1 todaysdeals4u.com
127.0.0.1 toggletools.com
127.0.0.1 tookcheckout.com
127.0.0.1 topadblocker.net
127.0.0.1 tradeexchanging.com
127.0.0.1 transfer-rate.com
127.0.0.1 transferkeep.com
127.0.0.1 transferlights.com
127.0.0.1 travelight.online
127.0.0.1 trendsymbol.net
127.0.0.1 trialvariable.net
127.0.0.1 trianglerank.net
127.0.0.1 turkishairines.info
127.0.0.1 unonoticias.net
127.0.0.1 unsubscribed.co
127.0.0.1 unusualneighbor.com
127.0.0.1 updateapps.net
127.0.0.1 updating-link.com
127.0.0.1 updating-url.com
127.0.0.1 updating-url.net
127.0.0.1 updatingpage.com
127.0.0.1 updatingwebpage.com
127.0.0.1 url-hoster.com
127.0.0.1 url-redirect.com
127.0.0.1 url2all.net
127.0.0.1 urlconnection.net
127.0.0.1 urlpage-redirect.com
127.0.0.1 urlpush.net
127.0.0.1 urlredirect.net
127.0.0.1 urlregistrar.net
127.0.0.1 urlreload.net
127.0.0.1 urlscanner.net
127.0.0.1 urlsync.com
127.0.0.1 urlupdates.com
127.0.0.1 urlviaweb.com
127.0.0.1 utensils.pro
127.0.0.1 vanillaandcream.com
127.0.0.1 vault-encryption.com
127.0.0.1 vider-image.com
127.0.0.1 viedechretien.org
127.0.0.1 viewstracker.com
127.0.0.1 vipmasajes.com
127.0.0.1 waitingtoload.com
127.0.0.1 wasted-nights.com
127.0.0.1 weatherapi.co
127.0.0.1 web-check.co
127.0.0.1 web-domain.net
127.0.0.1 web-hoster.co
127.0.0.1 web-loading.net
127.0.0.1 web-page.co
127.0.0.1 web-scanner.co
127.0.0.1 web-spider.net
127.0.0.1 web-url.net
127.0.0.1 webadv.co
127.0.0.1 webpageupdate.co
127.0.0.1 webprotector.co
127.0.0.1 webprotocol.net
127.0.0.1 webresourcer.com
127.0.0.1 websiteconnecting.com
127.0.0.1 websiteeco.com
127.0.0.1 websitereconnecting.com
127.0.0.1 websitetosubmit.com
127.0.0.1 webstrings.net
127.0.0.1 websupporter.co
127.0.0.1 webupdater.net
127.0.0.1 whats-new.org
127.0.0.1 whatsapp-app.com
127.0.0.1 whatsappsupport.net
127.0.0.1 whereismybonus.com
127.0.0.1 winter-balance.com
127.0.0.1 wishdownget.com
127.0.0.1 wonderfulinsights.com
127.0.0.1 wordstore.net
127.0.0.1 working-online.net
127.0.0.1 xchange4u.net
127.0.0.1 xtremelivesupport.com
127.0.0.1 youintelligence.com
127.0.0.1 youliehow.com
127.0.0.1 yourbestclothes.com
127.0.0.1 yummyfoodallover.com
#</pegasus-spyware-sites>

#<ad-sites>
#<maybe-ads>
#127.0.0.1 adfarm.mediaplex.com		# may interfere with ebay
#127.0.0.1 ads.msn.com			#This may cause problems with zone.msn.com
#127.0.0.1 ak.imgfarm.com		# may cause problems with iwon.com
#127.0.0.1 click.linksynergy.com
#127.0.0.1 global.msads.net		#This may cause problems with zone.msn.com
#127.0.0.1 lads.myspace.com		# blocks myspace media/video players
#127.0.0.1 refer.ccbill.com		#affiliate program, to add it back, remove the #
#127.0.0.1 rmads.msn.com			#This may cause problems with zone.msn.com
#127.0.0.1 www.apmebf.com		#qksrv
#127.0.0.1 www.tkqlhce.com		#qksrv
#127.0.0.1 ad.ca.doubleclick.net	#intereferes with video on globeandmail.com
#127.0.0.1 transfer.go.com		#may interfere with Disney websites
#</maybe-ads>

# ads
 
#127.0.0.1 aax-eu.amazon-adsystem.com 	# may interfere with Amazon ad preferences
#127.0.0.1 s.amazon-adsystem.com	# may interfere with Amazon ad preferences
127.0.0.1 0101011.com
127.0.0.1 0427d7.se
127.0.0.1 0d79ed.r.axf8.net
127.0.0.1 0pn.ru
127.0.0.1 0qizz.super-promo.hoxo.info
127.0.0.1 1.allyes.com.cn
127.0.0.1 10.im.cz
127.0.0.1 104231.dtiblog.com
127.0.0.1 1097834592.rsc.cdn77.org
127.0.0.1 10fbb07a4b0.se
127.0.0.1 121media.com
127.0.0.1 123.fluxads.com
127.0.0.1 123plays.com
127.0.0.1 15.basebanner.com
127.0.0.1 15.taboola.com
127.0.0.1 1l-view.mail.ru
127.0.0.1 2.marketbanker.com
127.0.0.1 2.speedknow.co
127.0.0.1 207-87-18-203.wsmg.digex.net
127.0.0.1 2468.go2cloud.org
127.0.0.1 247playz.com
127.0.0.1 247support.adtech.fr
127.0.0.1 247support.adtech.us
127.0.0.1 24ora.eu
127.0.0.1 24ratownik.hit.gemius.pl
127.0.0.1 24trk.com
127.0.0.1 25184.hittail.com
127.0.0.1 2819.linux2.testsider.dk
127.0.0.1 2975c.v.fwmrm.net
127.0.0.1 2leep.com
127.0.0.1 2perc.info
127.0.0.1 321cba.com
127.0.0.1 32red.it
127.0.0.1 33across-match.dotomi.com
127.0.0.1 360ads.com
127.0.0.1 3fns.com
127.0.0.1 411playz.com
127.0.0.1 4c28d6.r.axf8.net
127.0.0.1 4qinvite.4q.iperceptions.com
127.0.0.1 4th3d48.com
127.0.0.1 6159.genieessp.com
127.0.0.1 6kup12tgxx.com
127.0.0.1 7500.com
127.0.0.1 76.a.boom.ro
127.0.0.1 7adpower.com
127.0.0.1 7bpeople.com
127.0.0.1 7xc4n.com
127.0.0.1 820.joomsearch.com
127.0.0.1 829331534d183e7d1f6a-8d91cc88b27b979d0ea53a10ce8855ec.r96.cf5.rackcdn.com
127.0.0.1 85103.hittail.com
127.0.0.1 8574dnj3yzjace8c8io6zr9u3n.hop.clickbank.net
127.0.0.1 888casino.com
127.0.0.1 961.com
127.0.0.1 9cd76b4462bb.com
127.0.0.1 AUSpolice.com
127.0.0.1 BRApolice.com
127.0.0.1 COMpolice.com
127.0.0.1 COMpolice.net
127.0.0.1 CYPpolice.com
127.0.0.1 EGYpolice.com
127.0.0.1 ETHpolice.com
127.0.0.1 GEOpolice.com
127.0.0.1 INDpolice.com
127.0.0.1 LUXpolice.com
127.0.0.1 LUXpolice.net
127.0.0.1 PAKpolice.com
127.0.0.1 USApolice.com
127.0.0.1 a-ads.com
127.0.0.1 a-blog.eu
127.0.0.1 a.1nimo.com
127.0.0.1 a.ad.playstation.net
127.0.0.1 a.adorika.net
127.0.0.1 a.adready.com
127.0.0.1 a.adroll.com
127.0.0.1 a.ads1.msn.com
127.0.0.1 a.ads2.msn.com
127.0.0.1 a.adstome.com
127.0.0.1 a.adtng.com
127.0.0.1 a.applvn.com
127.0.0.1 a.baidu.com
127.0.0.1 a.blesk.cz
127.0.0.1 a.boom.ro
127.0.0.1 a.cctv.com
127.0.0.1 a.centrum.cz
127.0.0.1 a.cntv.cn
127.0.0.1 a.denik.cz
127.0.0.1 a.dynad.net
127.0.0.1 a.iprima.cz
127.0.0.1 a.kerg.net
127.0.0.1 a.libertystmedia.com
127.0.0.1 a.ligatus.com
127.0.0.1 a.ligatus.de
127.0.0.1 a.mktw.net
127.0.0.1 a.o333o.com
127.0.0.1 a.prisacom.com
127.0.0.1 a.rad.live.com
127.0.0.1 a.rad.msn.com
127.0.0.1 a.slunecnice.cz
127.0.0.1 a.spolecznosci.net
127.0.0.1 a.ss34.on9mail.com
127.0.0.1 a.total-media.net
127.0.0.1 a.tribalfusion.com
127.0.0.1 a.triggit.com
127.0.0.1 a.twiago.com
127.0.0.1 a.websponsors.com
127.0.0.1 a2.mediagra.com
127.0.0.1 a3.suntimes.com
127.0.0.1 a7cleaner.com
127.0.0.1 aa.agkn.com
127.0.0.1 aa.tweakers.nl
127.0.0.1 aaa-architecten.nl
127.0.0.1 aaa-arcobaleno.it
127.0.0.1 aads.treehugger.com
127.0.0.1 aan.amazon.com
127.0.0.1 aarth.net
127.0.0.1 aax-cpm.amazon-adsystem.com
127.0.0.1 aax-us-east.amazon-adsystem.com
127.0.0.1 aax-us-pdx.amazon-adsystem.com
127.0.0.1 aax.amazon-adsystem.com
127.0.0.1 ab.tweakers.nl
127.0.0.1 ab913aa797e78b3.com
127.0.0.1 abi83-schramberg.de
127.0.0.1 abourselfi.com
127.0.0.1 abseckw.adtlgc.com
127.0.0.1 ac.atpanel.com
127.0.0.1 ac.rnm.ca
127.0.0.1 ac.tynt.com
127.0.0.1 academy-internet.net
127.0.0.1 acceptable.a-ads.com
127.0.0.1 acces.streaming-direct.co
127.0.0.1 accessfreevpn.com
127.0.0.1 accountprotection.xyz
127.0.0.1 achetezfacile.com
127.0.0.1 acs.56.com
127.0.0.1 acs.agent.56.com
127.0.0.1 acs.agent.v-56.com
127.0.0.1 action.mathtag.com
127.0.0.1 action.media6degrees.com
127.0.0.1 actiondesk.com
127.0.0.1 actionflash.com
127.0.0.1 actionsplash.com
127.0.0.1 acvs.mediaonenetwork.net
127.0.0.1 acvsrv.mediaonenetwork.net
127.0.0.1 ad-411.com
127.0.0.1 ad-audit.tubemogul.com
127.0.0.1 ad-balancer.net
127.0.0.1 ad-clicks.com
127.0.0.1 ad-delivery.net
127.0.0.1 ad-feeds.com
127.0.0.1 ad-flow.com
127.0.0.1 ad-gbn.com
127.0.0.1 ad-indicator.com
127.0.0.1 ad-mediation.tuanguwen.com
127.0.0.1 ad-plus.cn
127.0.0.1 ad-score.com
127.0.0.1 ad-server.co.za
127.0.0.1 ad-serverparc.nl
127.0.0.1 ad-souk.com
127.0.0.1 ad-sponsor.com
127.0.0.1 ad-srv.net
127.0.0.1 ad-u.com
127.0.0.1 ad-vice.biz
127.0.0.1 ad.103092804.com
127.0.0.1 ad.23blogs.com
127.0.0.1 ad.360yield.com
127.0.0.1 ad.3dnews.ru
127.0.0.1 ad.71i.de
127.0.0.1 ad.abcnews.com
127.0.0.1 ad.aboutwebservices.com
127.0.0.1 ad.adition.de
127.0.0.1 ad.adition.net
127.0.0.1 ad.adnet.biz
127.0.0.1 ad.adnet.de
127.0.0.1 ad.adnetwork.com.br
127.0.0.1 ad.adnetwork.net
127.0.0.1 ad.adorika.com
127.0.0.1 ad.adriver.ru
127.0.0.1 ad.adsmart.net
127.0.0.1 ad.adsrvr.org
127.0.0.1 ad.adtegrity.net
127.0.0.1 ad.adverticum.net
127.0.0.1 ad.advertstream.com
127.0.0.1 ad.adview.pl
127.0.0.1 ad.afilo.pl
127.0.0.1 ad.afy11.net
127.0.0.1 ad.agilemedia.jp
127.0.0.1 ad.allyes.cn
127.0.0.1 ad.amgdgt.com
127.0.0.1 ad.aquamediadirect.com
127.0.0.1 ad.auditude.com
127.0.0.1 ad.bannerbank.ru
127.0.0.1 ad.bnmla.com
127.0.0.1 ad.cctv.com
127.0.0.1 ad.cibleclick.com
127.0.0.1 ad.clickotmedia.com
127.0.0.1 ad.cooks.com
127.0.0.1 ad.dc2.adtech.de
127.0.0.1 ad.deviantart.com
127.0.0.1 ad.directmirror.com
127.0.0.1 ad.directrev.com
127.0.0.1 ad.dnoticias.pt
127.0.0.1 ad.doganburda.com
127.0.0.1 ad.doublemax.net
127.0.0.1 ad.duga.jp
127.0.0.1 ad.e-kolay.net
127.0.0.1 ad.egloos.com
127.0.0.1 ad.ekonomikticaret.com
127.0.0.1 ad.eporner.com
127.0.0.1 ad.ettoday.net
127.0.0.1 ad.eurosport.com
127.0.0.1 ad.filmweb.pl
127.0.0.1 ad.firstadsolution.com
127.0.0.1 ad.floq.jp
127.0.0.1 ad.flux.com
127.0.0.1 ad.fout.jp
127.0.0.1 ad.funpic.de
127.0.0.1 ad.garantiarkadas.com
127.0.0.1 ad.gazeta.pl
127.0.0.1 ad.ghfusion.com
127.0.0.1 ad.goo.ne.jp
127.0.0.1 ad.gr.doubleclick.net
127.0.0.1 ad.groupon.be
127.0.0.1 ad.groupon.co.uk
127.0.0.1 ad.groupon.com
127.0.0.1 ad.groupon.de
127.0.0.1 ad.groupon.fr
127.0.0.1 ad.groupon.net
127.0.0.1 ad.groupon.nl
127.0.0.1 ad.groupon.pl
127.0.0.1 ad.hankooki.com
127.0.0.1 ad.horvitznewspapers.net
127.0.0.1 ad.icasthq.com
127.0.0.1 ad.iconadserver.com
127.0.0.1 ad.iloveinterracial.com
127.0.0.1 ad.insightexpressai.com
127.0.0.1 ad.ir.ru
127.0.0.1 ad.jamba.net
127.0.0.1 ad.jamster.ca
127.0.0.1 ad.jokeroo.com
127.0.0.1 ad.kataweb.it
127.0.0.1 ad.kau.li
127.0.0.1 ad.krutilka.ru
127.0.0.1 ad.land.to
127.0.0.1 ad.leadbolt.net
127.0.0.1 ad.lgappstv.com
127.0.0.1 ad.linkexchange.com
127.0.0.1 ad.linkstorms.com
127.0.0.1 ad.linksynergy.com
127.0.0.1 ad.livere.co.kr
127.0.0.1 ad.lyricswire.com
127.0.0.1 ad.mail.ru
127.0.0.1 ad.mangareader.net
127.0.0.1 ad.mastermedia.ru
127.0.0.1 ad.media-servers.net
127.0.0.1 ad.moscowtimes.ru
127.0.0.1 ad.my.doubleclick.net
127.0.0.1 ad.ne.com
127.0.0.1 ad.net
127.0.0.1 ad.network60.com
127.0.0.1 ad.nicovideo.jp
127.0.0.1 ad.nozonedata.com
127.0.0.1 ad.ntvmsnbc.com
127.0.0.1 ad.ohmynews.com
127.0.0.1 ad.ourgame.com
127.0.0.1 ad.pandora.tv
127.0.0.1 ad.parom.hu
127.0.0.1 ad.partis.si
127.0.0.1 ad.pickple.net
127.0.0.1 ad.pravda.ru
127.0.0.1 ad.premiumonlinemedia.com
127.0.0.1 ad.propellerads.com
127.0.0.1 ad.prv.pl
127.0.0.1 ad.qq.com
127.0.0.1 ad.qyer.com
127.0.0.1 ad.realist.gen.tr
127.0.0.1 ad.realmcdn.net
127.0.0.1 ad.reklamport.com
127.0.0.1 ad.repubblica.it
127.0.0.1 ad.ru.doubleclick.net
127.0.0.1 ad.search.ch
127.0.0.1 ad.sensismediasmart.com
127.0.0.1 ad.sensismediasmart.com.au
127.0.0.1 ad.slashgear.com
127.0.0.1 ad.smartclip.net
127.0.0.1 ad.sxp.smartclip.net
127.0.0.1 ad.thetyee.ca
127.0.0.1 ad.thewheelof.com
127.0.0.1 ad.thisav.com
127.0.0.1 ad.trafficmp.com
127.0.0.1 ad.turn.com
127.0.0.1 ad.tv2.no
127.0.0.1 ad.usatoday.com
127.0.0.1 ad.userporn.com
127.0.0.1 ad.valuecalling.com
127.0.0.1 ad.weplayer.cc
127.0.0.1 ad.where.com
127.0.0.1 ad.wsod.com
127.0.0.1 ad.yadro.ru
127.0.0.1 ad.yemeksepeti.com
127.0.0.1 ad.yieldmanager.com
127.0.0.1 ad.zaman.com
127.0.0.1 ad.zanox.com
127.0.0.1 ad.zodera.hu
127.0.0.1 ad0.haynet.com
127.0.0.1 ad01.focalink.com
127.0.0.1 ad01.mediacorpsingapore.com
127.0.0.1 ad02.focalink.com
127.0.0.1 ad03.focalink.com
127.0.0.1 ad04.focalink.com
127.0.0.1 ad05.focalink.com
127.0.0.1 ad06.focalink.com
127.0.0.1 ad07.focalink.com
127.0.0.1 ad08.focalink.com
127.0.0.1 ad09.focalink.com
127.0.0.1 ad1.bannerbank.ru
127.0.0.1 ad1.checkm8.com
127.0.0.1 ad1.emediate.dk
127.0.0.1 ad1.gamezone.com
127.0.0.1 ad1.hotel.com
127.0.0.1 ad1.lbn.ru
127.0.0.1 ad1.popcap.com
127.0.0.1 ad10.bannerbank.ru
127.0.0.1 ad10.checkm8.com
127.0.0.1 ad10.focalink.com
127.0.0.1 ad101com.adbureau.net
127.0.0.1 ad10digital.checkm8.com
127.0.0.1 ad11.bannerbank.ru
127.0.0.1 ad11.checkm8.com
127.0.0.1 ad11.focalink.com
127.0.0.1 ad11digital.checkm8.com
127.0.0.1 ad12.bannerbank.ru
127.0.0.1 ad12.checkm8.com
127.0.0.1 ad12.focalink.com
127.0.0.1 ad12digital.checkm8.com
127.0.0.1 ad13.checkm8.com
127.0.0.1 ad13.focalink.com
127.0.0.1 ad131m.adk2.co
127.0.0.1 ad13digital.checkm8.com
127.0.0.1 ad14.checkm8.com
127.0.0.1 ad14.focalink.com
127.0.0.1 ad14digital.checkm8.com
127.0.0.1 ad15.checkm8.com
127.0.0.1 ad15.focalink.com
127.0.0.1 ad15digital.checkm8.com
127.0.0.1 ad16.checkm8.com
127.0.0.1 ad16.focalink.com
127.0.0.1 ad16digital.checkm8.com
127.0.0.1 ad17.checkm8.com
127.0.0.1 ad17.focalink.com
127.0.0.1 ad17digital.checkm8.com
127.0.0.1 ad18.checkm8.com
127.0.0.1 ad18.focalink.com
127.0.0.1 ad18digital.checkm8.com
127.0.0.1 ad19.checkm8.com
127.0.0.1 ad19.focalink.com
127.0.0.1 ad19digital.checkm8.com
127.0.0.1 ad1digital.checkm8.com
127.0.0.1 ad2.adecn.com
127.0.0.1 ad2.bannerbank.ru
127.0.0.1 ad2.bannerhost.ru
127.0.0.1 ad2.checkm8.com
127.0.0.1 ad2.cooks.com
127.0.0.1 ad2.firehousezone.com
127.0.0.1 ad2.gammae.com
127.0.0.1 ad2.hotel.com
127.0.0.1 ad2.lbn.ru
127.0.0.1 ad2.nationalreview.com
127.0.0.1 ad2.pl
127.0.0.1 ad2.zophar.net
127.0.0.1 ad20.checkm8.com
127.0.0.1 ad20.net
127.0.0.1 ad20digital.checkm8.com
127.0.0.1 ad21.checkm8.com
127.0.0.1 ad21digital.checkm8.com
127.0.0.1 ad22.checkm8.com
127.0.0.1 ad22digital.checkm8.com
127.0.0.1 ad23.checkm8.com
127.0.0.1 ad23digital.checkm8.com
127.0.0.1 ad24.checkm8.com
127.0.0.1 ad24digital.checkm8.com
127.0.0.1 ad25.checkm8.com
127.0.0.1 ad25digital.checkm8.com
127.0.0.1 ad26.checkm8.com
127.0.0.1 ad26digital.checkm8.com
127.0.0.1 ad27.checkm8.com
127.0.0.1 ad27digital.checkm8.com
127.0.0.1 ad28.checkm8.com
127.0.0.1 ad28digital.checkm8.com
127.0.0.1 ad29.checkm8.com
127.0.0.1 ad29digital.checkm8.com
127.0.0.1 ad2digital.checkm8.com
127.0.0.1 ad2games.com
127.0.0.1 ad3.adfarm1.adition.com
127.0.0.1 ad3.bannerbank.ru
127.0.0.1 ad3.checkm8.com
127.0.0.1 ad3.eu
127.0.0.1 ad3.lbn.ru
127.0.0.1 ad3.nationalreview.com
127.0.0.1 ad30.checkm8.com
127.0.0.1 ad30digital.checkm8.com
127.0.0.1 ad31.checkm8.com
127.0.0.1 ad31digital.checkm8.com
127.0.0.1 ad32.checkm8.com
127.0.0.1 ad32digital.checkm8.com
127.0.0.1 ad33.checkm8.com
127.0.0.1 ad33digital.checkm8.com
127.0.0.1 ad34.checkm8.com
127.0.0.1 ad34digital.checkm8.com
127.0.0.1 ad35.checkm8.com
127.0.0.1 ad35digital.checkm8.com
127.0.0.1 ad36.checkm8.com
127.0.0.1 ad36digital.checkm8.com
127.0.0.1 ad37.checkm8.com
127.0.0.1 ad37digital.checkm8.com
127.0.0.1 ad38.checkm8.com
127.0.0.1 ad38digital.checkm8.com
127.0.0.1 ad39.checkm8.com
127.0.0.1 ad39digital.checkm8.com
127.0.0.1 ad3digital.checkm8.com
127.0.0.1 ad4.adfarm1.adition.com
127.0.0.1 ad4.bannerbank.ru
127.0.0.1 ad4.checkm8.com
127.0.0.1 ad4.lbn.ru
127.0.0.1 ad4.speedbit.com
127.0.0.1 ad40.checkm8.com
127.0.0.1 ad40digital.checkm8.com
127.0.0.1 ad41.atlas.cz
127.0.0.1 ad41.checkm8.com
127.0.0.1 ad41digital.checkm8.com
127.0.0.1 ad42.checkm8.com
127.0.0.1 ad42digital.checkm8.com
127.0.0.1 ad43.checkm8.com
127.0.0.1 ad43digital.checkm8.com
127.0.0.1 ad44.checkm8.com
127.0.0.1 ad44digital.checkm8.com
127.0.0.1 ad45.checkm8.com
127.0.0.1 ad45digital.checkm8.com
127.0.0.1 ad46.checkm8.com
127.0.0.1 ad46digital.checkm8.com
127.0.0.1 ad47.checkm8.com
127.0.0.1 ad47digital.checkm8.com
127.0.0.1 ad48.checkm8.com
127.0.0.1 ad48digital.checkm8.com
127.0.0.1 ad49.checkm8.com
127.0.0.1 ad49digital.checkm8.com
127.0.0.1 ad4digital.checkm8.com
127.0.0.1 ad4game.com
127.0.0.1 ad4partners.com
127.0.0.1 ad5.bannerbank.ru
127.0.0.1 ad5.checkm8.com
127.0.0.1 ad5.lbn.ru
127.0.0.1 ad50.checkm8.com
127.0.0.1 ad50digital.checkm8.com
127.0.0.1 ad5digital.checkm8.com
127.0.0.1 ad6.bannerbank.ru
127.0.0.1 ad6.checkm8.com
127.0.0.1 ad6.horvitznewspapers.net
127.0.0.1 ad6digital.checkm8.com
127.0.0.1 ad6media.fr
127.0.0.1 ad7.bannerbank.ru
127.0.0.1 ad7.checkm8.com
127.0.0.1 ad7digital.checkm8.com
127.0.0.1 ad8.adfarm1.adition.com
127.0.0.1 ad8.bannerbank.ru
127.0.0.1 ad8.checkm8.com
127.0.0.1 ad8digital.checkm8.com
127.0.0.1 ad9.bannerbank.ru
127.0.0.1 ad9.checkm8.com
127.0.0.1 ad9digital.checkm8.com
127.0.0.1 adagiobanner.s3.amazonaws.com
127.0.0.1 adaos-ads.net
127.0.0.1 adap.tv
127.0.0.1 adapd.com
127.0.0.1 adashx.ut.taobao.com
127.0.0.1 adashx4ae.ut.taobao.com
127.0.0.1 adb.fling.com
127.0.0.1 adb.wp.pl
127.0.0.1 adbers.com
127.0.0.1 adbg.hit.gemius.pl
127.0.0.1 adbit.co
127.0.0.1 adblade.com
127.0.0.1 adblockanalytics.com
127.0.0.1 adbot.theonion.com
127.0.0.1 adbrite.com
127.0.0.1 adbucks.brandreachsys.com
127.0.0.1 adc2.adcentriconline.com
127.0.0.1 adc3-launch.adcolony.com
127.0.0.1 adcanadian.com
127.0.0.1 adcarem.co
127.0.0.1 adcash.com
127.0.0.1 adcast.deviantart.com
127.0.0.1 adcentric.randomseed.com
127.0.0.1 adcentriconline.com
127.0.0.1 adclick.hit.gemius.pl
127.0.0.1 adclient-af.lp.uol.com.br
127.0.0.1 adcode.adengage.com
127.0.0.1 adconscious.com
127.0.0.1 adcontent.gamespy.com
127.0.0.1 adcontent.reedbusiness.com
127.0.0.1 adcontroller.unicast.com
127.0.0.1 adcovery.com
127.0.0.1 adcycle.footymad.net
127.0.0.1 add.f5haber.com
127.0.0.1 addelivery.thestreet.com
127.0.0.1 addserver.mtv.com.tr
127.0.0.1 addstock.co.uk
127.0.0.1 addthis.com
127.0.0.1 addthiscdn.com
127.0.0.1 ade.wooboo.com.cn
127.0.0.1 adecn.com
127.0.0.1 adengine.rt.ru
127.0.0.1 adexc.net
127.0.0.1 adexchangegate.com
127.0.0.1 adexchangeprediction.com
127.0.0.1 adexpansion.com
127.0.0.1 adexprt.com
127.0.0.1 adexprt.me
127.0.0.1 adexprts.com
127.0.0.1 adext.inkclub.com
127.0.0.1 adfactor.nl
127.0.0.1 adfarm1.adition.com
127.0.0.1 adforce.adtech.fr
127.0.0.1 adforce.adtech.us
127.0.0.1 adform.com
127.0.0.1 adfusion.com
127.0.0.1 adgardener.com
127.0.0.1 adgraphics.theonion.com
127.0.0.1 adguanggao.eee114.com
127.0.0.1 adhearus.com
127.0.0.1 adhese.be
127.0.0.1 adhese.com
127.0.0.1 adhese.nieuwsblad.be
127.0.0.1 adhitzads.com
127.0.0.1 adhref.pl
127.0.0.1 adidm.idmnet.pl
127.0.0.1 adimage.asia1.com.sg
127.0.0.1 adimage.blm.net
127.0.0.1 adimages.earthweb.com
127.0.0.1 adimages.go.com
127.0.0.1 adimages.mp3.com
127.0.0.1 adimages.omroepzeeland.nl
127.0.0.1 adimg.activeadv.net
127.0.0.1 adimg.com.com
127.0.0.1 adin.bigpoint.com
127.0.0.1 adipics.com
127.0.0.1 adireland.com
127.0.0.1 adition.com
127.0.0.1 adjmps.com
127.0.0.1 adjuggler.net
127.0.0.1 adjuggler.yourdictionary.com
127.0.0.1 adkontekst.pl
127.0.0.1 adm.265g.com
127.0.0.1 adm.baidu.com
127.0.0.1 adm.funshion.com
127.0.0.1 adm.fwmrm.net
127.0.0.1 adm.shinobi.jp
127.0.0.1 adm.xmfish.com
127.0.0.1 adman.freeze.com
127.0.0.1 adman.gr
127.0.0.1 adman.se
127.0.0.1 admanage.com
127.0.0.1 admanager.btopenworld.com
127.0.0.1 admanager.collegepublisher.com
127.0.0.1 admarkt.marktplaats.nl
127.0.0.1 admatch-syndication.mochila.com
127.0.0.1 admatcher.videostrip.com
127.0.0.1 admd.yam.com
127.0.0.1 admedia.com
127.0.0.1 admedia.wsod.com
127.0.0.1 admeld.com
127.0.0.1 admerize.be
127.0.0.1 admez.com
127.0.0.1 admin.digitalacre.com
127.0.0.1 admin.hotkeys.com
127.0.0.1 admonkey.dapper.net
127.0.0.1 adms.physorg.com
127.0.0.1 adn.ebay.com
127.0.0.1 adn.zone-telechargement.com
127.0.0.1 adnet.asahi.com
127.0.0.1 adnet.biz
127.0.0.1 adnet.com
127.0.0.1 adnet.de
127.0.0.1 adnetwork.nextgen.net
127.0.0.1 adnetwork.rovicorp.com
127.0.0.1 adnetworkperformance.com
127.0.0.1 adnxs.com
127.0.0.1 adnxs.revsci.net
127.0.0.1 ado.pro-market.net
127.0.0.1 adobe-sync.dotomi.com
127.0.0.1 adobe.tt.omtrdc.net
127.0.0.1 adobee.com
127.0.0.1 adocean.pl
127.0.0.1 adonline.e-kolay.net
127.0.0.1 adopt.euroclick.com
127.0.0.1 adopt.precisead.com
127.0.0.1 adotube.com
127.0.0.1 adp.gazeta.pl
127.0.0.1 adpepper.dk
127.0.0.1 adping.qq.com
127.0.0.1 adprovider.adlure.net
127.0.0.1 adpulse.ads.targetnet.com
127.0.0.1 adq.nextag.com
127.0.0.1 adrazzi.com
127.0.0.1 adriver.ru
127.0.0.1 adroll.com
127.0.0.1 adrotator.se
127.0.0.1 adrunnr.com
127.0.0.1 ads-a.juicyads.com
127.0.0.1 ads-d.viber.com
127.0.0.1 ads-de.spray.net
127.0.0.1 ads-game-187f4.firebaseapp.com
127.0.0.1 ads-rm.looksmart.com
127.0.0.1 ads-rolandgarros.com
127.0.0.1 ads-roularta.adhese.com
127.0.0.1 ads-stats.com
127.0.0.1 ads-t.ru
127.0.0.1 ads.5ci.lt
127.0.0.1 ads.7days.ae
127.0.0.1 ads.abs-cbn.com
127.0.0.1 ads.accelerator-media.com
127.0.0.1 ads.aceweb.net
127.0.0.1 ads.ad-center.com
127.0.0.1 ads.ad4game.com
127.0.0.1 ads.adamoads.com
127.0.0.1 ads.adap.tv
127.0.0.1 ads.adaptv.advertising.com
127.0.0.1 ads.adbroker.de
127.0.0.1 ads.adcorps.com
127.0.0.1 ads.addesktop.com
127.0.0.1 ads.addynamix.com
127.0.0.1 ads.adengage.com
127.0.0.1 ads.adfox.ru
127.0.0.1 ads.adgoto.com
127.0.0.1 ads.adhall.com
127.0.0.1 ads.adhostingsolutions.com
127.0.0.1 ads.adk2.com
127.0.0.1 ads.admarvel.com
127.0.0.1 ads.admaximize.com
127.0.0.1 ads.adroar.com
127.0.0.1 ads.adsag.com
127.0.0.1 ads.adsbookie.com
127.0.0.1 ads.adshareware.net
127.0.0.1 ads.adsinimages.com
127.0.0.1 ads.adsonar.com
127.0.0.1 ads.adsrvmedia.com
127.0.0.1 ads.adsrvmedia.net
127.0.0.1 ads.adtegrity.net
127.0.0.1 ads.adtiger.de
127.0.0.1 ads.adultfriendfinder.com
127.0.0.1 ads.advance.net
127.0.0.1 ads.adverline.com
127.0.0.1 ads.adviva.net
127.0.0.1 ads.adworldnetwork.com
127.0.0.1 ads.adxpansion.com
127.0.0.1 ads.adxpose.com
127.0.0.1 ads.aerserv.com
127.0.0.1 ads.affiliates.match.com
127.0.0.1 ads.ahds.ac.uk
127.0.0.1 ads.al.com
127.0.0.1 ads.albawaba.com
127.0.0.1 ads.allsites.com
127.0.0.1 ads.allvertical.com
127.0.0.1 ads.almasdarnews.com
127.0.0.1 ads.amazingmedia.com
127.0.0.1 ads.amgdgt.com
127.0.0.1 ads.ami-admin.com
127.0.0.1 ads.apartmenttherapy.com
127.0.0.1 ads.api.vungle.com
127.0.0.1 ads.apn.co.nz
127.0.0.1 ads.apn.co.za
127.0.0.1 ads.araba.com
127.0.0.1 ads.aroundtherings.com
127.0.0.1 ads.as4x.tmcs.net
127.0.0.1 ads.as4x.tmcs.ticketmaster.com
127.0.0.1 ads.aspalliance.com
127.0.0.1 ads.aspentimes.com
127.0.0.1 ads.associatedcontent.com
127.0.0.1 ads.astalavista.us
127.0.0.1 ads.auctionads.com
127.0.0.1 ads.auctioncity.co.nz
127.0.0.1 ads.auctions.yahoo.com
127.0.0.1 ads.avazu.net
127.0.0.1 ads.aws.viber.com
127.0.0.1 ads.azjmp.com
127.0.0.1 ads.b10f.jp
127.0.0.1 ads.baazee.com
127.0.0.1 ads.bangkokpost.co.th
127.0.0.1 ads.bauerpublishing.com
127.0.0.1 ads.bbcworld.com
127.0.0.1 ads.bcnewsgroup.com
127.0.0.1 ads.beeb.com
127.0.0.1 ads.beliefnet.com
127.0.0.1 ads.belointeractive.com
127.0.0.1 ads.betweendigital.com
127.0.0.1 ads.bfast.com
127.0.0.1 ads.bianca.com
127.0.0.1 ads.bidclix.com
127.0.0.1 ads.bidstreamserver.com
127.0.0.1 ads.biggerboat.com
127.0.0.1 ads.bizhut.com
127.0.0.1 ads.bizx.info
127.0.0.1 ads.blixem.nl
127.0.0.1 ads.blog.com
127.0.0.1 ads.blogherads.com
127.0.0.1 ads.bloomberg.com
127.0.0.1 ads.bluemountain.com
127.0.0.1 ads.bonnint.net
127.0.0.1 ads.brabys.com
127.0.0.1 ads.brand.net
127.0.0.1 ads.buscape.com.br
127.0.0.1 ads.businessclick.com
127.0.0.1 ads.businessweek.com
127.0.0.1 ads.camrecord.com
127.0.0.1 ads.cardea.se
127.0.0.1 ads.carocean.co.uk
127.0.0.1 ads.casinocity.com
127.0.0.1 ads.catholic.org
127.0.0.1 ads.cavello.com
127.0.0.1 ads.cbc.ca
127.0.0.1 ads.cc-dt.com
127.0.0.1 ads.cdn.viber.com
127.0.0.1 ads.cdnow.com
127.0.0.1 ads.centraliprom.com
127.0.0.1 ads.cgchannel.com
127.0.0.1 ads.chalomumbai.com
127.0.0.1 ads.champs-elysees.com
127.0.0.1 ads.chipcenter.com
127.0.0.1 ads.chumcity.com
127.0.0.1 ads.cineville.nl
127.0.0.1 ads.cleveland.com
127.0.0.1 ads.clickability.com
127.0.0.1 ads.clickad.com.pl
127.0.0.1 ads.clickagents.com
127.0.0.1 ads.clubzone.com
127.0.0.1 ads.cluster01.oasis.zmh.zope.net
127.0.0.1 ads.cnixon.com
127.0.0.1 ads.cnngo.com
127.0.0.1 ads.cobrad.com
127.0.0.1 ads.collegclub.com
127.0.0.1 ads.collegemix.com
127.0.0.1 ads.com.com
127.0.0.1 ads.contactmusic.com
127.0.0.1 ads.contentabc.com
127.0.0.1 ads.coopson.com
127.0.0.1 ads.corusradionetwork.com
127.0.0.1 ads.courierpostonline.com
127.0.0.1 ads.crakmedia.com
127.0.0.1 ads.crapville.com
127.0.0.1 ads.creative-serving.com
127.0.0.1 ads.crosscut.com
127.0.0.1 ads.ctvdigital.net
127.0.0.1 ads.currantbun.com
127.0.0.1 ads.cvut.cz
127.0.0.1 ads.cybersales.cz
127.0.0.1 ads.dada.it
127.0.0.1 ads.ddj.com
127.0.0.1 ads.democratandchronicle.com
127.0.0.1 ads.dennisnet.co.uk
127.0.0.1 ads.designboom.com
127.0.0.1 ads.designtaxi.com
127.0.0.1 ads.desmoinesregister.com
127.0.0.1 ads.detelefoongids.nl
127.0.0.1 ads.deviantart.com
127.0.0.1 ads.digital-digest.com
127.0.0.1 ads.digitalacre.com
127.0.0.1 ads.digitalcaramel.com
127.0.0.1 ads.digitalmedianet.com
127.0.0.1 ads.digitalpoint.com
127.0.0.1 ads.dimcab.com
127.0.0.1 ads.directionsmag.com
127.0.0.1 ads.dk
127.0.0.1 ads.domeus.com
127.0.0.1 ads.dotomi.com
127.0.0.1 ads.drf.com
127.0.0.1 ads.e-planning.net
127.0.0.1 ads.ecircles.com
127.0.0.1 ads.economist.com
127.0.0.1 ads.einmedia.com
127.0.0.1 ads.eircom.net
127.0.0.1 ads.enliven.com
127.0.0.1 ads.erotism.com
127.0.0.1 ads.espn.adsonar.com
127.0.0.1 ads.eu.msn.com
127.0.0.1 ads.examiner.net
127.0.0.1 ads.exosrv.com
127.0.0.1 ads.expekt.com
127.0.0.1 ads.fairfax.com.au
127.0.0.1 ads.fayettevillenc.com
127.0.0.1 ads.fileindexer.com
127.0.0.1 ads.filmup.com
127.0.0.1 ads.first-response.be
127.0.0.1 ads.flashgames247.com
127.0.0.1 ads.fling.com
127.0.0.1 ads.floridatoday.com
127.0.0.1 ads.fool.com
127.0.0.1 ads.forbes.net
127.0.0.1 ads.fortunecity.com
127.0.0.1 ads.fox.com
127.0.0.1 ads.foxnews.com
127.0.0.1 ads.fredericksburg.com
127.0.0.1 ads.freebannertrade.com
127.0.0.1 ads.freeskreen.com
127.0.0.1 ads.freshmeat.net
127.0.0.1 ads.friendfinder.com
127.0.0.1 ads.fuckingmachines.com
127.0.0.1 ads.game.net
127.0.0.1 ads.gamecity.net
127.0.0.1 ads.gamecopyworld.no
127.0.0.1 ads.gamespyid.com
127.0.0.1 ads.garga.biz
127.0.0.1 ads.glispa.com
127.0.0.1 ads.globo.com
127.0.0.1 ads.gmodules.com
127.0.0.1 ads.gold
127.0.0.1 ads.golfweek.com
127.0.0.1 ads.gorillanation.com
127.0.0.1 ads.gplusmedia.com
127.0.0.1 ads.granadamedia.com
127.0.0.1 ads.greenbaypressgazette.com
127.0.0.1 ads.greenvilleonline.com
127.0.0.1 ads.guardian.co.uk
127.0.0.1 ads.guardianunlimited.co.uk
127.0.0.1 ads.haberler.com
127.0.0.1 ads.harpers.org
127.0.0.1 ads.hbv.de
127.0.0.1 ads.he.valueclick.net
127.0.0.1 ads.hearstmags.com
127.0.0.1 ads.heartlight.org
127.0.0.1 ads.heraldnet.com
127.0.0.1 ads.heroldonline.com
127.0.0.1 ads.hitcents.com
127.0.0.1 ads.hollandsentinel.com
127.0.0.1 ads.hollywood.com
127.0.0.1 ads.hulu.com.edgesuite.net
127.0.0.1 ads.i-am-bored.com
127.0.0.1 ads.icq.com
127.0.0.1 ads.ign.com
127.0.0.1 ads.illuminatednation.com
127.0.0.1 ads.indeed.com
127.0.0.1 ads.indiatimes.com
127.0.0.1 ads.indya.com
127.0.0.1 ads.indystar.com
127.0.0.1 ads.inetinteractive.com
127.0.0.1 ads.infi.net
127.0.0.1 ads.injersey.com
127.0.0.1 ads.intellicast.com
127.0.0.1 ads.intergi.com
127.0.0.1 ads.internic.co.il
127.0.0.1 ads.ipowerweb.com
127.0.0.1 ads.ireport.com
127.0.0.1 ads.isoftmarketing.com
127.0.0.1 ads.itv.com
127.0.0.1 ads.iwon.com
127.0.0.1 ads.jetpackdigital.com
127.0.0.1 ads.jewcy.com
127.0.0.1 ads.jimworld.com
127.0.0.1 ads.jokaroo.com
127.0.0.1 ads.jossip.com
127.0.0.1 ads.jpost.com
127.0.0.1 ads.juicyads.com
127.0.0.1 ads.keywordblocks.com
127.0.0.1 ads.koreanfriendfinder.com
127.0.0.1 ads.ksl.com
127.0.0.1 ads.kure.tv
127.0.0.1 ads.lfstmedia.com
127.0.0.1 ads.link4ads.com
127.0.0.1 ads.linktracking.net
127.0.0.1 ads.linuxjournal.com
127.0.0.1 ads.live365.com
127.0.0.1 ads.lmmob.com
127.0.0.1 ads.lucidmedia.com
127.0.0.1 ads.lycos.com
127.0.0.1 ads.lzjl.com
127.0.0.1 ads.madisonavenue.com
127.0.0.1 ads.magnetic.is
127.0.0.1 ads.mail3x.com
127.0.0.1 ads.mariuana.it
127.0.0.1 ads.mcafee.com
127.0.0.1 ads.mdchoice.com
127.0.0.1 ads.mediaforge.com
127.0.0.1 ads.mediamayhemcorp.com
127.0.0.1 ads.mediaodyssey.com
127.0.0.1 ads.mediaturf.net
127.0.0.1 ads.mefeedia.com
127.0.0.1 ads.megaproxy.com
127.0.0.1 ads.metblogs.com
127.0.0.1 ads.metropolis.co.jp
127.0.0.1 ads.mgnetwork.com
127.0.0.1 ads.mindsetnetwork.com
127.0.0.1 ads.mircx.com
127.0.0.1 ads.mlive.com
127.0.0.1 ads.mm.ap.org
127.0.0.1 ads.mofos.com
127.0.0.1 ads.mopub.com
127.0.0.1 ads.morningstar.com
127.0.0.1 ads.mouseplanet.com
127.0.0.1 ads.movieweb.com
127.0.0.1 ads.mozilla.org
127.0.0.1 ads.mp.mydas.mobi
127.0.0.1 ads.mp3searchy.com
127.0.0.1 ads.mtv.uol.com.br
127.0.0.1 ads.multimania.lycos.fr
127.0.0.1 ads.mustangworks.com
127.0.0.1 ads.mycricket.com
127.0.0.1 ads.mysimon.com
127.0.0.1 ads.mytelus.com
127.0.0.1 ads.nationalreview.com
127.0.0.1 ads.nerve.com
127.0.0.1 ads.netbul.com
127.0.0.1 ads.networkwcs.net
127.0.0.1 ads.networldmedia.net
127.0.0.1 ads.neudesicmediagroup.com
127.0.0.1 ads.newgrounds.com
127.0.0.1 ads.newsint.co.uk
127.0.0.1 ads.newsminerextra.com
127.0.0.1 ads.newsobserver.com
127.0.0.1 ads.newsquest.co.uk
127.0.0.1 ads.newtention.net
127.0.0.1 ads.nexage.com
127.0.0.1 ads.nicovideo.jp
127.0.0.1 ads.ninemsn.com.au
127.0.0.1 ads.nola.com
127.0.0.1 ads.northjersey.com
127.0.0.1 ads.novem.pl
127.0.0.1 ads.novinhagostosa10.com
127.0.0.1 ads.ntadvice.com
127.0.0.1 ads.nyi.net
127.0.0.1 ads.nyootv.com
127.0.0.1 ads.nytimes.com
127.0.0.1 ads.o2.pl
127.0.0.1 ads.ole.com
127.0.0.1 ads.omaha.com
127.0.0.1 ads.online.ie
127.0.0.1 ads.onvertise.com
127.0.0.1 ads.open.pl
127.0.0.1 ads.opensubtitles.org
127.0.0.1 ads.oregonlive.com
127.0.0.1 ads.osdn.com
127.0.0.1 ads.panoramtech.net
127.0.0.1 ads.paper.li
127.0.0.1 ads.parrysound.com
127.0.0.1 ads.paxnet.co.kr
127.0.0.1 ads.peel.com
127.0.0.1 ads.pennyweb.com
127.0.0.1 ads.people.com.cn
127.0.0.1 ads.persgroep.net
127.0.0.1 ads.phillyburbs.com
127.0.0.1 ads.phpclasses.org
127.0.0.1 ads.pitchforkmedia.com
127.0.0.1 ads.pittsburghlive.com
127.0.0.1 ads.pixiq.com
127.0.0.1 ads.planet-f1.com
127.0.0.1 ads.pni.com
127.0.0.1 ads.pno.net
127.0.0.1 ads.poconorecord.com
127.0.0.1 ads.pof.com
127.0.0.1 ads.pointroll.com
127.0.0.1 ads.premiumnetwork.net
127.0.0.1 ads.pressdemo.com
127.0.0.1 ads.pricescan.com
127.0.0.1 ads.prisacom.com
127.0.0.1 ads.pro-market.net
127.0.0.1 ads.pro-market.net.edgesuite.net
127.0.0.1 ads.profitsdeluxe.com
127.0.0.1 ads.profootballtalk.com
127.0.0.1 ads.program3.com
127.0.0.1 ads.prospect.org
127.0.0.1 ads.pruc.org
127.0.0.1 ads.pubmatic.com
127.0.0.1 ads.queendom.com
127.0.0.1 ads.ratemyprofessors.com
127.0.0.1 ads.rcgroups.com
127.0.0.1 ads.rdstore.com
127.0.0.1 ads.realcastmedia.com
127.0.0.1 ads.realcities.com
127.0.0.1 ads.realmedia.de
127.0.0.1 ads.rediff.com
127.0.0.1 ads.register.com
127.0.0.1 ads.reklamatik.com
127.0.0.1 ads.reklamlar.net
127.0.0.1 ads.revenue.net
127.0.0.1 ads.revsci.net
127.0.0.1 ads.roanoke.com
127.0.0.1 ads.roiserver.com
127.0.0.1 ads.rondomondo.com
127.0.0.1 ads.rootzoo.com
127.0.0.1 ads.rubiconproject.com
127.0.0.1 ads.ruralpress.com
127.0.0.1 ads.sacbee.com
127.0.0.1 ads.satyamonline.com
127.0.0.1 ads.scabee.com
127.0.0.1 ads.scifi.com
127.0.0.1 ads.scorecardresearch.com
127.0.0.1 ads.scott-sports.com
127.0.0.1 ads.scottusa.com
127.0.0.1 ads.servebom.com
127.0.0.1 ads.servenobid.com
127.0.0.1 ads.sexier.com
127.0.0.1 ads.sfusion.com
127.0.0.1 ads.shiftdelete.net
127.0.0.1 ads.shizmoo.com
127.0.0.1 ads.shovtvnet.com
127.0.0.1 ads.showtvnet.com
127.0.0.1 ads.simpli.fi
127.0.0.1 ads.simtel.com
127.0.0.1 ads.simtel.net
127.0.0.1 ads.sl.interpals.net
127.0.0.1 ads.smartclick.com
127.0.0.1 ads.smartclicks.com
127.0.0.1 ads.smartclicks.net
127.0.0.1 ads.smowtion.com
127.0.0.1 ads.snowball.com
127.0.0.1 ads.socialtheater.com
127.0.0.1 ads.space.com
127.0.0.1 ads.specificclick.com
127.0.0.1 ads.specificmedia.com
127.0.0.1 ads.spilgames.com
127.0.0.1 ads.spintrade.com
127.0.0.1 ads.spymac.net
127.0.0.1 ads.stackoverflow.com
127.0.0.1 ads.starbanner.com
127.0.0.1 ads.stephensmedia.com
127.0.0.1 ads.stileproject.com
127.0.0.1 ads.stoiximan.gr
127.0.0.1 ads.sumotorrent.com
127.0.0.1 ads.sup.com
127.0.0.1 ads.superonline.com
127.0.0.1 ads.swiftnews.com
127.0.0.1 ads.tbs.com
127.0.0.1 ads.technoratimedia.com
127.0.0.1 ads.techvibes.com
127.0.0.1 ads.techweb.com
127.0.0.1 ads.telecinco.es
127.0.0.1 ads.thecoolhunter.net
127.0.0.1 ads.thecrimson.com
127.0.0.1 ads.thefrisky.com
127.0.0.1 ads.theindependent.com
127.0.0.1 ads.themoneytizer.com
127.0.0.1 ads.theolympian.com
127.0.0.1 ads.thestar.com
127.0.0.1 ads.timesunion.com
127.0.0.1 ads.tmcs.net
127.0.0.1 ads.tnt.tv
127.0.0.1 ads.toronto.com
127.0.0.1 ads.townhall.com
127.0.0.1 ads.tracfonewireless.com
127.0.0.1 ads.track.net
127.0.0.1 ads.traderonline.com
127.0.0.1 ads.traffichaus.com
127.0.0.1 ads.trafficjunky.net
127.0.0.1 ads.treehugger.com
127.0.0.1 ads.trinitymirror.co.uk
127.0.0.1 ads.tripod.com
127.0.0.1 ads.tripod.lycos.co.uk
127.0.0.1 ads.tripod.lycos.de
127.0.0.1 ads.tripod.lycos.es
127.0.0.1 ads.tromaville.com
127.0.0.1 ads.trutv.com
127.0.0.1 ads.tw.adsonar.com
127.0.0.1 ads.uigc.net
127.0.0.1 ads.ukclimbing.com
127.0.0.1 ads.ultimatesurrender.com
127.0.0.1 ads.undertone.com
127.0.0.1 ads.uproar.com
127.0.0.1 ads.urbandictionary.com
127.0.0.1 ads.usatoday.com
127.0.0.1 ads.v3.com
127.0.0.1 ads.v3exchange.com
127.0.0.1 ads.vaildaily.com
127.0.0.1 ads.valuead.com
127.0.0.1 ads.vegas.com
127.0.0.1 ads.veloxia.com
127.0.0.1 ads.ventivmedia.com
127.0.0.1 ads.veoh.com
127.0.0.1 ads.viber.com
127.0.0.1 ads.videoadvertising.com
127.0.0.1 ads.vidoomy.com
127.0.0.1 ads.virginislandsdailynews.com
127.0.0.1 ads.virtualcountries.com
127.0.0.1 ads.waframedia1.com
127.0.0.1 ads.waps.cn
127.0.0.1 ads.wapx.cn
127.0.0.1 ads.weather.ca
127.0.0.1 ads.web.de
127.0.0.1 ads.web21.com
127.0.0.1 ads.webfeat.com
127.0.0.1 ads.webheat.com
127.0.0.1 ads.webhosting.info
127.0.0.1 ads.webindia123.com
127.0.0.1 ads.webmd.com
127.0.0.1 ads.webnet.advance.net
127.0.0.1 ads.winsite.com
127.0.0.1 ads.worldstarhiphop.com
127.0.0.1 ads.x17online.com
127.0.0.1 ads.xbox-scene.com
127.0.0.1 ads.xtra.ca
127.0.0.1 ads.xtra.co.nz
127.0.0.1 ads.xtramsn.co.nz
127.0.0.1 ads.yahoo.com
127.0.0.1 ads.yap.yahoo.com
127.0.0.1 ads.yimg.com
127.0.0.1 ads.yimg.com.edgesuite.net
127.0.0.1 ads.yldmgrimg.net
127.0.0.1 ads.youtube.com
127.0.0.1 ads.zamunda.se
127.0.0.1 ads.zynga.com
127.0.0.1 ads01.com
127.0.0.1 ads01.focalink.com
127.0.0.1 ads02.focalink.com
127.0.0.1 ads03.focalink.com
127.0.0.1 ads04.focalink.com
127.0.0.1 ads05.focalink.com
127.0.0.1 ads06.focalink.com
127.0.0.1 ads07.focalink.com
127.0.0.1 ads08.focalink.com
127.0.0.1 ads09.focalink.com
127.0.0.1 ads1.admedia.ro
127.0.0.1 ads1.advance.net
127.0.0.1 ads1.ami-admin.com
127.0.0.1 ads1.destructoid.com
127.0.0.1 ads1.erotism.com
127.0.0.1 ads1.jev.co.za
127.0.0.1 ads1.msads.net
127.0.0.1 ads1.msn.com
127.0.0.1 ads1.performancingads.com
127.0.0.1 ads1.realcities.com
127.0.0.1 ads1.revenue.net
127.0.0.1 ads1.updated.com
127.0.0.1 ads10.console.adtarget.com.tr
127.0.0.1 ads10.focalink.com
127.0.0.1 ads10.speedbit.com
127.0.0.1 ads106.console.adtarget.com.tr
127.0.0.1 ads108.console.adtarget.com.tr
127.0.0.1 ads11.console.adtarget.com.tr
127.0.0.1 ads11.focalink.com
127.0.0.1 ads110.console.adtarget.com.tr
127.0.0.1 ads114.console.adtarget.com.tr
127.0.0.1 ads115.console.adtarget.com.tr
127.0.0.1 ads119.console.adtarget.com.tr
127.0.0.1 ads12.console.adtarget.com.tr
127.0.0.1 ads12.focalink.com
127.0.0.1 ads128.console.adtarget.com.tr
127.0.0.1 ads129.console.adtarget.com.tr
127.0.0.1 ads13.console.adtarget.com.tr
127.0.0.1 ads13.focalink.com
127.0.0.1 ads130.console.adtarget.com.tr
127.0.0.1 ads13000.cpmoz.com
127.0.0.1 ads135.console.adtarget.com.tr
127.0.0.1 ads136.console.adtarget.com.tr
127.0.0.1 ads137.console.adtarget.com.tr
127.0.0.1 ads138.console.adtarget.com.tr
127.0.0.1 ads139.console.adtarget.com.tr
127.0.0.1 ads14.focalink.com
127.0.0.1 ads140.console.adtarget.com.tr
127.0.0.1 ads145.console.adtarget.com.tr
127.0.0.1 ads146.console.adtarget.com.tr
127.0.0.1 ads15.focalink.com
127.0.0.1 ads151.console.adtarget.com.tr
127.0.0.1 ads152.console.adtarget.com.tr
127.0.0.1 ads153.console.adtarget.com.tr
127.0.0.1 ads154.console.adtarget.com.tr
127.0.0.1 ads155.console.adtarget.com.tr
127.0.0.1 ads156.console.adtarget.com.tr
127.0.0.1 ads157.console.adtarget.com.tr
127.0.0.1 ads158.console.adtarget.com.tr
127.0.0.1 ads159.console.adtarget.com.tr
127.0.0.1 ads16.advance.net
127.0.0.1 ads16.focalink.com
127.0.0.1 ads160.console.adtarget.com.tr
127.0.0.1 ads163.console.adtarget.com.tr
127.0.0.1 ads17.focalink.com
127.0.0.1 ads18.console.adtarget.com.tr
127.0.0.1 ads18.focalink.com
127.0.0.1 ads19.focalink.com
127.0.0.1 ads1a.depositfiles.com
127.0.0.1 ads2-adnow.com
127.0.0.1 ads2.advance.net
127.0.0.1 ads2.clearchannel.com
127.0.0.1 ads2.clickad.com
127.0.0.1 ads2.collegclub.com
127.0.0.1 ads2.collegeclub.com
127.0.0.1 ads2.contentabc.com
127.0.0.1 ads2.gamecity.net
127.0.0.1 ads2.haber3.com
127.0.0.1 ads2.msn.com
127.0.0.1 ads2.opensubtitles.org
127.0.0.1 ads2.osdn.com
127.0.0.1 ads2.pittsburghlive.com
127.0.0.1 ads2.realcities.com
127.0.0.1 ads2.revenue.net
127.0.0.1 ads2.weblogssl.com
127.0.0.1 ads2.zeusclicks.com
127.0.0.1 ads20.console.adtarget.com.tr
127.0.0.1 ads20.focalink.com
127.0.0.1 ads201.console.adtarget.com.tr
127.0.0.1 ads202.console.adtarget.com.tr
127.0.0.1 ads203.console.adtarget.com.tr
127.0.0.1 ads206.console.adtarget.com.tr
127.0.0.1 ads21.focalink.com
127.0.0.1 ads210.console.adtarget.com.tr
127.0.0.1 ads214.console.adtarget.com.tr
127.0.0.1 ads215.console.adtarget.com.tr
127.0.0.1 ads216.console.adtarget.com.tr
127.0.0.1 ads217.console.adtarget.com.tr
127.0.0.1 ads218.console.adtarget.com.tr
127.0.0.1 ads219.console.adtarget.com.tr
127.0.0.1 ads22.focalink.com
127.0.0.1 ads22.host-cdn.net
127.0.0.1 ads23.focalink.com
127.0.0.1 ads24.console.adtarget.com.tr
127.0.0.1 ads24.focalink.com
127.0.0.1 ads24.net
127.0.0.1 ads240.console.adtarget.com.tr
127.0.0.1 ads241.console.adtarget.com.tr
127.0.0.1 ads244.console.adtarget.com.tr
127.0.0.1 ads25.focalink.com
127.0.0.1 ads250.console.adtarget.com.tr
127.0.0.1 ads256.console.adtarget.com.tr
127.0.0.1 ads257.console.adtarget.com.tr
127.0.0.1 ads258.console.adtarget.com.tr
127.0.0.1 ads259.console.adtarget.com.tr
127.0.0.1 ads28.console.adtarget.com.tr
127.0.0.1 ads29.console.adtarget.com.tr
127.0.0.1 ads2ads.net
127.0.0.1 ads2srv.com
127.0.0.1 ads3.advance.net
127.0.0.1 ads3.freebannertrade.com
127.0.0.1 ads3.gamecity.net
127.0.0.1 ads3.haber3.com
127.0.0.1 ads3.realcities.com
127.0.0.1 ads30.console.adtarget.com.tr
127.0.0.1 ads31.console.adtarget.com.tr
127.0.0.1 ads32.console.adtarget.com.tr
127.0.0.1 ads36.console.adtarget.com.tr
127.0.0.1 ads360.com
127.0.0.1 ads37.console.adtarget.com.tr
127.0.0.1 ads38.console.adtarget.com.tr
127.0.0.1 ads4.advance.net
127.0.0.1 ads4.console.adtarget.com.tr
127.0.0.1 ads4.gamecity.net
127.0.0.1 ads4.realcities.com
127.0.0.1 ads40.console.adtarget.com.tr
127.0.0.1 ads42.console.adtarget.com.tr
127.0.0.1 ads43.console.adtarget.com.tr
127.0.0.1 ads44.console.adtarget.com.tr
127.0.0.1 ads46.console.adtarget.com.tr
127.0.0.1 ads47.console.adtarget.com.tr
127.0.0.1 ads48.console.adtarget.com.tr
127.0.0.1 ads4cheap.com
127.0.0.1 ads4homes.com
127.0.0.1 ads5.advance.net
127.0.0.1 ads5.console.adtarget.com.tr
127.0.0.1 ads5.fxdepo.com
127.0.0.1 ads50.console.adtarget.com.tr
127.0.0.1 ads51.console.adtarget.com.tr
127.0.0.1 ads54.console.adtarget.com.tr
127.0.0.1 ads55.console.adtarget.com.tr
127.0.0.1 ads56.console.adtarget.com.tr
127.0.0.1 ads58.console.adtarget.com.tr
127.0.0.1 ads59.console.adtarget.com.tr
127.0.0.1 ads6.advance.net
127.0.0.1 ads6.gamecity.net
127.0.0.1 ads7.advance.net
127.0.0.1 ads7.console.adtarget.com.tr
127.0.0.1 ads7.gamecity.net
127.0.0.1 ads7.speedbit.com
127.0.0.1 ads8.com
127.0.0.1 ads8.console.adtarget.com.tr
127.0.0.1 ads80.com
127.0.0.1 adsadmin.corusradionetwork.com
127.0.0.1 adsatt.abcnews.starwave.com
127.0.0.1 adsatt.espn.go.com
127.0.0.1 adsatt.espn.starwave.com
127.0.0.1 adsbb.dfiles.eu
127.0.0.1 adscendmedia.com
127.0.0.1 adscholar.com
127.0.0.1 adsclick.qq.com
127.0.0.1 adsdaq.com
127.0.0.1 adsearch.adkontekst.pl
127.0.0.1 adsearch.pl
127.0.0.1 adsearch.wp.pl
127.0.0.1 adserv.bravenet.com
127.0.0.1 adserv.lwmn.net
127.0.0.1 adserv.maineguide.com
127.0.0.1 adserv.mywebtimes.com
127.0.0.1 adserv.postbulletin.com
127.0.0.1 adserv.quality-channel.de
127.0.0.1 adserv.usps.com
127.0.0.1 adserv001.adtech.fr
127.0.0.1 adserv001.adtech.us
127.0.0.1 adserv002.adtech.fr
127.0.0.1 adserv002.adtech.us
127.0.0.1 adserv003.adtech.fr
127.0.0.1 adserv003.adtech.us
127.0.0.1 adserv004.adtech.fr
127.0.0.1 adserv004.adtech.us
127.0.0.1 adserv005.adtech.fr
127.0.0.1 adserv005.adtech.us
127.0.0.1 adserv006.adtech.fr
127.0.0.1 adserv006.adtech.us
127.0.0.1 adserv007.adtech.fr
127.0.0.1 adserv007.adtech.us
127.0.0.1 adserv008.adtech.fr
127.0.0.1 adserv008.adtech.us
127.0.0.1 adserv2.bravenet.com
127.0.0.1 adserve.adtoll.com
127.0.0.1 adserve.city-ad.com
127.0.0.1 adserve.ehpub.com
127.0.0.1 adserve.gossipgirls.com
127.0.0.1 adserve.mizzenmedia.com
127.0.0.1 adserve.podaddies.com
127.0.0.1 adserve.profit-smart.com
127.0.0.1 adserve.shopzilla.com
127.0.0.1 adserve.viaarena.com
127.0.0.1 adserve5.nikkeibp.co.jp
127.0.0.1 adserver-2.ig.com.br
127.0.0.1 adserver-4.ig.com.br
127.0.0.1 adserver-5.ig.com.br
127.0.0.1 adserver-espnet.sportszone.net
127.0.0.1 adserver-images.adikteev.com
127.0.0.1 adserver-us.adtech.advertising.com
127.0.0.1 adserver.100free.com
127.0.0.1 adserver.3digit.de
127.0.0.1 adserver.71i.de
127.0.0.1 adserver.abv.bg
127.0.0.1 adserver.adreactor.com
127.0.0.1 adserver.adremedy.com
127.0.0.1 adserver.ads360.com
127.0.0.1 adserver.adtech.de
127.0.0.1 adserver.adtech.fr
127.0.0.1 adserver.adtech.us
127.0.0.1 adserver.adtechus.com
127.0.0.1 adserver.adultfriendfinder.com
127.0.0.1 adserver.advertist.com
127.0.0.1 adserver.affiliatemg.com
127.0.0.1 adserver.airmiles.ca
127.0.0.1 adserver.aol.fr
127.0.0.1 adserver.archant.co.uk
127.0.0.1 adserver.betandwin.de
127.0.0.1 adserver.bizland-inc.net
127.0.0.1 adserver.bluereactor.com
127.0.0.1 adserver.cams.com
127.0.0.1 adserver.cantv.net
127.0.0.1 adserver.cebu-online.com
127.0.0.1 adserver.chickclick.com
127.0.0.1 adserver.click4cash.de
127.0.0.1 adserver.clundressed.com
127.0.0.1 adserver.co.il
127.0.0.1 adserver.colleges.com
127.0.0.1 adserver.com
127.0.0.1 adserver.corusradionetwork.com
127.0.0.1 adserver.creative-asia.com
127.0.0.1 adserver.creativeinspire.com
127.0.0.1 adserver.dayrates.com
127.0.0.1 adserver.dbusiness.com
127.0.0.1 adserver.developersnetwork.com
127.0.0.1 adserver.digitoday.com
127.0.0.1 adserver.directforce.com
127.0.0.1 adserver.dnps.com
127.0.0.1 adserver.dotmusic.com
127.0.0.1 adserver.emulation64.com
127.0.0.1 adserver.exoticads.com
127.0.0.1 adserver.filefront.com
127.0.0.1 adserver.friendfinder.com
127.0.0.1 adserver.gameparty.net
127.0.0.1 adserver.gorillanation.com
127.0.0.1 adserver.gr
127.0.0.1 adserver.harktheherald.com
127.0.0.1 adserver.hellasnet.gr
127.0.0.1 adserver.hg-computer.de
127.0.0.1 adserver.home.pl
127.0.0.1 adserver.hostinteractive.com
127.0.0.1 adserver.humanux.com
127.0.0.1 adserver.hwupgrade.it
127.0.0.1 adserver.icmedienhaus.de
127.0.0.1 adserver.ign.com
127.0.0.1 adserver.infotiger.com
127.0.0.1 adserver.intentiq.com
127.0.0.1 adserver.interfree.it
127.0.0.1 adserver.inwind.it
127.0.0.1 adserver.ision.de
127.0.0.1 adserver.isonews.com
127.0.0.1 adserver.janes.com
127.0.0.1 adserver.janes.net
127.0.0.1 adserver.janes.org
127.0.0.1 adserver.juicyads.com
127.0.0.1 adserver.killeraces.com
127.0.0.1 adserver.kimia.es
127.0.0.1 adserver.kylemedia.com
127.0.0.1 adserver.lanacion.com.ar
127.0.0.1 adserver.legacy-network.com
127.0.0.1 adserver.libero.it
127.0.0.1 adserver.linktrader.co.uk
127.0.0.1 adserver.livejournal.com
127.0.0.1 adserver.lostreality.com
127.0.0.1 adserver.lunarpages.com
127.0.0.1 adserver.lycos.co.jp
127.0.0.1 adserver.magazyn.pl
127.0.0.1 adserver.matchcraft.com
127.0.0.1 adserver.merc.com
127.0.0.1 adserver.mindshare.de
127.0.0.1 adserver.mobsmith.com
127.0.0.1 adserver.myownemail.com
127.0.0.1 adserver.netcreators.nl
127.0.0.1 adserver.ngz-network.de
127.0.0.1 adserver.nydailynews.com
127.0.0.1 adserver.nzoom.com
127.0.0.1 adserver.o2.pl
127.0.0.1 adserver.omroepzeeland.nl
127.0.0.1 adserver.onwisconsin.com
127.0.0.1 adserver.passion.com
127.0.0.1 adserver.phatmax.net
127.0.0.1 adserver.phillyburbs.com
127.0.0.1 adserver.pl
127.0.0.1 adserver.planet-multiplayer.de
127.0.0.1 adserver.portal.pl
127.0.0.1 adserver.portalofevil.com
127.0.0.1 adserver.pressboard.ca
127.0.0.1 adserver.proteinos.com
127.0.0.1 adserver.radio-canada.ca
127.0.0.1 adserver.ro
127.0.0.1 adserver.sandbox.cxad.cxense.com
127.0.0.1 adserver.sanomawsoy.fi
127.0.0.1 adserver.sextracker.com
127.0.0.1 adserver.sharewareonline.com
127.0.0.1 adserver.sl.kharkov.ua
127.0.0.1 adserver.smashtv.com
127.0.0.1 adserver.snowball.com
127.0.0.1 adserver.softonic.com
127.0.0.1 adserver.soloserver.com
127.0.0.1 adserver.swiatobrazu.pl
127.0.0.1 adserver.te.pt
127.0.0.1 adserver.terra.com.br
127.0.0.1 adserver.terra.es
127.0.0.1 adserver.theknot.com
127.0.0.1 adserver.theonering.net
127.0.0.1 adserver.thirty4.com
127.0.0.1 adserver.thisislondon.co.uk
127.0.0.1 adserver.track-star.com
127.0.0.1 adserver.trader.ca
127.0.0.1 adserver.trafficsyndicate.com
127.0.0.1 adserver.tweakers.net
127.0.0.1 adserver.twitpic.com
127.0.0.1 adserver.ugo.nl
127.0.0.1 adserver.van.net
127.0.0.1 adserver.virginmedia.com
127.0.0.1 adserver.virtuous.co.uk
127.0.0.1 adserver.webads.co.uk
127.0.0.1 adserver.webads.nl
127.0.0.1 adserver.wietforum.nl
127.0.0.1 adserver.x3.hu
127.0.0.1 adserver.yahoo.com
127.0.0.1 adserver.zeads.com
127.0.0.1 adserver1-images.backbeatmedia.com
127.0.0.1 adserver1.adtech.com.tr
127.0.0.1 adserver1.backbeatmedia.com
127.0.0.1 adserver1.hookyouup.com
127.0.0.1 adserver1.mediainsight.de
127.0.0.1 adserver1.sonymusiceurope.com
127.0.0.1 adserver1.wmads.com
127.0.0.1 adserver2.atman.pl
127.0.0.1 adserver2.creative.com
127.0.0.1 adserver2.mediainsight.de
127.0.0.1 adserver9.contextad.com
127.0.0.1 adserversolutions.com
127.0.0.1 adservice.google.ca
127.0.0.1 adservice.google.co.za
127.0.0.1 adservice.google.com
127.0.0.1 adservice.google.com.au
127.0.0.1 adservice.google.cz
127.0.0.1 adservice.google.nl
127.0.0.1 adseu.novem.pl
127.0.0.1 adsfac.eu
127.0.0.1 adsfac.net
127.0.0.1 adsfac.us
127.0.0.1 adsfile.qq.com
127.0.0.1 adsgroup.qq.com
127.0.0.1 adshmct.qq.com
127.0.0.1 adshmmsg.qq.com
127.0.0.1 adsinimages.com
127.0.0.1 adsino24.com
127.0.0.1 adslvfile.qq.com
127.0.0.1 adslvseed.qq.com
127.0.0.1 adsm.soush.com
127.0.0.1 adsmart.co.uk
127.0.0.1 adsmart.com
127.0.0.1 adsmart.net
127.0.0.1 adsmetadata.startappservice.com
127.0.0.1 adsniper.ru
127.0.0.1 adsoftware.com
127.0.0.1 adsoldier.com
127.0.0.1 adsomenoise.cdn01.rambla.be
127.0.0.1 adson.awempire.com
127.0.0.1 adsonar.com
127.0.0.1 adsp.ciner.com.tr
127.0.0.1 adsp.haberturk.com
127.0.0.1 adspaces.ero-advertising.com
127.0.0.1 adspirit.net
127.0.0.1 adsqqclick.qq.com
127.0.0.1 adsrevenue.net
127.0.0.1 adsrich.qq.com
127.0.0.1 adsrv.dispatch.com
127.0.0.1 adsrv.hpg.com.br
127.0.0.1 adsrv.iol.co.za
127.0.0.1 adsrv.lua.pl
127.0.0.1 adsrv.me
127.0.0.1 adsrv.tuscaloosanews.com
127.0.0.1 adsrv.wilmingtonstar.com
127.0.0.1 adsrv2.wilmingtonstar.com
127.0.0.1 adsrvr.com
127.0.0.1 adsrvr.org
127.0.0.1 adssl01.adtech.fr
127.0.0.1 adssl01.adtech.us
127.0.0.1 adssl02.adtech.fr
127.0.0.1 adssl02.adtech.us
127.0.0.1 adsspace.net
127.0.0.1 adstest.reklamstore.com
127.0.0.1 adstextview.qq.com
127.0.0.1 adstil.indiatimes.com
127.0.0.1 adstogo.com
127.0.0.1 adstome.com
127.0.0.1 adstract.adk2x.com
127.0.0.1 adstream.cardboardfish.com
127.0.0.1 adsupplyads.net
127.0.0.1 adsvidsdouble.com
127.0.0.1 adsview.qq.com
127.0.0.1 adsview2.qq.com
127.0.0.1 adswakeup.com
127.0.0.1 adswizz-match.dotomi.com
127.0.0.1 adsxyz.com
127.0.0.1 adsyndication.msn.com
127.0.0.1 adsynergy.com
127.0.0.1 adsys.townnews.com
127.0.0.1 adtag.cc
127.0.0.1 adtag.msn.ca
127.0.0.1 adtag.sympatico.ca
127.0.0.1 adtaily.com
127.0.0.1 adtaily.pl
127.0.0.1 adtech.com
127.0.0.1 adtech.de
127.0.0.1 adtech.panthercustomer.com
127.0.0.1 adtechus.com
127.0.0.1 adtegrity.spinbox.net
127.0.0.1 adtext.pl
127.0.0.1 adthru.com
127.0.0.1 adtigerpl.adspirit.net
127.0.0.1 adtlgc.com
127.0.0.1 adtotal.pl
127.0.0.1 adtracking.vinden.nl
127.0.0.1 adtrader.com
127.0.0.1 adtrak.net
127.0.0.1 adultadworld.com
127.0.0.1 adv-mydarkness.ggcorp.me
127.0.0.1 adv-op2.joygames.me
127.0.0.1 adv.adgates.com
127.0.0.1 adv.adview.pl
127.0.0.1 adv.bbanner.it
127.0.0.1 adv.gazeta.pl
127.0.0.1 adv.lampsplus.com
127.0.0.1 adv.merlin.co.il
127.0.0.1 adv.publy.net
127.0.0.1 adv.strategy.it
127.0.0.1 adv.virgilio.it
127.0.0.1 adv.webmd.com
127.0.0.1 adv.wp.pl
127.0.0.1 advconversion.com
127.0.0.1 adveng.hiasys.com
127.0.0.1 adver.pengyou.com
127.0.0.1 advert.bayarea.com
127.0.0.1 advert.uloz.to
127.0.0.1 advertere.zamunda.net
127.0.0.1 adverteren.vakmedianet.nl
127.0.0.1 adverterenbijnh.nl
127.0.0.1 adverterenbijsbs.nl
127.0.0.1 advertise.com
127.0.0.1 advertisement.avosapps.us
127.0.0.1 advertising.aol.com
127.0.0.1 advertising.bbcworldwide.com
127.0.0.1 advertising.civitai.com
127.0.0.1 advertising.hiasys.com
127.0.0.1 advertising.illinimedia.com
127.0.0.1 advertising.online-media24.de
127.0.0.1 advertising.paltalk.com
127.0.0.1 advertising.wellpack.fr
127.0.0.1 advertisingbay.com
127.0.0.1 advertpro.investorvillage.com
127.0.0.1 advertpro.sitepoint.com
127.0.0.1 adverts.ecn.co.uk
127.0.0.1 adverts.freeloader.com
127.0.0.1 advertstream.com
127.0.0.1 advice-ads-cdn.vice.com
127.0.0.1 adview.pl
127.0.0.1 adviva.net
127.0.0.1 advmaker.ru
127.0.0.1 advplace.com
127.0.0.1 advserver.xyz
127.0.0.1 advt.webindia123.com
127.0.0.1 advzilla.com
127.0.0.1 adw.sapo.pt
127.0.0.1 adx.adform.net
127.0.0.1 adx.groupstate.com
127.0.0.1 adx.hendersonvillenews.com
127.0.0.1 adx.starnewsonline.com
127.0.0.1 adx.theledger.com
127.0.0.1 adxpose.com
127.0.0.1 adzerk.net
127.0.0.1 adzone.ro
127.0.0.1 afdyfxfrwbfy.com
127.0.0.1 afe.specificclick.net
127.0.0.1 afe2.specificclick.net
127.0.0.1 aff.promodeals.nl
127.0.0.1 aff.ringtonepartner.com
127.0.0.1 aff3.gittigidiyor.com
127.0.0.1 affiliate-fr.com
127.0.0.1 affiliate.2mdn.net
127.0.0.1 affiliate.a4dtracker.com
127.0.0.1 affiliate.baazee.com
127.0.0.1 affiliate.exabytes.com.my
127.0.0.1 affiliate.googleusercontent.com
127.0.0.1 affiliate.mlntracker.com
127.0.0.1 affiliates.arvixe.com
127.0.0.1 affiliates.eblastengine.com
127.0.0.1 affiliates.genealogybank.com
127.0.0.1 affiliates.globat.com
127.0.0.1 affiliation-france.com
127.0.0.1 affimg.pop6.com
127.0.0.1 afform.co.uk
127.0.0.1 affpartners.com
127.0.0.1 affrh2023.com
127.0.0.1 afftrack001.com
127.0.0.1 afftracking.justanswer.com
127.0.0.1 afilo.pl
127.0.0.1 afp.qiyi.com
127.0.0.1 afunnygames.com
127.0.0.1 agisdayra.com
127.0.0.1 agkn.com
127.0.0.1 agriturismoilcascinone.com
127.0.0.1 agt.net
127.0.0.1 ahzahg6ohb.com
127.0.0.1 ajanlom-magamat.com
127.0.0.1 ajcclassifieds.com
127.0.0.1 ak.buyservices.com
127.0.0.1 ak.maxserving.com
127.0.0.1 ak.sail-horizon.com
127.0.0.1 aka-cdn-ns.adtech.de
127.0.0.1 aka-cdn-ns.adtechus.com
127.0.0.1 aka-cdn.adtechus.com
127.0.0.1 aka.ms-ads.co
127.0.0.1 akaads-espn.starwave.com
127.0.0.1 akamai.invitemedia.com
127.0.0.1 ako.cc
127.0.0.1 aksdk-images.adikteev.com
127.0.0.1 aktiv-blog.com
127.0.0.1 alexanderjonesi.com
127.0.0.1 alfa-tel.sk
127.0.0.1 all.orfr.adgtw.orangeads.fr
127.0.0.1 alliance.adbureau.net
127.0.0.1 allkindlecloud.com
127.0.0.1 alternativhirek.blogspot.hu
127.0.0.1 alxsite.com
127.0.0.1 amazon-adsystem.com
127.0.0.1 amazon-tam-match.dotomi.com
127.0.0.1 amch.questionmarket.com
127.0.0.1 amobil.online
127.0.0.1 amplify.outbrain.com
127.0.0.1 amplifypixel.outbrain.com
127.0.0.1 amrytt.adk2x.com
127.0.0.1 ams1-ib.adnxs.com
127.0.0.1 ams1-mobile.adnxs.com
127.0.0.1 ams2.rumourobey.com
127.0.0.1 amusun.com
127.0.0.1 an.tacoda.net
127.0.0.1 an.yandex.ru
127.0.0.1 analysis.fc2.com
127.0.0.1 analytics.kwebsoft.com
127.0.0.1 analytics.onesearch.id
127.0.0.1 analytics.percentmobile.com
127.0.0.1 analytics.rayjump.com
127.0.0.1 analytics.services.kirra.nl
127.0.0.1 analytics.shareaholic.com
127.0.0.1 analytics.spotta.nl
127.0.0.1 analytics.verizonenterprise.com
127.0.0.1 analytics.vodafone.co.uk
127.0.0.1 analyzer51.fc2.com
127.0.0.1 andr0id.traffic-smart.com
127.0.0.1 anephangja.com
127.0.0.1 anepszava.com
127.0.0.1 anetit.tradedoubler.com
127.0.0.1 angeldonationblog.com
127.0.0.1 ankieta-online.pl
127.0.0.1 annuaire-autosurf.com
127.0.0.1 anonymous-net.com
127.0.0.1 anonymousstats.keefox.org
127.0.0.1 anrtx.tacoda.net
127.0.0.1 antyweb.push-ad.com
127.0.0.1 anycast.dt.adsafeprotected.com
127.0.0.1 ap.lijit.com
127.0.0.1 ap.read.mediation.pns.ap.orangeads.fr
127.0.0.1 apex-ad.com
127.0.0.1 api-public.addthis.com
127.0.0.1 api-s2s.taboola.com
127.0.0.1 api.adcalls.nl
127.0.0.1 api.addthis.com
127.0.0.1 api.adlure.net
127.0.0.1 api.affinesystems.com
127.0.0.1 api.airpush.com
127.0.0.1 api.content-ad.net
127.0.0.1 api.content.ad
127.0.0.1 api.linkgist.com
127.0.0.1 api.linkz.net
127.0.0.1 api.mixpanel.com
127.0.0.1 api.optnmnstr.com
127.0.0.1 api.sagent.io
127.0.0.1 api.shoppingminds.net
127.0.0.1 api.taboola.com
127.0.0.1 api.uprivaladserver.net
127.0.0.1 api.viglink.com
127.0.0.1 api.vodus.com
127.0.0.1 api.zhy333.com
127.0.0.1 apnx-match.dotomi.com
127.0.0.1 aporasal.net
127.0.0.1 app-measurement.com
127.0.0.1 app.datafastguru.info
127.0.0.1 app.monetizze.com.br
127.0.0.1 app.scanscout.com
127.0.0.1 app1.letitbefaster.website
127.0.0.1 app1.letmacworkfaster.site
127.0.0.1 app2.downloadmacsoft.world
127.0.0.1 app2.letitbefaster.website
127.0.0.1 app2.letmacwork.world
127.0.0.1 app2.letmacworkfaster.site
127.0.0.1 app3.letitbefaster.website
127.0.0.1 app3.letmacwork.world
127.0.0.1 app3.makeitworkfaster.life
127.0.0.1 app4.kromtech.net
127.0.0.1 app4.letitbefaster.website
127.0.0.1 app4.letslowbefast.life
127.0.0.1 app5.fastermac.tech
127.0.0.1 app5.letitbefaster.website
127.0.0.1 appdatum.com
127.0.0.1 appdev.addthis.com
127.0.0.1 appfixing.space
127.0.0.1 applicationpremium70.club
127.0.0.1 applyfix.tech
127.0.0.1 appnexus.com
127.0.0.1 appodeal.com
127.0.0.1 apps-blue.com
127.0.0.1 apps-cloud.xyz
127.0.0.1 apps5.oingo.com
127.0.0.1 appswiss.ch
127.0.0.1 apx.moatads.com
127.0.0.1 arbomedia.pl
127.0.0.1 arcadia1998.web.fc2.com
127.0.0.1 archifaktura.hu
127.0.0.1 arena.altitudeplatform.com
127.0.0.1 aritzal.com
127.0.0.1 arsconsole.global-intermedia.com
127.0.0.1 art-offer.com
127.0.0.1 as.adwise.bg
127.0.0.1 as.casalemedia.com
127.0.0.1 as.sexad.net
127.0.0.1 as.vs4entertainment.com
127.0.0.1 as.webmd.com
127.0.0.1 as1.inoventiv.com
127.0.0.1 as1image1.adshuffle.com
127.0.0.1 as1image2.adshuffle.com
127.0.0.1 asa.tynt.com
127.0.0.1 asb.tynt.com
127.0.0.1 ash.creativecdn.com
127.0.0.1 ashow.pcpop.com
127.0.0.1 ask-gps.ru
127.0.0.1 asklots.com
127.0.0.1 asm2.z1.adserver.com
127.0.0.1 asm3.z1.adserver.com
127.0.0.1 asmedia.adsupplyssl.com
127.0.0.1 assets.adnuntius.com
127.0.0.1 assets.applovin.com
127.0.0.1 assets.igapi.com
127.0.0.1 assets.kromtech.net
127.0.0.1 assets.percentmobile.com
127.0.0.1 assoc-amazon.com
127.0.0.1 assostudiosrl.it
127.0.0.1 asv.nuggad.net
127.0.0.1 at-adserver.alltop.com
127.0.0.1 at.m1.nedstatbasic.net
127.0.0.1 atdmt.com
127.0.0.1 atemda.com
127.0.0.1 athena-ads.wikia.com
127.0.0.1 atout-energie-69.com
127.0.0.1 au.ads.link4ads.com
127.0.0.1 au.adserver.yahoo.com
127.0.0.1 auction.unityads.unity3d.com
127.0.0.1 aud.pubmatic.com
127.0.0.1 audicat.net
127.0.0.1 audio-pa-service.de
127.0.0.1 aureate.com
127.0.0.1 aussiemethod.com
127.0.0.1 autocontext.begun.ru
127.0.0.1 automotive-offer.com
127.0.0.1 auxin-box.com
127.0.0.1 avidnewssource.com
127.0.0.1 avilagtitkai.com
127.0.0.1 avpa.javalobby.org
127.0.0.1 avworld.activehosted.com
127.0.0.1 avworld.lt.acemlnc.com
127.0.0.1 axp.zedo.com
127.0.0.1 azcentra.app.ur.gcion.com
127.0.0.1 azoaltou.com
127.0.0.1 azoogleads.com
127.0.0.1 aztbeszelik.com
127.0.0.1 b.adexchangemachine.com
127.0.0.1 b.ads2.msn.com
127.0.0.1 b.am15.net
127.0.0.1 b.codeonclick.com
127.0.0.1 b.grabo.bg
127.0.0.1 b.liquidustv.com
127.0.0.1 b.myspace.com
127.0.0.1 b.rad.live.com
127.0.0.1 b.rad.msn.com
127.0.0.1 b.recwwcc5.info
127.0.0.1 b1fe8a95ae27823.com
127.0.0.1 b34rightym.com
127.0.0.1 b400393baba7cd476a3.com
127.0.0.1 babanetwork.adk2x.com
127.0.0.1 babycenter.tt.omtrdc.net
127.0.0.1 bacskateszov.hu
127.0.0.1 badults.se
127.0.0.1 baiduccdn1.com
127.0.0.1 bak-home.com
127.0.0.1 bak0-store.com
127.0.0.1 balkanwide-assistance.rs
127.0.0.1 bamulat.blogspot.hu
127.0.0.1 banery.netart.pl
127.0.0.1 banery.onet.pl
127.0.0.1 banki.onet.pl
127.0.0.1 bankofamerica.tt.omtrdc.net
127.0.0.1 banner.betwwts.com
127.0.0.1 banner.boostbox.com.br
127.0.0.1 banner.cdpoker.com
127.0.0.1 banner.clubdicecasino.com
127.0.0.1 banner.coza.com
127.0.0.1 banner.diamondclubcasino.com
127.0.0.1 banner.easyspace.com
127.0.0.1 banner.media-system.de
127.0.0.1 banner.monacogoldcasino.com
127.0.0.1 banner.newyorkcasino.com
127.0.0.1 banner.northsky.com
127.0.0.1 banner.oddcast.com
127.0.0.1 banner.orb.net
127.0.0.1 banner.piratos.de
127.0.0.1 banner.playgatecasino.com
127.0.0.1 banner.rbc.ru
127.0.0.1 banner.relcom.ru
127.0.0.1 banner.ringofon.com
127.0.0.1 banner.techarp.com
127.0.0.1 banner1.pornhost.com
127.0.0.1 bannerads.anytimenews.com
127.0.0.1 bannerads.de
127.0.0.1 bannerads.zwire.com
127.0.0.1 bannerconnect.net
127.0.0.1 bannerhost.egamingonline.com
127.0.0.1 bannerimages.0catch.com
127.0.0.1 bannerpower.com
127.0.0.1 banners.adgoto.com
127.0.0.1 banners.adultfriendfinder.com
127.0.0.1 banners.affiliatefuel.com
127.0.0.1 banners.affiliatefuture.com
127.0.0.1 banners.aftrk.com
127.0.0.1 banners.blogads.com
127.0.0.1 banners.bol.se
127.0.0.1 banners.celebritybling.com
127.0.0.1 banners.img.uol.com.br
127.0.0.1 banners.ims.nl
127.0.0.1 banners.iop.org
127.0.0.1 banners.ipotd.com
127.0.0.1 banners.ksl.com
127.0.0.1 banners.linkbuddies.com
127.0.0.1 banners.nbcupromotes.com
127.0.0.1 banners.nextcard.com
127.0.0.1 banners.passion.com
127.0.0.1 banners.pennyweb.com
127.0.0.1 banners.resultonline.com
127.0.0.1 banners.sextracker.com
127.0.0.1 banners.tribute.ca
127.0.0.1 banners.unibet.com
127.0.0.1 banners.valuead.com
127.0.0.1 banners.videosecrets.com
127.0.0.1 banners.webmasterplan.com
127.0.0.1 banners.wunderground.com
127.0.0.1 banners.zbs.ru
127.0.0.1 banners3.spacash.com
127.0.0.1 bannersurvey.biz
127.0.0.1 bannerus1.axelsfun.com
127.0.0.1 bannerus3.axelsfun.com
127.0.0.1 banniere.reussissonsensemble.fr
127.0.0.1 bans.bride.ru
127.0.0.1 banstex.com
127.0.0.1 bansys.onzin.com
127.0.0.1 bar.baidu.com
127.0.0.1 barnesandnoble.bfast.com
127.0.0.1 baskidunyasi.net
127.0.0.1 bb.crwdcntrl.net
127.0.0.1 bbcdn.delivery.reklamz.com
127.0.0.1 bbcdn.go.eu.bbelements.com
127.0.0.1 bbcdn.go.pl.bbelements.com
127.0.0.1 bbelements.com
127.0.0.1 bbnaut.bbelements.com
127.0.0.1 bcp.crwdcntrl.net
127.0.0.1 bdnad1.bangornews.com
127.0.0.1 bdv.bidvertiser.com
127.0.0.1 be.ads.justpremium.com
127.0.0.1 beachfront-match.dotomi.com
127.0.0.1 beacon-3.newrelic.com
127.0.0.1 beaconin2.notinote.me
127.0.0.1 beap.gemini.yahoo.com
127.0.0.1 bell.adcentriconline.com
127.0.0.1 benimreklam.com
127.0.0.1 bespokeshirtsmail.com
127.0.0.1 best2017games.com
127.0.0.1 best2019-games-web1.com
127.0.0.1 best2020-games-web1.com
127.0.0.1 bestadbid.com
127.0.0.1 bestaryua.com
127.0.0.1 bestmmo2018.com
127.0.0.1 bestorican.com
127.0.0.1 bestwatersystems.net
127.0.0.1 bet-at-home.com
127.0.0.1 beta.hotkeys.com
127.0.0.1 betclic.com
127.0.0.1 bfast.com
127.0.0.1 bgrel.bonedmilfs.com
127.0.0.1 bicoinsprofit.com
127.0.0.1 bid.contextweb.com
127.0.0.1 bid.openx.net
127.0.0.1 bid.underdog.media
127.0.0.1 bidclix.net
127.0.0.1 bidsystem.com
127.0.0.1 bidtraffic.com
127.0.0.1 bidvertiser.com
127.0.0.1 bigads.guj.de
127.0.0.1 bigbrandpromotions.com
127.0.0.1 bigbrandrewards.com
127.0.0.1 bigfreelotto.com
127.0.0.1 biggestgiftrewards.com
127.0.0.1 bill.agent.56.com
127.0.0.1 bill.agent.v-56.com
127.0.0.1 billing.speedboink.com
127.0.0.1 bimg.abv.bg
127.0.0.1 bitburg.adtech.fr
127.0.0.1 bitburg.adtech.us
127.0.0.1 bitcast-d.bitgravity.com
127.0.0.1 bitcoadz.io
127.0.0.1 bitmedia.io
127.0.0.1 bitonclick.com
127.0.0.1 bitraffic.com
127.0.0.1 biz-offer.com
127.0.0.1 biz5.sandai.net
127.0.0.1 bizad.nikkeibp.co.jp
127.0.0.1 bizalmas.com
127.0.0.1 bizographics.com
127.0.0.1 bizony.eu
127.0.0.1 bl.wavecdn.de
127.0.0.1 blackbass.mx
127.0.0.1 blackqpid.org.uk
127.0.0.1 blockchaintop.nl
127.0.0.1 blog.addthis.com
127.0.0.1 blog.br0vvnn.io
127.0.0.1 blogads.com
127.0.0.1 blogvertising.pl
127.0.0.1 bloodsugarberry.com
127.0.0.1 bloodsugrs.shop
127.0.0.1 blu.mobileads.msn.com
127.0.0.1 blueconic.net
127.0.0.1 bluediamondoffers.com
127.0.0.1 blueeyesintelligence.org
127.0.0.1 bm.alimama.cn
127.0.0.1 bmgiventures.com
127.0.0.1 bmvip.alimama.cn
127.0.0.1 bn.bfast.com
127.0.0.1 bnmgr.adinjector.net
127.0.0.1 bnrs.ilm.ee
127.0.0.1 bodelen.com
127.0.0.1 boksy.dir.onet.pl
127.0.0.1 boksy.onet.pl
127.0.0.1 bongacams.com
127.0.0.1 bookpdf.services
127.0.0.1 bootsstation-reiherhals.de
127.0.0.1 boroskola.info
127.0.0.1 boskrut.com
127.0.0.1 bosmafamily.nl
127.0.0.1 box-en.com
127.0.0.1 bp.adkmob.com
127.0.0.1 bp.specificclick.net
127.0.0.1 br.adserver.yahoo.com
127.0.0.1 br.naked.com
127.0.0.1 braccom.ch
127.0.0.1 brandsurveypanel.com
127.0.0.1 brandveiligheidsexperts.nl
127.0.0.1 bravo.israelinfo.ru
127.0.0.1 bravospots.com
127.0.0.1 breakthroughtrend.com
127.0.0.1 brekus.org
127.0.0.1 broadcast.piximedia.fr
127.0.0.1 brokertraffic.com
127.0.0.1 browser-tools.systems
127.0.0.1 browsergames2018.com
127.0.0.1 browsergames2019.com
127.0.0.1 browserprotecter.com
127.0.0.1 browsesentinel.com
127.0.0.1 brxfinance.com
127.0.0.1 bs.serving-sys.com
127.0.0.1 bs.url.tw
127.0.0.1 bsnj.eyeblaster.akadns.net
127.0.0.1 btbuyerapp.com
127.0.0.1 budapest1873.net
127.0.0.1 buf.lemonde.fr
127.0.0.1 bufetgarrigosa.com
127.0.0.1 bumerangshowsites.hurriyet.com.tr
127.0.0.1 bundasnovinhas.com
127.0.0.1 buresova-obrazy.wz.cz
127.0.0.1 burns.adtech.fr
127.0.0.1 burns.adtech.us
127.0.0.1 bus-offer.com
127.0.0.1 buttcandy.com
127.0.0.1 buttons.googlesyndication.com
127.0.0.1 buzzadnetwork.com
127.0.0.1 buzzonclick.com
127.0.0.1 bwp.lastfm.com.com
127.0.0.1 c.actiondesk.com
127.0.0.1 c.ad6media.fr
127.0.0.1 c.adexchangemachine.com
127.0.0.1 c.admob.com
127.0.0.1 c.adroll.com
127.0.0.1 c.adsco.re
127.0.0.1 c.amazon-adsystem.com
127.0.0.1 c.anytrx.com
127.0.0.1 c.ar.msn.com
127.0.0.1 c.at.msn.com
127.0.0.1 c.be.msn.com
127.0.0.1 c.bebi.com
127.0.0.1 c.br.msn.com
127.0.0.1 c.ca.msn.com
127.0.0.1 c.casalemedia.com
127.0.0.1 c.cl.msn.com
127.0.0.1 c.codeonclick.com
127.0.0.1 c.company-target.com
127.0.0.1 c.de.msn.com
127.0.0.1 c.dk.msn.com
127.0.0.1 c.dynad.net
127.0.0.1 c.eblastengine.com
127.0.0.1 c.es.msn.com
127.0.0.1 c.fi.msn.com
127.0.0.1 c.fr.msn.com
127.0.0.1 c.gr.msn.com
127.0.0.1 c.hk.msn.com
127.0.0.1 c.id.msn.com
127.0.0.1 c.ie.msn.com
127.0.0.1 c.il.msn.com
127.0.0.1 c.imedia.cz
127.0.0.1 c.in.msn.com
127.0.0.1 c.it.msn.com
127.0.0.1 c.jp.msn.com
127.0.0.1 c.l.qq.com
127.0.0.1 c.latam.msn.com
127.0.0.1 c.lomadee.com
127.0.0.1 c.media-dl.co
127.0.0.1 c.mgid.com
127.0.0.1 c.my.msn.com
127.0.0.1 c.nl.msn.com
127.0.0.1 c.no.msn.com
127.0.0.1 c.novostimira.biz
127.0.0.1 c.ph.msn.com
127.0.0.1 c.prodigy.msn.com
127.0.0.1 c.pt.msn.com
127.0.0.1 c.ru.msn.com
127.0.0.1 c.se.msn.com
127.0.0.1 c.seznam.cz
127.0.0.1 c.sg.msn.com
127.0.0.1 c.silvinst.com
127.0.0.1 c.th.msn.com
127.0.0.1 c.tr.msn.com
127.0.0.1 c.tw.msn.com
127.0.0.1 c.uk.msn.com
127.0.0.1 c.za.msn.com
127.0.0.1 c0011.boursorama.com
127.0.0.1 c1.adform.net
127.0.0.1 c1.cembuyukhanli.com
127.0.0.1 c1.popads.net
127.0.0.1 c1.somalisounds.com
127.0.0.1 c1.teaser-goods.ru
127.0.0.1 c1.zedo.com
127.0.0.1 c11370896.c.youradexchange.com
127.0.0.1 c2.cembuyukhanli.com
127.0.0.1 c2.l.qq.com
127.0.0.1 c2.popads.net
127.0.0.1 c2.somalisounds.com
127.0.0.1 c2.taboola.com
127.0.0.1 c2.zedo.com
127.0.0.1 c2366475.c.youradexchange.com
127.0.0.1 c3.cembuyukhanli.com
127.0.0.1 c3.somalisounds.com
127.0.0.1 c3.zedo.com
127.0.0.1 c35000246.c.youradexchange.com
127.0.0.1 c4.cembuyukhanli.com
127.0.0.1 c4.maxserving.com
127.0.0.1 c4.somalisounds.com
127.0.0.1 c4.zedo.com
127.0.0.1 c4tracking01.com
127.0.0.1 c5.cembuyukhanli.com
127.0.0.1 c5.somalisounds.com
127.0.0.1 c5.zedo.com
127.0.0.1 c6.cembuyukhanli.com
127.0.0.1 c6.somalisounds.com
127.0.0.1 c6.zedo.com
127.0.0.1 c7.cembuyukhanli.com
127.0.0.1 c7.somalisounds.com
127.0.0.1 c7.zedo.com
127.0.0.1 c8.zedo.com
127.0.0.1 ca.adserver.yahoo.com
127.0.0.1 ca3.revieworbit.com
127.0.0.1 ca4.revieworbit.com
127.0.0.1 cabrerapelaez.com
127.0.0.1 cache-dev.addthis.com
127.0.0.1 cache.addthis.com
127.0.0.1 cache.addthiscdn.com
127.0.0.1 cache.adm.cnzz.net
127.0.0.1 cache.betweendigital.com
127.0.0.1 cache.unicast.com
127.0.0.1 cacheserve.eurogrand.com
127.0.0.1 cadsans.com
127.0.0.1 cam2cam.xlovecam.com
127.0.0.1 camgeil.com
127.0.0.1 campaigns.f2.com.au
127.0.0.1 canadaalltax.com
127.0.0.1 canuckmethod.com
127.0.0.1 canva2023.com
127.0.0.1 capath.com
127.0.0.1 carambo.la
127.0.0.1 cardgamespidersolitaire.com
127.0.0.1 cards.virtuagirlhd.com
127.0.0.1 careersincorrectquickie.com
127.0.0.1 carmuffler.net
127.0.0.1 carnegienet.net
127.0.0.1 cas.clickability.com
127.0.0.1 cas.criteo.com
127.0.0.1 casale-match.dotomi.com
127.0.0.1 casalemedia.com
127.0.0.1 cashback.co.uk
127.0.0.1 cashbackwow.co.uk
127.0.0.1 cashflowmarketing.com
127.0.0.1 cashreportz.com
127.0.0.1 casino770.com
127.0.0.1 caslemedia.com
127.0.0.1 casting.openv.com
127.0.0.1 cb.alimama.cn
127.0.0.1 cb.baidu.com
127.0.0.1 cbango.com.ar
127.0.0.1 cbanners.virtuagirlhd.com
127.0.0.1 cc-dt.com
127.0.0.1 ccb.myzen.co.uk
127.0.0.1 ccpmo.com
127.0.0.1 cctv.adsunion.com
127.0.0.1 cdbs.com.tr
127.0.0.1 cdddfia.hornylocals24.com
127.0.0.1 cdn.8digits.com
127.0.0.1 cdn.acloudvideos.com
127.0.0.1 cdn.ad.citynews.it
127.0.0.1 cdn.ad.plus
127.0.0.1 cdn.adikteev.com
127.0.0.1 cdn.adk2.com
127.0.0.1 cdn.adnxs.com
127.0.0.1 cdn.adplxmd.com
127.0.0.1 cdn.adservingsolutionsinc.com
127.0.0.1 cdn.adskeeper.co.uk
127.0.0.1 cdn.adsrvmedia.net
127.0.0.1 cdn.adtrue.com
127.0.0.1 cdn.altitudeplatform.com
127.0.0.1 cdn.amgdgt.com
127.0.0.1 cdn.assets.craveonline.com
127.0.0.1 cdn.atlassbx.com
127.0.0.1 cdn.augur.io
127.0.0.1 cdn.axphotoalbum.top
127.0.0.1 cdn.ayads.co
127.0.0.1 cdn.banners.scubl.com
127.0.0.1 cdn.betgorebysson.club
127.0.0.1 cdn.braun634.com
127.0.0.1 cdn.carbonads.com
127.0.0.1 cdn.constafun.com
127.0.0.1 cdn.cpmstar.com
127.0.0.1 cdn.directrev.com
127.0.0.1 cdn.epommarket.com
127.0.0.1 cdn.freefaits.com
127.0.0.1 cdn.freefarcy.com
127.0.0.1 cdn.freehonor.com
127.0.0.1 cdn.freejars.com
127.0.0.1 cdn.freejax.com
127.0.0.1 cdn.freelac.com
127.0.0.1 cdn.getsmartcontent.com
127.0.0.1 cdn.hauleddes.com
127.0.0.1 cdn.innovid.com
127.0.0.1 cdn.inskinad.com
127.0.0.1 cdn.mediative.ca
127.0.0.1 cdn.mobicow.com
127.0.0.1 cdn.nativery.com
127.0.0.1 cdn.nearbyad.com
127.0.0.1 cdn.nsimg.net
127.0.0.1 cdn.onescreen.net
127.0.0.1 cdn.onthe.io
127.0.0.1 cdn.owebanalytics.com
127.0.0.1 cdn.sagent.io
127.0.0.1 cdn.stat-rock.com
127.0.0.1 cdn.stickyadstv.com
127.0.0.1 cdn.syn.verticalacuity.com
127.0.0.1 cdn.taboola.com
127.0.0.1 cdn.trafficstars.com
127.0.0.1 cdn.udmserve.net
127.0.0.1 cdn.undertone.com
127.0.0.1 cdn.usabilitytracker.com
127.0.0.1 cdn.viglink.com
127.0.0.1 cdn.wg.uproxx.com
127.0.0.1 cdn.wwwpromoter.com
127.0.0.1 cdn.yottos.com
127.0.0.1 cdn.zeusclicks.com
127.0.0.1 cdn1.ad-center.com
127.0.0.1 cdn1.adexprt.com
127.0.0.1 cdn1.ads.contentabc.com
127.0.0.1 cdn1.rmgserving.com
127.0.0.1 cdn1.smartadserver.com
127.0.0.1 cdn1.traffichaus.com
127.0.0.1 cdn1sitescout.edgesuite.net
127.0.0.1 cdn2.ad-center.com
127.0.0.1 cdn2.adsdk.com
127.0.0.1 cdn2.emediate.eu
127.0.0.1 cdn3.adexprts.com
127.0.0.1 cdn5.tribalfusion.com
127.0.0.1 cdn6.emediate.eu
127.0.0.1 cdnads.cam4.com
127.0.0.1 cdnaws.mobidea.com
127.0.0.1 cdns.mydirtyhobby.com
127.0.0.1 cds.adecn.com
127.0.0.1 cds.taboola.com
127.0.0.1 ce.lijit.com
127.0.0.1 cecash.com
127.0.0.1 ced.sascdn.com
127.0.0.1 cekornapred.org
127.0.0.1 cellphoneincentives.com
127.0.0.1 cent.adbureau.net
127.0.0.1 center-message-mobile.com
127.0.0.1 certifiedwinners.info
127.0.0.1 cetelemportugal2.solution.weborama.fr
127.0.0.1 cf.kampyle.com
127.0.0.1 cfg.adsmogo.com
127.0.0.1 cfg.datafastguru.info
127.0.0.1 cgirm.greatfallstribune.com
127.0.0.1 cgmt.co.id
127.0.0.1 chaintopdom.nl
127.0.0.1 channelvue.com.au
127.0.0.1 charging-technology.com
127.0.0.1 charmflirt.com
127.0.0.1 charmstroy.info
127.0.0.1 chartbeat.com
127.0.0.1 chatgpt-premium.com
127.0.0.1 chechla.cnixon.com
127.0.0.1 cherryhi.app.ur.gcion.com
127.0.0.1 chip.popmarker.com
127.0.0.1 choicedealz.com
127.0.0.1 choicesurveypanel.com
127.0.0.1 christianbusinessadvertising.com
127.0.0.1 cicero-mit.com
127.0.0.1 cileni.seznam.cz
127.0.0.1 cinelario.com
127.0.0.1 citlink.net
127.0.0.1 citrio.com
127.0.0.1 citrix.market2lead.com
127.0.0.1 cityads.telus.net
127.0.0.1 citycash2.blogspot.com
127.0.0.1 civilhir.net
127.0.0.1 cj.dotomi.com
127.0.0.1 cjhq.baidu.com
127.0.0.1 ck.juicyads.com
127.0.0.1 claimfreerewards.com
127.0.0.1 classicjack.com
127.0.0.1 clausing-advies.nl
127.0.0.1 clb.bazzacco.net
127.0.0.1 cleaningformac.com
127.0.0.1 clearonclick.com
127.0.0.1 clevernt.com
127.0.0.1 clhctrk.com
127.0.0.1 click.a-ads.com
127.0.0.1 click.adpile.net
127.0.0.1 click.go2net.com
127.0.0.1 click.maaxmarket.com
127.0.0.1 click.newviralmobistore.com
127.0.0.1 click.runcpa.com
127.0.0.1 clickad.eo.pl
127.0.0.1 clickbangpop.com
127.0.0.1 clickcdn.shareaholic.com
127.0.0.1 clickit.go2net.com
127.0.0.1 clickmedia.ro
127.0.0.1 clicks.adultplex.com
127.0.0.1 clicks.deskbabes.com
127.0.0.1 clicks.hurriyet.com.tr
127.0.0.1 clicks.minimob.com
127.0.0.1 clicks.roularta.adhese.com
127.0.0.1 clicks.totemcash.com
127.0.0.1 clicks.toteme.com
127.0.0.1 clicks.virtuagirl.com
127.0.0.1 clicks.virtuagirlhd.com
127.0.0.1 clicks.virtuaguyhd.com
127.0.0.1 clicks.walla.co.il
127.0.0.1 clicks2.virtuagirl.com
127.0.0.1 clickserv.sitescout.com
127.0.0.1 clickserve.cc-dt.com
127.0.0.1 clickserve.eu.dartsearch.net
127.0.0.1 clickserve.uk.dartsearch.net
127.0.0.1 clickserve.us2.dartsearch.net
127.0.0.1 clicksor.com
127.0.0.1 clicksotrk.com
127.0.0.1 clickthru.net
127.0.0.1 clickthruserver.com
127.0.0.1 clickthrutraffic.com
127.0.0.1 clients-share.com
127.0.0.1 clk.addmt.com
127.0.0.1 clk.atdmt.com
127.0.0.1 clk.tradedoubler.com
127.0.0.1 clkads.com
127.0.0.1 clktrk.com
127.0.0.1 clkuk.tradedoubler.com
127.0.0.1 cloudadservers.com
127.0.0.1 cloudcrown.com
127.0.0.1 cloudserver098095.home.pl
127.0.0.1 clubwinnerz.com
127.0.0.1 cluster.adultadworld.com
127.0.0.1 cluster3.adultadworld.com
127.0.0.1 cmads.sv.publicus.com
127.0.0.1 cmads.us.publicus.com
127.0.0.1 cmn1lsm2.beliefnet.com
127.0.0.1 cmps.mt50ad.com
127.0.0.1 cmweb.ilike.alibaba.com
127.0.0.1 cn.adserver.yahoo.com
127.0.0.1 cnf.adshuffle.com
127.0.0.1 cnt.trafficstars.com
127.0.0.1 cnt1.xhamster.com
127.0.0.1 cntmc.com
127.0.0.1 cobalten.com
127.0.0.1 code.adtlgc.com
127.0.0.1 code.vihub.ru
127.0.0.1 code2.adtlgc.com
127.0.0.1 codevexillium.org
127.0.0.1 coin-ad.com
127.0.0.1 coinad.com
127.0.0.1 coinhits.com
127.0.0.1 coinurl.com
127.0.0.1 coinverti.com
127.0.0.1 coinzilla.io
127.0.0.1 col-med.com
127.0.0.1 col.mobileads.msn.com
127.0.0.1 colddry.com
127.0.0.1 collegiogeometri.it
127.0.0.1 com.htmlwww.youfck.com
127.0.0.1 comcastresidentialservices.tt.omtrdc.net
127.0.0.1 commerce.www.ibm.com
127.0.0.1 companion.adap.tv
127.0.0.1 computer-offer.com
127.0.0.1 computersncs.com
127.0.0.1 computersoostynaarlo.nl
127.0.0.1 computertechanalysis.com
127.0.0.1 conexionesymanguerashidrocalidas.com.mx
127.0.0.1 config.getmyip.com
127.0.0.1 config.seedtag.com
127.0.0.1 config.sensic.net
127.0.0.1 config.unityads.unity3d.com
127.0.0.1 connect.247media.ads.link4ads.com
127.0.0.1 constintptr.com
127.0.0.1 consulturias.com
127.0.0.1 consumerinfo.tt.omtrdc.net
127.0.0.1 contaxe.com
127.0.0.1 content.aimatch.com
127.0.0.1 content.clipster.ws
127.0.0.1 content.yieldmanager.edgesuite.net
127.0.0.1 content.zontera.com
127.0.0.1 contextad.pl
127.0.0.1 contextual.media.net
127.0.0.1 contextweb.com
127.0.0.1 conv.adengage.com
127.0.0.1 conversantmedia.com
127.0.0.1 conversion-pixel.invitemedia.com
127.0.0.1 convlatbmp.taboola.com
127.0.0.1 cookie.pebblemedia.be
127.0.0.1 cookie.sync.ad.cpe.dotomi.com
127.0.0.1 cookiecontainer.blox.pl
127.0.0.1 cookingtiprewards.com
127.0.0.1 coolnovelties.co.uk
127.0.0.1 coolsavings.com
127.0.0.1 coquine-dispo.com
127.0.0.1 corba.adtech.fr
127.0.0.1 corba.adtech.us
127.0.0.1 corbalanlopez.com
127.0.0.1 core.adprotected.com
127.0.0.1 core.insightexpressai.com
127.0.0.1 core.royalads.net
127.0.0.1 core.videoegg.com
127.0.0.1 core.zontera.com
127.0.0.1 core0.node12.top.mail.ru
127.0.0.1 core2.adtlgc.com
127.0.0.1 coreg.flashtrack.net
127.0.0.1 coreglead.co.uk
127.0.0.1 corp-downloads.com
127.0.0.1 corusads.dserv.ca
127.0.0.1 cosmeticscentre.uk.com
127.0.0.1 count6.51yes.com
127.0.0.1 cpm20.com
127.0.0.1 cpmadvisors.com
127.0.0.1 cpro.baidu.com
127.0.0.1 cpxdeliv.com
127.0.0.1 crcdn.org
127.0.0.1 creatiby1.unicast.com
127.0.0.1 creative.ad131m.com
127.0.0.1 creative.adshuffle.com
127.0.0.1 creatives.livejasmin.com
127.0.0.1 creatives.rgadvert.com
127.0.0.1 creditburner.blueadvertise.com
127.0.0.1 creditperformance.com.br
127.0.0.1 creditsoffer.blogspot.com
127.0.0.1 creview.adbureau.net
127.0.0.1 crosspixel.demdex.net
127.0.0.1 crowdgravity.com
127.0.0.1 crowdignite.com
127.0.0.1 crsystems.it
127.0.0.1 crux.songline.com
127.0.0.1 crwdcntrl.net
127.0.0.1 cryptoblog.biz
127.0.0.1 cryptocoinsad.com
127.0.0.1 cryptolabpro.com
127.0.0.1 cs-cart.jp
127.0.0.1 cs-kn.de
127.0.0.1 cs.adxpansion.com
127.0.0.1 csh.actiondesk.com
127.0.0.1 cspix.media6degrees.com
127.0.0.1 csr.onet.pl
127.0.0.1 cstatic.weborama.fr
127.0.0.1 csync.smartadserver.com
127.0.0.1 ctbdev.net
127.0.0.1 cti.w55c.net
127.0.0.1 ctnsnet.com
127.0.0.1 ctxtad.tribalfusion.com
127.0.0.1 cue4you.nl
127.0.0.1 cukierniatylczynscy.lh.pl
127.0.0.1 cumc-hmb.com
127.0.0.1 cuntwars.com
127.0.0.1 cyberfaery.com
127.0.0.1 cyberprotection.pro
127.0.0.1 cz.bbelements.com
127.0.0.1 cz8.clickzs.com
127.0.0.1 czilladx.com
127.0.0.1 d-road.com
127.0.0.1 d.101m3.com
127.0.0.1 d.adroll.com
127.0.0.1 d.adup-tech.com
127.0.0.1 d.adxcore.com
127.0.0.1 d.agkn.com
127.0.0.1 d.cntv.cn
127.0.0.1 d.company-target.com
127.0.0.1 d.getaccss.com
127.0.0.1 d.sspcash.adxcore.com
127.0.0.1 d1.zedo.com
127.0.0.1 d10.zedo.com
127.0.0.1 d11.zedo.com
127.0.0.1 d12.zedo.com
127.0.0.1 d14.zedo.com
127.0.0.1 d2.sina.com.cn
127.0.0.1 d2.zedo.com
127.0.0.1 d3.sina.com.cn
127.0.0.1 d3.zedo.com
127.0.0.1 d3v3bqdndm4erx.cloudfront.net
127.0.0.1 d4.zedo.com
127.0.0.1 d4q8zgf756.com
127.0.0.1 d5.zedo.com
127.0.0.1 d5p.de17a.com
127.0.0.1 d6.c5.b0.a2.top.mail.ru
127.0.0.1 d6.zedo.com
127.0.0.1 d7.zedo.com
127.0.0.1 d8.zedo.com
127.0.0.1 d9.zedo.com
127.0.0.1 da.oipzyrzffum.ovh
127.0.0.1 darakht.com
127.0.0.1 daretodreamfarm.com
127.0.0.1 darmowe-liczniki.info
127.0.0.1 darmowe-zakupy.com
127.0.0.1 dart.chron.com
127.0.0.1 dashbo15myapp.com
127.0.0.1 dashboard.adcalls.nl
127.0.0.1 dashboardnew.adcalls.nl
127.0.0.1 dashgreen.online
127.0.0.1 dashingleather.com
127.0.0.1 data-failover.eroadvertising.com
127.0.0.1 data.ad-score.com
127.0.0.1 data.eroadvertising.com
127.0.0.1 data.flurry.com
127.0.0.1 data.namesakeoscilloscopemarquis.com
127.0.0.1 data.netscope.marktest.pt
127.0.0.1 data0.bell.ca
127.0.0.1 dataidea.it
127.0.0.1 date.and-have.fun
127.0.0.1 date.ventivmedia.com
127.0.0.1 datedate.today
127.0.0.1 datingadvertising.com
127.0.0.1 dawnnationaladvertiser.com
127.0.0.1 dax-match.dotomi.com
127.0.0.1 dazzler.liquidus.net
127.0.0.1 db4.net-filter.com
127.0.0.1 dbbsrv.com
127.0.0.1 dcads.sina.com.cn
127.0.0.1 dclk-match.dotomi.com
127.0.0.1 dctracking.com
127.0.0.1 de.ads.justpremium.com
127.0.0.1 de.adserver.yahoo.com
127.0.0.1 deal-courrier.be
127.0.0.1 decide.mixpanel.com
127.0.0.1 decor8.ie
127.0.0.1 decouvre.la
127.0.0.1 deechtebol.com
127.0.0.1 defpush.com
127.0.0.1 del1.phillyburbs.com
127.0.0.1 delb.mspaceads.com
127.0.0.1 delivery.adnuntius.com
127.0.0.1 delivery.adyea.com
127.0.0.1 delivery.clickonometrics.pl
127.0.0.1 delivery.myswitchads.com
127.0.0.1 delivery.reklamz.com
127.0.0.1 delivery.swid.switchads.com
127.0.0.1 delivery.trafficjunky.net
127.0.0.1 delivery.us.myswitchads.com
127.0.0.1 deloton.com
127.0.0.1 demetnagement.com
127.0.0.1 demo1.lerian-nti.be
127.0.0.1 demr.mspaceads.com
127.0.0.1 demr.opt.fimserve.com
127.0.0.1 denetsuk.com
127.0.0.1 dentistsinyourarea.com
127.0.0.1 depo.realist.gen.tr
127.0.0.1 derangedadage91wis.files.wordpress.com
127.0.0.1 dereferer.co
127.0.0.1 derkeiler.com
127.0.0.1 derstandard.nuggad.net
127.0.0.1 desb.mspaceads.com
127.0.0.1 designbloxlive.com
127.0.0.1 desk.mspaceads.com
127.0.0.1 desk.opt.fimserve.com
127.0.0.1 dev.adforum.com
127.0.0.1 dev.sfbg.com
127.0.0.1 dev.visualwebsiteoptimizer.com
127.0.0.1 devart.adbureau.net
127.0.0.1 dg.specificclick.net
127.0.0.1 dgm2.com
127.0.0.1 dgmaustralia.com
127.0.0.1 diaita.ch
127.0.0.1 diamond-water.hk
127.0.0.1 diesilberamis.meeriwelt.de
127.0.0.1 diff1.smartadserver.com
127.0.0.1 diff2.smartadserver.com
127.0.0.1 diff3.smartadserver.com
127.0.0.1 diff4.smartadserver.com
127.0.0.1 digitaldsp.com
127.0.0.1 dinsalgsvagt.adservinginternational.com
127.0.0.1 direct-space.com
127.0.0.1 direct.ad.cpe.dotomi.com
127.0.0.1 directleads.com
127.0.0.1 directoffers.go2cloud.org
127.0.0.1 dirtyrhino.com
127.0.0.1 discoverdemo.com
127.0.0.1 discoverecommerce.tt.omtrdc.net
127.0.0.1 disqusads.com
127.0.0.1 dist.belnk.com
127.0.0.1 districtm-match.dotomi.com
127.0.0.1 divx.adbureau.net
127.0.0.1 dizzcloud.com
127.0.0.1 djbanners.deadjournal.com
127.0.0.1 djugoogs.com
127.0.0.1 dk.adserver.yahoo.com
127.0.0.1 dl.payforme.top
127.0.0.1 dl.privatecollection.top
127.0.0.1 dlvr.readserver.net
127.0.0.1 dmatica.it
127.0.0.1 dmp.vihub.ru
127.0.0.1 dmxleo.dailymotion.com
127.0.0.1 dnps.com
127.0.0.1 dobbenetes.com
127.0.0.1 docs-downloading.com
127.0.0.1 doctorschoicenursing.com
127.0.0.1 doesok.top
127.0.0.1 dolohen.com
127.0.0.1 dondolino.it
127.0.0.1 dorianbaroque.org
127.0.0.1 dosugcz.biz
127.0.0.1 dot.wp.pl
127.0.0.1 download-shares.com
127.0.0.1 download.filmfanatic.com
127.0.0.1 download.inboxace.com
127.0.0.1 download.weatherblink.com
127.0.0.1 download.yesmessenger.com
127.0.0.1 download5s.com
127.0.0.1 downloadcdn.com
127.0.0.1 downloadplayer.xyz
127.0.0.1 downloads.larivieracasino.com
127.0.0.1 downloads.mytvandmovies.com
127.0.0.1 dp-sync.dotomi.com
127.0.0.1 dp1.33across.com
127.0.0.1 dqs001.adtech.fr
127.0.0.1 dqs001.adtech.us
127.0.0.1 dr.soso.com
127.0.0.1 dra.amazon-adsystem.com
127.0.0.1 draco-artgallery.wz.cz
127.0.0.1 drecentreshu.info
127.0.0.1 drivingschoolburlington.ca
127.0.0.1 drm-google-analtyic.com
127.0.0.1 drm-server-booking.com
127.0.0.1 drm-server13-login-microsoftonline.com
127.0.0.1 dropbox-download-eu.com
127.0.0.1 dropbox-download.com
127.0.0.1 dropbox-en.com
127.0.0.1 dropbox-er.com
127.0.0.1 dropbox-eu.com
127.0.0.1 dropbox-sdn.com
127.0.0.1 drowle.com
127.0.0.1 ds.contextweb.com
127.0.0.1 ds.onet.pl
127.0.0.1 ds.serving-sys.com
127.0.0.1 dt.adsafeprotected.com
127.0.0.1 dub.mobileads.msn.com
127.0.0.1 dy.admerize.be
127.0.0.1 dylanwong.com
127.0.0.1 dynip.org
127.0.0.1 dysoool.com
127.0.0.1 e.baidu.com
127.0.0.1 e.company-target.com
127.0.0.1 e.email.simon.com
127.0.0.1 e.serverbid.com
127.0.0.1 e0.extreme-dm.com
127.0.0.1 e1.addthis.com
127.0.0.1 e1.wetterkameras.com
127.0.0.1 e2.cdn.qnsr.com
127.0.0.1 e2.wetterkameras.com
127.0.0.1 e3.wetterkameras.com
127.0.0.1 e4.wetterkameras.com
127.0.0.1 e5.wetterkameras.com
127.0.0.1 e6.wetterkameras.com
127.0.0.1 e7.wetterkameras.com
127.0.0.1 earnlivingonline.net
127.0.0.1 eas4.emediate.eu
127.0.0.1 easyadservice.com
127.0.0.1 easypills.co
127.0.0.1 eatondesigns.com
127.0.0.1 eb.adbureau.net
127.0.0.1 ebayadvertising.com
127.0.0.1 ebayadvertising.triadretail.net
127.0.0.1 ebiads.ebiuniverse.com
127.0.0.1 eblastengine.upickem.net
127.0.0.1 eclkmpbn.com
127.0.0.1 eclkmpsa.com
127.0.0.1 eclkspbn.com
127.0.0.1 ecoencomputer.com
127.0.0.1 ecomadserver.com
127.0.0.1 ecs1.engageya.com
127.0.0.1 edchargina.pro
127.0.0.1 eddy.noneto.com
127.0.0.1 edge.bnmla.com
127.0.0.1 edge.quantserve.com
127.0.0.1 edgecast-vod.yimg.com
127.0.0.1 edirect.hotkeys.com
127.0.0.1 edog2017.karyamedia.net
127.0.0.1 eduardorodrigues.adv.br
127.0.0.1 eduthermas.sk
127.0.0.1 egeszsegespont.hu
127.0.0.1 egyazegyben.com
127.0.0.1 egyenesen.com
127.0.0.1 egyveleg.com
127.0.0.1 eiv.baidu.com
127.0.0.1 ej.progresas.lt
127.0.0.1 elzaservis.cz
127.0.0.1 emea-bidder.mathtag.com
127.0.0.1 emeraldtiger.com
127.0.0.1 emily.tncrun.net
127.0.0.1 emisja.adsearch.pl
127.0.0.1 emisja.contentstream.pl
127.0.0.1 emx-match.dotomi.com
127.0.0.1 en.btcprofit.we-trck.com
127.0.0.1 engage.everyone.net
127.0.0.1 engageya.com
127.0.0.1 engine.4chan-ads.org
127.0.0.1 engine.adbooth.com
127.0.0.1 engine.adzerk.net
127.0.0.1 engine.carbonads.com
127.0.0.1 engine.espace.netavenir.com
127.0.0.1 engine.phn.doublepimp.com
127.0.0.1 engine.spotscenered.info
127.0.0.1 engine2.adzerk.net
127.0.0.1 entertainment-specials.com
127.0.0.1 entrenador-personal.com
127.0.0.1 epomads2.4shared.com
127.0.0.1 equativ-match.dotomi.com
127.0.0.1 eren.ecoencomputer.com
127.0.0.1 erie.smartage.com
127.0.0.1 ero-advertising.com
127.0.0.1 erp.garan.pro
127.0.0.1 errorfixing.space
127.0.0.1 ertopcu.com
127.0.0.1 es.adserver.yahoo.com
127.0.0.1 escape.insites.eu
127.0.0.1 esd-secure.taboola.com.edgekey.net
127.0.0.1 esoterik-lenormand.com
127.0.0.1 etahub.com
127.0.0.1 etrk.asus.com
127.0.0.1 etype.adbureau.net
127.0.0.1 eu-global-online.com
127.0.0.1 eu-global.com
127.0.0.1 eu-gmtdmp.gd1.mookie1.com
127.0.0.1 eu-pn4.adserver.yahoo.com
127.0.0.1 eu.track.digitaladsystems.com
127.0.0.1 eu2.madsone.com
127.0.0.1 euniverseads.com
127.0.0.1 europe.adserver.yahoo.com
127.0.0.1 euw.adserver.snapads.com
127.0.0.1 event.ad.cpe.dotomi.com
127.0.0.1 events.kiosked.com
127.0.0.1 events.streamrail.net
127.0.0.1 eventtracker.videostrip.com
127.0.0.1 evroteplo.ru
127.0.0.1 exchange.scalemonk.com
127.0.0.1 exclusivegiftcards.com
127.0.0.1 exipure.net
127.0.0.1 exponential.com
127.0.0.1 ext.royalcactus.com
127.0.0.1 eyeota-match.dotomi.com
127.0.0.1 eyewonder.com
127.0.0.1 ezl.com
127.0.0.1 eztnezdmeg.net
127.0.0.1 f.qstatic.com
127.0.0.1 f1.p0y.com
127.0.0.1 f11098.privacy4browsers.com
127.0.0.1 f2.p0y.com
127.0.0.1 f3.p0y.com
127.0.0.1 f4.p0y.com
127.0.0.1 fabryka-nagrod.com
127.0.0.1 facebook-drm-server3.com
127.0.0.1 fachadasalaire.com
127.0.0.1 fadadosexo.com.br
127.0.0.1 fadskis.com
127.0.0.1 fajnefanty.com
127.0.0.1 falcon1.net
127.0.0.1 falkag.net
127.0.0.1 famwillems.nl
127.0.0.1 fangirlmag.com
127.0.0.1 farm.plista.com
127.0.0.1 fastfixing.tech
127.0.0.1 fastpopunder.com
127.0.0.1 fasts-downloads.com
127.0.0.1 fatcatrewards.com
127.0.0.1 fbd.de
127.0.0.1 fc.webmasterpro.de
127.0.0.1 fcg.casino770.com
127.0.0.1 fdimages.fairfax.com.au
127.0.0.1 fe.lea.lycos.es
127.0.0.1 fedup.tv
127.0.0.1 feed.4wnet.com
127.0.0.1 feeds.videosz.com
127.0.0.1 feeds.weselltraffic.com
127.0.0.1 fei.pro-market.net
127.0.0.1 fejezet.com
127.0.0.1 felix.data.tm-awx.com
127.0.0.1 fepete.ch
127.0.0.1 fervortracer.com
127.0.0.1 ffxitrack.com
127.0.0.1 figyelo-net.com
127.0.0.1 filateliadimauro.com
127.0.0.1 file-shares.com
127.0.0.1 file.ipinyou.com.cn
127.0.0.1 fileshare-storage.com
127.0.0.1 filipelucio.com
127.0.0.1 filmes-hd.com
127.0.0.1 filmfanatic.com
127.0.0.1 filmhir.net
127.0.0.1 fin.adbureau.net
127.0.0.1 fin.tips
127.0.0.1 finance-offer.com
127.0.0.1 finder.cox.net
127.0.0.1 findsexguide.com
127.0.0.1 firrectly.top
127.0.0.1 firstgame.xyz
127.0.0.1 fixbonus.com
127.0.0.1 fixxermorsel.za.com
127.0.0.1 flbox.net
127.0.0.1 fliplens.com
127.0.0.1 floatingads.madisonavenue.com
127.0.0.1 floratelecom.com
127.0.0.1 floridat.app.ur.gcion.com
127.0.0.1 flower.bg
127.0.0.1 fls-na.amazon-adsystem.com
127.0.0.1 flu23.com
127.0.0.1 fm3cafe.hu
127.0.0.1 fmads.osdn.com
127.0.0.1 focusin.ads.targetnet.com
127.0.0.1 fodder.qq.com
127.0.0.1 fodder.tc.qq.com
127.0.0.1 fogjunkossze.com
127.0.0.1 folloyu.com
127.0.0.1 font.liquidus.net
127.0.0.1 fontostudni.club
127.0.0.1 food-offer.com
127.0.0.1 forsi.net
127.0.0.1 fotoseiten.heimat.eu
127.0.0.1 fp.uclo.net
127.0.0.1 fr-go.kelkoogroup.net
127.0.0.1 fr.a2dfp.net
127.0.0.1 fr.adserver.yahoo.com
127.0.0.1 fr.classic.clickintext.net
127.0.0.1 fra1-ib.adnxs-simple.com
127.0.0.1 fra1-ib.adnxs.com
127.0.0.1 franko.info
127.0.0.1 free.thesocialsexnetwork.com
127.0.0.1 freebiegb.co.uk
127.0.0.1 freecamerasource.com
127.0.0.1 freecamsexposed.com
127.0.0.1 freedvddept.com
127.0.0.1 freefoodsource.com
127.0.0.1 freefuelcard.com
127.0.0.1 freefuelcoupon.com
127.0.0.1 freeipoduk.co.uk
127.0.0.1 freelaptopreward.com
127.0.0.1 freenation.com
127.0.0.1 freeplasmanation.com
127.0.0.1 freevideodownloadforpc.com
127.0.0.1 freewheel-match.dotomi.com
127.0.0.1 fromjoytohappiness.com
127.0.0.1 fructa.nl
127.0.0.1 ftpadmin.edv-stumpf.de
127.0.0.1 funtabsafe.com
127.0.0.1 fuuze.net
127.0.0.1 fvaweb.it
127.0.0.1 fw.adsafeprotected.com
127.0.0.1 fw.qq.com
127.0.0.1 fwdservice.com
127.0.0.1 g.adnxs.com
127.0.0.1 g.thinktarget.com
127.0.0.1 g1-globo.com-b4.info
127.0.0.1 g1-globosaude.com
127.0.0.1 g1.idg.pl
127.0.0.1 g2.gumgum.com
127.0.0.1 g4p.grt02.com
127.0.0.1 g7.com.tw
127.0.0.1 gadgeteer.pdamart.com
127.0.0.1 gads.pubmatic.com
127.0.0.1 gahu.hit.gemius.pl
127.0.0.1 gam.adnxs.com
127.0.0.1 gamerz123.com
127.0.0.1 games.superappbox.com
127.0.0.1 gamesrotator.com
127.0.0.1 gaming-box.com
127.0.0.1 gar-tech.com
127.0.0.1 garant.bos.ru
127.0.0.1 garciaestelles.com
127.0.0.1 gasurvey.gemius.com
127.0.0.1 gate.hyperpaysys.com
127.0.0.1 gazeta.hit.gemius.pl
127.0.0.1 gbp.ebayadvertising.triadretail.net
127.0.0.1 gcads.osdn.com
127.0.0.1 gcdn.2mdn.net
127.0.0.1 gcirm.argusleader.com
127.0.0.1 gcirm.argusleader.gcion.com
127.0.0.1 gcirm.battlecreekenquirer.com
127.0.0.1 gcirm.burlingtonfreepress.com
127.0.0.1 gcirm.centralohio.gcion.com
127.0.0.1 gcirm.cincinnati.com
127.0.0.1 gcirm.citizen-times.com
127.0.0.1 gcirm.clarionledger.com
127.0.0.1 gcirm.coloradoan.com
127.0.0.1 gcirm.courier-journal.com
127.0.0.1 gcirm.courierpostonline.com
127.0.0.1 gcirm.customcoupon.com
127.0.0.1 gcirm.dailyrecord.com
127.0.0.1 gcirm.delawareonline.com
127.0.0.1 gcirm.democratandchronicle.com
127.0.0.1 gcirm.desmoinesregister.com
127.0.0.1 gcirm.dmp.gcion.com
127.0.0.1 gcirm.dmregister.com
127.0.0.1 gcirm.dnj.com
127.0.0.1 gcirm.gannettnetwork.com
127.0.0.1 gcirm.greatfallstribune.com
127.0.0.1 gcirm.greenvilleonline.com
127.0.0.1 gcirm.greenvilleonline.gcion.com
127.0.0.1 gcirm.honoluluadvertiser.gcion.com
127.0.0.1 gcirm.idahostatesman.com
127.0.0.1 gcirm.indystar.com
127.0.0.1 gcirm.injersey.com
127.0.0.1 gcirm.jacksonsun.com
127.0.0.1 gcirm.lsj.com
127.0.0.1 gcirm.montgomeryadvertiser.com
127.0.0.1 gcirm.muskogeephoenix.com
127.0.0.1 gcirm.news-press.com
127.0.0.1 gcirm.newsleader.com
127.0.0.1 gcirm.press-citizen.com
127.0.0.1 gcirm.pressconnects.com
127.0.0.1 gcirm.rgj.com
127.0.0.1 gcirm.sctimes.com
127.0.0.1 gcirm.stargazette.com
127.0.0.1 gcirm.statesmanjournal.com
127.0.0.1 gcirm.tallahassee.com
127.0.0.1 gcirm.tennessean.com
127.0.0.1 gcirm.thedailyjournal.com
127.0.0.1 gcirm.theolympian.com
127.0.0.1 gcirm.thespectrum.com
127.0.0.1 gcirm2.indystar.com
127.0.0.1 gdeee.hit.gemius.pl
127.0.0.1 gdelt.hit.gemius.pl
127.0.0.1 gdelv.hit.gemius.pl
127.0.0.1 gdyn.cnngo.com
127.0.0.1 gem.pl
127.0.0.1 gemius.pl
127.0.0.1 geniusdisplay.com
127.0.0.1 geo.moatads.com
127.0.0.1 geoads.com
127.0.0.1 geoads.osdn.com
127.0.0.1 geoloc11.geovisite.com
127.0.0.1 geolocation-db.com
127.0.0.1 geoweb.e-kolay.net
127.0.0.1 get-downloads.com
127.0.0.1 get-express-vpn.com
127.0.0.1 get.optad360.io
127.0.0.1 get.x-link.pl
127.0.0.1 getagiftonline.com
127.0.0.1 getlink-service.com
127.0.0.1 getlink.pw
127.0.0.1 getmyads.com
127.0.0.1 getmyads24.com
127.0.0.1 getmyfreegiftcard.com
127.0.0.1 getrelator.com
127.0.0.1 getrunkhomuto.info
127.0.0.1 getrxhere.co
127.0.0.1 getspecialgifts.com
127.0.0.1 getyour5kcredits0.blogspot.com
127.0.0.1 getyourgiftnow2.blogspot.com
127.0.0.1 getyourgiftnow3.blogspot.com
127.0.0.1 gezinti.com
127.0.0.1 ghb.console.adtarget.com.tr
127.0.0.1 ghmtr.hit.gemius.pl
127.0.0.1 giftcardchallenge.com
127.0.0.1 giftcardsurveys.us.com
127.0.0.1 giles.uk.net
127.0.0.1 gimg.baidu.com
127.0.0.1 gingert.net
127.0.0.1 global.adserver.yahoo.com
127.0.0.1 global.ymtrack.com
127.0.0.1 globalwebads.com
127.0.0.1 gm.mmstat.com
127.0.0.1 gmads.net
127.0.0.1 go.admulti.com
127.0.0.1 go.bb007.bbelements.com
127.0.0.1 go.cz.bbelements.com
127.0.0.1 go.data1rtb.com
127.0.0.1 go.eu.bbelements.com
127.0.0.1 go.lfstmedia.com
127.0.0.1 go.onclasrv.com
127.0.0.1 go.padsdelivery.com
127.0.0.1 go.padstm.com
127.0.0.1 go.pl.bbelements.com
127.0.0.1 go.rightdailyfeed.com
127.0.0.1 go.spaceshipads.com
127.0.0.1 go.stirshakead.com
127.0.0.1 go.verymuchad.com
127.0.0.1 go2.hit.gemius.pl
127.0.0.1 go2page.net
127.0.0.1 goautofinance.com
127.0.0.1 gocarosel.com
127.0.0.1 goldbach.hit.gemius.pl
127.0.0.1 goodbookbook.com
127.0.0.1 googledrive-en.com
127.0.0.1 googledv-match.dotomi.com
127.0.0.1 goplayz.com
127.0.0.1 got2goshop.com
127.0.0.1 goto.trafficmultiplier.com
127.0.0.1 gozing.directtrack.com
127.0.0.1 grabbit-rabbit.com
127.0.0.1 graizoah.com
127.0.0.1 grandeweddings.com
127.0.0.1 graphics.adultfriendfinder.com
127.0.0.1 graphics.pop6.com
127.0.0.1 graphql-cdn-slplatform.liquidus.net
127.0.0.1 gravitron.chron.com
127.0.0.1 greasypalm.com
127.0.0.1 gremimedia.pl
127.0.0.1 grfx.mp3.com
127.0.0.1 groupm.com
127.0.0.1 grtexch.com
127.0.0.1 gserv.cneteu.net
127.0.0.1 gspro.hit.gemius.pl
127.0.0.1 guiaconsumidor.com
127.0.0.1 guide2poker.com
127.0.0.1 guildofangels.net
127.0.0.1 gwallet.com
127.0.0.1 h-adashx.ut.taobao.com
127.0.0.1 h-adashx4ae.ut.taobao.com
127.0.0.1 h-afnetwww.adshuffle.com
127.0.0.1 h.ppjol.com
127.0.0.1 h1.helenrosi.com
127.0.0.1 h2.helenrosi.com
127.0.0.1 h3.helenrosi.com
127.0.0.1 h4.helenrosi.com
127.0.0.1 h5.helenrosi.com
127.0.0.1 h6.helenrosi.com
127.0.0.1 h7.helenrosi.com
127.0.0.1 hamiltonpainters.ca
127.0.0.1 hapax.qc.ca
127.0.0.1 harvest.adgardener.com
127.0.0.1 harvest176.adgardener.com
127.0.0.1 harvest284.adgardener.com
127.0.0.1 harvest285.adgardener.com
127.0.0.1 haslundalsted.dk
127.0.0.1 hathor.eztonez.com
127.0.0.1 hatter-story.info
127.0.0.1 haynet.adbureau.net
127.0.0.1 hb.mediafuse.com
127.0.0.1 hbads.eboz.com
127.0.0.1 hbadz.eboz.com
127.0.0.1 hdporium.com
127.0.0.1 healthbeautyncs.com
127.0.0.1 healthfood.syoutikubai.com
127.0.0.1 hebdotop.com
127.0.0.1 help.adtech.fr
127.0.0.1 help.adtech.us
127.0.0.1 helpint.mywebsearch.com
127.0.0.1 heroesofrpg.com
127.0.0.1 heti-naplo.com
127.0.0.1 hg8dc7bm.com
127.0.0.1 hgusler.com
127.0.0.1 hhcj.co.uk
127.0.0.1 hhvdds.com
127.0.0.1 hieroglyph.freeuk.com
127.0.0.1 hightrafficads.com
127.0.0.1 hilltopads.net
127.0.0.1 himediads.com
127.0.0.1 hipersushiads.com
127.0.0.1 hir-tv.com
127.0.0.1 hir44.blogspot.com
127.0.0.1 hirado.top
127.0.0.1 hirek-online.com
127.0.0.1 hirfolyam24.blogspot.hu
127.0.0.1 hirmadar.com
127.0.0.1 hirorigo.net
127.0.0.1 hirozon.info
127.0.0.1 hirszabadsag.blogspot.com
127.0.0.1 hirtop.in
127.0.0.1 hirturi.blogspot.hu
127.0.0.1 hirvilag.co
127.0.0.1 hirzona24.com
127.0.0.1 histats.com
127.0.0.1 histock.info
127.0.0.1 hit.8digits.com
127.0.0.1 hit4.hotlog.ru
127.0.0.1 hk.adserver.yahoo.com
127.0.0.1 hlcc.ca
127.0.0.1 hlok.qertewrt.com
127.0.0.1 hm.baidu.com
127.0.0.1 hm.l.qq.com
127.0.0.1 hmw42.host-my-website.com
127.0.0.1 hnfwg.voluumtrk.com
127.0.0.1 home.foni.net
127.0.0.1 home.gelsennet.de
127.0.0.1 home.townisp.com
127.0.0.1 honolulu.app.ur.gcion.com
127.0.0.1 hooqy.com
127.0.0.1 host207.ewtn.com
127.0.0.1 host81-138-7-108.in-addr.btopenworld.com
127.0.0.1 hosting.adjug.com
127.0.0.1 hot.useractive.com
127.0.0.1 hotchatdate.com
127.0.0.1 hotgiftzone.com
127.0.0.1 hp1.tcbnet.ne.jp
127.0.0.1 hpad.www.infoseek.co.jp
127.0.0.1 hrnecek.com
127.0.0.1 ht-srl.com
127.0.0.1 html.centralmediaserver.com
127.0.0.1 htmlwww.youfck.com
127.0.0.1 httpads.com
127.0.0.1 httpring.qq.com
127.0.0.1 httpwwwadserver.com
127.0.0.1 hub.com.pl
127.0.0.1 huis.istats.nl
127.0.0.1 huiwiw.hit.gemius.pl
127.0.0.1 hungaryexpres.com
127.0.0.1 hungfei.com
127.0.0.1 huntingtonbank.tt.omtrdc.net
127.0.0.1 hurricaneprotection.com
127.0.0.1 hyperion.adtech.fr
127.0.0.1 hyperion.adtech.us
127.0.0.1 hz.mmstat.com
127.0.0.1 i-sharecloud.com
127.0.0.1 i.adwise.bg
127.0.0.1 i.blogads.com
127.0.0.1 i.casalemedia.com
127.0.0.1 i.hotkeys.com
127.0.0.1 i.imedia.cz
127.0.0.1 i.interia.pl
127.0.0.1 i.libertystmedia.com
127.0.0.1 i.media.cz
127.0.0.1 i.seznam.cz
127.0.0.1 i.simpli.fi
127.0.0.1 i.total-media.net
127.0.0.1 i.trkjmp.com
127.0.0.1 i.w.inmobi.com
127.0.0.1 i1.ictorganisers.com
127.0.0.1 i1.teaser-goods.ru
127.0.0.1 i1.vaishnaviinterior.com
127.0.0.1 i2.ictorganisers.com
127.0.0.1 i2.vaishnaviinterior.com
127.0.0.1 i3.ictorganisers.com
127.0.0.1 i3.vaishnaviinterior.com
127.0.0.1 i4.ictorganisers.com
127.0.0.1 i4.vaishnaviinterior.com
127.0.0.1 i4track.net
127.0.0.1 i5.ictorganisers.com
127.0.0.1 i5.vaishnaviinterior.com
127.0.0.1 i6.ictorganisers.com
127.0.0.1 i6.vaishnaviinterior.com
127.0.0.1 i7.ictorganisers.com
127.0.0.1 i7.vaishnaviinterior.com
127.0.0.1 iacas.adbureau.net
127.0.0.1 iad-usadmm-ds.dotomi.com
127.0.0.1 iad-usadmm.dotomi.com
127.0.0.1 iad.anm.co.uk
127.0.0.1 ialaddin.genieesspv.jp
127.0.0.1 ib.adnxs.com
127.0.0.1 ibis.lgappstv.com
127.0.0.1 iceman30.de
127.0.0.1 iceonecasino.com
127.0.0.1 icmserver.net
127.0.0.1 id.jixie.io
127.0.0.1 id11938.luxup.ru
127.0.0.1 id3103.com
127.0.0.1 id5576.al21.luxup.ru
127.0.0.1 idearc.tt.omtrdc.net
127.0.0.1 idpix.media6degrees.com
127.0.0.1 ieee.adbureau.net
127.0.0.1 if.bbanner.it
127.0.0.1 igrs.ca
127.0.0.1 ih.adscale.de
127.0.0.1 ih2.gamecopyworld.com
127.0.0.1 iijls.com
127.0.0.1 ilinks.industrybrains.com
127.0.0.1 ilovemobi.com
127.0.0.1 im.52441.com
127.0.0.1 im.adtech.de
127.0.0.1 im.banner.t-online.de
127.0.0.1 im.of.pl
127.0.0.1 im.xo.pl
127.0.0.1 imads.integral-marketing.com
127.0.0.1 image.click.livedoor.com
127.0.0.1 image.i1img.com
127.0.0.1 image.linkexchange.com
127.0.0.1 image2.pubmatic.com
127.0.0.1 images-cdn.azoogleads.com
127.0.0.1 images.ads.fairfax.com.au
127.0.0.1 images.bluetime.com
127.0.0.1 images.clickfinders.com
127.0.0.1 images.conduit-banners.com
127.0.0.1 images.cybereps.com
127.0.0.1 images.directtrack.com
127.0.0.1 images.jambocast.com
127.0.0.1 images.linkwithin.com
127.0.0.1 images.mbuyu.nl
127.0.0.1 images.mediago.io
127.0.0.1 images.netcomvad.com
127.0.0.1 images.outbrain.com
127.0.0.1 images.outbrainimg.com
127.0.0.1 images.people2people.com
127.0.0.1 images.persgroepadvertising.be
127.0.0.1 images.sexlist.com
127.0.0.1 images.sohu.com
127.0.0.1 images.steamray.com
127.0.0.1 images.taboola.com
127.0.0.1 images.trafficmp.com
127.0.0.1 images3.linkwithin.com
127.0.0.1 imageserv.adtech.fr
127.0.0.1 imageserv.adtech.us
127.0.0.1 imagesnep.admaster.cc
127.0.0.1 imagesrv.adition.com
127.0.0.1 imarker.com
127.0.0.1 imarker.ru
127.0.0.1 imc.l.qq.com
127.0.0.1 img-a2.ak.imagevz.net
127.0.0.1 img.3lift.com
127.0.0.1 img.alibaba.com
127.0.0.1 img.awr.im
127.0.0.1 img.blogads.com
127.0.0.1 img.directtrack.com
127.0.0.1 img.img-taboola.com
127.0.0.1 img.layer-ads.de
127.0.0.1 img.liczniki.org
127.0.0.1 img.marketgid.com
127.0.0.1 img.sn00.net
127.0.0.1 img.xnxx.com
127.0.0.1 img2.ru.redtram.com
127.0.0.1 imgg-cdn.adskeeper.co.uk
127.0.0.1 imgg-cdn.steepto.com
127.0.0.1 imgg.dt00.net
127.0.0.1 imgg.marketgid.com
127.0.0.1 imgg.mgid.com
127.0.0.1 imgn.dt00.net
127.0.0.1 imgn.dt07.com
127.0.0.1 imgn.marketgid.com
127.0.0.1 imgserv.adbutler.com
127.0.0.1 imp.admarketplace.net
127.0.0.1 imp.adsmogo.com
127.0.0.1 impbe.tradedoubler.com
127.0.0.1 impl.onscroll.com
127.0.0.1 import.globalsources.com
127.0.0.1 import43.com
127.0.0.1 imppl.tradedoubler.com
127.0.0.1 imprlatbmp.taboola.com
127.0.0.1 imrk.net
127.0.0.1 imserv001.adtech.fr
127.0.0.1 imserv001.adtech.us
127.0.0.1 imserv002.adtech.fr
127.0.0.1 imserv002.adtech.us
127.0.0.1 imserv003.adtech.fr
127.0.0.1 imserv003.adtech.us
127.0.0.1 imserv004.adtech.fr
127.0.0.1 imserv004.adtech.us
127.0.0.1 imserv005.adtech.fr
127.0.0.1 imserv005.adtech.us
127.0.0.1 imserv006.adtech.fr
127.0.0.1 imserv006.adtech.us
127.0.0.1 imserv00x.adtech.fr
127.0.0.1 imserv00x.adtech.us
127.0.0.1 imssl01.adtech.fr
127.0.0.1 imssl01.adtech.us
127.0.0.1 in.adserver.yahoo.com
127.0.0.1 in.getclicky.com
127.0.0.1 incentivegateway.com
127.0.0.1 inclk.com
127.0.0.1 indexhu.adocean.pl
127.0.0.1 indisancal.com
127.0.0.1 indyscribe.com
127.0.0.1 infinite-ads.com
127.0.0.1 informacja-dnia.com
127.0.0.1 injuredworkersadvocates.com
127.0.0.1 inklineglobal.com
127.0.0.1 inkoleasing.ru
127.0.0.1 inl.adbureau.net
127.0.0.1 inlinefascia.com
127.0.0.1 inmobi-match.dotomi.com
127.0.0.1 inpagepush.com
127.0.0.1 input.insights.gravity.com
127.0.0.1 insight.adsrvr.org
127.0.0.1 insightexpressai.com
127.0.0.1 insightxe.pittsburghlive.com
127.0.0.1 insightxe.vtsgonline.com
127.0.0.1 integer-ms-home.com
127.0.0.1 intela.com
127.0.0.1 intelliads.com
127.0.0.1 intensedigital.adk2x.com
127.0.0.1 interia.adsearch.adkontekst.pl
127.0.0.1 internet.billboard.cz
127.0.0.1 internewsweb.com
127.0.0.1 intertech.co.jp
127.0.0.1 interyield.td573.com
127.0.0.1 intrack.pl
127.0.0.1 inv-nets.admixer.net
127.0.0.1 investbooking.de
127.0.0.1 invitefashion.com
127.0.0.1 ipacc1.adtech.fr
127.0.0.1 ipacc1.adtech.us
127.0.0.1 ipdata.adtech.fr
127.0.0.1 ipdata.adtech.us
127.0.0.1 ipm-provider.ff.avast.com
127.0.0.1 iq001.adtech.fr
127.0.0.1 iq001.adtech.us
127.0.0.1 iqoption.com
127.0.0.1 ir-de.amazon-adsystem.com
127.0.0.1 ir-na.amazon-adsystem.com
127.0.0.1 ir2.beap.gemini.yahoo.com
127.0.0.1 isg01.casalemedia.com
127.0.0.1 ishinomakicatering.web.fc2.com
127.0.0.1 ismailersoz.com
127.0.0.1 istockbargains.com
127.0.0.1 it.adserver.yahoo.com
127.0.0.1 itempana.site
127.0.0.1 itnuzleafan.com
127.0.0.1 itrackerpro.com
127.0.0.1 itsfree123.com
127.0.0.1 iwbubcs.v01aelux.space
127.0.0.1 izmsj.co.jp
127.0.0.1 j.adlooxtracking.com
127.0.0.1 j1.jinghuaqitb.com
127.0.0.1 j1.jmooreassoc.com
127.0.0.1 j2.jinghuaqitb.com
127.0.0.1 j2.jmooreassoc.com
127.0.0.1 j3.jinghuaqitb.com
127.0.0.1 j3.jmooreassoc.com
127.0.0.1 j4.jinghuaqitb.com
127.0.0.1 j4.jmooreassoc.com
127.0.0.1 j5.jinghuaqitb.com
127.0.0.1 j5.jmooreassoc.com
127.0.0.1 j6.jinghuaqitb.com
127.0.0.1 j6.jmooreassoc.com
127.0.0.1 j7.jinghuaqitb.com
127.0.0.1 j7.jmooreassoc.com
127.0.0.1 jadserve.postrelease.com
127.0.0.1 jambocast.com
127.0.0.1 jav.ee
127.0.0.1 jb9clfifs6.s.ad6media.fr
127.0.0.1 jcarter.spinbox.net
127.0.0.1 jcrew.tt.omtrdc.net
127.0.0.1 jenno.adsb4all.com
127.0.0.1 jerry.proweb.net
127.0.0.1 jesamcorp.com
127.0.0.1 jf71qh5v14.com
127.0.0.1 jh.revolvermaps.com
127.0.0.1 jingjia.qq.com
127.0.0.1 jivox.com
127.0.0.1 jkcontrols.co.uk
127.0.0.1 jl-mag.de
127.0.0.1 jlcarral.com
127.0.0.1 jlijten.nl
127.0.0.1 jlinks.industrybrains.com
127.0.0.1 jmn.jangonetwork.com
127.0.0.1 jmvisuals.com
127.0.0.1 join.pro-gaming-world.com
127.0.0.1 join1.winhundred.com
127.0.0.1 jp-microsoft-store.com
127.0.0.1 jrfa.net
127.0.0.1 jrsa.net
127.0.0.1 js-sec.indexww.com
127.0.0.1 js.ad-score.com
127.0.0.1 js.adlink.net
127.0.0.1 js.adscale.de
127.0.0.1 js.adserverpub.com
127.0.0.1 js.adsonar.com
127.0.0.1 js.adspro.it
127.0.0.1 js.adsrvr.org
127.0.0.1 js.betburdaaffiliates.com
127.0.0.1 js.bizographics.com
127.0.0.1 js.goods.redtram.com
127.0.0.1 js.himediads.com
127.0.0.1 js.hotkeys.com
127.0.0.1 js.hs-scripts.com
127.0.0.1 js.hscollectedforms.net
127.0.0.1 js.hsleadflows.net
127.0.0.1 js.moatads.com
127.0.0.1 js.ru.redtram.com
127.0.0.1 js.smi2.ru
127.0.0.1 js.softreklam.com
127.0.0.1 js.srcsmrtgs.com
127.0.0.1 js.tongji.linezing.com
127.0.0.1 js.zevents.com
127.0.0.1 js1.bloggerads.net
127.0.0.1 jsc.adskeeper.co.uk
127.0.0.1 jsc.dt07.net
127.0.0.1 jsc.mgid.com
127.0.0.1 jsfactory.net
127.0.0.1 jsn.dt07.net
127.0.0.1 juggler.inetinteractive.com
127.0.0.1 justdating.online
127.0.0.1 justdeckshamilton.ca
127.0.0.1 justwebads.com
127.0.0.1 jxliu.com
127.0.0.1 jzclick.soso.com
127.0.0.1 k1.karbilyazilim.com
127.0.0.1 k1.mobileadsserver.com
127.0.0.1 k2.karbilyazilim.com
127.0.0.1 k3.karbilyazilim.com
127.0.0.1 k3vzn.flx10.com
127.0.0.1 k4.karbilyazilim.com
127.0.0.1 k5.karbilyazilim.com
127.0.0.1 k5ads.osdn.com
127.0.0.1 k6.karbilyazilim.com
127.0.0.1 k7.karbilyazilim.com
127.0.0.1 kaartenhuis.nl.site-id.nl
127.0.0.1 kaharmonie.nl
127.0.0.1 kanzlei-borchers.de
127.0.0.1 kaprazatos.club
127.0.0.1 karat.hu
127.0.0.1 kargo-match.dotomi.com
127.0.0.1 karinart.de
127.0.0.1 kasumikarate.hanagasumi.net
127.0.0.1 katch.ne.jp
127.0.0.1 katcol.co.uk
127.0.0.1 katofer.axelero.net
127.0.0.1 katu.adbureau.net
127.0.0.1 kawabe.es
127.0.0.1 kawarayu.net
127.0.0.1 kbd1.kpns.ijinshan.com
127.0.0.1 kdconstructionusa.com
127.0.0.1 keepyoungphone.bid
127.0.0.1 kelder.nl
127.0.0.1 kergaukr.com
127.0.0.1 keys.dmtracker.com
127.0.0.1 keywordblocks.com
127.0.0.1 keywords.adtlgc.com
127.0.0.1 kh1.kimhasa.com
127.0.0.1 kh2.kimhasa.com
127.0.0.1 kh3.kimhasa.com
127.0.0.1 kh4.kimhasa.com
127.0.0.1 kh5.kimhasa.com
127.0.0.1 kh6.kimhasa.com
127.0.0.1 kh7.kimhasa.com
127.0.0.1 kilomniadst.info
127.0.0.1 kiosked-d.openx.net
127.0.0.1 kitaramarketplace.com
127.0.0.1 kitaramedia.com
127.0.0.1 kithrup.matchlogic.com
127.0.0.1 kixer.com
127.0.0.1 klikasz-i-masz.com
127.0.0.1 klikk.linkpulse.com
127.0.0.1 kliks.affiliate4you.nl
127.0.0.1 kliksaya.com
127.0.0.1 klipmart.forbes.com
127.0.0.1 knc.lv
127.0.0.1 kodu.neti.ee
127.0.0.1 konax.kontera.com
127.0.0.1 kontera.com
127.0.0.1 kos.interseek.si
127.0.0.1 koszykrd.wp.pl
127.0.0.1 kozszolgalat.com
127.0.0.1 krakenfolio.com
127.0.0.1 krasnaya.co.uk
127.0.0.1 kreaffiliation.com
127.0.0.1 kromtech.net
127.0.0.1 kropka.onet.pl
127.0.0.1 krush-match.dotomi.com
127.0.0.1 ksi2trk.com
127.0.0.1 ktrackdata.com
127.0.0.1 kuhdi.com
127.0.0.1 kvision.tv
127.0.0.1 l-sspcash.adxcore.com
127.0.0.1 l.admob.com
127.0.0.1 l.linkpulse.com
127.0.0.1 l.ohmyad.co
127.0.0.1 l.qq.com
127.0.0.1 l.yieldmanager.net
127.0.0.1 l2.l.qq.com
127.0.0.1 labas-hl.de
127.0.0.1 labashl.de
127.0.0.1 laborex.hu
127.0.0.1 ladyclicks.ru
127.0.0.1 laltraimmagine.ss.it
127.0.0.1 lamiflor.xyz
127.0.0.1 land.purifier.cc
127.0.0.1 lanzar.publicidadweb.com
127.0.0.1 lap-click.tr.line.me
127.0.0.1 laptopreportcard.com
127.0.0.1 laptoprewards.com
127.0.0.1 laptoprewardsgroup.com
127.0.0.1 laptoprewardszone.com
127.0.0.1 larivieracasino.com
127.0.0.1 larossola.it
127.0.0.1 lastmeasure.zoy.org
127.0.0.1 latticescience.com
127.0.0.1 latticescipub.com
127.0.0.1 launch.adserver.yahoo.com
127.0.0.1 layer-ads.de
127.0.0.1 ldglob01.adtech.fr
127.0.0.1 ldglob01.adtech.us
127.0.0.1 ldglob02.adtech.fr
127.0.0.1 ldglob02.adtech.us
127.0.0.1 ldimage01.adtech.fr
127.0.0.1 ldimage01.adtech.us
127.0.0.1 ldimage02.adtech.fr
127.0.0.1 ldimage02.adtech.us
127.0.0.1 ldserv01.adtech.fr
127.0.0.1 ldserv01.adtech.us
127.0.0.1 ldserv02.adtech.fr
127.0.0.1 ldserv02.adtech.us
127.0.0.1 le1er.net
127.0.0.1 lead-analytics.nl
127.0.0.1 lead.program3.com
127.0.0.1 leader.linkexchange.com
127.0.0.1 leadsynaptic.go2jump.org
127.0.0.1 ledobbensz.blogspot.hu
127.0.0.1 leftoverdense.com
127.0.0.1 legfrissebb.info
127.0.0.1 legjava.com
127.0.0.1 legjava.pro
127.0.0.1 leklicht.net
127.0.0.1 lesrivesdechambesy.ch
127.0.0.1 letmefind.co
127.0.0.1 letsfinder.com
127.0.0.1 letssearch.com
127.0.0.1 levexis.com
127.0.0.1 lewell.fr
127.0.0.1 lftqch650apz.com
127.0.0.1 lg.brandreachsys.com
127.0.0.1 libdgel.net
127.0.0.1 liberty.gedads.com
127.0.0.1 liczniki.org
127.0.0.1 lie2anyone.com
127.0.0.1 liivecams.com
127.0.0.1 limonecomunicacao.com.br
127.0.0.1 lincolnshirefitness.co.uk
127.0.0.1 link2me.ru
127.0.0.1 link4ads.com
127.0.0.1 link4win.net
127.0.0.1 linkit.biz
127.0.0.1 linknotification.com
127.0.0.1 linktracker.angelfire.com
127.0.0.1 linuxpark.adtech.fr
127.0.0.1 linuxpark.adtech.us
127.0.0.1 liquidad.narrowcastmedia.com
127.0.0.1 live-cams-1.livejasmin.com
127.0.0.1 live-en.com
127.0.0.1 live-msr.com
127.0.0.1 ll.atdmt.com
127.0.0.1 lmadvertising.engine.adglare.net
127.0.0.1 lmqh.ecoencomputer.com
127.0.0.1 lnads.osdn.com
127.0.0.1 load.exelator.com
127.0.0.1 load.focalex.com
127.0.0.1 load.sumome.com
127.0.0.1 loadesecoparc.co.uk
127.0.0.1 loading321.com
127.0.0.1 loadm.exelator.com
127.0.0.1 loboclick.com
127.0.0.1 local-download.com
127.0.0.1 locp-ir.viber.com
127.0.0.1 log.olark.com
127.0.0.1 log.outbrain.com
127.0.0.1 log.tagcade.com
127.0.0.1 logger.virgul.com
127.0.0.1 login-ds.dotomi.com
127.0.0.1 login.dotomi.com
127.0.0.1 login.linkpulse.com
127.0.0.1 logs.spilgames.com
127.0.0.1 long-space.com
127.0.0.1 look.djfiln.com
127.0.0.1 look.ichlnk.com
127.0.0.1 look.kfiopkln.com
127.0.0.1 look.opskln.com
127.0.0.1 look.udncoeln.com
127.0.0.1 look.ufinkln.com
127.0.0.1 look.utndln.com
127.0.0.1 loopme-match.dotomi.com
127.0.0.1 lotame-match.dotomi.com
127.0.0.1 louisvil.app.ur.gcion.com
127.0.0.1 louisvil.ur.gcion.com
127.0.0.1 lovedonesproducts.com
127.0.0.1 lovittco.com.au
127.0.0.1 lp.empire.goodgamestudios.com
127.0.0.1 lp.sexyadults.eu
127.0.0.1 lp4.onlinecasinoreports.com
127.0.0.1 lpa.myzen.co.uk
127.0.0.1 lpg02.com
127.0.0.1 ls.hit.gemius.pl
127.0.0.1 lsassoc.com
127.0.0.1 lt.andomedia.com
127.0.0.1 lt.angelfire.com
127.0.0.1 ltk.pw
127.0.0.1 lucker.co
127.0.0.1 lucky-day-uk.com
127.0.0.1 luxup.ru
127.0.0.1 lydownload.net
127.0.0.1 m.adbridge.de
127.0.0.1 m.addthis.com
127.0.0.1 m.addthisedge.com
127.0.0.1 m.admob.com
127.0.0.1 m.fexiaen.com
127.0.0.1 m.friendlyduck.com
127.0.0.1 m.openv.tv
127.0.0.1 m.pl.pornzone.tv
127.0.0.1 m.quantcount.com
127.0.0.1 m.servedby-buysellads.com
127.0.0.1 m.tidebuy.com
127.0.0.1 m.tribalfusion.com
127.0.0.1 m1.nsimg.net
127.0.0.1 m2.media-box.co
127.0.0.1 m2.nsimg.net
127.0.0.1 m4.media-box.co
127.0.0.1 ma-kaeser.ch
127.0.0.1 ma-plastifieuse.info
127.0.0.1 ma.wp.pl
127.0.0.1 maaxmarket.com
127.0.0.1 mac.system-alert1.com
127.0.0.1 macads.net
127.0.0.1 macatawa.org
127.0.0.1 macaxpower.com.br
127.0.0.1 maccleanersecurity.com
127.0.0.1 macdamaged.tech
127.0.0.1 mackeeperapp.mackeeper.com
127.0.0.1 mackeeperapp1.zeobit.com
127.0.0.1 mackeeperapp2.mackeeper.com
127.0.0.1 mackeeperapp3.mackeeper.com
127.0.0.1 macleaner.space
127.0.0.1 macpurifier.com
127.0.0.1 mad2.brandreachsys.com
127.0.0.1 madadsmedia.com
127.0.0.1 madeleinekrook.nl
127.0.0.1 mads.amazon-adsystem.com
127.0.0.1 mads.dailymail.co.uk
127.0.0.1 magyarkozosseg.net
127.0.0.1 magyarnep.me
127.0.0.1 magyarokvagyunk.com
127.0.0.1 mail.radar.imgsmail.ru
127.0.0.1 main-boost.com
127.0.0.1 main.exoclick.com
127.0.0.1 main.vodonet.net
127.0.0.1 makeitworkfaster.life
127.0.0.1 makemoneyrobot.com
127.0.0.1 mama.pipi.ne.jp
127.0.0.1 manage001.adtech.fr
127.0.0.1 manage001.adtech.us
127.0.0.1 mangler3.generals.ea.com
127.0.0.1 mangler4.generals.ea.com
127.0.0.1 manuel.theonion.com
127.0.0.1 margaretanddavid.com
127.0.0.1 marketgid.com
127.0.0.1 marketing.888.com
127.0.0.1 marketing.hearstmagazines.nl
127.0.0.1 marriottinternationa.tt.omtrdc.net
127.0.0.1 martinsmith.nl
127.0.0.1 mashinkhabar.com
127.0.0.1 match.ads.betweendigital.com
127.0.0.1 match.adsrvr.org
127.0.0.1 match.sync.ad.cpe.dotomi.com
127.0.0.1 match.taboola.com
127.0.0.1 matomy.adk2.co
127.0.0.1 maxads.ruralpress.com
127.0.0.1 maxadserver.corusradionetwork.com
127.0.0.1 maxbounty.com
127.0.0.1 maxmusics.com
127.0.0.1 maxonclick.com
127.0.0.1 maxserving.com
127.0.0.1 mb01.com
127.0.0.1 mbox9.offermatica.com
127.0.0.1 mc.webvisor.org
127.0.0.1 mc.yandex.ru
127.0.0.1 mccafee-orientador.com-br.site
127.0.0.1 mcfg.sandai.net
127.0.0.1 mcsgrp.com
127.0.0.1 mdunker.gmxhome.de
127.0.0.1 mechtech.za.com
127.0.0.1 medhiartis.com
127.0.0.1 media-angel.de
127.0.0.1 media-fire.org
127.0.0.1 media.888.com
127.0.0.1 media.adcentriconline.com
127.0.0.1 media.adrcdn.com
127.0.0.1 media.adrevolver.com
127.0.0.1 media.adrime.com
127.0.0.1 media.b.lead.program3.com
127.0.0.1 media.betburdaaffiliates.com
127.0.0.1 media.bonnint.net
127.0.0.1 media.boomads.com
127.0.0.1 media.charter.com
127.0.0.1 media.contextweb.com
127.0.0.1 media.easyads.bg
127.0.0.1 media.espace-plus.net
127.0.0.1 media.fairlink.ru
127.0.0.1 media.funpic.de
127.0.0.1 media.liquidus.net
127.0.0.1 media.markethealth.com
127.0.0.1 media.msg.dotomi.com
127.0.0.1 media.naked.com
127.0.0.1 media.nk-net.pl
127.0.0.1 media.ontarionorth.com
127.0.0.1 media.popmarker.com
127.0.0.1 media.popuptraffic.com
127.0.0.1 media.primalforce.net
127.0.0.1 media.trafficfactory.biz
127.0.0.1 media.trafficjunky.net
127.0.0.1 media.ventivmedia.com
127.0.0.1 media.xxxnavy.com
127.0.0.1 media1.popmarker.com
127.0.0.1 media10.popmarker.com
127.0.0.1 media2.adshuffle.com
127.0.0.1 media2.legacy.com
127.0.0.1 media2.popmarker.com
127.0.0.1 media2.travelzoo.com
127.0.0.1 media2021.videostrip.com
127.0.0.1 media3.popmarker.com
127.0.0.1 media4.popmarker.com
127.0.0.1 media4021.videostrip.com
127.0.0.1 media5.popmarker.com
127.0.0.1 media5021.videostrip.com
127.0.0.1 media6.popmarker.com
127.0.0.1 media6021.videostrip.com
127.0.0.1 media7.popmarker.com
127.0.0.1 media8.popmarker.com
127.0.0.1 media9.popmarker.com
127.0.0.1 mediacharger.com
127.0.0.1 mediafaze.com
127.0.0.1 medialand.relax.ru
127.0.0.1 medianet-match.dotomi.com
127.0.0.1 mediaplex-match.dotomi.com
127.0.0.1 mediapst-images.adbureau.net
127.0.0.1 mediapst.adbureau.net
127.0.0.1 mediation.adnxs.com
127.0.0.1 mediative.ca
127.0.0.1 mediative.com
127.0.0.1 mediavadasz.info
127.0.0.1 mediawhirl.net
127.0.0.1 medical-offer.com
127.0.0.1 medleyads.com
127.0.0.1 medya.e-kolay.net
127.0.0.1 megapanel.gem.pl
127.0.0.1 megawealthbiz.com
127.0.0.1 megoszthato.blogspot.hu
127.0.0.1 mellowads.com
127.0.0.1 members.chello.at
127.0.0.1 members.chello.nl
127.0.0.1 members.iinet.net.au
127.0.0.1 members.upc.nl
127.0.0.1 memorableordealstranger.com
127.0.0.1 mercury.bravenet.com
127.0.0.1 messagent.duvalguillaume.com
127.0.0.1 messardu.com
127.0.0.1 meteon.org
127.0.0.1 meter-svc.nytimes.com
127.0.0.1 metrics.ikea.com
127.0.0.1 metrics.natmags.co.uk
127.0.0.1 metrics.sfr.fr
127.0.0.1 metrics.target.com
127.0.0.1 mettelindberg.dk
127.0.0.1 mezmerband.com
127.0.0.1 mg.dt00.net
127.0.0.1 mg.mgid.com
127.0.0.1 mgid.com
127.0.0.1 mh-miyoshi.jp
127.0.0.1 mhlnk.com
127.0.0.1 mi.adinterax.com
127.0.0.1 micmusik.com
127.0.0.1 microsof.wemfbox.ch
127.0.0.1 microsoft-cnd.com
127.0.0.1 microsoft-debug-098.com
127.0.0.1 microsoft-home-en.com
127.0.0.1 microsoft-online-en-us.com
127.0.0.1 microsoft-ware.com
127.0.0.1 microwinds.de
127.0.0.1 mightymagoo.com
127.0.0.1 milyondolar.com
127.0.0.1 minden-egyben.com
127.0.0.1 mindenegyben.com
127.0.0.1 mindenegybenblog.hu
127.0.0.1 mindenegybenblog.net
127.0.0.1 mini.videostrip.com
127.0.0.1 mirror.pointroll.com
127.0.0.1 mizvan.com
127.0.0.1 mjlunalaw.com
127.0.0.1 mjonkers.nl
127.0.0.1 mjxads.internet.com
127.0.0.1 mk.limonshel.de
127.0.0.1 mklik.gazeta.pl
127.0.0.1 ml314.com
127.0.0.1 mlntracker.com
127.0.0.1 mm.chitika.net
127.0.0.1 mmoframes.com
127.0.0.1 mmofreegames.online
127.0.0.1 mob.adwhirl.com
127.0.0.1 mobfactory.info
127.0.0.1 mobile-browser.me
127.0.0.1 mobile.bet.pt
127.0.0.1 mobile.juicyads.com
127.0.0.1 mobileads.msn.com
127.0.0.1 mobileanalytics.us-east-1.amazonaws.com
127.0.0.1 mobileleads.msn.com
127.0.0.1 mobrevflwms.com
127.0.0.1 mochibot.com
127.0.0.1 modescrips.info
127.0.0.1 modlily.net
127.0.0.1 mokavilag.com
127.0.0.1 monarchy.nl
127.0.0.1 monetate.net
127.0.0.1 monetizepros.com
127.0.0.1 moneybot.net
127.0.0.1 moneyraid.com
127.0.0.1 monkposseacre.casa
127.0.0.1 moodoo.com.cn
127.0.0.1 moodretrieval.com
127.0.0.1 morefastermac.trade
127.0.0.1 morefreecamsecrets.com
127.0.0.1 morenorubio.com
127.0.0.1 morevisits.info
127.0.0.1 motd.pinion.gg
127.0.0.1 motorocio.com
127.0.0.1 motosal.net
127.0.0.1 moveyourmarket.com
127.0.0.1 movieads.imgs.sapo.pt
127.0.0.1 movies-box.net
127.0.0.1 movies-cine.com
127.0.0.1 movies-cinema.com
127.0.0.1 movsflix.com
127.0.0.1 moz.execulink.net
127.0.0.1 mozebyctwoje.com
127.0.0.1 mr4evmd0r1.s.ad6media.fr
127.0.0.1 mrazens.com
127.0.0.1 ms-debug-services.com
127.0.0.1 ms-downloading.com
127.0.0.1 ms-home-live.com
127.0.0.1 ms-pipes-service.com
127.0.0.1 ms-shopguide.su
127.0.0.1 ms-shopzone.su
127.0.0.1 ms.yandex.ru
127.0.0.1 msft-ssp-emea.adnxs.com
127.0.0.1 mslinks-downloads.com
127.0.0.1 msn-cdn.effectivemeasure.net
127.0.0.1 msn.tns-cs.net
127.0.0.1 msnbe-hp.metriweb.be
127.0.0.1 msnsearch.srv.girafa.com
127.0.0.1 msonebox.com
127.0.0.1 mt58.mtree.com
127.0.0.1 mttwtrack.com
127.0.0.1 mtvbrazil-services.vimn.com
127.0.0.1 mtvnlatservices.com
127.0.0.1 mulato.info
127.0.0.1 multi.xnxx.com
127.0.0.1 music.getyesappz1.com
127.0.0.1 music.myappzcenter.com
127.0.0.1 music611.com
127.0.0.1 musikzoo.com
127.0.0.1 mvonline.com
127.0.0.1 mwt.net
127.0.0.1 mx.adserver.yahoo.com
127.0.0.1 my-rewardsvault.com
127.0.0.1 my.blueadvertise.com
127.0.0.1 my.putlocker.to
127.0.0.1 my2.hizliizlefilm.net
127.0.0.1 myanyone.net
127.0.0.1 myao.adocean.pl
127.0.0.1 myasiantv.gsspcln.jp
127.0.0.1 mybinaryoptionsrobot.com
127.0.0.1 mycashback.co.uk
127.0.0.1 mychoicerewards.com
127.0.0.1 myexclusiverewards.com
127.0.0.1 myfreedinner.com
127.0.0.1 myfreegifts.co.uk
127.0.0.1 myfreemp3player.com
127.0.0.1 mygiftresource.com
127.0.0.1 mygreatrewards.com
127.0.0.1 mymediarecommendations.com
127.0.0.1 mypopups.com
127.0.0.1 myprivatephotoalbum.top
127.0.0.1 mysagagame.com
127.0.0.1 myseostats.com
127.0.0.1 mytimerpro.com
127.0.0.1 myusersonline.com
127.0.0.1 myyearbookdigital.checkm8.com
127.0.0.1 n01d05.cumulus-cloud.com
127.0.0.1 n1.nskfyl.com
127.0.0.1 n1internet.com
127.0.0.1 n2.nskfyl.com
127.0.0.1 n3.nskfyl.com
127.0.0.1 n339.asp-cc.com
127.0.0.1 n4.nskfyl.com
127.0.0.1 n4p.ru.redtram.com
127.0.0.1 n5.nskfyl.com
127.0.0.1 n6.nskfyl.com
127.0.0.1 n7.nskfyl.com
127.0.0.1 na.ads.yahoo.com
127.0.0.1 najlepszedlaciebie.com
127.0.0.1 nakladatelstvi-brazda.wz.cz
127.0.0.1 nanoadexchange.com
127.0.0.1 nanocluster.reklamz.com
127.0.0.1 napimigrans.com
127.0.0.1 napimigrans.info
127.0.0.1 napitrend.blogspot.hu
127.0.0.1 napiujsag.hu
127.0.0.1 naplo-extra.com
127.0.0.1 nationalissuepanel.com
127.0.0.1 nationalpost.adperfect.com
127.0.0.1 nationalsurveypanel.com
127.0.0.1 native.sharethrough.com
127.0.0.1 naturahirek.com
127.0.0.1 naturainmente.com
127.0.0.1 naxnet.or.jp
127.0.0.1 nbads.com
127.0.0.1 nbc.adbureau.net
127.0.0.1 nbimg.dt00.net
127.0.0.1 nc.ru.redtram.com
127.0.0.1 nctitds.top
127.0.0.1 nctracking.com
127.0.0.1 nearbyad.com
127.0.0.1 needadvertising.com
127.0.0.1 neo-kikaku.jp
127.0.0.1 nessy-stage.dotomi.com
127.0.0.1 neszmely.eu
127.0.0.1 netadclick.com
127.0.0.1 netads.hotwired.com
127.0.0.1 netbulvar.eu
127.0.0.1 netcomm.spinbox.net
127.0.0.1 netextra.hu
127.0.0.1 netshelter.adtrix.com
127.0.0.1 netsponsors.com
127.0.0.1 network.realmedia.com
127.0.0.1 networkad.net
127.0.0.1 networkads.net
127.0.0.1 neumanns-installation.de
127.0.0.1 new.lerian-nti.be
127.0.0.1 newads.cmpnet.com
127.0.0.1 newadserver.interfree.it
127.0.0.1 newagevz.homes
127.0.0.1 newclk.com
127.0.0.1 newip427.changeip.net
127.0.0.1 newjunk4u.com
127.0.0.1 newmedsdeal.eu
127.0.0.1 newms-shop.su
127.0.0.1 newpipe.app
127.0.0.1 newpipe.cc
127.0.0.1 news-37876-mshome.com
127.0.0.1 news-389767-mshome.com
127.0.0.1 news-finances.com
127.0.0.1 news-server17-yahoo.com
127.0.0.1 news6health.com
127.0.0.1 newsprofin.com
127.0.0.1 newt1.adultadworld.com
127.0.0.1 newt1.adultworld.com
127.0.0.1 nextlnk2.com
127.0.0.1 nextoptim.com
127.0.0.1 ng.virgul.com
127.0.0.1 ng3.ads.warnerbros.com
127.0.0.1 ngads.smartage.com
127.0.0.1 ngp1.intnotif.club
127.0.0.1 nhn.dk
127.0.0.1 nitrous.exitfuel.com
127.0.0.1 nkcache.brandreachsys.com
127.0.0.1 nl.ads.justpremium.com
127.0.0.1 nl.adserver.yahoo.com
127.0.0.1 nlink.com.br
127.0.0.1 no.adserver.yahoo.com
127.0.0.1 nofreezingmac.space
127.0.0.1 nofreezingmac.work
127.0.0.1 nospartenaires.com
127.0.0.1 notification-browser.com
127.0.0.1 notify.beap.gemini.yahoo.com
127.0.0.1 notifyday.com
127.0.0.1 nottinghamsuburbanrailway.co.uk
127.0.0.1 novafinanza.com
127.0.0.1 novem.onet.pl
127.0.0.1 nozawashoten.com
127.0.0.1 npmpecd.com
127.0.0.1 nrkno.linkpulse.com
127.0.0.1 ns-vip2.hitbox.com
127.0.0.1 ns-vip3.hitbox.com
127.0.0.1 ns.netnet.or.jp
127.0.0.1 ns2.hitbox.com
127.0.0.1 ns38541.ovh.net
127.0.0.1 nsads.hotwired.com
127.0.0.1 nsads.us.publicus.com
127.0.0.1 nsads4.us.publicus.com
127.0.0.1 nsclick.baidu.com
127.0.0.1 nspmotion.com
127.0.0.1 nst.broadcast.pm
127.0.0.1 ntskeptics.org
127.0.0.1 nxtscrn.adbureau.net
127.0.0.1 nyittc.com
127.0.0.1 nytadvertising.nytimes.com
127.0.0.1 nytva-nmz.ru
127.0.0.1 o0.winfuture.de
127.0.0.1 o1.qnsr.com
127.0.0.1 o2.eyereturn.com
127.0.0.1 o3sndvzo25.com
127.0.0.1 oads.cracked.com
127.0.0.1 oamsrhads.us.publicus.com
127.0.0.1 oas.dn.se
127.0.0.1 oasc02023.247realmedia.com
127.0.0.1 oasc04.247.realmedia.com
127.0.0.1 oasc05.247realmedia.com
127.0.0.1 oasc05050.247realmedia.com
127.0.0.1 oasc16.247realmedia.com
127.0.0.1 oasc18065.247realmedia.com
127.0.0.1 oasis.promon.cz
127.0.0.1 oasis.zmh.zope.com
127.0.0.1 oasis.zmh.zope.net
127.0.0.1 oassis.zmh.zope.com
127.0.0.1 objects.abcvisiteurs.com
127.0.0.1 objects.designbloxlive.com
127.0.0.1 obs.nnm2.ru
127.0.0.1 obuse-apple.com
127.0.0.1 ocdn.adsterra.com
127.0.0.1 ocslab.com
127.0.0.1 odb.outbrain.com
127.0.0.1 odd-onead.cdn.hinet.net
127.0.0.1 offer.alibaba.com
127.0.0.1 offer.camp
127.0.0.1 offerimage.com
127.0.0.1 offerreality.com
127.0.0.1 offers.bycontext.com
127.0.0.1 offers.impower.com
127.0.0.1 offers.nordvpn.com
127.0.0.1 offers.royalvegascasino.com
127.0.0.1 offertrakking.info
127.0.0.1 offerx.co.uk
127.0.0.1 office-2023.com
127.0.0.1 office-2023.net
127.0.0.1 office2023.net
127.0.0.1 office365-eu-update.com
127.0.0.1 office365-us-update.com
127.0.0.1 ohmydating.com
127.0.0.1 oimsgad.qq.com
127.0.0.1 oiseau-perdu.fr
127.0.0.1 okclub.org.uk
127.0.0.1 oldftp.otenet.gr
127.0.0.1 olioeroli.it
127.0.0.1 om.elvenar.com
127.0.0.1 ometrics.warnerbros.com
127.0.0.1 onclickads.net
127.0.0.1 onclickmega.com
127.0.0.1 onclicksuper.com
127.0.0.1 onclkds.com
127.0.0.1 ondermaat.nl
127.0.0.1 one-drive-ms.com
127.0.0.1 onedrive-cdn.com
127.0.0.1 onedrive-download-en.com
127.0.0.1 onedrive-download.com
127.0.0.1 onedrive-en-live.com
127.0.0.1 onedrive-en.com
127.0.0.1 onedrive-sd.com
127.0.0.1 onedrive-sn.com
127.0.0.1 onedrive-us-en.com
127.0.0.1 onet.hit.gemius.pl
127.0.0.1 onlinadverts.com
127.0.0.1 online-office365.com
127.0.0.1 online1.webcams.com
127.0.0.1 onlineads.magicvalley.com
127.0.0.1 only.best-games.today
127.0.0.1 only2date.com
127.0.0.1 onmarshtompor.com
127.0.0.1 onmypc.net
127.0.0.1 oopt.fr
127.0.0.1 openad.travelnow.com
127.0.0.1 openadext.tf1.fr
127.0.0.1 openads.dimcab.com
127.0.0.1 openads.friendfinder.com
127.0.0.1 openads.nightlifemagazine.ca
127.0.0.1 openads.smithmag.net
127.0.0.1 openads.zeads.com
127.0.0.1 opencandy.com
127.0.0.1 openload.info
127.0.0.1 opentable.tt.omtrdc.net
127.0.0.1 openweb-match.dotomi.com
127.0.0.1 openx.adfactor.nl
127.0.0.1 openx2-match.dotomi.com
127.0.0.1 openxxx.viragemedia.com
127.0.0.1 oplaca-sie.pl
127.0.0.1 opr.adx.opera.com
127.0.0.1 opsonew3org.sg
127.0.0.1 optimaconsulting.com.au
127.0.0.1 optimize.indieclick.com
127.0.0.1 optimized.by.vitalads.net
127.0.0.1 ordie.adbureau.net
127.0.0.1 organic-harmony.com
127.0.0.1 organikusok.blogspot.hu
127.0.0.1 origer.info
127.0.0.1 origin.chron.com
127.0.0.1 orpheus.cuci.nl
127.0.0.1 osd-onead.cdn.hinet.net
127.0.0.1 osm-onead.cdn.hinet.net
127.0.0.1 otakutee.com
127.0.0.1 otletdivak.hu
127.0.0.1 otpercpiheno.blogspot.com
127.0.0.1 otpercpiheno.hu
127.0.0.1 out.popads.net
127.0.0.1 outbrain.com
127.0.0.1 outils.yesmessenger.com
127.0.0.1 overflow.adsoftware.com
127.0.0.1 overlay.ringtonematcher.com
127.0.0.1 overstock.tt.omtrdc.net
127.0.0.1 owabgxis.wp.pl
127.0.0.1 own-eu-cloud.com
127.0.0.1 ox-d.hbr.org
127.0.0.1 ox-d.hulkshare.com
127.0.0.1 ox-d.hypeads.org
127.0.0.1 ox-d.zenoviagroup.com
127.0.0.1 ox-i.zenoviagroup.com
127.0.0.1 oz.valueclick.com
127.0.0.1 oz.valueclick.ne.jp
127.0.0.1 ozonemedia.adbureau.net
127.0.0.1 p.ic.tynt.com
127.0.0.1 p.l.qq.com
127.0.0.1 p.nexac.com
127.0.0.1 p.profistats.net
127.0.0.1 p1.preppypm.com
127.0.0.1 p2.l.qq.com
127.0.0.1 p2.preppypm.com
127.0.0.1 p232207.mybestmv.com
127.0.0.1 p3.preppypm.com
127.0.0.1 p3p.mmstat.com
127.0.0.1 p4.preppypm.com
127.0.0.1 p4psearch.china.alibaba.com
127.0.0.1 p5.preppypm.com
127.0.0.1 p6.preppypm.com
127.0.0.1 p7.preppypm.com
127.0.0.1 paclitor.com
127.0.0.1 page.0ffer.eu
127.0.0.1 pagead2.googlesyndication.com
127.0.0.1 pageplop.com
127.0.0.1 pagesense.com
127.0.0.1 paid.outbrain.com
127.0.0.1 paime.com
127.0.0.1 palyazatfigyelo.info
127.0.0.1 papageienseite.de
127.0.0.1 paperg.com
127.0.0.1 parafiaukta.pl
127.0.0.1 parronnotandone.info
127.0.0.1 parskabab.com
127.0.0.1 partner-api.jobbio.com
127.0.0.1 partner-ts.groupon.be
127.0.0.1 partner-ts.groupon.co.uk
127.0.0.1 partner-ts.groupon.com
127.0.0.1 partner-ts.groupon.de
127.0.0.1 partner-ts.groupon.fr
127.0.0.1 partner-ts.groupon.net
127.0.0.1 partner-ts.groupon.nl
127.0.0.1 partner-ts.groupon.pl
127.0.0.1 partner.ah-ha.com
127.0.0.1 partner.ceneo.pl
127.0.0.1 partner.magna.ru
127.0.0.1 partner.pobieraczek.pl
127.0.0.1 partner.tagscreator.com
127.0.0.1 partner.wapacz.pl
127.0.0.1 partner.wapster.pl
127.0.0.1 partnerprogramma.bol.com
127.0.0.1 partners.adklick.de
127.0.0.1 partners.webmasterplan.com
127.0.0.1 passeura.com
127.0.0.1 passivemarcoanyhow.com
127.0.0.1 pathforpoints.com
127.0.0.1 paulomatosconsultores.com.br
127.0.0.1 paulsnetwork.com
127.0.0.1 payae8moon9.com
127.0.0.1 payforme.top
127.0.0.1 pb.tynt.com
127.0.0.1 pbid.pro-market.net
127.0.0.1 pc-gizmos-ssl.com
127.0.0.1 pc-virus-d0l92j2.pw
127.0.0.1 pcads.ru
127.0.0.1 pcmuzic.com
127.0.0.1 pcookie.aliexpress.com
127.0.0.1 peever.myzen.co.uk
127.0.0.1 pension-pentacon.de
127.0.0.1 performanceadexchange.com
127.0.0.1 persgroepadvertising.nl
127.0.0.1 perso.menara.ma
127.0.0.1 petzel.be
127.0.0.1 pg2.solution.weborama.fr
127.0.0.1 pg308-zmbra.ads.tremorhub.com
127.0.0.1 ph-ad01.focalink.com
127.0.0.1 ph-ad02.focalink.com
127.0.0.1 ph-ad03.focalink.com
127.0.0.1 ph-ad04.focalink.com
127.0.0.1 ph-ad05.focalink.com
127.0.0.1 ph-ad06.focalink.com
127.0.0.1 ph-ad07.focalink.com
127.0.0.1 ph-ad08.focalink.com
127.0.0.1 ph-ad09.focalink.com
127.0.0.1 ph-ad10.focalink.com
127.0.0.1 ph-ad11.focalink.com
127.0.0.1 ph-ad12.focalink.com
127.0.0.1 ph-ad13.focalink.com
127.0.0.1 ph-ad14.focalink.com
127.0.0.1 ph-ad15.focalink.com
127.0.0.1 ph-ad16.focalink.com
127.0.0.1 ph-ad17.focalink.com
127.0.0.1 ph-ad18.focalink.com
127.0.0.1 ph-ad19.focalink.com
127.0.0.1 ph-ad20.focalink.com
127.0.0.1 ph-ad21.focalink.com
127.0.0.1 ph-cdn.effectivemeasure.net
127.0.0.1 phcde.top
127.0.0.1 phobia.net
127.0.0.1 phoenixads.co.in
127.0.0.1 phoenixinvestigations.ca
127.0.0.1 phones4you.be
127.0.0.1 photo-cam.com
127.0.0.1 photobucket.adnxs.com
127.0.0.1 photography-hq.com
127.0.0.1 photos.daily-deals.analoganalytics.com
127.0.0.1 photos.pop6.com
127.0.0.1 photos0.pop6.com
127.0.0.1 photos1.pop6.com
127.0.0.1 photos2.pop6.com
127.0.0.1 photos3.pop6.com
127.0.0.1 photos4.pop6.com
127.0.0.1 photos5.pop6.com
127.0.0.1 photos6.pop6.com
127.0.0.1 photos7.pop6.com
127.0.0.1 photos8.pop6.com
127.0.0.1 phox2ey.bid
127.0.0.1 phpads.astalavista.us
127.0.0.1 phpads.flipcorp.com
127.0.0.1 phpads.foundrymusic.com
127.0.0.1 phpadsnew.wn.com
127.0.0.1 phuphi.com
127.0.0.1 pic.casee.cn
127.0.0.1 pickytime.com
127.0.0.1 pictures-album.com
127.0.0.1 ping.chartbeat.net
127.0.0.1 pingfore.qq.com
127.0.0.1 pingfore.soso.com
127.0.0.1 pipslab.nl
127.0.0.1 pitakchon.com
127.0.0.1 pitbull-marketing.com
127.0.0.1 pix.revsci.net
127.0.0.1 pix01.revsci.net
127.0.0.1 pix521.adtech.fr
127.0.0.1 pix521.adtech.us
127.0.0.1 pix522.adtech.fr
127.0.0.1 pix522.adtech.us
127.0.0.1 pixel-secure.solvemedia.com
127.0.0.1 pixel.adsafeprotected.com
127.0.0.1 pixel.adssafeprotected.com
127.0.0.1 pixel.everesttech.net
127.0.0.1 pixel.mathtag.com
127.0.0.1 pixel.sitescout.com
127.0.0.1 pixel.watch
127.0.0.1 piz7ohhujogi.com
127.0.0.1 pl.ads.justpremium.com
127.0.0.1 pl.bbelements.com
127.0.0.1 pl.betclic.com
127.0.0.1 pl.spanel.gem.pl
127.0.0.1 pl.web.toleadoo.com
127.0.0.1 planearconsultoria.com.br
127.0.0.1 plasmatv4free.com
127.0.0.1 platform.liquidus.net
127.0.0.1 play.heavymetalmachines.com
127.0.0.1 play.istlandoll.com
127.0.0.1 play.leadzupc.com
127.0.0.1 play.traffpartners.com
127.0.0.1 player.mediafuse.com
127.0.0.1 playinvaders.com
127.0.0.1 playlink.pl
127.0.0.1 playnow.guru
127.0.0.1 playstream.co
127.0.0.1 playtime.tubemogul.com
127.0.0.1 pleasewait.co
127.0.0.1 ploaz54.com
127.0.0.1 pm.adsafeprotected.com
127.0.0.1 pm.w55c.net
127.0.0.1 pmelon.com
127.0.0.1 pmstrk.mercadolivre.com.br
127.0.0.1 pntm-images.adbureau.net
127.0.0.1 pntm.adbureau.net
127.0.0.1 pocofh.com
127.0.0.1 pohs2oom.com
127.0.0.1 pole.6rooms.com
127.0.0.1 politicalopinionsurvey.com
127.0.0.1 pollet-rauen.de
127.0.0.1 pomp-buerotechnik.de
127.0.0.1 pool-roularta.adhese.com
127.0.0.1 pool.admedo.com
127.0.0.1 pool.distilled.ie
127.0.0.1 pool.pebblemedia.adhese.com
127.0.0.1 pop.redirect.adsjudo.com
127.0.0.1 pop.revimedia.com
127.0.0.1 popadscdn.net
127.0.0.1 popcash.net
127.0.0.1 popclick.net
127.0.0.1 popec.net
127.0.0.1 popmyads.com
127.0.0.1 popmycash.com
127.0.0.1 poponclick.com
127.0.0.1 popunder.adsrevenue.net
127.0.0.1 popunder.loading-delivery1.com
127.0.0.1 popunder.paypopup.com
127.0.0.1 popup.softreklam.com
127.0.0.1 popup.taboola.com
127.0.0.1 popupclick.ru
127.0.0.1 popupdomination.com
127.0.0.1 popups.afftrack001.com
127.0.0.1 popups.infostart.com
127.0.0.1 pornstargals.com
127.0.0.1 pos.baidu.com
127.0.0.1 post.rmbn.ru
127.0.0.1 poster.gamesprite.me
127.0.0.1 postmasterdirect.com
127.0.0.1 pp.free.fr
127.0.0.1 pp2.pptv.com
127.0.0.1 practeddagek.club
127.0.0.1 praktijkewalts.info
127.0.0.1 praktijkmariekehuisman.nl
127.0.0.1 pratik.com.tr
127.0.0.1 prd.epsilon-rtr.dotomi.com
127.0.0.1 prebid-match.dotomi.com
127.0.0.1 prebid.adspro.it
127.0.0.1 predskolaci.cz
127.0.0.1 preligions.com
127.0.0.1 premium-offers.space
127.0.0.1 premiumproductsonline.com
127.0.0.1 prestoris.com
127.0.0.1 prexyone.appspot.com
127.0.0.1 prfctlivs.click
127.0.0.1 primetime.ad.primetime.net
127.0.0.1 primusbelgium.com
127.0.0.1 privatecollection.top
127.0.0.1 privitize.com
127.0.0.1 prizes.co.uk
127.0.0.1 prjcq.com
127.0.0.1 pro.hit.gemius.pl
127.0.0.1 pro.letv.com
127.0.0.1 probusinesshub.com
127.0.0.1 proc.ad.cpe.dotomi.com
127.0.0.1 prod-a.applovin.com
127.0.0.1 prodentim101.com
127.0.0.1 productresearchpanel.com
127.0.0.1 producttestpanel.com
127.0.0.1 profile.uproxx.com
127.0.0.1 profiline-berlin.de
127.0.0.1 profitboosterapp.com
127.0.0.1 programe.top
127.0.0.1 promo.awempire.com
127.0.0.1 promo.betcity.net
127.0.0.1 promo.easy-dating.org
127.0.0.1 promo.mes-meilleurs-films.fr
127.0.0.1 promo.mobile.de
127.0.0.1 promo.profxbrokers.com
127.0.0.1 promo.streaming-illimite.net
127.0.0.1 promoreclame.info
127.0.0.1 promoreclame.nl
127.0.0.1 promos.fling.com
127.0.0.1 promotion.partnercash.com
127.0.0.1 promotions.sportingbet.com
127.0.0.1 promoviral.com
127.0.0.1 prospectnews.com
127.0.0.1 protect-your-privacy.net
127.0.0.1 protection.ASpolice.com
127.0.0.1 protection.AUpolice.com
127.0.0.1 protection.AZpolice.com
127.0.0.1 protection.BTpolice.com
127.0.0.1 protection.BYpolice.com
127.0.0.1 protection.CApolice.com
127.0.0.1 protection.CCpolice.com
127.0.0.1 protection.DKpolice.com
127.0.0.1 protection.ESpolice.com
127.0.0.1 protection.FRpolice.com
127.0.0.1 protection.FXpolice.com
127.0.0.1 protection.GApolice.com
127.0.0.1 protection.HKpolice.com
127.0.0.1 protection.HNpolice.com
127.0.0.1 protection.ILpolice.com
127.0.0.1 protection.ITpolice.com
127.0.0.1 protection.JMpolice.com
127.0.0.1 protection.KYpolice.com
127.0.0.1 protection.LApolice.com
127.0.0.1 protection.LBpolice.com
127.0.0.1 protection.LCpolice.com
127.0.0.1 protection.LIpolice.com
127.0.0.1 protection.LRpolice.com
127.0.0.1 protection.LSpolice.com
127.0.0.1 protection.LVpolice.com
127.0.0.1 protection.MApolice.com
127.0.0.1 protection.MDpolice.com
127.0.0.1 protection.MEpolice.com
127.0.0.1 protection.MNpolice.com
127.0.0.1 protection.NApolice.com
127.0.0.1 protection.NCpolice.com
127.0.0.1 protection.NZpolice.com
127.0.0.1 protection.PApolice.com
127.0.0.1 protection.PGpolice.com
127.0.0.1 protection.SBpolice.com
127.0.0.1 protection.TNpolice.com
127.0.0.1 protection.TOpolice.com
127.0.0.1 protection.VApolice.com
127.0.0.1 protection.VIpolice.com
127.0.0.1 protection.stpolice.com
127.0.0.1 proweb.co.uk
127.0.0.1 proximityads.flipcorp.com
127.0.0.1 prpops.com
127.0.0.1 ps-us.amazon-adsystem.com
127.0.0.1 ps.eyeota.net
127.0.0.1 ps.popcash.net
127.0.0.1 ps4ux.com
127.0.0.1 psoabojaksou.net
127.0.0.1 pstatic.datafastguru.info
127.0.0.1 pt-gmtdmp.mookie1.com
127.0.0.1 pt.beststreams.club
127.0.0.1 pt.trafficjunky.net
127.0.0.1 pt21na.com
127.0.0.1 pt5.titans-gel.net
127.0.0.1 pteenoum.com
127.0.0.1 ptirgaux.com
127.0.0.1 ptrads.mp3.com
127.0.0.1 pttsite.com
127.0.0.1 pub.sapo.pt
127.0.0.1 pub.web.sapo.io
127.0.0.1 pubdirecte.com
127.0.0.1 pubimgs.sapo.pt
127.0.0.1 publiads.com
127.0.0.1 publicidades.redtotalonline.com
127.0.0.1 publicis.adcentriconline.com
127.0.0.1 publisher-config.unityads.unity3d.com
127.0.0.1 publishers.adscholar.com
127.0.0.1 publishers.bidtraffic.com
127.0.0.1 publishing.kalooga.com
127.0.0.1 pubmatic-match.dotomi.com
127.0.0.1 pubpress.net
127.0.0.1 pubserver.xl.pt
127.0.0.1 pubshop.img.uol.com.br
127.0.0.1 pulsepoint-match.dotomi.com
127.0.0.1 purryowl.com
127.0.0.1 push-ad.com
127.0.0.1 push-notification.tools
127.0.0.1 push.aarth.net
127.0.0.1 pushagim.com
127.0.0.1 pushno.com
127.0.0.1 pwdplz.com
127.0.0.1 pwwysydh.com
127.0.0.1 px.moatads.com
127.0.0.1 q.azcentral.com
127.0.0.1 qd.admetricspro.com
127.0.0.1 qfdn3gyfbs.com
127.0.0.1 qip.magna.ru
127.0.0.1 qqlogo.qq.com
127.0.0.1 qring-tms.qq.com
127.0.0.1 qss-client.qq.com
127.0.0.1 qualifiedourspecialoffer.com
127.0.0.1 quickandeasy.co.za
127.0.0.1 quickbrowsersearch.com
127.0.0.1 quickfilmz.com
127.0.0.1 quik-serv.com
127.0.0.1 quizzitch.net
127.0.0.1 qxxru.linknotification.com
127.0.0.1 r.chitika.net
127.0.0.1 r.reklama.biz
127.0.0.1 r.turn.com
127.0.0.1 r.turn.com.akadns.net
127.0.0.1 r1.ritikajoshi.com
127.0.0.1 r1.romeflirt.com
127.0.0.1 r2.adwo.com
127.0.0.1 r2.ritikajoshi.com
127.0.0.1 r2.romeflirt.com
127.0.0.1 r3.ritikajoshi.com
127.0.0.1 r3.romeflirt.com
127.0.0.1 r4.ritikajoshi.com
127.0.0.1 r4.romeflirt.com
127.0.0.1 r5.ritikajoshi.com
127.0.0.1 r5.romeflirt.com
127.0.0.1 r6.ritikajoshi.com
127.0.0.1 r6.romeflirt.com
127.0.0.1 r7.ritikajoshi.com
127.0.0.1 r7.romeflirt.com
127.0.0.1 r7mediar.com
127.0.0.1 rad.live.com
127.0.0.1 rad.msn.com
127.0.0.1 rads.stackoverflow.com
127.0.0.1 railroadtomato.com
127.0.0.1 rassegnavermentino.it
127.0.0.1 razor.arnes.si
127.0.0.1 rc.asci.freenet.de
127.0.0.1 rc.bt.ilsemedia.nl
127.0.0.1 rc.hotkeys.com
127.0.0.1 rc.rlcdn.com
127.0.0.1 rc.wl.webads.nl
127.0.0.1 rcdna.gwallet.com
127.0.0.1 rcm-images.amazon.com
127.0.0.1 rcm-it.amazon.it
127.0.0.1 rcm-na.amazon-adsystem.com
127.0.0.1 rd.speakol.com
127.0.0.1 rdsa2012.com
127.0.0.1 re.directrev.com
127.0.0.1 reactads.cdn.adglare.net
127.0.0.1 realads.realmedia.com
127.0.0.1 realgfsbucks.com
127.0.0.1 realmedia-a800.d4p.net
127.0.0.1 realmedia.advance.net
127.0.0.1 realplayz.com
127.0.0.1 rebevengwas.com
127.0.0.1 recommendedforyou.xyz
127.0.0.1 record.commissionlounge.com
127.0.0.1 redherring.ngadcenter.net
127.0.0.1 redir.bebi.com
127.0.0.1 redir9.alteabz.it
127.0.0.1 redirect.click2net.com
127.0.0.1 redirect.hotkeys.com
127.0.0.1 redirect.xmlheads.com
127.0.0.1 redonetype.com
127.0.0.1 reduxads.valuead.com
127.0.0.1 regflow.com
127.0.0.1 regie.espace-plus.net
127.0.0.1 regio.adlink.de
127.0.0.1 register.cinematrix.net
127.0.0.1 register.silverscreen.cc
127.0.0.1 reklam.arabul.com
127.0.0.1 reklam.ebiuniverse.com
127.0.0.1 reklam.milliyet.com.tr
127.0.0.1 reklam.misli.com
127.0.0.1 reklam.mynet.com
127.0.0.1 reklam.softreklam.com
127.0.0.1 reklama.onet.pl
127.0.0.1 reklamagaci.com
127.0.0.1 reklamtrk.com
127.0.0.1 reklamy.sfd.pl
127.0.0.1 relestar.com
127.0.0.1 relevantairbornefantastic.com
127.0.0.1 remekcikkek.com
127.0.0.1 rencontreavenue.com
127.0.0.1 reninet.com
127.0.0.1 report02.adtech.fr
127.0.0.1 report02.adtech.us
127.0.0.1 reporter.adtech.fr
127.0.0.1 reporter.adtech.us
127.0.0.1 reporter001.adtech.fr
127.0.0.1 reporter001.adtech.us
127.0.0.1 reportimage.adtech.fr
127.0.0.1 reportimage.adtech.us
127.0.0.1 reporting.aatkit.com
127.0.0.1 repostuj.push-ad.com
127.0.0.1 req.adsmogo.com
127.0.0.1 res-backup.com
127.0.0.1 res1.applovin.com
127.0.0.1 reselling-corp.com
127.0.0.1 resolvingserver.com
127.0.0.1 resources.infolinks.com
127.0.0.1 restaurantcom.tt.omtrdc.net
127.0.0.1 retargetly-match.dotomi.com
127.0.0.1 reverso.refr.adgtw.orangeads.fr
127.0.0.1 revsci.net
127.0.0.1 rewardpoll.com
127.0.0.1 rewardsflow.com
127.0.0.1 reynders.info
127.0.0.1 rf-arch.com
127.0.0.1 rh.qq.com
127.0.0.1 rh.revolvermaps.com
127.0.0.1 rhads.sv.publicus.com
127.0.0.1 rich.qq.com
127.0.0.1 richmedia.yimg.com
127.0.0.1 ridepush.com
127.0.0.1 rimaje.nl
127.0.0.1 ringtonepartner.com
127.0.0.1 rivalo.network
127.0.0.1 river-store.com
127.0.0.1 rjr-rs.com.br
127.0.0.1 rmbn.ru
127.0.0.1 rmcdn.2mdn.net
127.0.0.1 rmcdn.f.2mdn.net
127.0.0.1 rmedia.boston.com
127.0.0.1 rmm1u.checkm8.com
127.0.0.1 rmp.rakuten.com
127.0.0.1 robbiblubber.org
127.0.0.1 robot.royalcactus.com
127.0.0.1 romepartners.com
127.0.0.1 roosevelt.gjbig.com
127.0.0.1 rosettastone.tt.omtrdc.net
127.0.0.1 rotumal.com
127.0.0.1 route31.org
127.0.0.1 router.adlure.net
127.0.0.1 rovion.com
127.0.0.1 rp.hit.gemius.pl
127.0.0.1 rpc-php.trafficfactory.biz
127.0.0.1 rpc.trafficfactory.biz
127.0.0.1 rpgmasterleague.com
127.0.0.1 rpm.newrelisc.com
127.0.0.1 rqtrk.eu
127.0.0.1 rs1.qq.com
127.0.0.1 rs2.qq.com
127.0.0.1 rss.buysellads.com
127.0.0.1 rta.dailymail.co.uk
127.0.0.1 rtb-lb-event-sjc.tubemogul.com
127.0.0.1 rtb.pclick.yahoo.com
127.0.0.1 rtb.tubemogul.com
127.0.0.1 rtb1.adscience.nl
127.0.0.1 rtb10.adscience.nl
127.0.0.1 rtb11.adscience.nl
127.0.0.1 rtb12.adscience.nl
127.0.0.1 rtb13.adscience.nl
127.0.0.1 rtb14.adscience.nl
127.0.0.1 rtb15.adscience.nl
127.0.0.1 rtb16.adscience.nl
127.0.0.1 rtb17.adscience.nl
127.0.0.1 rtb18.adscience.nl
127.0.0.1 rtb19.adscience.nl
127.0.0.1 rtb2.adscience.nl
127.0.0.1 rtb20.adscience.nl
127.0.0.1 rtb21.adscience.nl
127.0.0.1 rtb22.adscience.nl
127.0.0.1 rtb23.adscience.nl
127.0.0.1 rtb24.adscience.nl
127.0.0.1 rtb25.adscience.nl
127.0.0.1 rtb26.adscience.nl
127.0.0.1 rtb27.adscience.nl
127.0.0.1 rtb28.adscience.nl
127.0.0.1 rtb29.adscience.nl
127.0.0.1 rtb3.adscience.nl
127.0.0.1 rtb30.adscience.nl
127.0.0.1 rtb4.adscience.nl
127.0.0.1 rtb5.adscience.nl
127.0.0.1 rtb6.adscience.nl
127.0.0.1 rtb7.adscience.nl
127.0.0.1 rtb8.adscience.nl
127.0.0.1 rtb9.adscience.nl
127.0.0.1 rtl-most.blogspot.hu
127.0.0.1 rtr.innovid.com
127.0.0.1 rts.sparkstudios.com
127.0.0.1 ru.redtram.com
127.0.0.1 ru4.com
127.0.0.1 rubicon-match.dotomi.com
127.0.0.1 rubyfortune.com
127.0.0.1 ruegenfleisch.de
127.0.0.1 runcpa.com
127.0.0.1 runtime.lemonpi.io
127.0.0.1 rv.adcpx.v1.de.eusem.adaos-ads.net
127.0.0.1 s-adserver.sandbox.cxad.cxense.com
127.0.0.1 s-bid.rmp.rakuten.com
127.0.0.1 s-clk.rmp.rakuten.com
127.0.0.1 s-usweb.dotomi.com
127.0.0.1 s.ad131m.com
127.0.0.1 s.admulti.com
127.0.0.1 s.arclk.net
127.0.0.1 s.atemda.com
127.0.0.1 s.baidu.com
127.0.0.1 s.boom.ro
127.0.0.1 s.click.aliexpress.com
127.0.0.1 s.clickiocdn.com
127.0.0.1 s.clicktale.net
127.0.0.1 s.console.adtarget.com.tr
127.0.0.1 s.di.com.pl
127.0.0.1 s.domob.cn
127.0.0.1 s.dynad.net
127.0.0.1 s.flite.com
127.0.0.1 s.innovid.com
127.0.0.1 s.media-imdb.com
127.0.0.1 s.megaclick.com
127.0.0.1 s.moatads.com
127.0.0.1 s.ntv.io
127.0.0.1 s.optnx.com
127.0.0.1 s.oroll.com
127.0.0.1 s.ppjol.net
127.0.0.1 s.rev2pub.com
127.0.0.1 s.seedtag.com
127.0.0.1 s.skimresources.com
127.0.0.1 s.spolecznosci.net
127.0.0.1 s.spoutable.com
127.0.0.1 s.tcimg.com
127.0.0.1 s.thebrighttag.com
127.0.0.1 s.visilabs.net
127.0.0.1 s0b.bluestreak.com
127.0.0.1 s1.2mdn.net
127.0.0.1 s1.adform.net
127.0.0.1 s3.adbers.com
127.0.0.1 s3.buysellads.com
127.0.0.1 s3.pfp.sina.net
127.0.0.1 s5.addthis.com
127.0.0.1 s7.addthis.com
127.0.0.1 s7clean.com
127.0.0.1 s8t.teads.tv
127.0.0.1 s9kkremkr0.com
127.0.0.1 sabre.com.tw
127.0.0.1 safe.hyperpaysys.com
127.0.0.1 safebrowse.com
127.0.0.1 sagent.io
127.0.0.1 salesforcecom.tt.omtrdc.net
127.0.0.1 saletrybest.su
127.0.0.1 samsung3.solution.weborama.fr
127.0.0.1 sanalreklam.com
127.0.0.1 sarahshuckburgh.com
127.0.0.1 sas.decisionnews.com
127.0.0.1 saturn.tiser.com.au
127.0.0.1 save-plan.com
127.0.0.1 savings-time.com
127.0.0.1 sayac.hurriyet.com.tr
127.0.0.1 sayfabulunamadi.com
127.0.0.1 sb.freeskreen.com
127.0.0.1 sb.scorecardresearch.com
127.0.0.1 sb1.shble.com
127.0.0.1 sb2.shble.com
127.0.0.1 sb3.shble.com
127.0.0.1 sb4.shble.com
127.0.0.1 sb5.shble.com
127.0.0.1 sb6.shble.com
127.0.0.1 sb7.shble.com
127.0.0.1 scalemonk.com
127.0.0.1 scdown.qq.com
127.0.0.1 scegli-vinci.it
127.0.0.1 scgis.co.uk
127.0.0.1 schoorsteen.geenstijl.nl
127.0.0.1 schumacher.adtech.fr
127.0.0.1 schumacher.adtech.us
127.0.0.1 schwab.tt.omtrdc.net
127.0.0.1 scnet.tv
127.0.0.1 scr.kliksaya.com
127.0.0.1 screen-mates.com
127.0.0.1 script.banstex.com
127.0.0.1 script.crsspxl.com
127.0.0.1 scripts.kiosked.com
127.0.0.1 scripts.linkz.net
127.0.0.1 scripts.verticalacuity.com
127.0.0.1 sdk.streamrail.com
127.0.0.1 se.adserver.yahoo.com
127.0.0.1 seapower-italia.it
127.0.0.1 search.addthis.com
127.0.0.1 search.freeonline.com
127.0.0.1 search.keywordblocks.com
127.0.0.1 search.netseer.com
127.0.0.1 search.spotxchange.com
127.0.0.1 searchwe.com
127.0.0.1 sec.hit.gemius.pl
127.0.0.1 secimage.adtech.fr
127.0.0.1 secimage.adtech.us
127.0.0.1 secondchancecoaching.com
127.0.0.1 secserv.adtech.de
127.0.0.1 secserv.adtech.fr
127.0.0.1 secserv.adtech.us
127.0.0.1 secure-js.kontera.com
127.0.0.1 secure.addthis.com
127.0.0.1 secure.adnxs.com
127.0.0.1 secure.bidvertiser.com
127.0.0.1 secure.bidvertiserr.com
127.0.0.1 secure.netscope.marktest.pt
127.0.0.1 secure.webconnect.net
127.0.0.1 securecloud-smart.com
127.0.0.1 secureir.ebaystatic.com
127.0.0.1 securerr.com
127.0.0.1 securerunner.com
127.0.0.1 security60-e.com
127.0.0.1 sedlec.unas.cz
127.0.0.1 see-back.com
127.0.0.1 seemlessfixing.tech
127.0.0.1 seiyuu.ne.jp
127.0.0.1 seks-partner.com
127.0.0.1 select001.adtech.fr
127.0.0.1 select001.adtech.us
127.0.0.1 select002.adtech.fr
127.0.0.1 select002.adtech.us
127.0.0.1 select003.adtech.fr
127.0.0.1 select003.adtech.us
127.0.0.1 select004.adtech.fr
127.0.0.1 select004.adtech.us
127.0.0.1 selling-group.com
127.0.0.1 sergarius.popunder.ru
127.0.0.1 serv.ad-rotator.com
127.0.0.1 serv.adspeed.com
127.0.0.1 serv.tooplay.com
127.0.0.1 serv2.ad-rotator.com
127.0.0.1 serve.adplxmd.com
127.0.0.1 serve.freegaypix.com
127.0.0.1 serve.mediayan.com
127.0.0.1 serve.popads.net
127.0.0.1 serve.prestigecasino.com
127.0.0.1 servedby-buysellads.com
127.0.0.1 servedby.adcombination.com
127.0.0.1 servedby.flashtalking.com
127.0.0.1 servedbyadbutler.com
127.0.0.1 server.as5000.com
127.0.0.1 server.bittads.com
127.0.0.1 server.cpmstar.com
127.0.0.1 server.zoiets.be
127.0.0.1 server2.as5000.com
127.0.0.1 server2.mediajmp.com
127.0.0.1 server44.dubhosting.co.uk
127.0.0.1 server821.com
127.0.0.1 service.adtech.fr
127.0.0.1 service.adtech.us
127.0.0.1 service.urchin.com
127.0.0.1 service001.adtech.fr
127.0.0.1 service001.adtech.us
127.0.0.1 service002.adtech.fr
127.0.0.1 service002.adtech.us
127.0.0.1 service003.adtech.fr
127.0.0.1 service003.adtech.us
127.0.0.1 service004.adtech.fr
127.0.0.1 service004.adtech.us
127.0.0.1 service00x.adtech.fr
127.0.0.1 service00x.adtech.us
127.0.0.1 servicer.mgid.com
127.0.0.1 services.adtech.fr
127.0.0.1 services.adtech.us
127.0.0.1 services1.adtech.fr
127.0.0.1 services1.adtech.us
127.0.0.1 serving-sys.com
127.0.0.1 serving.plexop.net
127.0.0.1 serving.stat-rock.com
127.0.0.1 serwisy.gremimedia.pl
127.0.0.1 setrise.nl
127.0.0.1 seward.net
127.0.0.1 sexpartnerx.com
127.0.0.1 sexsponsors.com
127.0.0.1 sexzavod.com
127.0.0.1 seyatosan.iaigiri.com
127.0.0.1 sfads.osdn.com
127.0.0.1 sg.adserver.yahoo.com
127.0.0.1 sg3.beap.gemini.yahoo.com
127.0.0.1 sgs001.adtech.fr
127.0.0.1 sgs001.adtech.us
127.0.0.1 sh2070.evanzo-server.de
127.0.0.1 sh4sure-images.adbureau.net
127.0.0.1 share-clouds.com
127.0.0.1 share-server.com
127.0.0.1 share-stores.com
127.0.0.1 shareaholic.com
127.0.0.1 shareasale.com
127.0.0.1 sharebar.addthiscdn.com
127.0.0.1 shared-download.com
127.0.0.1 sharefile-us.com
127.0.0.1 sharefiles-eu.com
127.0.0.1 shares-cloud.com
127.0.0.1 shatershepeleve.com
127.0.0.1 shellstore.info
127.0.0.1 shichihukuudon.com
127.0.0.1 shinedns.net
127.0.0.1 shinystat.shiny.it
127.0.0.1 shopperpromotions.com
127.0.0.1 shopping-offer.com
127.0.0.1 shoppingminds.net
127.0.0.1 short-share.com
127.0.0.1 shortcut-links.com
127.0.0.1 shorthouse.com
127.0.0.1 show-msgch.qq.com
127.0.0.1 showads1000.pubmatic.com
127.0.0.1 showadsak.pubmatic.com
127.0.0.1 shrek.6.cn
127.0.0.1 shrimpsqueezed.com
127.0.0.1 si.hit.gemius.pl
127.0.0.1 sidare.homes
127.0.0.1 sifomedia.citypaketet.se
127.0.0.1 signup.advance.net
127.0.0.1 silcom.com
127.0.0.1 simba.6.cn
127.0.0.1 simg.zedo.com
127.0.0.1 simpleads.net
127.0.0.1 simpli.fi
127.0.0.1 simpli.top
127.0.0.1 sinseisyoji.co.jp
127.0.0.1 sistemishop.it
127.0.0.1 site.adform.com
127.0.0.1 siteadvisor.com-br.site
127.0.0.1 siteonline.stream
127.0.0.1 sixapart.adbureau.net
127.0.0.1 sjc-usadmm-ds.dotomi.com
127.0.0.1 sjc-usadmm.dotomi.com
127.0.0.1 skaluneris.com
127.0.0.1 sky.od.ua
127.0.0.1 slayinglance.com
127.0.0.1 slhk23.0101host.com
127.0.0.1 slimspots.com
127.0.0.1 slowmac.tech
127.0.0.1 slowmacfaster.trade
127.0.0.1 smaato-match.dotomi.com
127.0.0.1 smarine.mu
127.0.0.1 smart-scripts.com
127.0.0.1 smartadserver.com
127.0.0.1 smartclip.com
127.0.0.1 smartclip.net
127.0.0.1 smartcontext.pl
127.0.0.1 smartinit.webads.nl
127.0.0.1 smartlifeguides.com
127.0.0.1 smartshare.lgtvsdp.com
127.0.0.1 smarttopchain.nl
127.0.0.1 smitt.nl
127.0.0.1 smokersopinionpoll.com
127.0.0.1 smsmovies.net
127.0.0.1 smutstone.com
127.0.0.1 snammar-jumntal.com
127.0.0.1 snaps.vidiemi.com
127.0.0.1 snip.answers.com
127.0.0.1 soarpower.com
127.0.0.1 sobar.baidu.com
127.0.0.1 sochr.com
127.0.0.1 social.bidsystem.com
127.0.0.1 socom.es
127.0.0.1 softlinkers.popunder.ru
127.0.0.1 sokrates.adtech.fr
127.0.0.1 sokrates.adtech.us
127.0.0.1 sol-images.adbureau.net
127.0.0.1 sol.adbureau.net
127.0.0.1 solartia.com
127.0.0.1 solicita.info
127.0.0.1 solitairetime.com
127.0.0.1 solution.weborama.fr
127.0.0.1 somethingawful.crwdcntrl.net
127.0.0.1 sonycomputerentertai.tt.omtrdc.net
127.0.0.1 sophang8.com
127.0.0.1 sortis.lt
127.0.0.1 sp.adbrn.com
127.0.0.1 spaces.slimspots.com
127.0.0.1 spadework.org
127.0.0.1 spanel.gem.pl
127.0.0.1 spanids.dictionary.com
127.0.0.1 spanids.thesaurus.com
127.0.0.1 special-alerts.com
127.0.0.1 specialoffers.aol.com
127.0.0.1 speed.pointroll.com
127.0.0.1 speedboink.com
127.0.0.1 speedclicks.ero-advertising.com
127.0.0.1 speedcurve.com
127.0.0.1 speednetwork14.adk2x.com
127.0.0.1 speednetwork6.adk2x.com
127.0.0.1 speeltuintalud.nl
127.0.0.1 spensa.co
127.0.0.1 spin.spinbox.net
127.0.0.1 spinbox.com
127.0.0.1 spinbox.freedom.com
127.0.0.1 spinbox.techtracker.com
127.0.0.1 spiralfolderrollers.com
127.0.0.1 spolecznosci.mgr.consensu.org
127.0.0.1 spolecznosci.net
127.0.0.1 sponsor1.com
127.0.0.1 sponsorships.net
127.0.0.1 sportreisen.de
127.0.0.1 sportydesktops.com
127.0.0.1 spotxchange.com
127.0.0.1 sq2trk2.com
127.0.0.1 srs.targetpoint.com
127.0.0.1 srtb.msn.com
127.0.0.1 srv.bebi.com
127.0.0.1 srv.juiceadv.com
127.0.0.1 srv.sayyac.com
127.0.0.1 srv7.admedit.net
127.0.0.1 ssads.osdn.com
127.0.0.1 sso.canada.com
127.0.0.1 ssp.adplus.co.id
127.0.0.1 ssp.imedia.cz
127.0.0.1 ssp.seznam.cz
127.0.0.1 ssp.streamrail.net
127.0.0.1 sspcash.adxcore.com
127.0.0.1 st.blogads.com
127.0.0.1 st.pba.xl.pt
127.0.0.1 st.videojam.tv
127.0.0.1 staceydodge.com
127.0.0.1 stampen.adtlgc.com
127.0.0.1 stampen.linkpulse.com
127.0.0.1 stampscom.tt.omtrdc.net
127.0.0.1 stanbridgeestate.com
127.0.0.1 star-advertising.com
127.0.0.1 star.pulseonclick.com
127.0.0.1 start.badults.se
127.0.0.1 stat.56.com
127.0.0.1 stat.blogads.com
127.0.0.1 stat.dealtime.com
127.0.0.1 stat.detelefoongids.nl
127.0.0.1 stat.rolledwil.biz
127.0.0.1 stat2.corp.56.com
127.0.0.1 static-downloads.com
127.0.0.1 static-google-analtyic.com
127.0.0.1 static.2mdn.net
127.0.0.1 static.admaximize.com
127.0.0.1 static.adsafeprotected.com
127.0.0.1 static.adsonar.com
127.0.0.1 static.adwo.com
127.0.0.1 static.adzerk.net
127.0.0.1 static.chartbeat.com
127.0.0.1 static.clickonometrics.pl
127.0.0.1 static.criteo.net
127.0.0.1 static.doubleclick.net
127.0.0.1 static.eu.criteo.net
127.0.0.1 static.everyone.net
127.0.0.1 static.fmpub.net
127.0.0.1 static.freenet.de
127.0.0.1 static.freeskreen.com
127.0.0.1 static.ifa.camads.net
127.0.0.1 static.l3.cdn.adbucks.com
127.0.0.1 static.l3.cdn.adsucks.com
127.0.0.1 static.linkz.net
127.0.0.1 static.loboclick.com
127.0.0.1 static.mackeeper.com
127.0.0.1 static.mediav.com
127.0.0.1 static.oroll.com
127.0.0.1 static.plista.com
127.0.0.1 static.plugrush.com
127.0.0.1 static.ptoahaistais.com
127.0.0.1 static.scanscout.com
127.0.0.1 static.trackuity.com
127.0.0.1 static.trafficstars.com
127.0.0.1 static.unocdn.com
127.0.0.1 static.vertamedia.com
127.0.0.1 static.virgul.com
127.0.0.1 static.vpptechnologies.com
127.0.0.1 static.wooboo.com.cn
127.0.0.1 static.youmi.net
127.0.0.1 staticads.btopenworld.com
127.0.0.1 staticb.mydirtyhobby.com
127.0.0.1 staticd.cdn.adblade.com
127.0.0.1 statistic.ads24h.net
127.0.0.1 statistik-gallup.dk
127.0.0.1 stats.appsflyer.com
127.0.0.1 stats.askmoses.com
127.0.0.1 stats.defense.gov
127.0.0.1 stats.fd.nl
127.0.0.1 stats.ipinyou.com
127.0.0.1 stats.shopify.com
127.0.0.1 stats.tubemogul.com
127.0.0.1 stats.x14.eu
127.0.0.1 statsie.com
127.0.0.1 stephanie.tnctrx.com
127.0.0.1 stocker.bonnint.net
127.0.0.1 stompebi.link
127.0.0.1 storage.softure.com
127.0.0.1 storage.trafic.ro
127.0.0.1 store-downloads.com
127.0.0.1 strategy.lmobi.net
127.0.0.1 stream-direct.co
127.0.0.1 streamate.com
127.0.0.1 streamate.doublepimp.com
127.0.0.1 stub.mainspotvideosfree.best
127.0.0.1 studiomugnaini.eu
127.0.0.1 studiospa.com.pl
127.0.0.1 stx-match.dotomi.com
127.0.0.1 su.addthis.com
127.0.0.1 su.valley.ne.jp
127.0.0.1 sudokuwhiz.com
127.0.0.1 suhunsoo.uk
127.0.0.1 summer.ntua.edu.tw
127.0.0.1 sumo.ad
127.0.0.1 sumome.com
127.0.0.1 sunmaker.com
127.0.0.1 super-mario-deluxe.net
127.0.0.1 superbrewards.com
127.0.0.1 superfastcdn.com
127.0.0.1 superinterstitial.com
127.0.0.1 superlecker.info
127.0.0.1 support-ip.com
127.0.0.1 support.sweepstakes.com
127.0.0.1 suprama.online
127.0.0.1 surfindave.com
127.0.0.1 surfsecured.net
127.0.0.1 surplus-suppliers.com
127.0.0.1 survey.china.alibaba.com
127.0.0.1 survey.nuggad.net
127.0.0.1 surveymonkeycom.tt.omtrdc.net
127.0.0.1 surveypass.com
127.0.0.1 survymonkey.xyz
127.0.0.1 susi.adtech.fr
127.0.0.1 susi.adtech.us
127.0.0.1 svava.eu
127.0.0.1 svd.adtlgc.com
127.0.0.1 svd2.adtlgc.com
127.0.0.1 swa.and.co.uk
127.0.0.1 swa.metro.co.uk
127.0.0.1 sweetsforfree.com
127.0.0.1 swfhostltd.com
127.0.0.1 sworkitads.herokuapp.com
127.0.0.1 syn.verticalacuity.com
127.0.0.1 synacor-match.dotomi.com
127.0.0.1 synad.nuffnang.com.sg
127.0.0.1 synad2.nuffnang.com.cn
127.0.0.1 sync-eu.exe.bid
127.0.0.1 sync-share.com
127.0.0.1 sync.1rx.io
127.0.0.1 sync.audtd.com
127.0.0.1 sync.console.adtarget.com.tr
127.0.0.1 sync.credebat.com
127.0.0.1 sync.mathtag.com
127.0.0.1 sync.outbrain.com
127.0.0.1 sync.pulseradius.com
127.0.0.1 sync.upravel.com
127.0.0.1 syncaccess.net
127.0.0.1 syncdownload.com
127.0.0.1 syncdownloading.com
127.0.0.1 syndicated.mondominishows.com
127.0.0.1 syndication.exdynsrv.com
127.0.0.1 syndication.exoclick.com
127.0.0.1 syndication.exosrv.com
127.0.0.1 syndication.optimizesrv.com
127.0.0.1 syndication.traffichaus.com
127.0.0.1 sysadmin.map24.com
127.0.0.1 sysip.net
127.0.0.1 szabadonebredok.info
127.0.0.1 szalonenagrody.com
127.0.0.1 szalonepromocje.com
127.0.0.1 szemlelo.com
127.0.0.1 szupertanacsok.blog.hu
127.0.0.1 t-ads.adap.tv
127.0.0.1 t-o-kitano.com
127.0.0.1 t-odx.op-mobile.opera.com
127.0.0.1 t.atpanel.com
127.0.0.1 t.dynad.net
127.0.0.1 t.frtyg.com
127.0.0.1 t.mdn2015x3.com
127.0.0.1 t.seedtag.com
127.0.0.1 t.silvinst.com
127.0.0.1 t1.adserver.com
127.0.0.1 t2.junbi-tracker.com
127.0.0.1 t8t7frium3.s.ad6media.fr
127.0.0.1 taboola.com
127.0.0.1 taboola.com.edgekey.net
127.0.0.1 taboolasyndication.com
127.0.0.1 tag-dyn.omnitagjs.com
127.0.0.1 tag.contextweb.com
127.0.0.1 tag.regieci.com
127.0.0.1 tag.webcompteur.com
127.0.0.1 tag.yieldoptimizer.com
127.0.0.1 tags.bluekai.com
127.0.0.1 tags.expo9.exponential.com
127.0.0.1 tags.hypeads.org
127.0.0.1 tags.onscroll.com
127.0.0.1 tags.tagcade.com
127.0.0.1 taicheetee.com
127.0.0.1 takeforme.xyz
127.0.0.1 takeoneaudio.jp
127.0.0.1 tanio-najtaniej.com
127.0.0.1 taobaoafp.allyes.cn
127.0.0.1 taouxis.gr
127.0.0.1 tapixesa.pro
127.0.0.1 tc.tradetracker.net
127.0.0.1 tcadops.ca
127.0.0.1 tcimg.com
127.0.0.1 tcss.qq.com
127.0.0.1 tdameritrade.tt.omtrdc.net
127.0.0.1 tdc.advertorials.dk
127.0.0.1 te.kontera.com
127.0.0.1 te1.techgeetam.com
127.0.0.1 teads-match.dotomi.com
127.0.0.1 tealium.com
127.0.0.1 tealiumiq.com
127.0.0.1 techexpert.site
127.0.0.1 techms-shop.su
127.0.0.1 techreview-images.adbureau.net
127.0.0.1 techreview.adbureau.net
127.0.0.1 teeser.ru
127.0.0.1 telefoniabologna.it
127.0.0.1 telusplanet.net
127.0.0.1 testapp.adhood.com
127.0.0.1 testensie.de
127.0.0.1 testpconly12.prepare2upvideosafesystem4setnow.online
127.0.0.1 tewxda71.secure.ne.jp
127.0.0.1 texas-diesel.com
127.0.0.1 text-link-ads.com
127.0.0.1 textad.traficdublu.ro
127.0.0.1 textads.madisonavenue.com
127.0.0.1 textsrv.com
127.0.0.1 tf.nexac.com
127.0.0.1 tgpmanager.com
127.0.0.1 thamescom.com
127.0.0.1 thanku.page
127.0.0.1 the-adblocker.website
127.0.0.1 the-binary-trader.biz
127.0.0.1 thebestgame2020.com
127.0.0.1 thebitcrew.com
127.0.0.1 thebrighttag.com
127.0.0.1 thebuzz.today
127.0.0.1 theestatehouse.co.uk
127.0.0.1 theketo-complete.com
127.0.0.1 themaplemethod.com
127.0.0.1 theotime.net
127.0.0.1 thepiratetrader.com
127.0.0.1 theswimshop.co.za
127.0.0.1 theuseful.com
127.0.0.1 theuseful.net
127.0.0.1 thinknyc.eu-adcenter.net
127.0.0.1 thinktarget.com
127.0.0.1 thirtydaychange.com
127.0.0.1 this.content.served.by.addshuffle.com
127.0.0.1 this.content.served.by.adshuffle.com
127.0.0.1 throtle-match.dotomi.com
127.0.0.1 throwingsevens.co.uk
127.0.0.1 thruport.com
127.0.0.1 tic.filmstoon.cam
127.0.0.1 tidebuy.com
127.0.0.1 tiltott.net
127.0.0.1 timetunnel.net
127.0.0.1 tiqcdn.com
127.0.0.1 titan-gel-extra.com
127.0.0.1 titkoshirek.wordpress.com
127.0.0.1 titokterminal.com
127.0.0.1 tj6w5.flx10.com
127.0.0.1 tlx.3lift.com
127.0.0.1 tmx.technoratimedia.com
127.0.0.1 toads.osdn.com
127.0.0.1 todayresearch.com
127.0.0.1 toiletpaper.life
127.0.0.1 tommasobuglioni.com
127.0.0.1 tommysbookmarks.com
127.0.0.1 tommysbookmarks.net
127.0.0.1 tomsonguitars.co.uk
127.0.0.1 tongji.baidu.com
127.0.0.1 toolbar.baidu.com
127.0.0.1 toolbar.soso.com
127.0.0.1 top.list.ru
127.0.0.1 top100-images.rambler.ru
127.0.0.1 top1site.3host.com
127.0.0.1 top5.mail.ru
127.0.0.1 topbestgames.com
127.0.0.1 topcashvibes.com
127.0.0.1 topconsumergifts.com
127.0.0.1 topdemaroc.com
127.0.0.1 tophirek.hu
127.0.0.1 toplist.cz
127.0.0.1 toplist.eu
127.0.0.1 toplist.throughput.de
127.0.0.1 topshape.me
127.0.0.1 toro-tags.com
127.0.0.1 toroadvertisingmedia.com
127.0.0.1 tororango.com
127.0.0.1 touch.media-serving.com
127.0.0.1 tour.cineble.com
127.0.0.1 tp2.beap.gemini.yahoo.com
127.0.0.1 tpads.ovguide.com
127.0.0.1 tpc.googlesyndication.com
127.0.0.1 tps.doubleverify.com
127.0.0.1 tps10216.doubleverify.com
127.0.0.1 tps20519.doubleverify.com
127.0.0.1 tps30.doubleverify.com
127.0.0.1 tps31.doubleverify.com
127.0.0.1 tpt.dotomi.com
127.0.0.1 tr.bigpoint.com
127.0.0.1 tr.outbrain.com
127.0.0.1 tr.wl.webads.nl
127.0.0.1 traaaack.com
127.0.0.1 trace.qq.com
127.0.0.1 track.adbooth.net
127.0.0.1 track.cam4tracking.com
127.0.0.1 track.e7r.com.br
127.0.0.1 track.omgpl.com
127.0.0.1 track.roularta.adhese.com
127.0.0.1 track.tooplay.com
127.0.0.1 track.vscash.com
127.0.0.1 tracker.awr.im
127.0.0.1 tracker.baidu.com
127.0.0.1 tracking.aatkit.com
127.0.0.1 tracking.craktraffic.com
127.0.0.1 tracking.edvisors.com
127.0.0.1 tracking.feedmob.com
127.0.0.1 tracking.internetstores.de
127.0.0.1 tracking.joker.com
127.0.0.1 tracking.keywordmax.com
127.0.0.1 tracking.scientific-meets.com
127.0.0.1 tracking.truthfinder.com
127.0.0.1 tracking.vcommission.com
127.0.0.1 tracking.veoxa.com
127.0.0.1 trackvoluum.com
127.0.0.1 tradearabia.advertserve.com
127.0.0.1 tradecore.tradehouse.media
127.0.0.1 tradelax.com
127.0.0.1 tradem.com
127.0.0.1 tradetracker.net
127.0.0.1 traffic.adxprts.com
127.0.0.1 traffic.adxprtz.com
127.0.0.1 traffic.focuusing.com
127.0.0.1 traffic.getmyads.com
127.0.0.1 traffic.outbrain.com
127.0.0.1 trafficbee.com
127.0.0.1 trafficnetworkads24.com
127.0.0.1 trafficrevenue.net
127.0.0.1 trafficsan.com
127.0.0.1 traffictraders.com
127.0.0.1 traffprofit.com
127.0.0.1 trafmag.com
127.0.0.1 trafsearchonline.com
127.0.0.1 traktum.com
127.0.0.1 transferwiser.io
127.0.0.1 transplugin.io
127.0.0.1 travelhub.com.sg
127.0.0.1 trc.taboola.com
127.0.0.1 trekmedia.net
127.0.0.1 trendingpatrol.com
127.0.0.1 trendnews.com
127.0.0.1 trends.revcontent.com
127.0.0.1 triangle.dealsaver.com
127.0.0.1 tridentenvironmental.co.uk
127.0.0.1 triplelift-match.dotomi.com
127.0.0.1 trk.ablogica.com
127.0.0.1 trk.etrigue.com
127.0.0.1 trk.vidible.tv
127.0.0.1 trourted.pro
127.0.0.1 trustaffs.com
127.0.0.1 trvlnet-images.adbureau.net
127.0.0.1 trvlnet.adbureau.net
127.0.0.1 tryanimalemale.com
127.0.0.1 ts-shimada.com
127.0.0.1 tsbm.ch
127.0.0.1 tsp2002.com
127.0.0.1 tste.startribune.com
127.0.0.1 tsyndicate.com
127.0.0.1 ttarget.adbureau.net
127.0.0.1 ttnet.yandex.com.tr
127.0.0.1 ttoc8ok.com
127.0.0.1 tudasfaja.com
127.0.0.1 tudaskor.com
127.0.0.1 tudathalo.blogspot.hu
127.0.0.1 tudatosanelok.com
127.0.0.1 tudnodkel.blogspot.com
127.0.0.1 tudnodkell.info
127.0.0.1 turn.com
127.0.0.1 turnerapac.d1.sc.omtrdc.net
127.0.0.1 tv2no.linkpulse.com
127.0.0.1 tvn.adocean.pl
127.0.0.1 tvn.hit.gemius.pl
127.0.0.1 tvshowsnow.tvmax.hop.clickbank.net
127.0.0.1 tw.adserver.yahoo.com
127.0.0.1 tw2.adserver.yahoo.com
127.0.0.1 twofish.freeuk.com
127.0.0.1 twoj-typ.pl
127.0.0.1 twoj-voucher.com
127.0.0.1 twoje-nagrody.com.pl
127.0.0.1 twoje-nagrody.pl
127.0.0.1 twojszczesliwydzien.com
127.0.0.1 tz284.com
127.0.0.1 u-ads.adap.tv
127.0.0.1 u.openx.net
127.0.0.1 u.videoamp.com
127.0.0.1 uac.advertising.com
127.0.0.1 uav.tidaltv.com
127.0.0.1 ubmcmm.baidustatic.com
127.0.0.1 ucstat.baidu.com
127.0.0.1 ud.adkmob.com
127.0.0.1 udarem.com
127.0.0.1 uedata.amazon.com
127.0.0.1 uelbdc74fn.s.ad6media.fr
127.0.0.1 ugo.eu-adcenter.net
127.0.0.1 ui.ppjol.com
127.0.0.1 ujvilagtudat.blogspot.hu
127.0.0.1 uk-ads.openx.net
127.0.0.1 uk.adserver.yahoo.com
127.0.0.1 uk.bitcoinfreedom-appl.t500track42.com
127.0.0.1 ukrashulya.ru
127.0.0.1 uktc.ijento.com
127.0.0.1 ultrasponsor.com
127.0.0.1 ulusalofis.com
127.0.0.1 um.simpli.fi
127.0.0.1 ums.adtechus.com
127.0.0.1 unclechunk.com
127.0.0.1 undertonenetworks.com
127.0.0.1 uniclick.openv.com
127.0.0.1 union.56.com
127.0.0.1 union.6.cn
127.0.0.1 union.baidu.com
127.0.0.1 unityads.unity.cn
127.0.0.1 unityads.unitychina.cn
127.0.0.1 unruly-match.dotomi.com
127.0.0.1 unser-en.de
127.0.0.1 unstat.baidu.com
127.0.0.1 uole.ad.uol.com.br
127.0.0.1 upgrade-ms-home.com
127.0.0.1 upload.adtech.fr
127.0.0.1 upload.adtech.us
127.0.0.1 uproar.com
127.0.0.1 uproar.fortunecity.com
127.0.0.1 urban.adspirit.de
127.0.0.1 urc.taboolasyndication.com
127.0.0.1 us-ads.openx.net
127.0.0.1 us-microsoft-store.com
127.0.0.1 us-u.openx.net
127.0.0.1 us.adserver.yahoo.com
127.0.0.1 usadmm-ds.dotomi.com
127.0.0.1 usadmm.dotomi.com
127.0.0.1 usatoday.app.ur.gcion.com
127.0.0.1 usc.adserver.snapads.com
127.0.0.1 usemax.de
127.0.0.1 users.cuci.nl
127.0.0.1 users.tpg.com.au
127.0.0.1 usswrite.com
127.0.0.1 utarget.ru
127.0.0.1 utility.baidu.com
127.0.0.1 utils.media-general.com
127.0.0.1 utils.mediageneral.com
127.0.0.1 uvimage.56.com
127.0.0.1 v-support.free.bg
127.0.0.1 v1.browser-tools.systems
127.0.0.1 v1.viayonetici.com
127.0.0.1 v16.56.com
127.0.0.1 v2.adsbookie.com
127.0.0.1 v2.viayonetici.com
127.0.0.1 v2profit.com
127.0.0.1 v3.toolbar.soso.com
127.0.0.1 v3.viayonetici.com
127.0.0.1 v4.viayonetici.com
127.0.0.1 v5.viayonetici.com
127.0.0.1 v6.viayonetici.com
127.0.0.1 v7.viayonetici.com
127.0.0.1 vaitu.club
127.0.0.1 vakarek.info
127.0.0.1 valsgaard-kofod.dk
127.0.0.1 van.ads.link4ads.com
127.0.0.1 vanbenthem.org
127.0.0.1 vast.ssp.optimatic.com
127.0.0.1 vast.tubemogul.com
127.0.0.1 vast.vertamedia.com
127.0.0.1 vcdn.adnxs.com
127.0.0.1 vda.oipzyrzffum.ovh
127.0.0.1 vdbunt.net
127.0.0.1 ve1.claker.top
127.0.0.1 ve1.techgeetam.com
127.0.0.1 ve2.techgeetam.com
127.0.0.1 veirregnant.club
127.0.0.1 vendorlist.consensu.org
127.0.0.1 venetia.iad.appboy.com
127.0.0.1 vhowland.co.uk
127.0.0.1 vht.tradedoubler.com
127.0.0.1 viamichelin.cdn11.contentabc.com
127.0.0.1 viamichelin.media.trafficjunky.net
127.0.0.1 vibrantmedia.com
127.0.0.1 vice-ads-cdn.vice.com
127.0.0.1 victorlutte.cl
127.0.0.1 vidamsag.postr.hu
127.0.0.1 video-bazis.com
127.0.0.1 video.cynogage.com
127.0.0.1 video.entertaintastic.com
127.0.0.1 videobox.com
127.0.0.1 videocop.com
127.0.0.1 videoegg.adbureau.net
127.0.0.1 videogamerewardscentral.com
127.0.0.1 videomediagroep.nl
127.0.0.1 videos.fleshlight.com
127.0.0.1 videoslots.888.com
127.0.0.1 videovip.org
127.0.0.1 vidnline.com
127.0.0.1 vidroll.ru
127.0.0.1 view.atdmt.com
127.0.0.1 view.binlayer.com
127.0.0.1 view.jamba.de
127.0.0.1 views.m4n.nl
127.0.0.1 viglink.com
127.0.0.1 viglink.pgpartner.com
127.0.0.1 vilagfigyelo.com
127.0.0.1 vilaghelyzete.blogspot.com
127.0.0.1 vilagpolgarok.blogspot.hu
127.0.0.1 vilagunk.hu
127.0.0.1 villagarden.pl
127.0.0.1 vinkelvej12.dk
127.0.0.1 vip.adpiano.com
127.0.0.1 vipfastmoney.com
127.0.0.1 viralture.com
127.0.0.1 viralvideos.tips
127.0.0.1 vj.quanjingpay.com
127.0.0.1 vltwox7zl7h1wv.com
127.0.0.1 vmcsatellite.com
127.0.0.1 vmix.adbureau.net
127.0.0.1 vn.grab-credit4u.com
127.0.0.1 vnu.eu-adcenter.net
127.0.0.1 vnumedia02.webtrekk.net
127.0.0.1 vnumedia03.webtrekk.net
127.0.0.1 vnumedia04.webtrekk.net
127.0.0.1 vodafoneit.solution.weborama.fr
127.0.0.1 vodoustoichivshperplat.com
127.0.0.1 vodus-api-serverless.azurewebsites.net
127.0.0.1 vodus-api.azurewebsites.net
127.0.0.1 vodus.com
127.0.0.1 voduscdn.azureedge.net
127.0.0.1 volksaddiction.nl
127.0.0.1 voluumtracker.com
127.0.0.1 voluumtrk.com
127.0.0.1 voluumtrk2.com
127.0.0.1 voluumtrk3.com
127.0.0.1 voordeel.ad.nl
127.0.0.1 vpm.hu
127.0.0.1 vq91811.com
127.0.0.1 vu.veoxa.com
127.0.0.1 vz-cdn.trafficjunky.net
127.0.0.1 vzarabotke.ru
127.0.0.1 w-chat.xf.cz
127.0.0.1 w.ic.tynt.com
127.0.0.1 w.l.qq.com
127.0.0.1 w1.am15.net
127.0.0.1 w1.webcompteur.com
127.0.0.1 w10.centralmediaserver.com
127.0.0.1 w11.centralmediaserver.com
127.0.0.1 w2.am15.net
127.0.0.1 wa.and.co.uk
127.0.0.1 wac.2ddcc.alphacdn.net
127.0.0.1 wafmedia3.com
127.0.0.1 wahoha.com
127.0.0.1 wallflore.de
127.0.0.1 wangmeng.baidu.com
127.0.0.1 waoptions.com.au
127.0.0.1 wap.casee.cn
127.0.0.1 watch-this.live
127.0.0.1 waust.at
127.0.0.1 wayfarerspoutpraise.com
127.0.0.1 wd.adcolony.com
127.0.0.1 wdm29.com
127.0.0.1 we-are-gamers.com
127.0.0.1 weather.fixitpro.ro
127.0.0.1 web-bars.com
127.0.0.1 web.adblade.com
127.0.0.1 web.hb.ad.cpe.dotomi.com
127.0.0.1 web123.webhotelli.fi
127.0.0.1 web1b.netreflector.com
127.0.0.1 webads.bizservers.com
127.0.0.1 webads.nl
127.0.0.1 webcamsex.nl
127.0.0.1 webcompteur.com
127.0.0.1 webhosting-ads.home.pl
127.0.0.1 webkurchatov.ru
127.0.0.1 webmdcom.tt.omtrdc.net
127.0.0.1 webstats1.com
127.0.0.1 websurvey.spa-mr.com
127.0.0.1 webtj.net
127.0.0.1 webtrekk.net
127.0.0.1 webuysupplystore.mooo.com
127.0.0.1 webwise.bt.com
127.0.0.1 wedleaunocomp.work
127.0.0.1 wegetpaid.net
127.0.0.1 wegotmedia.co
127.0.0.1 welcome.faptitans.com
127.0.0.1 welcome.pussysaga.com
127.0.0.1 wellnessnaturopathic.com
127.0.0.1 werinussa.net
127.0.0.1 westbridges.net
127.0.0.1 wf.basebanner.com
127.0.0.1 wf.taboola.com
127.0.0.1 whatishotnow.net
127.0.0.1 whos.amung.us
127.0.0.1 widespace.com
127.0.0.1 widget.achetezfacile.com
127.0.0.1 widget.adcovery.com
127.0.0.1 widget3.linkwithin.com
127.0.0.1 widget5.linkwithin.com
127.0.0.1 widgets.amung.us
127.0.0.1 widgets.outbrain.com
127.0.0.1 widgets.tcimg.com
127.0.0.1 wigetmedia.com
127.0.0.1 wikiforosh.ir
127.0.0.1 williamhill.es
127.0.0.1 windowgolddealtheclicks.live
127.0.0.1 windows-afx-update.com
127.0.0.1 windows-cnd-update.com
127.0.0.1 windows-en-us-update.com
127.0.0.1 windows-fsd-update.com
127.0.0.1 windows-msd-update.com
127.0.0.1 windows-office365.com
127.0.0.1 windows-service-en.com
127.0.0.1 windows-several-update.com
127.0.0.1 windows-update-02-en.com
127.0.0.1 windows-wsus-update.com
127.0.0.1 winner-prize.com
127.0.0.1 wm.baidu.com
127.0.0.1 wmedia.adk2x.com
127.0.0.1 wms-eu.amazon-adsystem.com
127.0.0.1 wms-na.amazon-adsystem.com
127.0.0.1 wonderlandads.com
127.0.0.1 worden.samenresultaat.nl
127.0.0.1 work-offer.com
127.0.0.1 workaccount.free.bg
127.0.0.1 worldmedpilldeliver.com
127.0.0.1 worry-free-savings.com
127.0.0.1 wowanalytics.co.uk
127.0.0.1 wppluginspro.com
127.0.0.1 ws-na.amazon-adsystem.com
127.0.0.1 wtp101.com
127.0.0.1 ww1.flashx.net
127.0.0.1 ww12.audienceexposure.com
127.0.0.1 ww1510.smartadserver.com
127.0.0.1 ww251.smartadserver.com
127.0.0.1 ww690.smartadserver.com
127.0.0.1 ww7.audienceexposure.com
127.0.0.1 www-x-videos.com
127.0.0.1 www.0202.com.tw
127.0.0.1 www.1-1ads.com
127.0.0.1 www.1120.com.tw
127.0.0.1 www.1hkfq6598i.com
127.0.0.1 www.247realmedia.com
127.0.0.1 www.321cba.com
127.0.0.1 www.360ads.com
127.0.0.1 www.3qqq.net
127.0.0.1 www.3turtles.com
127.0.0.1 www.404errorpage.com
127.0.0.1 www.56.com
127.0.0.1 www.5thavenue.com
127.0.0.1 www.7500.com
127.0.0.1 www.7bpeople.com
127.0.0.1 www.805m.com
127.0.0.1 www.888.com
127.0.0.1 www.888casino.com
127.0.0.1 www.888poker.com
127.0.0.1 www.90offbags.com
127.0.0.1 www.961.com
127.0.0.1 www.aandgwright.plus.com
127.0.0.1 www.aarth.net
127.0.0.1 www.abc-tax.jp
127.0.0.1 www.actiondesk.com
127.0.0.1 www.ad-center.com
127.0.0.1 www.ad-souk.com
127.0.0.1 www.ad-up.com
127.0.0.1 www.ad-words.ru
127.0.0.1 www.ad6media.fr
127.0.0.1 www.adblockanalytics.com
127.0.0.1 www.adbrite.com
127.0.0.1 www.adcanadian.com
127.0.0.1 www.adcash.com
127.0.0.1 www.addthis.com
127.0.0.1 www.adengage.com
127.0.0.1 www.adexchangecloud.com
127.0.0.1 www.adfactor.nl
127.0.0.1 www.adfunkyserver.com
127.0.0.1 www.adfusion.com
127.0.0.1 www.adimages.beeb.com
127.0.0.1 www.adipics.com
127.0.0.1 www.adjmps.com
127.0.0.1 www.adjug.com
127.0.0.1 www.adloader.com
127.0.0.1 www.adlogix.com
127.0.0.1 www.admex.com
127.0.0.1 www.adnet.biz
127.0.0.1 www.adnet.com
127.0.0.1 www.adnet.de
127.0.0.1 www.adnetworkperformance.com
127.0.0.1 www.adnxs.com
127.0.0.1 www.adobee.com
127.0.0.1 www.adocean.pl
127.0.0.1 www.adotube.com
127.0.0.1 www.adpepper.dk
127.0.0.1 www.adpmbtj.com
127.0.0.1 www.adpowerzone.com
127.0.0.1 www.adquest3d.com
127.0.0.1 www.adreporting.com
127.0.0.1 www.adrianwaldock.plus.com
127.0.0.1 www.ads.revenue.net
127.0.0.1 www.ads2srv.com
127.0.0.1 www.adscience.nl
127.0.0.1 www.adsensecustomsearchads.com
127.0.0.1 www.adserver-espnet.sportszone.net
127.0.0.1 www.adserver.co.il
127.0.0.1 www.adserver.com
127.0.0.1 www.adserver.com.my
127.0.0.1 www.adserver.janes.net
127.0.0.1 www.adserver.janes.org
127.0.0.1 www.adserver.net
127.0.0.1 www.adserver.ugo.nl
127.0.0.1 www.adservtech.com
127.0.0.1 www.adsinimages.com
127.0.0.1 www.adskeeper.co.uk
127.0.0.1 www.adsoftware.com
127.0.0.1 www.adspics.com
127.0.0.1 www.adsrvr.org
127.0.0.1 www.adstogo.com
127.0.0.1 www.adsupplyads.com
127.0.0.1 www.adtechus.com
127.0.0.1 www.adtrader.com
127.0.0.1 www.adtrix.com
127.0.0.1 www.advaliant.com
127.0.0.1 www.advanpromo.com
127.0.0.1 www.advconversion.com
127.0.0.1 www.adverterenbijrtl.nl
127.0.0.1 www.adverterenbijsbs.nl
127.0.0.1 www.adverterenzeeland.nl
127.0.0.1 www.advertpro.com
127.0.0.1 www.adverts.dcthomson.co.uk
127.0.0.1 www.advertyz.com
127.0.0.1 www.adview.cn
127.0.0.1 www.adzerk.net
127.0.0.1 www.aero-source.net
127.0.0.1 www.afcyhf.com
127.0.0.1 www.affiliate-fr.com
127.0.0.1 www.affiliateclick.com
127.0.0.1 www.affiliation-france.com
127.0.0.1 www.afform.co.uk
127.0.0.1 www.affpartners.com
127.0.0.1 www.afterdownload.com
127.0.0.1 www.agkn.com
127.0.0.1 www.agt.net
127.0.0.1 www.airfrance.life
127.0.0.1 www.ajalis.com
127.0.0.1 www.akiko.f9.co.uk
127.0.0.1 www.alexrc.plus.com
127.0.0.1 www.algocashmaster.com
127.0.0.1 www.allosponsor.com
127.0.0.1 www.amazing-opportunities.info
127.0.0.1 www.andyhawk.free-online.co.uk
127.0.0.1 www.andymurray.plus.com
127.0.0.1 www.annuaire-autosurf.com
127.0.0.1 www.anrdoezrs.net
127.0.0.1 www.api.taboola.com
127.0.0.1 www.apogara.plus.com
127.0.0.1 www.applelounge.com
127.0.0.1 www.applicationwiki.com
127.0.0.1 www.appliedsemantics.com
127.0.0.1 www.appnexus.com
127.0.0.1 www.aptracking1.com
127.0.0.1 www.area043.com
127.0.0.1 www.art-offer.com
127.0.0.1 www.atpanel.com
127.0.0.1 www.audienceexposure.com
127.0.0.1 www.aureate.com
127.0.0.1 www.autohipnose.com
127.0.0.1 www.automotive-offer.com
127.0.0.1 www.avenues-inc.com
127.0.0.1 www.avsads.com
127.0.0.1 www.awltovhc.com
127.0.0.1 www.baba-t.com
127.0.0.1 www.balnakiel.plus.com
127.0.0.1 www.bannerads.de
127.0.0.1 www.bannerbackup.com
127.0.0.1 www.bannerconnect.net
127.0.0.1 www.bannersurvey.biz
127.0.0.1 www.banstex.com
127.0.0.1 www.bbelements.com
127.0.0.1 www.benhamlyn.plus.com
127.0.0.1 www.best-iphone6s.com
127.0.0.1 www.bicoinsprofit.com
127.0.0.1 www.bidtraffic.com
127.0.0.1 www.bidvertiser.com
127.0.0.1 www.bigbangempire.com
127.0.0.1 www.bigbrandpromotions.com
127.0.0.1 www.bigbrandrewards.com
127.0.0.1 www.biggestgiftrewards.com
127.0.0.1 www.billcarthy.f9.co.uk
127.0.0.1 www.binarysystem4u.com
127.0.0.1 www.bitcoadz.io
127.0.0.1 www.bitmedia.io
127.0.0.1 www.bitraffic.com
127.0.0.1 www.biz-offer.com
127.0.0.1 www.bizographics.com
127.0.0.1 www.bjhdrx.com
127.0.0.1 www.blockadsnot.com
127.0.0.1 www.blockchaintop.nl
127.0.0.1 www.blossomtel.com
127.0.0.1 www.bluecrabhosting.co.uk
127.0.0.1 www.bluediamondoffers.com
127.0.0.1 www.bnnr.nl
127.0.0.1 www.bodog.eu
127.0.0.1 www.boonsolutions.com
127.0.0.1 www.bostonwall.com
127.0.0.1 www.bovadapromotions.lv
127.0.0.1 www.brandsurveypanel.com
127.0.0.1 www.bretby.plus.com
127.0.0.1 www.brightonclick.com
127.0.0.1 www.bryantaylor.free-online.co.uk
127.0.0.1 www.btalbot.plus.com
127.0.0.1 www.btvm.ne.jp
127.0.0.1 www.budsinc.com
127.0.0.1 www.bulkclicks.com
127.0.0.1 www.bulletads.com
127.0.0.1 www.burstnet.com
127.0.0.1 www.bus-offer.com
127.0.0.1 www.buttcandy.com
127.0.0.1 www.buycheapadvertising.com
127.0.0.1 www.buyhitscheap.com
127.0.0.1 www.buzzadnetwork.com
127.0.0.1 www.buzzonclick.com
127.0.0.1 www.c2.taboola.com
127.0.0.1 www.cadvision.com
127.0.0.1 www.cafecoquin.com
127.0.0.1 www.cam4.fr
127.0.0.1 www.camion.idps.co.uk
127.0.0.1 www.canuckmethods.com
127.0.0.1 www.capath.com
127.0.0.1 www.capturedcovers.com
127.0.0.1 www.carnegienet.net
127.0.0.1 www.cashback.co.uk
127.0.0.1 www.cashbackwow.co.uk
127.0.0.1 www.cashcapitalsystem.com
127.0.0.1 www.cashcount.com
127.0.0.1 www.casino770.com
127.0.0.1 www.cati.com.tw
127.0.0.1 www.cdn.taboola.com
127.0.0.1 www.cdn4ads.com
127.0.0.1 www.cellphoneincentives.com
127.0.0.1 www.chartbeat.com
127.0.0.1 www.chartercare.plus.com
127.0.0.1 www.chienhung.url.tw
127.0.0.1 www.chiyih.com
127.0.0.1 www.choicedealz.com
127.0.0.1 www.choicesurveypanel.com
127.0.0.1 www.christianbusinessadvertising.com
127.0.0.1 www.claimfreerewards.com
127.0.0.1 www.clevernt.com
127.0.0.1 www.click10.com
127.0.0.1 www.click4click.com
127.0.0.1 www.clickbank.com
127.0.0.1 www.clickdensity.com
127.0.0.1 www.clicksgear.com
127.0.0.1 www.clicksor.com
127.0.0.1 www.clicktale.com
127.0.0.1 www.clicktale.net
127.0.0.1 www.clickthruserver.com
127.0.0.1 www.clickthrutraffic.com
127.0.0.1 www.clicktilluwin.com
127.0.0.1 www.clickxchange.com
127.0.0.1 www.cliftons.plus.com
127.0.0.1 www.coin-ad.com
127.0.0.1 www.coinad.com
127.0.0.1 www.coinzilla.io
127.0.0.1 www.computer-offer.com
127.0.0.1 www.computersncs.com
127.0.0.1 www.contaxe.com
127.0.0.1 www.contextuads.com
127.0.0.1 www.contextweb.com
127.0.0.1 www.conversantmedia.com
127.0.0.1 www.cookingtiprewards.com
127.0.0.1 www.coolconcepts.nl
127.0.0.1 www.coreglead.co.uk
127.0.0.1 www.cosmeticscentre.uk.com
127.0.0.1 www.cotc.net
127.0.0.1 www.courtneywalker.plus.com
127.0.0.1 www.cpabank.com
127.0.0.1 www.cpmadvisors.com
127.0.0.1 www.crazypopups.com
127.0.0.1 www.crazywinnings.com
127.0.0.1 www.crispads.com
127.0.0.1 www.crowdgravity.com
127.0.0.1 www.crowdignite.com
127.0.0.1 www.cryptocoinsad.com
127.0.0.1 www.crystaltao.art
127.0.0.1 www.csalikft.hu
127.0.0.1 www.ctaz.com
127.0.0.1 www.ctbdev.net
127.0.0.1 www.cuci.nl
127.0.0.1 www.cyberfaery.com
127.0.0.1 www.da-ads.com
127.0.0.1 www.dalesnewzealand.co.nz
127.0.0.1 www.danair.es
127.0.0.1 www.datatech.es
127.0.0.1 www.datingadvertising.com
127.0.0.1 www.datoben.waw.pl
127.0.0.1 www.davion.plus.com
127.0.0.1 www.debbo.plus.com
127.0.0.1 www.deelen-wageningen.nl
127.0.0.1 www.defaultinternet.com
127.0.0.1 www.delton.com
127.0.0.1 www.derekrjones.plus.com
127.0.0.1 www.designbloxlive.com
127.0.0.1 www.destinationurl.com
127.0.0.1 www.devenney.plus.com
127.0.0.1 www.devis-abri-de-piscine.fr
127.0.0.1 www.devon38.plus.com
127.0.0.1 www.dgmaustralia.com
127.0.0.1 www.diaita.ch
127.0.0.1 www.digimedia.com
127.0.0.1 www.directnetadvertising.net
127.0.0.1 www.dirtyrhino.com
127.0.0.1 www.djugoogs.com
127.0.0.1 www.dragonawaken.com
127.0.0.1 www.drowle.com
127.0.0.1 www.dt1blog.com
127.0.0.1 www.dunlop.force9.co.uk
127.0.0.1 www.dutchsales.org
127.0.0.1 www.e-bannerx.com
127.0.0.1 www.eastwood35.idps.co.uk
127.0.0.1 www.easy2date.net
127.0.0.1 www.easyadservice.com
127.0.0.1 www.ebayadservices.com
127.0.0.1 www.ebayadvertising.com
127.0.0.1 www.ebaybanner.com
127.0.0.1 www.ecoledessciences.com
127.0.0.1 www.edv-waldherr.at
127.0.0.1 www.emadesign.net
127.0.0.1 www.emarketmakers.com
127.0.0.1 www.entertainment-specials.com
127.0.0.1 www.eshopads2.com
127.0.0.1 www.euros4click.de
127.0.0.1 www.eva.hi-ho.ne.jp
127.0.0.1 www.everestgroupcorp.com
127.0.0.1 www.everifymatch.com
127.0.0.1 www.exclusivegiftcards.com
127.0.0.1 www.expoteam.net
127.0.0.1 www.eyewonder.com
127.0.0.1 www.ezl.com
127.0.0.1 www.ezlink.ca
127.0.0.1 www.fast-adv.it
127.0.0.1 www.fatcatrewards.com
127.0.0.1 www.feedstermedia.com
127.0.0.1 www.finance-offer.com
127.0.0.1 www.fineclicks.com
127.0.0.1 www.firemouth.plus.com
127.0.0.1 www.firered.plus.com
127.0.0.1 www.flagcounter.com
127.0.0.1 www.flexibletool.com
127.0.0.1 www.flowerdevon.idps.co.uk
127.0.0.1 www.flu23.com
127.0.0.1 www.focalex.com
127.0.0.1 www.folloyu.com
127.0.0.1 www.food-offer.com
127.0.0.1 www.ford7.plus.com
127.0.0.1 www.formosahappiness.org
127.0.0.1 www.fpctraffic2.com
127.0.0.1 www.fra19.plus.com
127.0.0.1 www.framar.plus.com
127.0.0.1 www.freeadguru.com
127.0.0.1 www.freebiegb.co.uk
127.0.0.1 www.freecamerasource.com
127.0.0.1 www.freecamsecrets.com
127.0.0.1 www.freecamsexposed.com
127.0.0.1 www.freedvddept.com
127.0.0.1 www.freefoodsource.com
127.0.0.1 www.freefuelcard.com
127.0.0.1 www.freefuelcoupon.com
127.0.0.1 www.freeipoduk.co.uk
127.0.0.1 www.freelaptopreward.com
127.0.0.1 www.freenation.com
127.0.0.1 www.freeplasmanation.com
127.0.0.1 www.freespinwinner.win
127.0.0.1 www.freo-stats.nl
127.0.0.1 www.friendlyduck.com
127.0.0.1 www.frontpagecash.com
127.0.0.1 www.ftjcfx.com
127.0.0.1 www.funkydoowop.plus.com
127.0.0.1 www.fusionbanners.com
127.0.0.1 www.garethwalker.plus.com
127.0.0.1 www.gatesofhell.plus.com
127.0.0.1 www.gatoradvertisinginformationnetwork.com
127.0.0.1 www.gbinnie.plus.com
127.0.0.1 www.georgewatson.plus.com
127.0.0.1 www.get-express-vpn.com
127.0.0.1 www.getagiftonline.com
127.0.0.1 www.getlink.pw
127.0.0.1 www.getloan.com
127.0.0.1 www.getmyads24.com
127.0.0.1 www.getmyfreegiftcard.com
127.0.0.1 www.getspecialgifts.com
127.0.0.1 www.giftcardchallenge.com
127.0.0.1 www.giftcardsurveys.us.com
127.0.0.1 www.gigdnetwork.com
127.0.0.1 www.gm4pgv.plus.com
127.0.0.1 www.gmads.net
127.0.0.1 www.googleadservices.com
127.0.0.1 www.grabbit-rabbit.com
127.0.0.1 www.greasypalm.com
127.0.0.1 www.greatdexchange.com
127.0.0.1 www.greencentral.plus.com
127.0.0.1 www.groupm.com
127.0.0.1 www.grtexch.com
127.0.0.1 www.guesstheview.com
127.0.0.1 www.hansvanderwerf.nl
127.0.0.1 www.healthbeautyncs.com
127.0.0.1 www.hebdotop.com
127.0.0.1 www.heusmarketing.nl
127.0.0.1 www.hibids10.com
127.0.0.1 www.hieroglyph.freeuk.com
127.0.0.1 www.highleycoupons.com
127.0.0.1 www.hightrafficads.com
127.0.0.1 www.hiroden-con.jp
127.0.0.1 www.histats.com
127.0.0.1 www.hooqy.com
127.0.0.1 www.hotchatdate.com
127.0.0.1 www.hotgiftzone.com
127.0.0.1 www.hotkeys.com
127.0.0.1 www.i-younet.ne.jp
127.0.0.1 www.idealcasino.net
127.0.0.1 www.idirect.com
127.0.0.1 www.ifileyou.com
127.0.0.1 www.iicdn.com
127.0.0.1 www.ili.net
127.0.0.1 www.ilovecheating.com
127.0.0.1 www.ilovemobi.com
127.0.0.1 www.images.taboola.com
127.0.0.1 www.imcounting.com
127.0.0.1 www.incentivegateway.com
127.0.0.1 www.indiads.com
127.0.0.1 www.infinite-ads.com
127.0.0.1 www.inflationbreedinghoax.com
127.0.0.1 www.intela.com
127.0.0.1 www.interstitialzone.com
127.0.0.1 www.invitefashion.com
127.0.0.1 www.inyes.com.tw
127.0.0.1 www.iqoption.com
127.0.0.1 www.is1.clixgalore.com
127.0.0.1 www.isfilebest.com
127.0.0.1 www.isistech.com.tw
127.0.0.1 www.istats.nl
127.0.0.1 www.itrackerpro.com
127.0.0.1 www.itsfree123.com
127.0.0.1 www.izmsj.co.jp
127.0.0.1 www.izu.co.jp
127.0.0.1 www.jetseeker.com
127.0.0.1 www.jivox.com
127.0.0.1 www.jolic2.com
127.0.0.1 www.jrhayley.plus.com
127.0.0.1 www.jxliu.com
127.0.0.1 www.k-macs.ne.jp
127.0.0.1 www.katch.ne.jp
127.0.0.1 www.kenkudo.plus.com
127.0.0.1 www.keywordblocks.com
127.0.0.1 www.kitaramarketplace.com
127.0.0.1 www.kitaramedia.com
127.0.0.1 www.kixer.com
127.0.0.1 www.kliksaya.com
127.0.0.1 www.knell.plus.com
127.0.0.1 www.kolks.nl
127.0.0.1 www.konimkan.com
127.0.0.1 www.kontera.com
127.0.0.1 www.konversation.com
127.0.0.1 www.kreaffiliation.com
127.0.0.1 www.kuhdi.com
127.0.0.1 www.ladyclicks.ru
127.0.0.1 www.laptopreportcard.com
127.0.0.1 www.laptoprewards.com
127.0.0.1 www.laptoprewardsgroup.com
127.0.0.1 www.laptoprewardszone.com
127.0.0.1 www.larivieracasino.com
127.0.0.1 www.lduhtrp.net
127.0.0.1 www.le1er.net
127.0.0.1 www.leadgreed.com
127.0.0.1 www.leklicht.net
127.0.0.1 www.lincolnshirefitness.co.uk
127.0.0.1 www.linkhut.com
127.0.0.1 www.linkpulse.com
127.0.0.1 www.linkredirect.biz
127.0.0.1 www.linkwithin.com
127.0.0.1 www.liveadexchanger.com
127.0.0.1 www.loboclick.com
127.0.0.1 www.lottoforever.com
127.0.0.1 www.lpcloudsvr302.com
127.0.0.1 www.lpmxp2017.com
127.0.0.1 www.lpmxp2024.com
127.0.0.1 www.lucky-day-uk.com
127.0.0.1 www.lysabarnard.plus.com
127.0.0.1 www.m2trk.com
127.0.0.1 www.ma-kaeser.ch
127.0.0.1 www.maaxmarket.com
127.0.0.1 www.macatawa.org
127.0.0.1 www.market-buster.com
127.0.0.1 www.marketrip.co
127.0.0.1 www.maxbounty.com
127.0.0.1 www.maxonclick.com
127.0.0.1 www.mb01.com
127.0.0.1 www.mb102.com
127.0.0.1 www.medhiartis.com
127.0.0.1 www.media-motor.com
127.0.0.1 www.media2.travelzoo.com
127.0.0.1 www.medical-offer.com
127.0.0.1 www.megawealthbiz.com
127.0.0.1 www.mellowads.com
127.0.0.1 www.merijntjeaanderijn.nl
127.0.0.1 www.merlin.co.il
127.0.0.1 www.mgid.com
127.0.0.1 www.mightymagoo.com
127.0.0.1 www.mikaeljigmo.com
127.0.0.1 www.miqsoft.hu
127.0.0.1 www.miyazaki-catv.ne.jp
127.0.0.1 www.mjonkers.nl
127.0.0.1 www.mlntracker.com
127.0.0.1 www.mochibot.com
127.0.0.1 www.monetizemore.com
127.0.0.1 www.morefreecamsecrets.com
127.0.0.1 www.morevisits.info
127.0.0.1 www.mpression.net
127.0.0.1 www.mr-mondial.com
127.0.0.1 www.mrazens.com
127.0.0.1 www.ms247.plus.com
127.0.0.1 www.my-rewardsvault.com
127.0.0.1 www.my-stats.com
127.0.0.1 www.myadsl.co.za
127.0.0.1 www.myaffiliateprogram.com
127.0.0.1 www.mycashback.co.uk
127.0.0.1 www.mychoicerewards.com
127.0.0.1 www.myexclusiverewards.com
127.0.0.1 www.myfreedinner.com
127.0.0.1 www.myfreegifts.co.uk
127.0.0.1 www.myfreemp3player.com
127.0.0.1 www.mygreatrewards.com
127.0.0.1 www.myseostats.com
127.0.0.1 www.myuitm.com
127.0.0.1 www.myusersonline.com
127.0.0.1 www.na47.com
127.0.0.1 www.nas-k.co.jp
127.0.0.1 www.nationalissuepanel.com
127.0.0.1 www.nationalsurveypanel.com
127.0.0.1 www.nctracking.com
127.0.0.1 www.ndbsoft.be
127.0.0.1 www.nearbyad.com
127.0.0.1 www.nebulus30.plus.com
127.0.0.1 www.needadvertising.com
127.0.0.1 www.neptuneads.com
127.0.0.1 www.neszmely.eu
127.0.0.1 www.newmedia.plus.com
127.0.0.1 www.newnorth.net
127.0.0.1 www.news6health.com
127.0.0.1 www.newtrees.plus.com
127.0.0.1 www.nextlnk7.com
127.0.0.1 www.nospartenaires.com
127.0.0.1 www.novelsys.co
127.0.0.1 www.nozawashoten.com
127.0.0.1 www.nutaku.com
127.0.0.1 www.odyssey.on.ca
127.0.0.1 www.offerx.co.uk
127.0.0.1 www.olioeroli.it
127.0.0.1 www.onclickpredictiv.com
127.0.0.1 www.onclicktop.com
127.0.0.1 www.ontheweb.com
127.0.0.1 www.opendownload.de
127.0.0.1 www.openload.de
127.0.0.1 www.optad360.com
127.0.0.1 www.outbrain.com
127.0.0.1 www.ozonatory24.pl
127.0.0.1 www.paperg.com
127.0.0.1 www.parsads.com
127.0.0.1 www.partycasino.com
127.0.0.1 www.pathforpoints.com
127.0.0.1 www.paypopup.com
127.0.0.1 www.peachy18.com
127.0.0.1 www.pedigree1.plus.com
127.0.0.1 www.perfectgirls.net
127.0.0.1 www.performanceonclick.com
127.0.0.1 www.persgroepadvertising.nl
127.0.0.1 www.perso.ch
127.0.0.1 www.peteralexander.plus.com
127.0.0.1 www.peterfishwick.free-online.co.uk
127.0.0.1 www.pfhsystem.com
127.0.0.1 www.phoenixads.co.in
127.0.0.1 www.phorm.com
127.0.0.1 www.pitakchon.com
127.0.0.1 www.placelocal.com
127.0.0.1 www.planet.eon.net
127.0.0.1 www.plasmatv4free.com
127.0.0.1 www.politicalopinionsurvey.com
127.0.0.1 www.pomp-buerotechnik.de
127.0.0.1 www.poponclick.com
127.0.0.1 www.popup.taboola.com
127.0.0.1 www.popupad.net
127.0.0.1 www.popupdomination.com
127.0.0.1 www.popuptraffic.com
127.0.0.1 www.postmasterbannernet.com
127.0.0.1 www.postmasterdirect.com
127.0.0.1 www.postnewsads.com
127.0.0.1 www.praktijkmariekehuisman.nl
127.0.0.1 www.predictivadnetwork.com
127.0.0.1 www.premiumproductsonline.com
127.0.0.1 www.prizes.co.uk
127.0.0.1 www.pro-partners.nl
127.0.0.1 www.probabilidades.net
127.0.0.1 www.probusinesshub.com
127.0.0.1 www.productresearchpanel.com
127.0.0.1 www.producttestpanel.com
127.0.0.1 www.projectwonderful.com
127.0.0.1 www.prtc.net
127.0.0.1 www.psclicks.com
127.0.0.1 www.pubdirecte.com
127.0.0.1 www.pureadexchange.com
127.0.0.1 www.qcoldtui1999.com
127.0.0.1 www.quickbrowsersearch.com
127.0.0.1 www.radiate.com
127.0.0.1 www.rankyou.com
127.0.0.1 www.redactiepartners.nl
127.0.0.1 www.regflow.com
127.0.0.1 www.registrarads.com
127.0.0.1 www.reklam3.net
127.0.0.1 www.resolvingserver.com
127.0.0.1 www.reusenproject-n.nl
127.0.0.1 www.rewardsflow.com
127.0.0.1 www.ringtonepartner.com
127.0.0.1 www.riskybus.f9.co.uk
127.0.0.1 www.ritikhush.com
127.0.0.1 www.robm674.plus.com
127.0.0.1 www.romepartners.com
127.0.0.1 www.roulettebotplus.com
127.0.0.1 www.rpepin.plus.com
127.0.0.1 www.rtcode.com
127.0.0.1 www.rubyfortune.com
127.0.0.1 www.ryosuke.plus.com
127.0.0.1 www.sa44.net
127.0.0.1 www.sagent.io
127.0.0.1 www.sarge05.plus.com
127.0.0.1 www.savings-time.com
127.0.0.1 www.sayfabulunamadi.com
127.0.0.1 www.schemml.de
127.0.0.1 www.scottofyork.plus.com
127.0.0.1 www.screen-mates.com
127.0.0.1 www.searchingzone.com
127.0.0.1 www.searchwe.com
127.0.0.1 www.securerunner.com
127.0.0.1 www.servedby-buysellads.com
127.0.0.1 www.servitemequipos.cl
127.0.0.1 www.seward.net
127.0.0.1 www.sexadvertentiesite.nl
127.0.0.1 www.sexpartnerx.com
127.0.0.1 www.sexsponsors.com
127.0.0.1 www.sgtwilko.f9.co.uk
127.0.0.1 www.share-server.com
127.0.0.1 www.shareasale.com
127.0.0.1 www.shaunfennings.plus.com
127.0.0.1 www.shichihukuudon.com
127.0.0.1 www.shopperpromotions.com
127.0.0.1 www.shopping-offer.com
127.0.0.1 www.shoppingjobshere.com
127.0.0.1 www.shoppingminds.net
127.0.0.1 www.shorthouse.com
127.0.0.1 www.silcom.com
127.0.0.1 www.simpli.fi
127.0.0.1 www.skegness.net
127.0.0.1 www.skvarsani.plus.com
127.0.0.1 www.sky-net.or.jp
127.0.0.1 www.skywin.com.tw
127.0.0.1 www.smailes.plus.com
127.0.0.1 www.smart-scripts.com
127.0.0.1 www.smartadserver.com
127.0.0.1 www.smarttopchain.nl
127.0.0.1 www.smichovbike.cz
127.0.0.1 www.smokersopinionpoll.com
127.0.0.1 www.smspop.com
127.0.0.1 www.sochr.com
127.0.0.1 www.sociallypublish.com
127.0.0.1 www.speedboink.com
127.0.0.1 www.speedyclick.com
127.0.0.1 www.spinbox.com
127.0.0.1 www.spinia.com
127.0.0.1 www.sponsorads.de
127.0.0.1 www.sponsoradulto.com
127.0.0.1 www.sq2trk2.com
127.0.0.1 www.ssquire.plus.com
127.0.0.1 www.star-advertising.com
127.0.0.1 www.startnewtab.com
127.0.0.1 www.studiomugnaini.eu
127.0.0.1 www.subsitesadserver.co.uk
127.0.0.1 www.sudokuwhiz.com
127.0.0.1 www.sun-inet.or.jp
127.0.0.1 www.superbrewards.com
127.0.0.1 www.superinterstitial.com
127.0.0.1 www.surplus-suppliers.com
127.0.0.1 www.sweetsforfree.com
127.0.0.1 www.syncaccess.net
127.0.0.1 www.system-live-media.cz
127.0.0.1 www.taboola.com
127.0.0.1 www.tao123.com
127.0.0.1 www.tbitcoin.me
127.0.0.1 www.teltech.hu
127.0.0.1 www.telusplanet.net
127.0.0.1 www.terraclicks.com
127.0.0.1 www.text-link-ads.com
127.0.0.1 www.textbanners.net
127.0.0.1 www.textsrv.com
127.0.0.1 www.tgpmanager.com
127.0.0.1 www.thatrendsystem.com
127.0.0.1 www.thepringlefamily.plus.com
127.0.0.1 www.thetraderinpajamas.com
127.0.0.1 www.theuseful.com
127.0.0.1 www.theuseful.net
127.0.0.1 www.thewaycloud.com
127.0.0.1 www.thinktarget.com
127.0.0.1 www.thruport.com
127.0.0.1 www.tlauder.f9.co.uk
127.0.0.1 www.top-free-casino-games.com
127.0.0.1 www.top20free.com
127.0.0.1 www.topcashvibes.com
127.0.0.1 www.topconsumergifts.com
127.0.0.1 www.topdemaroc.com
127.0.0.1 www.topreward.site
127.0.0.1 www.topsecretmagic.co.uk
127.0.0.1 www.topworld.nl
127.0.0.1 www.tqlkg.com
127.0.0.1 www.track2cash.com
127.0.0.1 www.tracklead.net
127.0.0.1 www.tradeadexchange.com
127.0.0.1 www.tradelax.com
127.0.0.1 www.tradem.com
127.0.0.1 www.trafficnetworkads24.com
127.0.0.1 www.trafficrevenue.net
127.0.0.1 www.traffictrader.net
127.0.0.1 www.traffictraders.com
127.0.0.1 www.trafsearchonline.com
127.0.0.1 www.traktrafficflow.com
127.0.0.1 www.tranzit124.cz
127.0.0.1 www.traveladvertising.com
127.0.0.1 www.trc.taboola.com
127.0.0.1 www.treeloot.com
127.0.0.1 www.trendnews.com
127.0.0.1 www.trendsonline.biz
127.0.0.1 www.trourted.pro
127.0.0.1 www.truentertainment.net
127.0.0.1 www.ts-shimada.com
127.0.0.1 www.ttnet.yandex.com.tr
127.0.0.1 www.ttoc8ok.com
127.0.0.1 www.turn.com
127.0.0.1 www.tutka.net
127.0.0.1 www.tutop.com
127.0.0.1 www.twofish.freeuk.com
127.0.0.1 www.u1trkqf.com
127.0.0.1 www.ukbanners.com
127.0.0.1 www.uproar.com
127.0.0.1 www.urdoot.win
127.0.0.1 www.usemax.de
127.0.0.1 www.user-shield.com
127.0.0.1 www.users.dialstart.net
127.0.0.1 www.users.freenetname.co.uk
127.0.0.1 www.utarget.co.uk
127.0.0.1 www.valueclick.com
127.0.0.1 www.vandenberghider.plus.com
127.0.0.1 www.vanguard-art.com
127.0.0.1 www.veritaspartners.co.jp
127.0.0.1 www.vibrantmedia.com
127.0.0.1 www.victorlutte.cl
127.0.0.1 www.victory1999.com
127.0.0.1 www.videoconverterhd.com
127.0.0.1 www.videogamerewardscentral.com
127.0.0.1 www.videomediagroep.nl
127.0.0.1 www.view4cash.de
127.0.0.1 www.vilaglato.info
127.0.0.1 www.virtumundo.com
127.0.0.1 www.visualwebsiteoptimizer.com
127.0.0.1 www.vmcsatellite.com
127.0.0.1 www.wctc.net
127.0.0.1 www.wdm29.com
127.0.0.1 www.webcompteur.com
127.0.0.1 www.websitepromoten.be
127.0.0.1 www.websponsors.com
127.0.0.1 www.webtj.net
127.0.0.1 www.webtrekk.net
127.0.0.1 www.wegetpaid.net
127.0.0.1 www.wessexgrange.plus.com
127.0.0.1 www.westreclameadvies.nl
127.0.0.1 www.whalecashads.com
127.0.0.1 www.widespace.com
127.0.0.1 www.widgetbucks.com
127.0.0.1 www.wigetmedia.com
127.0.0.1 www.williamhill.es
127.0.0.1 www.windaily.com
127.0.0.1 www.wondertravelegypt.com
127.0.0.1 www.work-offer.com
127.0.0.1 www.worry-free-savings.com
127.0.0.1 www.wppluginspro.com
127.0.0.1 www.wu4652.com.tw
127.0.0.1 www.wwt-ag.ch
127.0.0.1 www.xadsmart.com
127.0.0.1 www.xaxis.com
127.0.0.1 www.xbn.ru
127.0.0.1 www.xn--turkishirlines-1p8g.com
127.0.0.1 www.yceml.net
127.0.0.1 www.yieldmanager.net
127.0.0.1 www.yieldpartners.com
127.0.0.1 www.youfck.com
127.0.0.1 www.your-gift-zone.com
127.0.0.1 www.yourgascards.com
127.0.0.1 www.yourgiftrewards.com
127.0.0.1 www.yourgiftzone.com
127.0.0.1 www.youripad4free.com
127.0.0.1 www.yourrewardzone.com
127.0.0.1 www.yoursmartrewards.com
127.0.0.1 www.yuzuni.com
127.0.0.1 www.ywmc.com.tw
127.0.0.1 www.zabavazaodrasle.com
127.0.0.1 www.zbippirad.info
127.0.0.1 www.zemgo.com
127.0.0.1 www.zevents.com
127.0.0.1 www.zytpirwai.net
127.0.0.1 www1.amigo2.ne.jp
127.0.0.1 www1.bannerspace.com
127.0.0.1 www1.belboon.de
127.0.0.1 www1.mpnrs.com
127.0.0.1 www1.xmediaserve.com
127.0.0.1 www1.zapadserver1.com
127.0.0.1 www10.glam.com
127.0.0.1 www10.indiads.com
127.0.0.1 www10.paypopup.com
127.0.0.1 www12.glam.com
127.0.0.1 www123.glam.com
127.0.0.1 www13.glam.com
127.0.0.1 www14.smartadserver.com
127.0.0.1 www17.glam.com
127.0.0.1 www18.glam.com
127.0.0.1 www2.ad-server.online
127.0.0.1 www2.adserverpub.com
127.0.0.1 www2.bannerspace.com
127.0.0.1 www2.glam.com
127.0.0.1 www2.gorillavid.in
127.0.0.1 www2.pubdirecte.com
127.0.0.1 www2.tpgi.com.au
127.0.0.1 www2.wyylde.com
127.0.0.1 www2.zapadserver1.com
127.0.0.1 www210.paypopup.com
127.0.0.1 www211.paypopup.com
127.0.0.1 www212.paypopup.com
127.0.0.1 www213.paypopup.com
127.0.0.1 www24.glam.com
127.0.0.1 www24a.glam.com
127.0.0.1 www25.glam.com
127.0.0.1 www25a.glam.com
127.0.0.1 www3.addthis.com
127.0.0.1 www3.bannerspace.com
127.0.0.1 www3.game-advertising-online.com
127.0.0.1 www3.haberturk.com
127.0.0.1 www3.smartadserver.com
127.0.0.1 www3.telus.net
127.0.0.1 www3.webhostingtalk.com
127.0.0.1 www30.glam.com
127.0.0.1 www30a1-orig.glam.com
127.0.0.1 www30a1.glam.com
127.0.0.1 www30a2-orig.glam.com
127.0.0.1 www30a3-orig.glam.com
127.0.0.1 www30a3.glam.com
127.0.0.1 www30a7.glam.com
127.0.0.1 www30l2.glam.com
127.0.0.1 www30t1-orig.glam.com
127.0.0.1 www35f.glam.com
127.0.0.1 www35jm.glam.com
127.0.0.1 www35t.glam.com
127.0.0.1 www4.bannerspace.com
127.0.0.1 www4.glam.com
127.0.0.1 www4.smartadserver.com
127.0.0.1 www4176uc.sakura.ne.jp
127.0.0.1 www5.bannerspace.com
127.0.0.1 www5.zoosi.club
127.0.0.1 www6.bannerspace.com
127.0.0.1 www7.bannerspace.com
127.0.0.1 www8.bannerspace.com
127.0.0.1 www9.paypopup.com
127.0.0.1 www9.smartadserver.com
127.0.0.1 wwwroot.forent.sk
127.0.0.1 wytypowany-zwyciezca.com
127.0.0.1 wytypowany-zwyciezca.pl
127.0.0.1 x-album.com
127.0.0.1 x-album.net
127.0.0.1 x-albums.net
127.0.0.1 x-image.net
127.0.0.1 x-images.com
127.0.0.1 x-images.net
127.0.0.1 x-photobucket.top
127.0.0.1 x-photos.net
127.0.0.1 x-picture.net
127.0.0.1 x-pictures.net
127.0.0.1 x.azjmp.com
127.0.0.1 x.bidswitch.net
127.0.0.1 x.iasrv.com
127.0.0.1 x.interia.pl
127.0.0.1 x.mochiads.com
127.0.0.1 x2.trk1.co
127.0.0.1 xads.zedo.com
127.0.0.1 xaxis.com
127.0.0.1 xbox-ms-store-debug.com
127.0.0.1 xch.smrtgs.com
127.0.0.1 xl-trk.com
127.0.0.1 xml.ad-maven.com
127.0.0.1 xml.adfclick1.com
127.0.0.1 xml.adservme.com
127.0.0.1 xml.adtech.fr
127.0.0.1 xml.adtech.us
127.0.0.1 xml.click9.com
127.0.0.1 xml.explorads.com
127.0.0.1 xml.mediashakers.com
127.0.0.1 xml.realtime-bid.com
127.0.0.1 xml.yepmedia.com
127.0.0.1 xmlheads.com
127.0.0.1 xpantivirus.com
127.0.0.1 xphones-2019.info
127.0.0.1 xphotos-album.com
127.0.0.1 xphotos.net
127.0.0.1 xpictures.net
127.0.0.1 xstatic.nk-net.pl
127.0.0.1 xuochfumvoaalgthpcwkvcro.audienceexposure.com
127.0.0.1 y.cdn.adblade.com
127.0.0.1 yadro.ru
127.0.0.1 yahoo-match.dotomi.com
127.0.0.1 yas-jr.com
127.0.0.1 yepdigital.adk2x.com
127.0.0.1 yhti.net
127.0.0.1 yieldmanager.net
127.0.0.1 yieldmo-match.dotomi.com
127.0.0.1 yllix.com
127.0.0.1 ym.adnxs.com
127.0.0.1 yodleeinc.tt.omtrdc.net
127.0.0.1 yoredi.com
127.0.0.1 yotube.com
127.0.0.1 youfck.com
127.0.0.1 your-gift-zone.com
127.0.0.1 your.dailytopdealz.com
127.0.0.1 youradexchange.com
127.0.0.1 yourgascards.com
127.0.0.1 yourgiftrewards.com
127.0.0.1 yourgiftzone.com
127.0.0.1 youripad4free.com
127.0.0.1 yourrewardzone.com
127.0.0.1 yoursmartrewards.com
127.0.0.1 ysiu.freenation.com
127.0.0.1 yt-adblocker.com
127.0.0.1 yumenetworks.com
127.0.0.1 yx-in-f108.1e100.net
127.0.0.1 z-na.amazon-adsystem.com
127.0.0.1 z.blogads.com
127.0.0.1 z.dynad.net
127.0.0.1 z.moatads.com
127.0.0.1 z1.adserver.com
127.0.0.1 zabavazaodrasle.com
127.0.0.1 zads.zedo.com
127.0.0.1 zapadserver1.com
127.0.0.1 zapcdn.space
127.0.0.1 zazerygu.pro
127.0.0.1 zc1.zeroredirect11.com
127.0.0.1 zdads.e-media.com
127.0.0.1 zem.outbrainimg.com
127.0.0.1 zemgo.com
127.0.0.1 zeroredirect.com
127.0.0.1 zeroredirect1.com
127.0.0.1 zeroredirect11.com
127.0.0.1 zeroredirect12.com
127.0.0.1 zeroredirect2.com
127.0.0.1 zeroredirect5.com
127.0.0.1 zeroredirect8.com
127.0.0.1 zevents.com
127.0.0.1 zlhoteckelinie.wz.cz
127.0.0.1 zoeandjo.co.uk
127.0.0.1 zu1.november-lax.com
127.0.0.1 zulu.r867qq.net
127.0.0.1 zytpirwai.net
#</ad-sites>

# https://securehomes.esat.kuleuven.be/~gacar/persistent/index.html
#<canvass-fingerprinting-sites>
127.0.0.1 admicro1.vcmedia.vn
127.0.0.1 ct1.addthis.com
127.0.0.1 cya2.net
127.0.0.1 i.ligatus.com
127.0.0.1 images.revtrax.com
127.0.0.1 shorte.st
127.0.0.1 src.kitcode.net
#</canvass-fingerprinting-sites>

#<evercookies-sites>
127.0.0.1 ar.hao123.com
127.0.0.1 irs01.net
127.0.0.1 kiks.yandex.ru
127.0.0.1 y3.ifengimg.com
#</evercookies-sites>

#<yahoo-ad-sites>

# yahoo banner ads
# If you have trouble with Yahoo email, you may need to comment out these lines
#127.0.0.1 us.i1.yimg.com	#Uncomment this to block yahoo images
127.0.0.1 in.yimg.com
127.0.0.1 us.a1.yimg.com
#</yahoo-ad-sites>

#<hitbox-sites>

# hitbox.com web bugs
127.0.0.1 adminec1.hitbox.com
127.0.0.1 ads.hitbox.com
127.0.0.1 ai.hitbox.com
127.0.0.1 counter.hitbox.com
127.0.0.1 counter2.hitbox.com
127.0.0.1 dev101.hitbox.com
127.0.0.1 download.hitbox.com
127.0.0.1 ec1.hitbox.com
127.0.0.1 ehg-247internet.hitbox.com
127.0.0.1 ehg-accuweather.hitbox.com
127.0.0.1 ehg-acdsystems.hitbox.com
127.0.0.1 ehg-adeptscience.hitbox.com
127.0.0.1 ehg-affinitynet.hitbox.com
127.0.0.1 ehg-aha.hitbox.com
127.0.0.1 ehg-amerix.hitbox.com
127.0.0.1 ehg-apcc.hitbox.com
127.0.0.1 ehg-ati.hitbox.com
127.0.0.1 ehg-attenza.hitbox.com
127.0.0.1 ehg-autodesk.hitbox.com
127.0.0.1 ehg-baa.hitbox.com
127.0.0.1 ehg-backweb.hitbox.com
127.0.0.1 ehg-bestbuy.hitbox.com
127.0.0.1 ehg-bizjournals.hitbox.com
127.0.0.1 ehg-boschsiemens.hitbox.com
127.0.0.1 ehg-bskyb.hitbox.com
127.0.0.1 ehg-cafepress.hitbox.com
127.0.0.1 ehg-careerbuilder.hitbox.com
127.0.0.1 ehg-cbc.hitbox.com
127.0.0.1 ehg-cbs.hitbox.com
127.0.0.1 ehg-cbsradio.hitbox.com
127.0.0.1 ehg-cedarpoint.hitbox.com
127.0.0.1 ehg-clearchannel.hitbox.com
127.0.0.1 ehg-closetmaid.hitbox.com
127.0.0.1 ehg-commjun.hitbox.com
127.0.0.1 ehg-communityconnect.hitbox.com
127.0.0.1 ehg-comscore.hitbox.com
127.0.0.1 ehg-corusentertainment.hitbox.com
127.0.0.1 ehg-coverityinc.hitbox.com
127.0.0.1 ehg-crain.hitbox.com
127.0.0.1 ehg-ctv.hitbox.com
127.0.0.1 ehg-cygnusbm.hitbox.com
127.0.0.1 ehg-datamonitor.hitbox.com
127.0.0.1 ehg-dig.hitbox.com
127.0.0.1 ehg-digg.hitbox.com
127.0.0.1 ehg-eckounlimited.hitbox.com
127.0.0.1 ehg-esa.hitbox.com
127.0.0.1 ehg-espn.hitbox.com
127.0.0.1 ehg-fifa.hitbox.com
127.0.0.1 ehg-findlaw.hitbox.com
127.0.0.1 ehg-foundation.hitbox.com
127.0.0.1 ehg-foxsports.hitbox.com
127.0.0.1 ehg-futurepub.hitbox.com
127.0.0.1 ehg-gamedaily.hitbox.com
127.0.0.1 ehg-gamespot.hitbox.com
127.0.0.1 ehg-gatehousemedia.hitbox.com
127.0.0.1 ehg-glam.hitbox.com
127.0.0.1 ehg-groceryworks.hitbox.com
127.0.0.1 ehg-groupernetworks.hitbox.com
127.0.0.1 ehg-guardian.hitbox.com
127.0.0.1 ehg-hasbro.hitbox.com
127.0.0.1 ehg-hellodirect.hitbox.com
127.0.0.1 ehg-himedia.hitbox.com
127.0.0.1 ehg-hitent.hitbox.com
127.0.0.1 ehg-hollywood.hitbox.com
127.0.0.1 ehg-idg.hitbox.com
127.0.0.1 ehg-idgentertainment.hitbox.com
127.0.0.1 ehg-ifilm.hitbox.com
127.0.0.1 ehg-ignitemedia.hitbox.com
127.0.0.1 ehg-intel.hitbox.com
127.0.0.1 ehg-ittoolbox.hitbox.com
127.0.0.1 ehg-itworldcanada.hitbox.com
127.0.0.1 ehg-kingstontechnology.hitbox.com
127.0.0.1 ehg-knightridder.hitbox.com
127.0.0.1 ehg-learningco.hitbox.com
127.0.0.1 ehg-legonewyorkinc.hitbox.com
127.0.0.1 ehg-liveperson.hitbox.com
127.0.0.1 ehg-macpublishingllc.hitbox.com
127.0.0.1 ehg-macromedia.hitbox.com
127.0.0.1 ehg-magicalia.hitbox.com
127.0.0.1 ehg-maplesoft.hitbox.com
127.0.0.1 ehg-mgnlimited.hitbox.com
127.0.0.1 ehg-mindshare.hitbox.com
127.0.0.1 ehg-mtv.hitbox.com
127.0.0.1 ehg-mybc.hitbox.com
127.0.0.1 ehg-newegg.hitbox.com
127.0.0.1 ehg-newscientist.hitbox.com
127.0.0.1 ehg-nokiafin.hitbox.com
127.0.0.1 ehg-novell.hitbox.com
127.0.0.1 ehg-nvidia.hitbox.com
127.0.0.1 ehg-oreilly.hitbox.com
127.0.0.1 ehg-pacifictheatres.hitbox.com
127.0.0.1 ehg-pennwell.hitbox.com
127.0.0.1 ehg-peoplesoft.hitbox.com
127.0.0.1 ehg-philipsvheusen.hitbox.com
127.0.0.1 ehg-pizzahut.hitbox.com
127.0.0.1 ehg-playboy.hitbox.com
127.0.0.1 ehg-qualcomm.hitbox.com
127.0.0.1 ehg-quantumcorp.hitbox.com
127.0.0.1 ehg-randomhouse.hitbox.com
127.0.0.1 ehg-redherring.hitbox.com
127.0.0.1 ehg-register.hitbox.com
127.0.0.1 ehg-researchinmotion.hitbox.com
127.0.0.1 ehg-rfa.hitbox.com
127.0.0.1 ehg-rodale.hitbox.com
127.0.0.1 ehg-salesforce.hitbox.com
127.0.0.1 ehg-salonmedia.hitbox.com
127.0.0.1 ehg-samsungusa.hitbox.com
127.0.0.1 ehg-seca.hitbox.com
127.0.0.1 ehg-shoppersdrugmart.hitbox.com
127.0.0.1 ehg-sonybssc.hitbox.com
127.0.0.1 ehg-sonycomputer.hitbox.com
127.0.0.1 ehg-sonyelec.hitbox.com
127.0.0.1 ehg-sonymusic.hitbox.com
127.0.0.1 ehg-sonyny.hitbox.com
127.0.0.1 ehg-space.hitbox.com
127.0.0.1 ehg-streamload.hitbox.com
127.0.0.1 ehg-superpages.hitbox.com
127.0.0.1 ehg-techtarget.hitbox.com
127.0.0.1 ehg-tfl.hitbox.com
127.0.0.1 ehg-thefirstchurchchrist.hitbox.com
127.0.0.1 ehg-tigerdirect.hitbox.com
127.0.0.1 ehg-tigerdirect2.hitbox.com
127.0.0.1 ehg-topps.hitbox.com
127.0.0.1 ehg-tribute.hitbox.com
127.0.0.1 ehg-tumbleweed.hitbox.com
127.0.0.1 ehg-ubisoft.hitbox.com
127.0.0.1 ehg-uniontrib.hitbox.com
127.0.0.1 ehg-usnewsworldreport.hitbox.com
127.0.0.1 ehg-verizoncommunications.hitbox.com
127.0.0.1 ehg-viacom.hitbox.com
127.0.0.1 ehg-vmware.hitbox.com
127.0.0.1 ehg-vonage.hitbox.com
127.0.0.1 ehg-wachovia.hitbox.com
127.0.0.1 ehg-wacomtechnology.hitbox.com
127.0.0.1 ehg-womanswallstreet.hitbox.com
127.0.0.1 ehg-wss.hitbox.com
127.0.0.1 ehg-xxolympicwintergames.hitbox.com
127.0.0.1 ehg-yellowpages.hitbox.com
127.0.0.1 ehg-youtube.hitbox.com
127.0.0.1 ehg.hitbox.com
127.0.0.1 ejs.hitbox.com
127.0.0.1 enterprise.hitbox.com
127.0.0.1 esg.hitbox.com
127.0.0.1 evwr.hitbox.com
127.0.0.1 get.hitbox.com
127.0.0.1 hg1.hitbox.com
127.0.0.1 hg10.hitbox.com
127.0.0.1 hg11.hitbox.com
127.0.0.1 hg12.hitbox.com
127.0.0.1 hg13.hitbox.com
127.0.0.1 hg14.hitbox.com
127.0.0.1 hg15.hitbox.com
127.0.0.1 hg16.hitbox.com
127.0.0.1 hg17.hitbox.com
127.0.0.1 hg2.hitbox.com
127.0.0.1 hg6a.hitbox.com
127.0.0.1 hitbox.com
127.0.0.1 hitboxbenchmarker.com
127.0.0.1 hitboxcentral.com
127.0.0.1 host6.hitbox.com
127.0.0.1 ias.hitbox.com
127.0.0.1 ias2.hitbox.com
127.0.0.1 ibg.hitbox.com
127.0.0.1 ics.hitbox.com
127.0.0.1 idb.hitbox.com
127.0.0.1 js1.hitbox.com
127.0.0.1 lookup.hitbox.com
127.0.0.1 mrtg.hitbox.com
127.0.0.1 myhitbox.com
127.0.0.1 nei.hitbox.com
127.0.0.1 noc.hitbox.com
127.0.0.1 ns1.hitbox.com
127.0.0.1 oas.hitbox.com
127.0.0.1 phg.hitbox.com
127.0.0.1 rd1.hitbox.com
127.0.0.1 reseller.hitbox.com
127.0.0.1 resources.hitbox.com
127.0.0.1 sitesearch.hitbox.com
127.0.0.1 ss.hitbox.com
127.0.0.1 stage.hitbox.com
127.0.0.1 stage101.hitbox.com
127.0.0.1 stage102.hitbox.com
127.0.0.1 stage103.hitbox.com
127.0.0.1 stats.hitbox.com
127.0.0.1 stats2.hitbox.com
127.0.0.1 stats3.hitbox.com
127.0.0.1 tetra.hitbox.com
127.0.0.1 tools.hitbox.com
127.0.0.1 tools2.hitbox.com
127.0.0.1 toolsa.hitbox.com
127.0.0.1 ts1.hitbox.com
127.0.0.1 ts2.hitbox.com
127.0.0.1 vwr1.hitbox.com
127.0.0.1 w1.hitbox.com
127.0.0.1 w10.hitbox.com
127.0.0.1 w100.hitbox.com
127.0.0.1 w101.hitbox.com
127.0.0.1 w102.hitbox.com
127.0.0.1 w103.hitbox.com
127.0.0.1 w104.hitbox.com
127.0.0.1 w105.hitbox.com
127.0.0.1 w106.hitbox.com
127.0.0.1 w107.hitbox.com
127.0.0.1 w108.hitbox.com
127.0.0.1 w109.hitbox.com
127.0.0.1 w11.hitbox.com
127.0.0.1 w110.hitbox.com
127.0.0.1 w111.hitbox.com
127.0.0.1 w112.hitbox.com
127.0.0.1 w113.hitbox.com
127.0.0.1 w114.hitbox.com
127.0.0.1 w115.hitbox.com
127.0.0.1 w116.hitbox.com
127.0.0.1 w117.hitbox.com
127.0.0.1 w118.hitbox.com
127.0.0.1 w119.hitbox.com
127.0.0.1 w12.hitbox.com
127.0.0.1 w120.hitbox.com
127.0.0.1 w121.hitbox.com
127.0.0.1 w122.hitbox.com
127.0.0.1 w123.hitbox.com
127.0.0.1 w124.hitbox.com
127.0.0.1 w126.hitbox.com
127.0.0.1 w128.hitbox.com
127.0.0.1 w129.hitbox.com
127.0.0.1 w13.hitbox.com
127.0.0.1 w130.hitbox.com
127.0.0.1 w131.hitbox.com
127.0.0.1 w132.hitbox.com
127.0.0.1 w133.hitbox.com
127.0.0.1 w135.hitbox.com
127.0.0.1 w136.hitbox.com
127.0.0.1 w137.hitbox.com
127.0.0.1 w138.hitbox.com
127.0.0.1 w139.hitbox.com
127.0.0.1 w14.hitbox.com
127.0.0.1 w140.hitbox.com
127.0.0.1 w141.hitbox.com
127.0.0.1 w144.hitbox.com
127.0.0.1 w147.hitbox.com
127.0.0.1 w15.hitbox.com
127.0.0.1 w153.hitbox.com
127.0.0.1 w154.hitbox.com
127.0.0.1 w155.hitbox.com
127.0.0.1 w157.hitbox.com
127.0.0.1 w159.hitbox.com
127.0.0.1 w16.hitbox.com
127.0.0.1 w161.hitbox.com
127.0.0.1 w162.hitbox.com
127.0.0.1 w167.hitbox.com
127.0.0.1 w168.hitbox.com
127.0.0.1 w17.hitbox.com
127.0.0.1 w170.hitbox.com
127.0.0.1 w175.hitbox.com
127.0.0.1 w18.hitbox.com
127.0.0.1 w19.hitbox.com
127.0.0.1 w2.hitbox.com
127.0.0.1 w20.hitbox.com
127.0.0.1 w21.hitbox.com
127.0.0.1 w22.hitbox.com
127.0.0.1 w23.hitbox.com
127.0.0.1 w24.hitbox.com
127.0.0.1 w25.hitbox.com
127.0.0.1 w26.hitbox.com
127.0.0.1 w27.hitbox.com
127.0.0.1 w28.hitbox.com
127.0.0.1 w29.hitbox.com
127.0.0.1 w3.hitbox.com
127.0.0.1 w30.hitbox.com
127.0.0.1 w31.hitbox.com
127.0.0.1 w32.hitbox.com
127.0.0.1 w33.hitbox.com
127.0.0.1 w36.hitbox.com
127.0.0.1 w4.hitbox.com
127.0.0.1 w5.hitbox.com
127.0.0.1 w6.hitbox.com
127.0.0.1 w7.hitbox.com
127.0.0.1 w8.hitbox.com
127.0.0.1 w9.hitbox.com
127.0.0.1 webload101.hitbox.com
127.0.0.1 wvwr1.hitbox.com
127.0.0.1 ww1.hitbox.com
127.0.0.1 ww2.hitbox.com
127.0.0.1 ww3.hitbox.com
127.0.0.1 wwa.hitbox.com
127.0.0.1 wwb.hitbox.com
127.0.0.1 wwc.hitbox.com
127.0.0.1 wwd.hitbox.com
127.0.0.1 www.hitbox.com
127.0.0.1 yang.hitbox.com
127.0.0.1 ying.hitbox.com
#</hitbox-sites>

#<extreme-dm-sites>

# www.extreme-dm.com tracking
127.0.0.1 extreme-dm.com
127.0.0.1 reports.extreme-dm.com
127.0.0.1 t.extreme-dm.com
127.0.0.1 t0.extreme-dm.com
127.0.0.1 t1.extreme-dm.com
127.0.0.1 u.extreme-dm.com
127.0.0.1 u0.extreme-dm.com
127.0.0.1 u1.extreme-dm.com
127.0.0.1 v.extreme-dm.com
127.0.0.1 v0.extreme-dm.com
127.0.0.1 v1.extreme-dm.com
127.0.0.1 w.extreme-dm.com
127.0.0.1 w0.extreme-dm.com
127.0.0.1 w1.extreme-dm.com
127.0.0.1 www.extreme-dm.com
127.0.0.1 x3.extreme-dm.com
127.0.0.1 y.extreme-dm.com
127.0.0.1 y0.extreme-dm.com
127.0.0.1 y1.extreme-dm.com
127.0.0.1 z.extreme-dm.com
127.0.0.1 z0.extreme-dm.com
127.0.0.1 z1.extreme-dm.com
#</extreme-dm-sites>

#<realmedia-sites>

# realmedia.com's Open Ad Stream
127.0.0.1 ap.oasfile.aftenposten.no
127.0.0.1 oas-central.east.realmedia.com
127.0.0.1 oas-central.realmedia.com
127.0.0.1 oas.adservingml.com
127.0.0.1 oas.benchmark.fr
127.0.0.1 oas.foxnews.com
127.0.0.1 oas.ibnlive.com
127.0.0.1 oas.publicitas.ch
127.0.0.1 oas.sciencemag.org
127.0.0.1 oas.startribune.com
127.0.0.1 oas.toronto.com
127.0.0.1 oas.uniontrib.com
127.0.0.1 oas.villagevoice.com
127.0.0.1 oas.vtsgonline.com
127.0.0.1 oasc03012.247realmedia.com
127.0.0.1 oasc03049.247realmedia.com
127.0.0.1 oasc06006.247realmedia.com
127.0.0.1 oasc08008.247realmedia.com
127.0.0.1 oasc09.247realmedia.com
127.0.0.1 oascentral.123greetings.com
127.0.0.1 oascentral.abclocal.go.com
127.0.0.1 oascentral.adage.com
127.0.0.1 oascentral.adageglobal.com
127.0.0.1 oascentral.aircanada.com
127.0.0.1 oascentral.artistirect.com
127.0.0.1 oascentral.askmen.com
127.0.0.1 oascentral.blackenterprises.com
127.0.0.1 oascentral.businessweeks.com
127.0.0.1 oascentral.buy.com
127.0.0.1 oascentral.canadaeast.com
127.0.0.1 oascentral.canadianliving.com
127.0.0.1 oascentral.charleston.net
127.0.0.1 oascentral.chicagobusiness.com
127.0.0.1 oascentral.chron.com
127.0.0.1 oascentral.citypages.com
127.0.0.1 oascentral.clearchannel.com
127.0.0.1 oascentral.comcast.net
127.0.0.1 oascentral.comics.com
127.0.0.1 oascentral.construction.com
127.0.0.1 oascentral.consumerreports.org
127.0.0.1 oascentral.crainsdetroit.com
127.0.0.1 oascentral.cybereps.com
127.0.0.1 oascentral.dailybreeze.com
127.0.0.1 oascentral.discovery.com
127.0.0.1 oascentral.drphil.com
127.0.0.1 oascentral.fashionmagazine.com
127.0.0.1 oascentral.fayettevillenc.com
127.0.0.1 oascentral.forsythnews.com
127.0.0.1 oascentral.fortunecity.com
127.0.0.1 oascentral.foxnews.com
127.0.0.1 oascentral.freedom.com
127.0.0.1 oascentral.gigex.com
127.0.0.1 oascentral.herenb.com
127.0.0.1 oascentral.hollywood.com
127.0.0.1 oascentral.houstonpress.com
127.0.0.1 oascentral.inq7.net
127.0.0.1 oascentral.investorwords.com
127.0.0.1 oascentral.itbusiness.ca
127.0.0.1 oascentral.laptopmag.com
127.0.0.1 oascentral.law.com
127.0.0.1 oascentral.laweekly.com
127.0.0.1 oascentral.looksmart.com
127.0.0.1 oascentral.lycos.com
127.0.0.1 oascentral.mayoclinic.com
127.0.0.1 oascentral.medbroadcast.com
127.0.0.1 oascentral.minnpost.com
127.0.0.1 oascentral.mochila.com
127.0.0.1 oascentral.nerve.com
127.0.0.1 oascentral.newsmax.com
127.0.0.1 oascentral.onwisconsin.com
127.0.0.1 oascentral.phoenixnewtimes.com
127.0.0.1 oascentral.phoenixvillenews.com
127.0.0.1 oascentral.poconorecord.com
127.0.0.1 oascentral.politico.com
127.0.0.1 oascentral.post-gazette.com
127.0.0.1 oascentral.pottsmerc.com
127.0.0.1 oascentral.rcrnews.com
127.0.0.1 oascentral.redherring.com
127.0.0.1 oascentral.redstate.com
127.0.0.1 oascentral.register.com
127.0.0.1 oascentral.santacruzsentinel.com
127.0.0.1 oascentral.seacoastonline.com
127.0.0.1 oascentral.sfgate.com
127.0.0.1 oascentral.sfweekly.com
127.0.0.1 oascentral.sina.com
127.0.0.1 oascentral.sina.com.hk
127.0.0.1 oascentral.sparknotes.com
127.0.0.1 oascentral.starbulletin.com
127.0.0.1 oascentral.surfline.com
127.0.0.1 oascentral.thechronicleherald.ca
127.0.0.1 oascentral.thenation.com
127.0.0.1 oascentral.theonion.com
127.0.0.1 oascentral.theonionavclub.com
127.0.0.1 oascentral.thephoenix.com
127.0.0.1 oascentral.tmcnet.com
127.0.0.1 oascentral.tnr.com
127.0.0.1 oascentral.tourismvancouver.com
127.0.0.1 oascentral.townhall.com
127.0.0.1 oascentral.trutv.com
127.0.0.1 oascentral.upi.com
127.0.0.1 oascentral.villagevoice.com
127.0.0.1 oascentral.virtualtourist.com
127.0.0.1 oascentral.washtimes.com
127.0.0.1 oascentral.wciv.com
127.0.0.1 oascentral.westword.com
127.0.0.1 oascentral.where.ca
127.0.0.1 oascentral.wjla.com
127.0.0.1 oascentral.wkrn.com
127.0.0.1 oascentral.yellowpages.com
127.0.0.1 oascentral.zwire.com
127.0.0.1 oascentralnx.comcast.net
#</realmedia-sites>

#<fastclick-sites>

# fastclick banner ads
127.0.0.1 fastclick.net
#</fastclick-sites>

#<belo-interactive-sites>

# belo interactive ads
127.0.0.1 te.about.com
127.0.0.1 te.adlandpro.com
127.0.0.1 te.advance.net
127.0.0.1 te.ap.org
127.0.0.1 te.astrology.com
127.0.0.1 te.boston.com
127.0.0.1 te.chron.com
127.0.0.1 te.cleveland.net
127.0.0.1 te.greenwichtime.com
127.0.0.1 te.infoworld.com
127.0.0.1 te.journalnow.com
127.0.0.1 te.newsday.com
127.0.0.1 te.nytdigital.com
127.0.0.1 te.scrippsnetworksprivacy.com
127.0.0.1 te.scrippsnewspapersprivacy.com
127.0.0.1 te.sfgate.com
127.0.0.1 te.signonsandiego.com
127.0.0.1 te.stamfordadvocate.com
127.0.0.1 te.thestar.ca
127.0.0.1 te.thestar.com
127.0.0.1 te.trb.com
127.0.0.1 te.versiontracker.com
#</belo-interactive-sites>

#<popup-traps>

# popup traps -- sites that bounce you around or won't let you leave
127.0.0.1 adultfriendfinder.com
127.0.0.1 incestland.com
127.0.0.1 lesview.com
127.0.0.1 searchforit.com
127.0.0.1 www.bangbuddy.com
127.0.0.1 www.datanotary.com
127.0.0.1 www.entercasino.com
127.0.0.1 www.justhookup.com
127.0.0.1 www.mangayhentai.com
127.0.0.1 www.ourfuckbook.com
127.0.0.1 www.realincestvideos.com
127.0.0.1 www.searchv.com
127.0.0.1 www.seductiveamateurs.com
127.0.0.1 www.smsmovies.net
127.0.0.1 www.wowjs.1www.cn
127.0.0.1 www.xxxnations.com
127.0.0.1 www.xxxtoolbar.com
127.0.0.1 www.yourfuckbook.com
#</popup-traps>

#<ecard-scam-sites>

# malicious e-card -- these sites send out mass quantities of spam 
	# and some distribute adware and spyware
127.0.0.1 123greetings.com	# contains one link to distributor of adware or spyware
127.0.0.1 2000greetings.com
127.0.0.1 celebwelove.com
127.0.0.1 ecard4all.com
127.0.0.1 eforu.com
127.0.0.1 freewebcards.com
127.0.0.1 fukkad.com
127.0.0.1 fun-e-cards.com
127.0.0.1 funnyreign.com	# heavy spam (Site Advisor received 1075 e-mails/week)
127.0.0.1 funsilly.com
127.0.0.1 myfuncards.com
127.0.0.1 www.cool-downloads.com
127.0.0.1 www.cool-downloads.net
127.0.0.1 www.friend-card.com
127.0.0.1 www.friend-cards.com
127.0.0.1 www.friend-cards.net
127.0.0.1 www.friend-greeting.com
127.0.0.1 www.friend-greetings.com
127.0.0.1 www.friend-greetings.net
127.0.0.1 www.friendgreetings.com
127.0.0.1 www.friendgreetings.net
127.0.0.1 www.laugh-mail.com
127.0.0.1 www.laugh-mail.net
#</ecard-scam-sites>

#<IVW-sites>

# European network of tracking sites
#</IVW-sites>

#<wiki-spam-sites>

# message board and wiki spam -- these sites are linked in 
	# message board spam and are unlikely to be real sites
127.0.0.1 21jewelry.com
127.0.0.1 24x7.soliday.org
127.0.0.1 2site.com
127.0.0.1 33b.b33r.net
127.0.0.1 4allfree.com
127.0.0.1 55.2myip.com
127.0.0.1 6165.rapidforum.com
127.0.0.1 7x.cc
127.0.0.1 911.x24hr.com
127.0.0.1 ab.5.p2l.info
127.0.0.1 aboutharrypotter.fasthost.tv
127.0.0.1 acyclovir.1.p2l.info
127.0.0.1 adderall.ourtablets.com
127.0.0.1 adipex.1.p2l.info
127.0.0.1 adipex.24sws.ws
127.0.0.1 adipex.3.p2l.info
127.0.0.1 adipex.4.p2l.info
127.0.0.1 adipex.hut1.ru
127.0.0.1 adipex.ourtablets.com
127.0.0.1 adipex.shengen.ru
127.0.0.1 adipex.t-amo.net
127.0.0.1 adipexp.3xforum.ro
127.0.0.1 adult.shengen.ru
127.0.0.1 aid-golf-golfdust-training.tabrays.com
127.0.0.1 ak.5.p2l.info
127.0.0.1 al.5.p2l.info
127.0.0.1 all-sex.shengen.ru
127.0.0.1 allegra.1.p2l.info
127.0.0.1 allergy.1.p2l.info
127.0.0.1 alprazolam.ourtablets.com
127.0.0.1 alprazolamonline.findmenow.info
127.0.0.1 alyssamilano.home.sapo.pt
127.0.0.1 ambien.1.p2l.info
127.0.0.1 ambien.3.p2l.info
127.0.0.1 ambien.4.p2l.info
127.0.0.1 ambien.ourtablets.com
127.0.0.1 amoxicillin.ourtablets.com
127.0.0.1 anklets.shengen.ru
127.0.0.1 antidepressants.1.p2l.info
127.0.0.1 anxiety.1.p2l.info
127.0.0.1 aol.spb.su
127.0.0.1 ar.5.p2l.info
127.0.0.1 arcade.ya.com
127.0.0.1 arthritis.atspace.com
127.0.0.1 as.5.p2l.info
127.0.0.1 ativan.ourtablets.com
127.0.0.1 auto.allewagen.de
127.0.0.1 az.5.p2l.info
127.0.0.1 azz.badazz.org
127.0.0.1 balabass.peerserver.com
127.0.0.1 bbs.ws
127.0.0.1 bc.5.p2l.info
127.0.0.1 beauty.finaltips.com
127.0.0.1 bextra-store.shengen.ru
127.0.0.1 bextra.ourtablets.com
127.0.0.1 birth-control.1.p2l.info
127.0.0.1 bontril.1.p2l.info
127.0.0.1 bontril.ourtablets.com
127.0.0.1 bupropion-hcl.1.p2l.info
127.0.0.1 buspar.1.p2l.info
127.0.0.1 buspirone.1.p2l.info
127.0.0.1 butalbital-apap.1.p2l.info
127.0.0.1 buy-adipex.aca.ru
127.0.0.1 buy-adipex.hut1.ru
127.0.0.1 buy-cheap-phentermine.blogspot.com
127.0.0.1 buy-cialis-online.iscool.nl
127.0.0.1 buy-cialis.splinder.com
127.0.0.1 buy-fioricet.hut1.ru
127.0.0.1 buy-hydrocodone.aca.ru
127.0.0.1 buy-hydrocodone.este.ru
127.0.0.1 buy-lortab-online.iscool.nl
127.0.0.1 buy-lortab.hut1.ru
127.0.0.1 buy-phentermine.thepizza.net
127.0.0.1 buy-ultram-online.iscool.nl
127.0.0.1 buy-valium.este.ru
127.0.0.1 buy-valium.hut1.ru
127.0.0.1 buy-viagra.aca.ru
127.0.0.1 buy-vicodin-online.seumala.net
127.0.0.1 buy-vicodin-online.supersite.fr
127.0.0.1 buy-vicodin.hut1.ru
127.0.0.1 buy-vicodin.iscool.nl
127.0.0.1 buy-xanax-cheap-xanax-online.com
127.0.0.1 buy-xanax.aztecaonline.net
127.0.0.1 buy-xanax.hut1.ru
127.0.0.1 buycialisonline.7h.com
127.0.0.1 buyfioricet.findmenow.info
127.0.0.1 buyfioricetonline.7h.com
127.0.0.1 buyfioricetonline.freeservers.com
127.0.0.1 buyhydrocodoneonline.findmenow.info
127.0.0.1 buylevitra.3xforum.ro
127.0.0.1 buylevitraonline.7h.com
127.0.0.1 buylortabonline.7h.com
127.0.0.1 buypaxilonline.7h.com
127.0.0.1 buyphentermineonline.7h.com
127.0.0.1 buyvicodinonline.veryweird.com
127.0.0.1 ca.5.p2l.info
127.0.0.1 car-donation.shengen.ru
127.0.0.1 car-loan.shengen.ru
127.0.0.1 carisoprodol.1.p2l.info
127.0.0.1 carisoprodol.hut1.ru
127.0.0.1 carisoprodol.ourtablets.com
127.0.0.1 carisoprodol.shengen.ru
127.0.0.1 cash-advance.now-cash.com
127.0.0.1 cat.onlinepeople.net
127.0.0.1 cc5f.dnyp.com
127.0.0.1 celebrex.1.p2l.info
127.0.0.1 celexa.1.p2l.info
127.0.0.1 celexa.3.p2l.info
127.0.0.1 celexa.4.p2l.info
127.0.0.1 cephalexin.ourtablets.com
127.0.0.1 cheap-adipex.hut1.ru
127.0.0.1 cheap-web-hosting-here.blogspot.com
127.0.0.1 cheap-xanax-here.blogspot.com
127.0.0.1 cheapxanax.hut1.ru
127.0.0.1 cialis-store.shengen.ru
127.0.0.1 cialis.1.p2l.info
127.0.0.1 cialis.3.p2l.info
127.0.0.1 cialis.4.p2l.info
127.0.0.1 cialis.ourtablets.com
127.0.0.1 co.5.p2l.info
127.0.0.1 codeine.ourtablets.com
127.0.0.1 creampie.afdss.info
127.0.0.1 credit-card-application.now-cash.com
127.0.0.1 credit-cards.shengen.ru
127.0.0.1 ct.5.p2l.info
127.0.0.1 cyclobenzaprine.1.p2l.info
127.0.0.1 cyclobenzaprine.ourtablets.com
127.0.0.1 danger-phentermine.allforyourlife.com
127.0.0.1 darvocet.ourtablets.com
127.0.0.1 dc.5.p2l.info
127.0.0.1 de.5.p2l.info
127.0.0.1 debt.shengen.ru
127.0.0.1 def.5.p2l.info
127.0.0.1 detox-kit.com
127.0.0.1 detox.shengen.ru
127.0.0.1 diazepam.ourtablets.com
127.0.0.1 diazepam.razma.net
127.0.0.1 diazepam.shengen.ru
127.0.0.1 didrex.1.p2l.info
127.0.0.1 diet-pills.hut1.ru
127.0.0.1 dir.opank.com
127.0.0.1 dos.velek.com
127.0.0.1 drug-testing.shengen.ru
127.0.0.1 drugdetox.shengen.ru
127.0.0.1 e-dot.hut1.ru
127.0.0.1 e-hosting.hut1.ru
127.0.0.1 eb.prout.be
127.0.0.1 ed.at.thamaster.de
127.0.0.1 effexor-xr.1.p2l.info
127.0.0.1 en.ultrex.ru
127.0.0.1 enpresse.1.p2l.info
127.0.0.1 erectile.byethost33.com
127.0.0.1 esgic.1.p2l.info
127.0.0.1 fahrrad.bikesshop.de
127.0.0.1 famvir.1.p2l.info
127.0.0.1 farmius.org
127.0.0.1 fee-hydrocodone.bebto.com
127.0.0.1 female-v.1.p2l.info
127.0.0.1 femaleviagra.findmenow.info
127.0.0.1 fg.softguy.com
127.0.0.1 findmenow.info
127.0.0.1 fioricet-online.blogspot.com
127.0.0.1 fioricet.1.p2l.info
127.0.0.1 fioricet.3.p2l.info
127.0.0.1 fioricet.4.p2l.info
127.0.0.1 fl.5.p2l.info
127.0.0.1 flexeril.1.p2l.info
127.0.0.1 flextra.1.p2l.info
127.0.0.1 flonase.1.p2l.info
127.0.0.1 flonase.3.p2l.info
127.0.0.1 flonase.4.p2l.info
127.0.0.1 fluoxetine.1.p2l.info
127.0.0.1 fo4n.com
127.0.0.1 forex-broker.hut1.ru
127.0.0.1 forex-chart.hut1.ru
127.0.0.1 forex-market.hut1.ru
127.0.0.1 forex-news.hut1.ru
127.0.0.1 forex-online.hut1.ru
127.0.0.1 forex-signal.hut1.ru
127.0.0.1 forex-trade.hut1.ru
127.0.0.1 forex-trading-benefits.blogspot.com
127.0.0.1 forextrading.hut1.ru
127.0.0.1 free-money.host.sk
127.0.0.1 ga.5.p2l.info
127.0.0.1 gastrointestinal.1.p2l.info
127.0.0.1 gu.5.p2l.info
127.0.0.1 guerria-skateboard-tommy.tabrays.com
127.0.0.1 h1.ripway.com
127.0.0.1 herpes.1.p2l.info
127.0.0.1 herpes.3.p2l.info
127.0.0.1 herpes.4.p2l.info
127.0.0.1 hi.5.p2l.info
127.0.0.1 homehre.bravehost.com
127.0.0.1 homehre.ifrance.com
127.0.0.1 homehre.tripod.com
127.0.0.1 hydrocodone-buy-online.blogspot.com
127.0.0.1 hydrocodone.irondel.swisshost.by
127.0.0.1 hydrocodone.shengen.ru
127.0.0.1 hydrocodone.t-amo.net
127.0.0.1 hydrocodone.visa-usa.ru
127.0.0.1 ia.5.p2l.info
127.0.0.1 id.5.p2l.info
127.0.0.1 il.5.p2l.info
127.0.0.1 imitrex.1.p2l.info
127.0.0.1 imitrex.3.p2l.info
127.0.0.1 imitrex.4.p2l.info
127.0.0.1 in.5.p2l.info
127.0.0.1 ionamin.1.p2l.info
127.0.0.1 irondel.swisshost.by
127.0.0.1 ks.5.p2l.info
127.0.0.1 ky.5.p2l.info
127.0.0.1 la.5.p2l.info
127.0.0.1 levitra.1.p2l.info
127.0.0.1 levitra.3.p2l.info
127.0.0.1 levitra.4.p2l.info
127.0.0.1 lexapro.1.p2l.info
127.0.0.1 lexapro.3.p2l.info
127.0.0.1 lexapro.4.p2l.info
127.0.0.1 loan.aol.msk.su
127.0.0.1 loestrin.1.p2l.info
127.0.0.1 lol.to
127.0.0.1 lortab-cod.hut1.ru
127.0.0.1 lortab.hut1.ru
127.0.0.1 ma.5.p2l.info
127.0.0.1 make-money.shengen.ru
127.0.0.1 mb.5.p2l.info
127.0.0.1 md.5.p2l.info
127.0.0.1 me.5.p2l.info
127.0.0.1 medical.carway.net
127.0.0.1 mens.1.p2l.info
127.0.0.1 meridia.1.p2l.info
127.0.0.1 meridia.3.p2l.info
127.0.0.1 meridia.4.p2l.info
127.0.0.1 meridiameridia.3xforum.ro
127.0.0.1 mesotherapy.jino-net.ru
127.0.0.1 mi.5.p2l.info
127.0.0.1 mn.5.p2l.info
127.0.0.1 mo.5.p2l.info
127.0.0.1 mortgage-rates.now-cash.com
127.0.0.1 mp.5.p2l.info
127.0.0.1 ms.5.p2l.info
127.0.0.1 mt.5.p2l.info
127.0.0.1 multimedia-projector.katrina.ru
127.0.0.1 muscle-relaxers.1.p2l.info
127.0.0.1 nasacort.1.p2l.info
127.0.0.1 nasonex.1.p2l.info
127.0.0.1 nb.5.p2l.info
127.0.0.1 nc.5.p2l.info
127.0.0.1 nd.5.p2l.info
127.0.0.1 ne.5.p2l.info
127.0.0.1 nexium.1.p2l.info
127.0.0.1 nextel-ringtone.spb.su
127.0.0.1 nf.5.p2l.info
127.0.0.1 nh.5.p2l.info
127.0.0.1 nj.5.p2l.info
127.0.0.1 nm.5.p2l.info
127.0.0.1 nordette.1.p2l.info
127.0.0.1 nordette.3.p2l.info
127.0.0.1 nordette.4.p2l.info
127.0.0.1 ns.5.p2l.info
127.0.0.1 nv.5.p2l.info
127.0.0.1 ny.5.p2l.info
127.0.0.1 o8.aus.cc
127.0.0.1 oh.5.p2l.info
127.0.0.1 ok.5.p2l.info
127.0.0.1 on.5.p2l.info
127.0.0.1 online-casino.shengen.ru
127.0.0.1 online-casino.webpark.pl
127.0.0.1 online-forex-trading-systems.blogspot.com
127.0.0.1 online-forex.hut1.ru
127.0.0.1 online-pharmacy-online.blogspot.com
127.0.0.1 online-poker.shengen.ru
127.0.0.1 only-valium.shengen.ru
127.0.0.1 or.5.p2l.info
127.0.0.1 orderadipex.findmenow.info
127.0.0.1 ortho-tri-cyclen.1.p2l.info
127.0.0.1 pa.5.p2l.info
127.0.0.1 pacific-poker.e-online-poker-4u.net
127.0.0.1 pain-relief.1.p2l.info
127.0.0.1 paintball-gun.tripod.com
127.0.0.1 patio-furniture.dreamhoster.com
127.0.0.1 paxil.1.p2l.info
127.0.0.1 payday-loans.now-cash.com
127.0.0.1 pe.5.p2l.info
127.0.0.1 peter-north-cum-shot.blogspot.com
127.0.0.1 pets.finaltips.com
127.0.0.1 pharmacy-canada.forsearch.net
127.0.0.1 pharmacy-news.blogspot.com
127.0.0.1 pharmacy.hut1.ru
127.0.0.1 phendimetrazine.1.p2l.info
127.0.0.1 phentermine-online.iscool.nl
127.0.0.1 phentermine.1.p2l.info
127.0.0.1 phentermine.3.p2l.info
127.0.0.1 phentermine.4.p2l.info
127.0.0.1 phentermine.aussie7.com
127.0.0.1 phentermine.shengen.ru
127.0.0.1 phentermine.t-amo.net
127.0.0.1 phentermine.webpark.pl
127.0.0.1 phone-calling-card.exnet.su
127.0.0.1 plavix.shengen.ru
127.0.0.1 play-poker-free.forsearch.net
127.0.0.1 poker-games.e-online-poker-4u.net
127.0.0.1 pop.egi.biz
127.0.0.1 pr.5.p2l.info
127.0.0.1 prescription-drugs.easy-find.net
127.0.0.1 prescription-drugs.shengen.ru
127.0.0.1 prevacid.1.p2l.info
127.0.0.1 prilosec.1.p2l.info
127.0.0.1 propecia.1.p2l.info
127.0.0.1 protonix.shengen.ru
127.0.0.1 psorias.atspace.com
127.0.0.1 purchase.hut1.ru
127.0.0.1 qc.5.p2l.info
127.0.0.1 refinance.shengen.ru
127.0.0.1 renova.1.p2l.info
127.0.0.1 resanium.com
127.0.0.1 retin-a.1.p2l.info
127.0.0.1 ri.5.p2l.info
127.0.0.1 sc.5.p2l.info
127.0.0.1 sd.5.p2l.info
127.0.0.1 search-phentermine.hpage.net
127.0.0.1 search4you.50webs.com
127.0.0.1 seasonale.1.p2l.info
127.0.0.1 sk.5.p2l.info
127.0.0.1 skelaxin.1.p2l.info
127.0.0.1 skelaxin.3.p2l.info
127.0.0.1 skelaxin.4.p2l.info
127.0.0.1 skin-care.1.p2l.info
127.0.0.1 skocz.pl
127.0.0.1 sleep-aids.1.p2l.info
127.0.0.1 sleeper-sofa.dreamhoster.com
127.0.0.1 sobolev.net.ru
127.0.0.1 soma-store.visa-usa.ru
127.0.0.1 soma.1.p2l.info
127.0.0.1 soma.3xforum.ro
127.0.0.1 sonata.1.p2l.info
127.0.0.1 spyware-removers.shengen.ru
127.0.0.1 sq7.co.uk
127.0.0.1 stop-smoking.1.p2l.info
127.0.0.1 supplements.1.p2l.info
127.0.0.1 sx.nazari.org
127.0.0.1 sx.z0rz.com
127.0.0.1 tenuate.1.p2l.info
127.0.0.1 texas-hold-em.e-online-poker-4u.net
127.0.0.1 texas-holdem.shengen.ru
127.0.0.1 ticket20.tripod.com
127.0.0.1 tizanidine.1.p2l.info
127.0.0.1 tn.5.p2l.info
127.0.0.1 topmeds10.com
127.0.0.1 tramadol.1.p2l.info
127.0.0.1 tramadol.3.p2l.info
127.0.0.1 tramadol.4.p2l.info
127.0.0.1 tramadol2006.3xforum.ro
127.0.0.1 triphasil.1.p2l.info
127.0.0.1 triphasil.3.p2l.info
127.0.0.1 triphasil.4.p2l.info
127.0.0.1 tx.5.p2l.info
127.0.0.1 ultracet.1.p2l.info
127.0.0.1 ultram.1.p2l.info
127.0.0.1 urlcut.net
127.0.0.1 ut.5.p2l.info
127.0.0.1 utairway.com
127.0.0.1 va.5.p2l.info
127.0.0.1 valium.este.ru
127.0.0.1 valium.hut1.ru
127.0.0.1 valium.ourtablets.com
127.0.0.1 valiumvalium.3xforum.ro
127.0.0.1 valtrex.1.p2l.info
127.0.0.1 valtrex.3.p2l.info
127.0.0.1 valtrex.4.p2l.info
127.0.0.1 valtrex.7h.com
127.0.0.1 vaniqa.1.p2l.info
127.0.0.1 vi.5.p2l.info
127.0.0.1 viagra-pill.blogspot.com
127.0.0.1 viagra-soft-tabs.1.p2l.info
127.0.0.1 viagra-store.shengen.ru
127.0.0.1 viagra.1.p2l.info
127.0.0.1 viagra.3.p2l.info
127.0.0.1 viagra.4.p2l.info
127.0.0.1 viagraviagra.3xforum.ro
127.0.0.1 vicodin-store.shengen.ru
127.0.0.1 vicodin.t-amo.net
127.0.0.1 viewtools.com
127.0.0.1 vioxx.1.p2l.info
127.0.0.1 vitalitymax.1.p2l.info
127.0.0.1 vt.5.p2l.info
127.0.0.1 wa.5.p2l.info
127.0.0.1 water-bed.8p.org.uk
127.0.0.1 webhosting.hut1.ru
127.0.0.1 weborg.hut1.ru
127.0.0.1 weight-loss.1.p2l.info
127.0.0.1 weight-loss.3.p2l.info
127.0.0.1 weight-loss.4.p2l.info
127.0.0.1 weight-loss.hut1.ru
127.0.0.1 wellbutrin.1.p2l.info
127.0.0.1 wellbutrin.3.p2l.info
127.0.0.1 wellbutrin.4.p2l.info
127.0.0.1 wellnessmonitor.bravehost.com
127.0.0.1 wi.5.p2l.info
127.0.0.1 wp-club.net
127.0.0.1 ws01.do.nu
127.0.0.1 ws02.do.nu
127.0.0.1 ws03.do.nu
127.0.0.1 ws03.home.sapo.pt
127.0.0.1 ws04.do.nu
127.0.0.1 ws04.home.sapo.pt
127.0.0.1 ws05.home.sapo.pt
127.0.0.1 ws06.home.sapo.pt
127.0.0.1 wv.5.p2l.info
127.0.0.1 www.31d.net
127.0.0.1 www.adspoll.com
127.0.0.1 www.adult-top-list.com
127.0.0.1 www.aektschen.de
127.0.0.1 www.aeqs.com
127.0.0.1 www.atlantis-asia.com
127.0.0.1 www.bestrxpills.com
127.0.0.1 www.bigsister-puff.cxa.de
127.0.0.1 www.bigsister.cxa.de
127.0.0.1 www.bitlocker.net
127.0.0.1 www.cheap-online-stamp.cast.cc
127.0.0.1 www.computerxchange.com
127.0.0.1 www.credit-dreams.com
127.0.0.1 www.exe-file.de
127.0.0.1 www.fetisch-pornos.cxa.de
127.0.0.1 www.ficken-ficken-ficken.cxa.de
127.0.0.1 www.ficken-xxx.cxa.de
127.0.0.1 www.heimlich-gefilmt.cxa.de
127.0.0.1 www.keyofhealth.com
127.0.0.1 www.kitchentablegang.org
127.0.0.1 www.km69.de
127.0.0.1 www.kvr-systems.de
127.0.0.1 www.lesben-pornos.cxa.de
127.0.0.1 www.littledevildoubt.com
127.0.0.1 www.masterspace.biz
127.0.0.1 www.medical-research-books.com
127.0.0.1 www.nextstudent.com
127.0.0.1 www.nutten-verzeichnis.cxa.de
127.0.0.1 www.obesitycheck.com
127.0.0.1 www.pawnauctions.net
127.0.0.1 www.poker-new.com
127.0.0.1 www.poker-unique.com
127.0.0.1 www.poker4spain.com
127.0.0.1 www.porno-lesben.cxa.de
127.0.0.1 www.randppro-cuts.com
127.0.0.1 www.romanticmaui.net
127.0.0.1 www.schwule-boys-nackt.cxa.de
127.0.0.1 www.shopping-artikel.de
127.0.0.1 www.showcaserealestate.net
127.0.0.1 www.skattabrain.com
127.0.0.1 www.softcha.com
127.0.0.1 www.talentbroker.net
127.0.0.1 www.the-discount-store.com
127.0.0.1 www.topmeds10.com
127.0.0.1 www.uniqueinternettexasholdempoker.com
127.0.0.1 www.vthought.com
127.0.0.1 www.vtoyshop.com
127.0.0.1 www.vulcannonibird.de
127.0.0.1 www.willcommen.de
127.0.0.1 www4.at.debianbase.de
127.0.0.1 www6.ns1.name
127.0.0.1 www69.bestdeals.at
127.0.0.1 www69.byinter.net
127.0.0.1 www69.findhere.org
127.0.0.1 www9.compblue.com
127.0.0.1 www9.servequake.com
127.0.0.1 www99.bounceme.net
127.0.0.1 www99.zapto.org
127.0.0.1 wy.5.p2l.info
127.0.0.1 x25.plorp.com
127.0.0.1 x4.lov3.net
127.0.0.1 x888x.myserver.org
127.0.0.1 xanax-online.dot.de
127.0.0.1 xanax-online.run.to
127.0.0.1 xanax-store.shengen.ru
127.0.0.1 xanax.ourtablets.com
127.0.0.1 xanax.t-amo.net
127.0.0.1 xanaxxanax.3xforum.ro
127.0.0.1 xenical.1.p2l.info
127.0.0.1 xenical.3.p2l.info
127.0.0.1 xenical.4.p2l.info
127.0.0.1 xoomer.alice.it
127.0.0.1 yasmin.1.p2l.info
127.0.0.1 yasmin.3.p2l.info
127.0.0.1 yasmin.4.p2l.info
127.0.0.1 yt.5.p2l.info
127.0.0.1 zanaflex.1.p2l.info
127.0.0.1 zebutal.1.p2l.info
127.0.0.1 zoloft.1.p2l.info
127.0.0.1 zoloft.3.p2l.info
127.0.0.1 zoloft.4.p2l.info
127.0.0.1 zyban-store.shengen.ru
127.0.0.1 zyban.1.p2l.info
127.0.0.1 zyrtec.1.p2l.info
127.0.0.1 zyrtec.3.p2l.info
127.0.0.1 zyrtec.4.p2l.info
#</wiki-spam-sites>

#<Windows10>

# Windows 10 reporting domains. 
127.0.0.1 a.ads2.msads.net
127.0.0.1 adnexus.net
127.0.0.1 aidps.atdmt.com
127.0.0.1 az361816.vo.msecnd.net
127.0.0.1 az512334.vo.msecnd.net
127.0.0.1 b.ads1.msn.com
127.0.0.1 b.ads2.msads.net
127.0.0.1 c.atdmt.com
127.0.0.1 cdn.atdmt.com
127.0.0.1 cds26.ams9.msecn.net
127.0.0.1 db3aqu.atdmt.com
127.0.0.1 ec.atdmt.com
127.0.0.1 feedback.microsoft-hohm.com
127.0.0.1 flex.msn.com
127.0.0.1 h1.msn.com
127.0.0.1 live.rads.msn.com
127.0.0.1 m.adnxs.com
127.0.0.1 msntest.serving-sys.com
127.0.0.1 preview.msn.com
127.0.0.1 reports.wes.df.telemetry.microsoft.com
127.0.0.1 schemas.microsoft.akadns.net
127.0.0.1 secure.flashtalking.com
127.0.0.1 statsfe2.ws.microsoft.com
127.0.0.1 wes.df.telemetry.microsoft.com
#</Windows10>

#<shock-sites>
# For example, to block unpleasant pages, try:
127.0.0.1 goatse.cx       # More information on sites such as 
127.0.0.1 www.goatse.cx   # these can be found in this article
127.0.0.1 oralse.cx       # en.wikipedia.org/wiki/List_of_shock_sites
127.0.0.1 www.oralse.cx
127.0.0.1 goatse.ca
127.0.0.1 www.goatse.ca
127.0.0.1 oralse.ca
127.0.0.1 www.oralse.ca
127.0.0.1 goat.cx
127.0.0.1 www.goat.cx
127.0.0.1 shafou.com
127.0.0.1 www.shafou.com
127.0.0.1 joyjak.st
127.0.0.1 www.joyjak.st
127.0.0.1 1girl1pitcher.com
127.0.0.1 1girl1pitcher.org
127.0.0.1 1guy1cock.com
127.0.0.1 1man1jar.org
127.0.0.1 1man2needles.com
127.0.0.1 1priest1nun.com
127.0.0.1 1priest1nun.net
127.0.0.1 2girls1cup-free.com
127.0.0.1 2girls1cup.cc
127.0.0.1 2girls1cup.com
127.0.0.1 2girls1cup.nl
127.0.0.1 2girls1cup.ws
127.0.0.1 2girls1finger.com
127.0.0.1 2girls1finger.org
127.0.0.1 2guys1stump.org
127.0.0.1 3guys1hammer.ws
127.0.0.1 4girlsfingerpaint.com
127.0.0.1 4girlsfingerpaint.org
127.0.0.1 bagslap.com
127.0.0.1 ballsack.org
127.0.0.1 bestgore.fun
127.0.0.1 bestshockers.com
127.0.0.1 bluewaffle.biz
127.0.0.1 bottleguy.com
127.0.0.1 bowlgirl.com
127.0.0.1 cadaver.org
127.0.0.1 clownsong.com
127.0.0.1 cyberscat.com
127.0.0.1 dadparty.com
127.0.0.1 detroithardcore.com
127.0.0.1 donotwatch.org
127.0.0.1 dontwatch.us
127.0.0.1 eelsoup.net
127.0.0.1 fruitlauncher.com
127.0.0.1 funnelchair.com
127.0.0.1 goatse.bz
127.0.0.1 goatse.ru
127.0.0.1 goatsegirl.org
127.0.0.1 hai2u.com
127.0.0.1 homewares.org
127.0.0.1 howtotroll.org
127.0.0.1 japscat.org
127.0.0.1 jarsquatter.com
127.0.0.1 jiztini.com
127.0.0.1 kids-in-sandbox.com
127.0.0.1 kidsinsandbox.info
127.0.0.1 lemonparty.biz
127.0.0.1 lemonparty.org
127.0.0.1 lolhello.com
127.0.0.1 lolshock.com
127.0.0.1 loltrain.com
127.0.0.1 meatspin.biz
127.0.0.1 meatspin.com
127.0.0.1 merryholidays.org
127.0.0.1 milkfountain.com
127.0.0.1 mudfall.com
127.0.0.1 mudmonster.org
127.0.0.1 nimp.org
127.0.0.1 nobrain.dk
127.0.0.1 nutabuse.com
127.0.0.1 octopusgirl.com
127.0.0.1 on.nimp.org
127.0.0.1 painolympics.info
127.0.0.1 painolympics.org
127.0.0.1 phonejapan.com
127.0.0.1 pnrtscr.com
127.0.0.1 pressurespot.com
127.0.0.1 prolapseman.com
127.0.0.1 scrollbelow.com
127.0.0.1 selfpwn.org
127.0.0.1 shockgore.com
127.0.0.1 sourmath.com
127.0.0.1 strawpoii.me
127.0.0.1 suckdude.com
127.0.0.1 thatsjustgay.com
127.0.0.1 thatsphucked.com
127.0.0.1 thehomo.org
127.0.0.1 themacuser.org
127.0.0.1 thepounder.com
127.0.0.1 tubgirl.me
127.0.0.1 tubgirl.org
127.0.0.1 turdgasm.com
127.0.0.1 vomitgirl.org
127.0.0.1 walkthedinosaur.com
127.0.0.1 whipcrack.org
127.0.0.1 wormgush.com
127.0.0.1 www.1girl1pitcher.org
127.0.0.1 www.1guy1cock.com
127.0.0.1 www.1man1jar.org
127.0.0.1 www.1man2needles.com
127.0.0.1 www.1priest1nun.com
127.0.0.1 www.1priest1nun.net
127.0.0.1 www.2girls1cup-free.com
127.0.0.1 www.2girls1cup.cc
127.0.0.1 www.2girls1cup.nl
127.0.0.1 www.2girls1cup.ws
127.0.0.1 www.2girls1finger.org
127.0.0.1 www.2guys1stump.org
127.0.0.1 www.3guys1hammer.ws
127.0.0.1 www.4girlsfingerpaint.org
127.0.0.1 www.bagslap.com
127.0.0.1 www.ballsack.org
127.0.0.1 www.bestshockers.com
127.0.0.1 www.bluewaffle.biz
127.0.0.1 www.bottleguy.com
127.0.0.1 www.bowlgirl.com
127.0.0.1 www.cadaver.org
127.0.0.1 www.clownsong.com
127.0.0.1 www.cyberscat.com
127.0.0.1 www.dadparty.com
127.0.0.1 www.detroithardcore.com
127.0.0.1 www.donotwatch.org
127.0.0.1 www.dontwatch.us
127.0.0.1 www.eelsoup.net
127.0.0.1 www.fruitlauncher.com
127.0.0.1 www.funnelchair.com
127.0.0.1 www.goatse.bz
127.0.0.1 www.goatse.ru
127.0.0.1 www.goatsegirl.org
127.0.0.1 www.hai2u.com
127.0.0.1 www.homewares.org
127.0.0.1 www.howtotroll.org
127.0.0.1 www.japscat.org
127.0.0.1 www.jiztini.com
127.0.0.1 www.kids-in-sandbox.com
127.0.0.1 www.kidsinsandbox.info
127.0.0.1 www.lemonparty.biz
127.0.0.1 www.lemonparty.org
127.0.0.1 www.lolhello.com
127.0.0.1 www.lolshock.com
127.0.0.1 www.loltrain.com
127.0.0.1 www.meatspin.biz
127.0.0.1 www.meatspin.com
127.0.0.1 www.merryholidays.org
127.0.0.1 www.milkfountain.com
127.0.0.1 www.mudfall.com
127.0.0.1 www.mudmonster.org
127.0.0.1 www.nimp.org
127.0.0.1 www.nobrain.dk
127.0.0.1 www.nutabuse.com
127.0.0.1 www.octopusgirl.com
127.0.0.1 www.on.nimp.org
127.0.0.1 www.painolympics.info
127.0.0.1 www.painolympics.org
127.0.0.1 www.phonejapan.com
127.0.0.1 www.pressurespot.com
127.0.0.1 www.prolapseman.com
127.0.0.1 www.punishtube.com
127.0.0.1 www.scrollbelow.com
127.0.0.1 www.selfpwn.org
127.0.0.1 www.sourmath.com
127.0.0.1 www.strawpoii.me
127.0.0.1 www.suckdude.com
127.0.0.1 www.thatsjustgay.com
127.0.0.1 www.thatsphucked.com
127.0.0.1 www.theexgirlfriends.com
127.0.0.1 www.thehomo.org
127.0.0.1 www.themacuser.org
127.0.0.1 www.thepounder.com
127.0.0.1 www.tubgirl.me
127.0.0.1 www.tubgirl.org
127.0.0.1 www.turdgasm.com
127.0.0.1 www.vomitgirl.org
127.0.0.1 www.walkthedinosaur.com
127.0.0.1 www.whipcrack.org
127.0.0.1 www.wormgush.com
127.0.0.1 www.xvideoslive.com
127.0.0.1 www.youaresogay.com
127.0.0.1 www.ypmate.com
127.0.0.1 www.zentastic.com
127.0.0.1 youaresogay.com
127.0.0.1 zentastic.com
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
#  Marschall, Michael Tompkins, Michael O'Donnell, José Lucas Teixeira
#  de Oliveira, M. Ömer Gölgeli, and Anthony Gelibert for helping to build 
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



