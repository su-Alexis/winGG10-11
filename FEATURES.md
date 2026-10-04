# WindowsGG - winGG10&11.ps1
## Feature Reference (generation 3)

639,655 bytes | 18,532 lines | 59 functions | 46 steps  (see addenda below)
~2,661 lines of code, ~15,363 lines of embedded data
Target: a freshly reformatted Windows 10/11 gaming PC.

---

## HOW IT RUNS

Self-elevating (relaunches through UAC if not already admin), and hands itself
over to Windows PowerShell 5.1 if started from PowerShell 7 - the Appx cmdlets
do not load in Core.

Every step goes through one harness, `Invoke-Step`, which:

  - prints the step, runs it, prints `[ OK ]`, `[ PARTIAL ]` or `[ ERROR ]`
  - clears and counts `$Error` per step, so a failure inside a step surfaces as
    PARTIAL with the actual message rather than being swallowed or killing the run
  - times every step and feeds a dot-leader run summary at the end
  - shows a live braille spinner with a ticking elapsed counter on 29 of the 44
    steps (the quiet ones; noisy steps keep the classic `[ PROCESS ]` box so
    their own output is not fought over)
  - detects when output is redirected or piped and silently drops back to static
    rendering, so wrapping the script in a logger cannot shred the display

A full transcript of every run lands in `C:\Temp\WindowsDebloat&Optimize`.

---

## THE STEPS  (44 at time of writing; 46 now - see addenda)

### Preparation
  1.  Building Desktop tools + God Mode
  2.  Creating a system restore point
  3.  Repairing the system image (DISM/SFC)

### Debloat
  4.  Uninstalling bloatware                    whitelist sweep, all users
  5.  Removing blacklisted/sponsored apps       17 curated patterns
  6.  Removing leftover bloatware reg keys
  7.  Restoring whitelisted apps                re-registers anything caught by mistake

### Privacy and telemetry
  8.  Applying privacy + telemetry settings
  9.  Disabling Cortana
  10. Disabling Diagnostics Tracking Service    DiagTrack stopped and disabled
  11. Re-enabling DMWAppushservice              deliberately put BACK - Windows needs it
  33. Disabling Recall / Windows AI
  34. Disabling Activity History
  35. Disabling cross-device clipboard sync     local Win+V history deliberately kept
  36. Restricting Delivery Optimization         LAN peers only, stops seeding to strangers
  39. Disabling error reporting and CEIP
  40. Restricting background app access
  41. Disabling Windows Copilot
  42. Muzzling Edge telemetry                   Edge is kept (WebView2), so it is muzzled

### Explorer and shell
  12. Removing 3D Objects from Explorer
  13. Stopping Edge hijacking PDFs
  15. Showing seconds in the system clock
  23. Disabling the On-Screen Keyboard
  24. Disabling Aero Shake
  44. Setting visual effects to performance     ClearType explicitly preserved

### Performance and gaming
  14. Enabling .NET 3.5                         many older games still need it
  16. Optimizing for games                      GPU priority, MMCSS, GameDVR
  17. Optimizing the system                     responsiveness, network throttling, timeouts
  18. Disabling Fast Boot (hybrid shutdown)
  19. Unparking the CPU
  20. Disabling Nagle's Algorithm               TcpAckFrequency=1, TcpDelAckTicks=0, TCPNoDelay=1
  27. Setting the power plan to High Performance
  43. Reclaiming disk space                     hibernation off, Reserved Storage off

  Also applied: `bcdedit useplatformclock=false` and `disabledynamictick=yes`
  (boot timer latency). UNTESTED ON REAL FIRMWARE - see the caution below.

### Network
  21. Applying the hosts blocklist              13,108 sinkholed domains
  25. Setting DNS to CloudFlare                 1.1.1.1 / 1.0.0.1
  26. Resetting the local network stack
  37. Enabling DNS over HTTPS                   encrypts the CloudFlare queries

