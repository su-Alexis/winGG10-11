# tests

## adaptive-test.ps1

Tests the ASCII-art reveal in `winGG10&11.ps1`.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tests\adaptive-test.ps1
```

Needs a real console window. Makes no system changes — it only draws to the screen
and reads the script beside it.

### What it covers

`Show-ArtReveal` resolves to one of three outcomes at runtime, because this script
runs on whatever machine it lands on and console geometry varies wildly:

| condition | outcome |
|---|---|
| no console, or no VT | plain print — nothing animated is possible |
| art will not fit on screen | `Show-ArtCascade`, which rewrites one line at a time and ignores height |
| art fits | animate in place |

The test forces each of those deliberately rather than waiting for a machine that
happens to trigger it.

**Part 1** shows the real effects, paused, so they can be judged by eye: an in-place
sweep, an in-place rain, art taller than the window handing off to the cascade, and a
before/after pair showing colour survives an animation.

**Part 2** asserts the branches and prints a pass/fail summary. Twelve assertions in
all: ten branch cases, plus two on the VT guard in `Restore-ConsoleColour`.

### Two things about how it is built

**It holds no reimplementation.** The VT probe, `$script:VTIndex`,
`Restore-ConsoleColour`, `Write-Gradient`, `$script:CanAnimate`, `Show-ArtReveal` and
`Show-ArtCascade` are lifted **verbatim** out of `winGG10&11.ps1`. A test carrying its
own copy of the logic drifts, keeps passing, and proves nothing — so `Test-NoDrift`
re-parses the script beside it and compares the lifted functions against the real
ones. If the script changes, the test says `STALE` and names the function, instead of
quietly testing an old version.

**It asserts the path taken, not the elapsed time.** It captures the real
`Show-ArtCascade` and `Write-Gradient`, shadows those names with spies that record the
path and then call through, and shadows `Write-Host` to catch plain prints — a
whole-art multi-line argument is the signature of one, while per-character and
blank-line calls are ignored.

This matters more than it sounds. Art wider than the window takes **two hops**: the
chain sends it to the cascade, whose own width guard then plain-prints it. The outcome
is indistinguishable from a direct plain print by eye or by stopwatch, so a
duration-based test would score a broken chain as passing. Timing is kept only as a
secondary check that frames genuinely ran.

### Reading a failure

A branch failure names the case, what it expected, and what it got — e.g.
`expected cascade,plain, got plain` means the chain skipped the cascade.

A `STALE` result means the script changed and the test needs relifting. That is not a
failure of the chain.

### Relifting after a change to the script

The lifted blocks are contiguous regions of `winGG10&11.ps1`. When the script changes,
copy the current text of those seven regions over the ones in the test, keeping their
order, then re-run — `Test-NoDrift` confirms you got it right.
