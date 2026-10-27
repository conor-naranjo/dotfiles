# Clipboard Management & Portability Exploration Plan

## 1. Executive Summary & Goals
- **Current State**: GNU Stow managing dotfiles across `master`, `desktop-config`, and `laptop-config` branches; i3bar driven by Conky (`conky-i3bar`); clipboard managed by `clipmenud` with a custom i3 focus listener script (`i3-handle-keepassxc-window`).
- **Target Architecture**: Nix + Home Manager across desktop and laptop (with host-specific status bar widgets like battery, `nm-applet`, etc.).
- **Immediate Improvements**:
  - Replace the race-prone `i3-handle-keepassxc-window` script with systemd-units and native `clipmenud` environment variables (`CM_IGNORE_WINDOW`, `CM_SELECTIONS="clipboard"`).
  - Evaluate status bar choices (Conky + i3bar vs. Polybar vs. py3status).
  - Evaluate screenshot clipboard caching and All-In-One (AIO) text + image clipboard options.

---

## 2. Clipboard Findings & Fixes (Implemented)
1. **The KeePassXC Leak Issue**:
   - The old bash script (`i3-handle-keepassxc-window`) relied on async i3 window focus events and `clipctl disable`, causing a race condition where fast clipboard copies from KeePassXC were captured before the disable command executed.
   - Additionally, `extensions.conf` was not included in `i3/.config/i3/config`, rendering the listener inactive.
2. **The Robust Fix**:
   - Leveraged `clipmenud`'s built-in `CM_IGNORE_WINDOW=".*[Kk]ee[Pp]ass.*"` and `CM_SELECTIONS="clipboard"` (to ignore X11 primary selection / highlighted text).
   - Configured via a systemd user unit drop-in (`systemd-units/.config/systemd/user/clipmenud.service`), managed via Stow and reloaded successfully.

---

## 3. Status Bar Migration Options (Desktop vs. Laptop)
- **Option 1: Enrich Conky + i3bar (Current)**
  - Clean up Lua/Conky config and add conditional blocks for battery/network on the laptop.
- **Option 2: Polybar via Home Manager (Recommended)**
  - Native modules for battery, wireless network, CPU, RAM, and tray icons (`nm-applet`).
  - Host-specific overrides in Nix (`desktop.nix` vs. `laptop.nix`).
- **Option 3: py3status**
  - Python-based i3bar plugin runner preserving the exact i3bar layout.

---

## 4. Screenshot & Image Clipboard Integration Options
- **Current limitation**: `clipmenud` / `xsel` only support plain text (`UTF8_STRING`), ignoring `image/png` binary targets from region screenshots (`maim -s`).
- **Approach A: Lightweight `feh` Visual Thumbnail Picker**
  - Use `tee` during screenshot capture to save copies to `${XDG_RUNTIME_DIR}/clip-shots/` while pushing to clipboard.
  - Bind a key to open `feh -t` (thumbnail grid) with an action to restore selected images back to the clipboard.
- **Approach B: Custom Patched `dmenu` + Patched `clipmenu`**
  - Patch `dmenu` with `imlib2` image preview support.
  - Extend `clipmenud` / `clipmenu` to capture and restore `image/png` MIME types.
- **Approach C: Custom Go / C Daemon + Launcher (`clipd`)**
  - Build a ~350-500 line daemon replacing `clipnotify`, `xdotool`, and `xsel`.
  - Native X11 XFixes listener, automatic `x-kde-passwordManagerHint` detection for password managers (immune to focus race conditions), and multi-MIME support (`UTF8_STRING` + `image/png`).
  - Package via Harbor `.deb`, Arch `PKGBUILD`, and Nix `buildGoModule`.