### Security hardening
  22. Disabling AutoRun                         AutoRun.inf -> @SYS:DoesNotExist
  28. Hardening SMB (v1 + guest auth)           EternalBlue transport, guest fallback
  29. Disabling LLMNR, mDNS and NetBIOS-NS      all three broadcast name protocols
  30. Hardening credential storage              WDigest off, LSA RunAsPPL on
  31. Removing the PowerShell v2 engine         predates AMSI and script-block logging
  32. Completing AutoRun hardening              NoDriveTypeAutoRun=255
  38. Disabling legacy remote access            WPAD, Remote Assistance, Remote Registry

---

## WHAT IT KEEPS

Two protection lists, 89 entries total, checked before anything is removed:

  WhitelistedApps  38 entries   apps you want to survive
  NonRemovable     51 entries   Windows components that must survive

Kept deliberately, and worth knowing these were decisions not accidents:

  - Microsoft.GamingApp          the Xbox app / Game Pass
  - XblGameSaveTask              Xbox Live game-save sync, left ENABLED
  - HEVC, AV1, MPEG2, AVC, Raw   codecs - capture, streaming, playback
  - Voice Access, Live Captions, Speech Recognition, Text Input Host
  - Notepad, Paint, Terminal, Calculator, Store, Photos, Snipping Tool
  - Start Menu, File Explorer, Windows Security, XAML and WinAppSDK runtimes
  - Edge                         removing it breaks WebView2
  - Claude

A typical run removes 15 per-user packages and 12 provisioned packages out of
roughly 101 installed.

Provisioned packages matter more than they sound: they are the copies Windows
installs into every NEW user profile. Remove the per-user copy only and the
bloat returns the moment a second account is created.

---

## THE DESKTOP TOOLS

Written to the Desktop on every run, and usable standalone afterwards:

  cleanup_main.bat        452 lines   interactive disk cleanup, ticks what you
                                      want removed, warns on the dangerous
                                      handlers (Downloads, Windows.old, ESD)
  net-reset-reboot.bat    644 lines   full network stack reset with logging,
                                      backup and a verify mode
  net-reset-lite.bat      833 lines   lighter variant
  God Mode                            every Control Panel task in one folder

The network reset refuses to run over RDP or a remote session unless forced -
that is the failure mode that strands a machine.

---

## SAFETY DESIGN

  - System restore point created before anything changes
  - hosts.original written once and never overwritten, plus a timestamped
    backup on every run, and the hosts file is written to temp, verified,
    then swapped in - never edited in place
  - Idempotent: verified across consecutive runs with zero registry, AppX,
    DNS or scheduled-task drift
  - No remote code execution, no downloads, no base64, no Defender tampering,
    no ACL changes, no account changes, no disk or partition operations
  - Exactly one -Recurse delete in the whole script, guarded by Test-Path
  - A SYSTEM fallback for provisioned-package removal, using a transient
    scheduled task that unregisters itself in a finally block

---

## KNOWN LIMITS - READ BEFORE A LIVE MACHINE

  1. AMSI FALSE POSITIVE, WORKED AROUND. Windows Defender flags the script as
     Trojan:BAT/CryptoDrainer.C!MTB when the hosts blocklist and the embedded
     cleanup .bat share one file. Either half alone is clean. With real-time
     protection ON - the default after a reformat - the script is refused at
     parse time and does not run. The companion-file variant in AMSIfix\ now does
     exactly that, so by the leave-one-out result above it should scan clean -
     but that has not been re-verified against a live Defender install. The
     single-file form is affected either way.

  2. NEVER TESTED ON REAL HARDWARE. Validated across 13 runs on a VMware guest
     only. The bcdedit boot-timer settings in particular are unverified against
     real firmware; hibernation and Reserved Storage reclaim could not be
     measured because neither was active on the VM.

  3. NO UNDO PATH. Around 80 system changes with System Restore as the only
     reversal - and restore points age out.

  4. HANGS IF RUN NON-INTERACTIVELY. The closing reboot prompt loops forever
     without a console. Fine for double-click use, fatal for scheduled runs.

  5. DNS is forced to CloudFlare on every connected physical adapter. On a
     network that requires specific DNS this breaks resolution until reverted.

---

