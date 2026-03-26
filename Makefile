# TODO: created links owned by root
DIR=~/github/dotfiles

all: install symlinks

symlinks:
	@mkdir -p ~/.config/wezterm
	@ln -sf $(DIR)/tmux/_tmux.conf ~/.tmux.conf
	@ln -sf $(DIR)/wezterm/_wezterm.lua ~/.config/wezterm/wezterm.lua
	@ln -sf $(DIR)/git/lazygit/config.yml ~/.config/lazygit/config.yml
	@ln -sf $(DIR)/lazyvim/init.lua ~/.config/nvim/init.lua
	@ln -sf $(DIR)/lazyvim/stylua.toml ~/.config/nvim/stylua.toml
	@ln -sf $(DIR)/lazyvim/lazy-lock.json ~/.config/nvim/lazy-lock.json
	@ln -sf $(DIR)/lazyvim/lazyvim.json ~/.config/nvim/lazyvim.json
	@ln -sf $(DIR)/lazyvim/lua ~/.config/nvim/lua
	@ln -sf $(DIR)/clang/config.yaml ~/.config/clangd/config.yaml
	@ln -sf $(DIR)/bash/_bashrc ~/.bashrc
	@ln -sf $(DIR)/pandoc ~/.pandoc


install:
	$(DIR)/scripts/install.sh

