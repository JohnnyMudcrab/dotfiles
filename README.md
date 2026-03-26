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
