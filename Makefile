# TODO: created links owned by root
DIR=~/github/dotfiles

all: install symlinks
	@echo "Reminder: Vim plugins are managed within Vim with Vundle."

symlinks:
	@ln -sf $(DIR)/tmux/_tmux.conf ~/.tmux.conf
	@ln -sf $(DIR)/tmux/_tmuxline ~/.tmuxline
	@ln -sf $(DIR)/neovim/init.vim ~/.config/nvim/init.vim
	@ln -sf $(DIR)/neovim/coc-settings.json ~/.config/nvim/coc-settings.json
	@ln -sff ~/github/dotfiles/bash/_bashrc ~/.bashrc


install:
	$(DIR)/scripts/install.sh