## GENERATION HISTORY

  gen 1   480,575 bytes   Sycnex-derived upstream
  gen 2   588,219 bytes   Invoke-Step / Write-RunSummary harness, blocklist
                          moved out of the middle of a function
  gen 3   641,816 bytes   this file

Notable gen 3 fixes:

  - DebloatAll had never executed. A glob (`*Nvidia*`) in a string used as a
    regex made -NotMatch throw, killing the function in 0.2s on every run
    since forever. DebloatBlacklist had been doing all the debloat alone.
  - Six whitelist entries were silently corrupted by backtick line
    continuations inside single quotes, leaving Windows Hello enrollment and
    three other components unprotected.
  - The whitelist was Windows 10-era. Once DebloatAll worked, it selected 52 of
    101 packages including the Start Menu, File Explorer and Windows Security.
    Now 17, all genuine bloat.
  - Run time cut from ~6 minutes to ~3m13s, almost entirely by replacing
    `HKCR:` lookups with direct registry access. `HKCR:` is a merged view that
    PowerShell reconciles on every call - 12 seconds per Test-Path, 18 of them.
---

# ADDENDUM - COMPETITIVE GAMING PASS (2026-09-14)

Script is now 650,008 bytes / 18,156 lines / 58 functions / 46 steps.
Latest run: 44 OK / 2 partial / 0 failed in 122 seconds.

## ANTI-CHEAT: VERIFIED CLEAN

Audited against what kernel-level anti-cheat actually inspects. The script does
NOT touch any of these:

    Secure Boot            TPM                  Memory Integrity / HVCI
    Core Isolation         driver signing       testsigning
    vulnerable-driver blocklist                 kernel debugging
    Virtualization-Based Security (VBS)

That matters specifically for Vanguard (Valorant), which requires TPM 2.0 and
Secure Boot on Windows 11 - both intact. EAC, BattlEye, FACEIT and ESEA
inspect the same surface and are equally unaffected.

The 13,108-entry hosts blocklist was checked against gaming and anti-cheat
domains. Steam, Riot, Battle.net, Epic, EasyAntiCheat, BattlEye, FACEIT,
Discord, Xbox Live and the GPU vendors all resolve normally. The only genuine
game domain blocked is mangler3/4.generals.ea.com - Command & Conquer Generals
master servers from 2003, long dead.

## BUG FOUND AND FIXED: ULTIMATE PERFORMANCE NEVER EXISTED

Every generation of this script carried the same error:

    gen1 line 14346   powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    gen2 line  1641   powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    gen3 line  2521   powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

8c5e7fda-... is HIGH PERFORMANCE. Ultimate Performance is
e9a42b02-d5df-448d-aa00-03f14749eb61. The message said "Creating Ultimate
Performance" while the GUID activated High Performance, so Ultimate Performance
was never created on any machine this ever ran on. The old guard checked
whether 'High Performance' existed - always true - so it silently took the else
branch and re-activated a plan that was already there.

Likely origin: an earlier, menu-driven version had a separate branch per power
scheme. Consolidating to the automatic version took the MESSAGE from the
Ultimate branch and the GUID from the High Performance branch. Both halves were
correct in their original context.

HIGHPOWA is now rewritten with a no-duplicate guard, since
powercfg -duplicatescheme mints a fresh GUID on every call and would otherwise
leave a pile of identical entries. Verified on both paths: it created the
scheme once, skipped creating it on the next run, and held at four schemes even
with two instances running concurrently.

## CHANGED FOR COMPETITIVE PLAY

  SystemResponsiveness   0 -> 10
      0 reserves no CPU for multimedia threads. It reads as the aggressive
      gaming choice and is shared that way constantly, but it is the documented
      cause of audio crackle under load - and voice comms run in that same
      scheduler class. 10 keeps effectively all the gaming benefit without
      starving Discord mid-fight.

  useplatformclock   set false -> deleted
      Absent means Windows selects the timer source at boot and picks the
      invariant TSC on any modern CPU (~20ns, one RDTSC instruction). Setting
      TRUE forces HPET, whose reads cross the bus at hundreds of ns - that is
      what every "disable HPET" guide is about. Setting FALSE is not the same
      as absent: it pins a constraint, survives Windows upgrades that improve
      the selection logic, and removes the graceful fallback on systems where
      the TSC is not invariant. On most modern installs the value was never
      present, so setting it false ADDED an entry where none existed.

  disabledynamictick  Yes   (unchanged - verified present in {current})

