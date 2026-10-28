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
blocklist, and still scanned clean, and again on 2026-10-23 for the security-hardening
update, which changed both embedded `.bat` files. If the script is ever refused at parse time with
real-time protection on, that is what happened. See FEATURES.md, KNOWN LIMITS 1.

Beyond that: this script makes **substantial, persistent changes** to a Windows
install. It is designed for a machine you have just reformatted and are willing to
reformat again. Do not run it on a machine that matters without reading
FEATURES.md first and taking a restore point.

## What it does

65 steps. FEATURES.md has the detail for each one and why it is there.

| Area | Steps |
|---|---|
| Preparation | Desktop tools + God Mode, a verified restore point, DISM/SFC repair |
| Debloat | A survey of unrecognised packages (reported, never removed), 40 blacklisted package patterns removed (packages that are part of Windows are skipped and listed in the run summary), leftover registry keys, whitelisted apps re-registered |
| Privacy | Telemetry and ad ID, Cortana, DiagTrack, Recall / Windows AI, Activity History, cross-device clipboard (local Win+V kept), Delivery Optimization limited to LAN, error reporting and CEIP, background apps, Copilot, Edge telemetry, ads / tips / web suggestions, leftover telemetry tasks. `dmwappushservice` is deliberately kept on |
| Explorer and shell | 3D Objects removed, Edge PDF takeover stopped, seconds on the clock, On-Screen Keyboard and Aero Shake off, performance visual effects (ClearType kept), Explorer extras (Start "Recommended" hidden on Enterprise / Education / SE only), Windows Photo Viewer, Windows Update in Control Panel, right-click tools, the classic context menu on Windows 11 |
| Performance and gaming | .NET 3.5, game and system tuning, Fast Boot off, CPU unparked, Nagle off, the Ultimate Performance power plan, USB / PCIe / NIC power saving off, scheduler and timer tuning, hibernation and Reserved Storage off |
| Network | Dan Pollock's hosts blocklist (13,108 domains), CloudFlare DNS (IPv4, and IPv6 where you have it) with DNS over HTTPS, a network stack reset that applies on reboot |
| Security | AutoRun off, SMBv1 and guest auth off, LLMNR / mDNS / NetBIOS-NS off, WDigest off, LSA protection on and NTLMv2 only, the PowerShell v2 engine removed, WPAD / Remote Assistance / Remote Registry off, Defender PUA blocking and five attack surface reduction rules (skipped if you use another antivirus), Microsoft's vulnerable driver blocklist on, the firewall turned back on if something turned it off, Remote Desktop made to require NLA if it is on, process creation auditing (4688, with command lines) and PowerShell script block logging (4104) with bigger logs, dropped firewall packets logged, no anonymous share / account listing, IP source routing and ICMP redirects off, Edge blocks potentially unwanted downloads |
| Report | An anti-cheat readiness check: Windows 11, TPM 2.0, Secure Boot, VBS, Memory Integrity, IOMMU, test-signing. A Windows Update health check: warns when the newest update is over 45 days old or a WSUS policy setting is broken. Both read-only - the script never changes any of these |
| Optional | The built-in Administrator account, only if you give it a password. UAC is turned on for it |

## How it runs

Right-click → **Run with PowerShell**, or double-click it.

- Self-elevating: relaunches itself through UAC if it is not already admin
- Hands itself to **Windows PowerShell 5.1** if started from PowerShell 7, because
  the Appx cmdlets do not load in Core
- Checks, before it changes anything, that HKCU is really your registry, and stops
  to ask if it is not: started from inside an MSIX app (the Claude desktop app, for
  one) every per-user change would land in that app's private copy, and with
  another admin's UAC password it would land in that admin's profile
- Every step runs through one harness that prints `[ OK ]`, `[ PARTIAL ]` or
  `[ ERROR ]`, counts errors per step, times each one, and prints a run summary
- Never runs anything elevated from a folder a normal user can write to: its
  helper files live in a random, admin-only folder under `C:\ProgramData` that is
  deleted at the end. See FEATURES.md, ADDENDUM 8
- Near the end it offers to enable the built-in Administrator account. Leave it
  blank and press Enter to skip. It only goes ahead with a password you type twice,
  and it sets that password (and turns UAC on for that account) before enabling it
- Answer `nn` at the end to skip the reboot

## What it leaves behind

| Location | Contents |
|---|---|
| Desktop | `cleanup_main.bat`, `net-reset-reboot.bat`, `net-reset-lite.bat`, a God Mode folder, and `netreset-logs\` from the network reset |
| `C:\Temp\WindowsDebloat&Optimize` | Run transcripts, hosts backups (`hosts.original` is your pre-script file, kept for good), unrecognised-package reports. Administrators can change it; everyone else can only read it. If someone without admin rights created the folder first, it is renamed `WindowsDebloat&Optimize.untrusted-<date>` and left for you to look at, and a clean one is made |
| `C:\Windows\System32\drivers\etc` | `hosts.winGG.previous`, the hosts file as it was just before this run |
| Right-click menu | The classic menu on Windows 11, plus tools: admin consoles, Hash, Take Ownership, Unblock, View owner, Encrypt and more. Unblock and the two non-admin "Run with PowerShell" entries need Shift+right-click. To get the Windows 11 menu back: `reg.exe delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f`, then restart Explorer |
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

## Verify your download

Each [release](https://github.com/su-Alexis/winGG10-11/releases) has the script
attached as `winGG10-11.ps1`, with its SHA256 in the release notes and in
`SHA256SUMS.txt`. GitHub does not allow `&` in a download's name, so it is the same file
under a different name; renaming it back to `winGG10&11.ps1` does not change the hash.
Every commit on `main` also has its SHA256 in the summary of its CI run, on the
[Actions](https://github.com/su-Alexis/winGG10-11/actions) page. Check the file you have:

```powershell
Get-FileHash -Algorithm SHA256 '.\winGG10-11.ps1'     # a release download
Get-FileHash -Algorithm SHA256 '.\winGG10&11.ps1'     # from a clone
```

The hash must match exactly. Both hashes are of the file as git checks it out, with
CRLF line endings: the release asset and a `git clone` give those bytes. A "Raw"
download from GitHub comes with LF line endings, so it hashes differently even though
it is the same script.

## Tests

`tests/adaptive-test.ps1` covers the ASCII-art reveal — the one part of this script
whose behaviour depends on the machine it lands on, since it picks between an in-place
animation, a line-by-line cascade and a plain print based on the console it finds at
runtime.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tests\adaptive-test.ps1
```

It needs a console window and makes no system changes, so it is run by hand. The
animation functions are lifted verbatim out of the script rather than reimplemented, and
the test re-parses the script to confirm those copies are still current, so it cannot
quietly pass against a stale copy. See [tests/README.md](tests/README.md).

Every push and pull request runs `.github/workflows/ci.yml` on Windows: the script must
parse under Windows PowerShell 5.1 with no errors, every function must be named in the
header's function list, PSScriptAnalyzer's security rules must find nothing, and the
SHA256 of the result is printed in the run's summary.

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
