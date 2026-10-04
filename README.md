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

**Windows Defender flags this script as `Trojan:BAT/CryptoDrainer.C!MTB`.**

It is a false positive. The classifier scores a batch script doing bulk directory
deletion sitting beside ~13,000 known-malicious domain strings and concludes
crypto-drainer. Isolated by leave-one-out testing: remove either the hosts
blocklist or the embedded cleanup payload and the file scans clean; together they
trip it.

With real-time protection **on**, the script is refused at parse time and does not
run at all. There is a variant that works around this by moving the embedded
payload into a companion file read at runtime — ask if you want it added here.

Beyond that: this script makes **substantial, persistent changes** to a Windows
install. It is designed for a machine you have just reformatted and are willing to
reformat again. Do not run it on a machine that matters without reading
FEATURES.md first and taking a restore point.

## How it runs

Right-click → **Run with PowerShell**, or double-click it.

- Self-elevating: relaunches itself through UAC if it is not already admin
- Hands itself to **Windows PowerShell 5.1** if started from PowerShell 7, because
  the Appx cmdlets do not load in Core
- Every step runs through one harness that prints `[ OK ]`, `[ PARTIAL ]` or
  `[ ERROR ]`, counts errors per step, times each one, and prints a run summary
- Answer `nn` at the end to skip the reboot

## What it leaves behind

| Location | Contents |
|---|---|
| Desktop | `cleanup_main.bat`, `net-reset-reboot.bat`, `net-reset-lite.bat`, a God Mode folder |
| `C:\Temp\WindowsDebloat&Optimize` | Run transcripts, hosts backups, unrecognised-package reports |

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

One carve-out: the embedded hosts blocklist is Dan Pollock's work, licensed
**CC BY-SA 4.0**, and is not covered by the MIT license above. It is reproduced
with attribution, as the script header records.
