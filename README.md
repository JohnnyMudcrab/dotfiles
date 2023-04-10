dotfiles
========

My personal dotfiles.

## Installation

You need to clone the repository into `~/github/dotfiles` and `sudo apt install make && make all`.

## Neovim Steps
First start will display errors because all plugins are missing
`:PlugInstall`

- :TSInstall <language_to_install>
    - ensure_installed = { "c", "lua", "vim", "help" }
    
  
## WSL Workaround for snapd
```
git clone https://github.com/DamionGans/ubuntu-wsl2-systemd-script.git $HOME/ubuntu-wsl2-systemd-script
$HOME/ubuntu-wsl2-systemd-script/ubuntu-wsl2-systemd-script.sh
```
