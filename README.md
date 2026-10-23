# WindowsGG — winGG10&11.ps1

A one-shot baselining script for a **freshly installed Windows 10 or 11 gaming
PC**. It debloats, applies a set of performance and privacy changes, and writes a
few standalone maintenance tools to the Desktop on its way out.

It is built on [Syncex's Windows10Debloater](https://github.com/Sycnex/Windows10Debloater)
and uses [Dan Pollock's hosts file](https://someonewhocares.org/hosts/) for the
blocklist step. Credit to both — see the header of the script.

**Read [FEATURES.md](FEATURES.md) for what each step actually does.** This README
is the short version.

---

## ⚠ Before you run this

**Windows Defender used to refuse this script as `Trojan:BAT/CryptoDrainer.C!MTB`.**

That was a false positive, and it stopped on 2026-10-21 after two small edits to the
embedded cleanup `.bat` (a guard list that could never match, and the wording of one
note). An inert scan of the current file passes while the old file is still refused,
and a full real run logged no detection. Which edit mattered, and why Defender chose
that label, is **not known** - so a future edit could bring it back. It was checked
again on 2026-10-22 against the file with the ExtraTweaks merge and the refreshed
blocklist, and still scanned clean. If the script is ever refused at parse time with
real-time protection on, that is what happened. See FEATURES.md, KNOWN LIMITS 1.

Beyond that: this script makes **substantial, persistent changes** to a Windows
install. It is designed for a machine you have just reformatted and are willing to
reformat again. Do not run it on a machine that matters without reading
FEATURES.md first and taking a restore point.

## What it does

54 steps. FEATURES.md has the detail for each one and why it is there.

| Area | Steps |
|---|---|
| Preparation | Desktop tools + God Mode, a verified restore point, DISM/SFC repair |
| Debloat | A survey of unrecognised packages (reported, never removed), 40 blacklisted package patterns removed, leftover registry keys, whitelisted apps re-registered |
| Privacy | Telemetry and ad ID, Cortana, DiagTrack, Recall / Windows AI, Activity History, cross-device clipboard (local Win+V kept), Delivery Optimization limited to LAN, error reporting and CEIP, background apps, Copilot, Edge telemetry, ads / tips / web suggestions, leftover telemetry tasks. `dmwappushservice` is deliberately kept on |
| Explorer and shell | 3D Objects removed, Edge PDF takeover stopped, seconds on the clock, On-Screen Keyboard and Aero Shake off, performance visual effects (ClearType kept), Explorer extras (Start "Recommended" hidden on Enterprise / Education / SE only), Windows Photo Viewer, Windows Update in Control Panel, right-click tools, the classic context menu on Windows 11 |
| Performance and gaming | .NET 3.5, game and system tuning, Fast Boot off, CPU unparked, Nagle off, the Ultimate Performance power plan, USB / PCIe / NIC power saving off, scheduler and timer tuning, hibernation and Reserved Storage off |
| Network | Dan Pollock's hosts blocklist (13,108 domains), CloudFlare DNS with DNS over HTTPS, a network stack reset that applies on reboot |
| Security | AutoRun off, SMBv1 and guest auth off, LLMNR / mDNS / NetBIOS-NS off, WDigest off and LSA protection on, the PowerShell v2 engine removed, WPAD / Remote Assistance / Remote Registry off |
| Optional | The built-in Administrator account, only if you give it a password |

## How it runs

Right-click → **Run with PowerShell**, or double-click it.

- Self-elevating: relaunches itself through UAC if it is not already admin
- Hands itself to **Windows PowerShell 5.1** if started from PowerShell 7, because
  the Appx cmdlets do not load in Core
- Checks first that HKCU is really your registry, and stops to ask if it is not:
  started from inside an MSIX app (the Claude desktop app, for one) every per-user
  change would land in that app's private copy, and with another admin's UAC
  password it would land in that admin's profile
- Every step runs through one harness that prints `[ OK ]`, `[ PARTIAL ]` or
  `[ ERROR ]`, counts errors per step, times each one, and prints a run summary
- Near the end it offers to enable the built-in Administrator account. Leave it
  blank and press Enter to skip. It only goes ahead with a password you type twice,
  and it sets that password before enabling the account
- Answer `nn` at the end to skip the reboot

## What it leaves behind

| Location | Contents |
|---|---|
| Desktop | `cleanup_main.bat`, `net-reset-reboot.bat`, `net-reset-lite.bat`, a God Mode folder |
| `C:\Temp\WindowsDebloat&Optimize` | Run transcripts, hosts backups (`hosts.original` is your pre-script file, kept for good), unrecognised-package reports |
| Right-click menu | The classic menu on Windows 11, plus tools: admin consoles, Hash, Take Ownership, Unblock, View owner, Encrypt and more. To get the Windows 11 menu back: `reg.exe delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f`, then restart Explorer |
| Elsewhere | Windows Photo Viewer back under Open with, and Windows Update in Control Panel |

The three batch tools are standalone and usable on their own afterwards. They each
have their own repository, with full documentation:

- **[Windows-Cleanup](https://github.com/su-Alexis/Windows-Cleanup)** — scans, shows
  you the totals, then asks what to remove
- **[Network-Stack-Reset](https://github.com/su-Alexis/Network-Stack-Reset)** — full
  TCP/IP, IPv6 and Winsock reset; reboot required
- **[Network-Refresh](https://github.com/su-Alexis/Network-Refresh)** — cache flush
  and DHCP renew; no reboot

Those repos hold the authoritative copies of each tool's documentation. The copies
embedded in this script are what get written to the Desktop.

## Tests

`tests/adaptive-test.ps1` covers the ASCII-art reveal — the one part of this script
whose behaviour depends on the machine it lands on, since it picks between an in-place
animation, a line-by-line cascade and a plain print based on the console it finds at
runtime.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tests\adaptive-test.ps1
```

It needs a console window and makes no system changes. The animation functions are
lifted verbatim out of the script rather than reimplemented, and the test re-parses the
script to confirm those copies are still current, so it cannot quietly pass against a
stale copy. See [tests/README.md](tests/README.md).

## Requirements

Windows 10 or 11. Administrator rights — it elevates itself. Windows PowerShell
5.1 is used for the actual work; starting it from PowerShell 7 is fine, it hands
itself over.

## Credits

- **Syncex** and contributors — the original Windows10Debloater this was built from
  (MIT)
- **Dan Pollock** and contributors — the hosts file
  ([someonewhocares.org](https://someonewhocares.org))
- Stack Overflow, for the usual reasons

## License

MIT — see [LICENSE](LICENSE). Syncex's original script is also MIT.

One carve-out: the embedded hosts blocklist is Dan Pollock's work and is **not**
covered by the MIT license above. It carries its own terms, quoted from its
header:

> You are free to copy and distribute this file for non-commercial uses, as long
> the original URL and attribution is included.

That is the author's own wording rather than a standard licence, and it
**restricts commercial use**. The source URL and attribution are retained inside
the embedded copy. If you intend to use this commercially, replace the blocklist
step or obtain permission from the author first.