## ADDED FOR COMPETITIVE PLAY

  Ultimate Performance power plan    no core parking, no P-state latency
  USB selective suspend OFF          stops Windows suspending mouse/keyboard,
                                     which causes a hitch on the next input
  PCIe ASPM OFF                      stops the GPU and NIC links dropping into
                                     low-power states
  NIC power management OFF           same class of problem on the adapter
                                     carrying your packets
  Win32PrioritySeparation = 38       short variable quantums, 3:1 foreground
                                     boost. Windows 11 ships 2
  GlobalTimerResolutionRequests = 1  restores Windows 10 global timer
                                     resolution behaviour (reboot to apply)

## DELIBERATELY NOT ADDED

  HAGS (HwSchMode)          hardware-dependent, can worsen frametimes -
                            belongs behind a prompt, and is untestable in a VM
  Mouse/keyboard queue size widely shared, no credible evidence, oversized
                            queues can ADD latency
  Disabling filter/sticky keys  a popup annoyance, not a latency issue
  Game Mode                 net-positive on Windows 11 now; leave it alone
  Memory Integrity / HVCI   frametime cost AND known anti-cheat conflicts
  Controlled Folder Access  breaks game saves until each title is allowlisted

## PERFORMANCE

  Run time cut from ~6 minutes to ~2 minutes. Almost entirely from replacing
  HKCR: registry lookups with direct .NET access. HKCR: is a merged view of
  HKLM\SOFTWARE\Classes and HKCU\SOFTWARE\Classes and PowerShell's provider
  reconciles that merge on EVERY call - measured at 12 seconds per Test-Path.
  Remove-Keys went from 216s to 1.9s; Stop-EdgePDF from 13.2s to near zero.

## STILL UNVERIFIED ON REAL HARDWARE

  Everything above was validated on a VMware guest. Specifically unproven:
  the bcdedit timer behaviour against real firmware, hibernation reclaim
  (no hiberfil existed on the VM), Reserved Storage (inactive on the VM), NIC
  power management (vmxnet3 exposes no such setting - it will do real work on
  an Intel or Realtek adapter), and CPU unparking / MMCSS effects, which cannot
  be meaningfully measured in a VM.

  The AMSI block remains unresolved and is still the blocker for any machine
  running Defender at defaults.

---

# ADDENDUM 2 - DETERMINISM PASS (2026-09-14)

651,431 bytes / 18,185 lines / 59 functions / 46 steps.
Latest run: 45 OK / 1 partial / 0 failed in 116 seconds.

## THE MODEL CHANGED: BLACKLIST-ONLY

Previously DebloatAll SWEPT - it removed every installed package that was not on
the whitelist. That cannot produce the same result on two different machines,
because the outcome is defined by what is ABSENT from a list, and the installed
package set differs with every Windows build and SKU.

Measured on the 26200 test machine: 17 of 17 removals came from the sweep, and
NONE from the explicit blacklist. The removal set was emergent, not intended.
The blacklist at that point was entirely 2018-era bloat (CandyCrush, Wunderlist,
Flipboard, Twitter, Sway) that does not exist on modern Windows.

Now:

  DebloatAll        SURVEYS ONLY. Zero removal calls. Reports any installed
                    package that is neither protected nor explicitly listed,
                    LEAVES IT INSTALLED, and writes it to
                    unrecognised-packages-<timestamp>.txt in the log folder.
  DebloatBlacklist  The ONLY thing that removes anything, per-user and
                    provisioned, driven entirely by named patterns.

  Get-BlacklistPatterns   Single source of truth, read by both. Two copies of
                          the list would drift, and a drift means the survey
                          calls something unrecognised while the remover
                          deletes it - or the reverse.

