Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
scoop bucket add extras
scoop install nvim neovide gcc python lazygit
# TODO: make symlinks for nvim config under windows
