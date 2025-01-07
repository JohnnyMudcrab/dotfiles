Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex #TODO: check if already installed
scoop bucket add extras
scoop install neovim neovide gcc python lazygit
# TODO: make symlinks for nvim config under windows