EVERY PACKAGE THIS SCRIPT REMOVES IS NAMED. Nothing is removed for being absent
from some other list. Same list in, same packages out, on any machine.

Blacklist grew from 17 patterns to 40 - the 23 additions are every package the
old sweep actually removed on the test machine, now named explicitly.

## STRUCTURAL PROTECTION ADDED

The whitelist was 89 package names observed on ONE build. Names cannot protect a
component that did not exist when the list was written. Family prefixes now do:

    MicrosoftWindows.Client.      all Win11 shell components, present and future
    Microsoft.NET.Native          .NET Native runtimes
    Microsoft.VCLibs              VC++ UWP runtimes
    Microsoft.Services.Store      Store services

Anything in these families that DOES need removing is named in the blacklist
instead, which runs afterwards. MicrosoftWindows.Client.WebExperience is the
worked example: protected from the sweep by family, removed by name.

## FOUR PACKAGES FOUND MISSING

Tested the lists against packages that exist on other builds but not on 26200:

    Microsoft.Windows.Search        Win10/11 search host
    MicrosoftWindows.Client.LKG     newer Win11 shell component
    MicrosoftWindows.Client.AIX     Win11 25H2 shell component
    Microsoft.XboxGameOverlay       Xbox overlay

That last one is the sharp edge: the whitelist had Microsoft.XboxGamingOverlay
but not Microsoft.XboxGameOverlay - two different packages, one character apart.

## CONTROLSET BUG FIXED

Three registry paths were hardcoded to HKLM:\SYSTEM\ControlSet001 (CPU
unparking and the Ndu service). A machine booted from a non-default control set
- which happens after a failed boot or a Last Known Good recovery - would have
had those writes land in a control set that is not in use. Silent no-op. Now
CurrentControlSet.

## WHAT THIS DOES NOT SOLVE

  - New bloat on a newer build is NOT removed until it is added to the list.
    That is the trade: predictability over automatic coverage. The survey is
    what makes it manageable - run it on a new build, read the report, extend
    the list, run again. A first run on an unfamiliar build is reconnaissance,
    not a finished debloat.
  - The blacklist is now the entire specification, and it was built from one
    26200 machine.
  - This VM is a WEAK test of all of it. After twenty runs everything removable
    was already gone, so "nothing changed" was the only possible outcome. What
    is proven: the survey deletes nothing and the shared list wires up. What is
    NOT proven: that the blacklist removes the right things on a machine that
    still has bloat. That needs a rolled-back snapshot or a real reformat.
  - The AMSI block remains unresolved.

---

# ADDENDUM 3 - LOCALE INDEPENDENCE (2026-09-14)

654,459 bytes / 46 steps. Latest run: 45 OK / 1 partial / 0 failed in 114.5s.

## THE LAST SILENT DIVERGENCE, CLOSED

HIGHPOWA detected Ultimate Performance by matching the English string
"Ultimate Performance" in powercfg /list output. On a localised Windows that
match fails, the function falls back to High Performance, and the step still
reports OK. It was the only place in the script that produced a different
result with no visible sign - every other divergence (missing packages, no
internet, absent hardware feature) is something you can see.

Detection is now four tiers, most reliable first:

  1. marker GUID recorded in HKLM:\SOFTWARE\w10n11deb by a previous run
  2. the template GUID present as a built-in scheme
  3. English name match - MIGRATION ONLY, adopts a scheme an older version
     created and records its GUID as the marker
  4. duplicate once, diff the scheme list, take whatever GUID is new

Tiers 1, 2 and 4 are language-independent. Tier 3 exists only so that upgrading
does not duplicate a scheme that already exists - and the moment it fires it
records the marker, so locale never matters again on that machine.

## TWO BUGS I INTRODUCED AND FIXED WHILE DOING IT

Worth recording because both are instructive.

ORPHANED elseif. The first rewrite inserted a block between an if block's
closing brace and its elseif, breaking the chain. The step failed at runtime
with "The term 'elseif' is not recognized".
  -> Parser::ParseFile REPORTED CLEAN. PowerShell parses a bare elseif as a
     command name, so a structurally broken if-chain passes the parser and only
     dies when executed. Parse-clean is NOT proof the code runs. Changed
     functions are now dot-sourced and invoked in an isolated scope before the
     full script is run.

