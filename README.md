dotfiles
========

My personal dotfiles for ROS2/C++ development.

## Installation

Clone the repository and run:

```bash
git clone https://github.com/JohnnyMudcrab/dotfiles ~/github/dotfiles
sudo apt install make
make all
```

This installs packages, tools, and creates all symlinks. Safe to re-run for updates.

## What gets installed

- **Neovim** – latest stable binary (LazyVim)
- **lazygit** – latest release
- **Node.js** – latest LTS via fnm
- **Deno**
- **tmux** + TPM
- **bash-it**
- apt packages: tmux, ripgrep, fd-find, ranger, python3, ...

## First start

Open Neovim – LazyVim will automatically bootstrap and install all plugins on first launch.

## Updating

Re-running `make all` updates Neovim and lazygit to their latest releases.
Neovim plugins are managed with `:Lazy update` inside Neovim.

## Windows

```powershell
scoop export -c > windows\scoop.json   # on the old machine, commit the result
.\windows\install.ps1                  # scoop into D:\scoop, then scoop import
.\windows\deploy.ps1                   # symlinks + autohotkey autostart
.\windows\deploy.ps1 -ImportRegistry   # plus the neovide context menu (elevated)
```

`install.ps1 -ScoopRoot <path>` picks a different scoop location; the export
deliberately does not carry it. `deploy.ps1` needs Developer Mode or an
elevated shell for the symlinks and moves anything it finds in the way to a
`.bak-<timestamp>` copy.

Run `deploy.ps1` as the account you actually work with - it writes into that
account's profile, startup folder and per user registry. The autohotkey layout
only reaches elevated windows through UI access, which needs an official
AutoHotkey install under Program Files; deploy.ps1 uses its `*_UIA.exe` when it
finds one and says so when it does not.
