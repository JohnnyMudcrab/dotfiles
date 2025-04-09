Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex #TODO: check if already installed
scoop install git
scoop bucket add extras
scoop install neovim neovide gcc python lazygit wezterm
scoop install autohotkey
scoop install vcredist2022
scoop install powertoys
scoop install onecommander
scoop install brave
scoop install blender
scoop install xmind
scoop install inkscape
scoop install zotero
scoop install yed

# TODO set Home Path
# TODO: make symlinks for nvim config under windows