MARKER PROBE COUNTED AS FAILURE. Reading the marker key before it exists is
EXPECTED to fail on a clean machine, but the error still landed in $Error and
Invoke-Step counted it, reporting PARTIAL on an otherwise perfect first run.
  -> Third instance of this exact pattern (Reserved Storage, NIC adapters, and
     now the marker read). All three use the same fix: record $Error.Count,
     probe, trim only what the probe added. If a fourth appears, replace the
     three inline copies with one Test-Silently helper.

## A NOTE ON THE VERIFICATION IN THIS DOCUMENT

The "0 -eq ''" trap fired three separate times while checking this script:
in PowerShell, 0 -eq '' is TRUE, so any check written as
    if ($null -eq $v -or $v -eq '')
reports every correctly-set zero as "NOT SET". Three times it produced a false
alarm about settings that were applied correctly. Use $null -eq $v alone.

---

# ADDENDUM 4 - Invoke-Silently (2026-09-14)

656,116 bytes / 46 steps / 60 functions. Run: 45 OK / 1 partial / 0 failed, 118s.

## THE PATTERN THIS SOLVES

Invoke-Step measures a step by clearing $Error, running it, and counting what is
left behind. That is the right model - it is why a failure inside a step
surfaces as PARTIAL instead of vanishing, and it caught real bugs repeatedly.

But a PROBE - "does this key exist", "does this driver support that setting" -
is EXPECTED to fail, and -ErrorAction SilentlyContinue suppresses the message
while still recording the error. So three healthy steps were reporting PARTIAL
for behaving correctly:

    Reserved Storage state read      "not available on this machine"
    NIC power-management capability  vmxnet3 exposes no such setting
    Ultimate Performance marker read absent until the first successful run

Each had grown its own copy of the same count-and-trim logic. Now one helper:

    Invoke-Silently { <probe> }            returns the value, or $null
    Invoke-Silently -AsBool { <probe> }    returns success, for void cmdlets

Only the probe passed in is silenced. Everything else the step does reports
normally.

## A REAL DEFECT FOUND WHILE REFACTORING

The Reserved Storage trim wrapped the WHOLE block, not just the probe - so a
genuine Set-WindowsReservedStorageState failure would have been swallowed along
with the expected "not available", and the step would have reported OK for
something that did not happen. That is the exact failure this project has been
about: code claiming success it has not earned. Only the probe is silenced now.

## TWO BUGS I INTRODUCED, BOTH PATTERNS WORTH KNOWING

POWERSHELL VARIABLE NAMES ARE CASE-INSENSITIVE. $rS (a line number) and $rs (a
here-string) are ONE VARIABLE - the second assignment clobbered the first and
the edit failed. Second occurrence this session; the first was $g/$G destroying
a glyph table. Easy to hit when generating code programmatically.

PARSE-CLEAN IS NOT PROOF. An earlier edit orphaned an elseif by inserting a
block between an if block's closing brace and its elseif. Parser::ParseFile
reported CLEAN - PowerShell parses a bare elseif as a command name - and it
failed only at runtime. Changed functions are now dot-sourced and invoked in an
isolated scope before the full script runs. That is how the Invoke-Silently
refactor was verified: unit checks on the helper (failing probe, succeeding
probe, -AsBool both ways) plus all three call sites, each confirmed to leave
$Error.Count at 0.

---

# ADDENDUM 5 - BLOCKLIST REFRESH AND LICENCE CORRECTIONS (2026-10-04)

## BLOCKLIST UPDATED TO CURRENT UPSTREAM

The embedded list was replaced with the current someonewhocares.org/hosts/zero
revision. **13,108 unique domains**, up from 12,942. Upstream had added 193 and
dropped one (`ads.realcastmedia.com`) since the old copy was taken.

