# tb-tray

Turtle Beach Stealth 700 Gen 3 battery indicator for the system tray.
Companion to [tb-heal](https://github.com/richard523/tb-heal): polls
`tb-heal --json` and shows the headset battery as a tray icon with the
percent drawn in, color-coded, plus a status menu.

```
icon:  (90) green    linked, battery fine
       (90) amber    charging
       (15) red      linked, <=20% (also fires a desktop toast, once)
       ( - ) gray    not linked / transmitter missing / tooling problem
```

The state text is always in the tooltip and the first menu line - e.g.
`My Headset: linked, battery 90% (charging) [13:41]`.

## Menu

| Item | Effect |
|---|---|
| status line | live status (state, battery, last update time) |
| Refresh now | poll immediately |
| Copy status | `wl-copy` the status line |
| Run tb-heal | one-shot tb-heal, report shown as a notification |
| Quit | exit (autostart brings it back next login) |

## Requirements

- [tb-heal](https://github.com/richard523/tb-heal) on `PATH`
  (`~/.local/bin/tb-heal`)
- `libayatana-appindicator`, `python-gobject`
- a tray that speaks StatusNotifierItem: GNOME with the AppIndicator
  extension, KDE Plasma, most desktops. Plain GNOME without the
  extension has no tray at all.

## Install

```sh
./install.sh            # ~/.local/bin/tb-tray + autostart entry
~/.local/bin/tb-tray &  # start now without relogging
```

## Usage

| Option | Meaning |
|---|---|
| `--interval S` | poll interval, default 30 s (min 10) |
| `--heal` | also re-run tb-heal's self-heal each poll (default: report only - a healing daemon would fight deliberate output switching) |
| `--version` | print version |

Polling is report-only by default and single-instance guarded; a second
launch prints a note and exits. A poll that comes back with a transient
error (USB claim lost to a concurrent query - tb-heal serializes its own
exchanges on a lock since v1.0.1, so this is rare) is retried once
before the error reaches the icon.

## How it reads the battery

Each poll runs `tb-heal --json --no-heal` (~1.5 s, the Airoha RACE
exchange against the transmitter - read-only). The poll runs in a worker
thread so the tray never blocks. Battery reported while unlinked is the
dongle's last-known value; the icon goes gray in that case so a stale
number is never mistaken for a live one.

## License

MIT - see [LICENSE](LICENSE).