Checked before overwriting 13,000 lines: of the domains in the old embedded list,
exactly one was absent from current upstream, and that one was the upstream
removal. So `#<other>` really was the only local customisation, and a wholesale
replacement was safe. Had that number come back larger, the replacement would have
silently discarded local edits.

The data is now natively `0.0.0.0` form rather than `127.0.0.1`. The runtime
rewrite at the top of `BlocklistMNNSSM` is consequently close to a no-op - it only
still touches the single `127.0.0.1 local` line. Left in place; harmless.

## #<other> CUT FROM 47 ENTRIES TO 21

The section carried its own comment admitting the overlap with Dan Pollock's list
had never been checked. It has now been checked, and the section was wrong in
three separate ways:

  10 entries   exact duplicates within the section - lines 1-10 of the block all
               reappeared verbatim further down
   1 entry     `watson.mi`, a truncated `watson.microsoft.com`. Blocking a domain
               that does not exist. `watson.microsoft.com` was present in full
  15 entries   already blocked by upstream, so doing nothing

**The check that mattered:** total unique blocked domains is 13,108 both before
and after the 15 were cut. If any of them had been doing real work that figure
would have fallen. Overlap between the section and upstream is now zero.

What survives is the genuinely distinctive material: the `vortex` and `settings`
telemetry endpoints, the `glbdns2` and `nsatc.net` CDN variants, two `msnbot`
crawlers, the `sls`/`fe2` update endpoints, and the `watson` crash-reporting
hosts. None of those are in Dan Pollock's list.

A `#</other>` closing marker was added to match every other section, and the
entries were converted to `0.0.0.0` form for consistency with the rest of the file.

## THE HOSTS FILE IS NOT CC BY-SA

The script stated in two places that Dan Pollock's list was CC BY-SA 4.0. It is
not. Neither the file header nor the published page mentions Creative Commons
anywhere. The only stated terms are the author's own:

> You are free to copy and distribute this file for non-commercial uses, as long
> the original URL and attribution is included.

That **restricts commercial use**, which CC BY-SA explicitly permits - so the old
label claimed a more permissive licence than was actually granted. Both places are
corrected and now quote the real wording. The source URL and attribution remain
inside the embedded copy, which is what those terms require.

This matters more now the script is published: anyone intending commercial use
needs to replace the blocklist step or obtain permission from the author.

## MIT LICENCE TEXT IN THE HEADER WAS DAMAGED

The script's own MIT block had dropped a clause - it ran from "obtaining a copy"
straight to "in the Software without restriction", omitting *"of this software and
associated documentation files (the "Software"), to deal"*. Without it the grant
has no object. It also ended `OFTWARE.` instead of `SOFTWARE.`

Both repaired, and verified rather than eyeballed: the corrected body was diffed
against Syncex's copy in the same header, which was intact all along, and the two
are now character-identical.

## THE THREE DESKTOP TOOLS: NO MORE BEEP

All three used `choice.exe` for their prompts. It beeps at the console on any key
outside its list and has no flag to silence that. All five prompts across the
three tools now read a line and re-ask quietly instead, with identical accepted
answers.

Each loop caps at ten unusable answers rather than looping forever - `set /p`
returns an empty string instantly when stdin is not a console, which would
otherwise spin. The fallbacks are chosen per question: the network reset cancels,
its ending prompt leaves the machine running, and the cleanup tool's force-close
prompt leaves applications running rather than killing them.

**Note this is the same defect class as KNOWN LIMIT 4.** The tools now bound their
prompts; the PS1's own closing reboot prompt still loops forever without a
console. That limit stands.

Also in the network reset: the DNS restore no longer abandons every remaining
adapter when one fails, and a three-option menu appears when it is launched with
no arguments.

## PUBLISHED

The script and its three tools are now public repositories:

  winGG10-11            this script, as winGG10&11.ps1
  Windows-Cleanup       cleanup_main.bat
  Network-Stack-Reset   net-reset-reboot.bat
  Network-Refresh       net-reset-lite.bat

Each tool repo holds the authoritative documentation for that tool. The copies
embedded here are what get written to the Desktop, and they do not update
themselves when a repo changes - they are separate copies needing their own commit.
