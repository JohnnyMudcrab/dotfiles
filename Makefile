# TODO: created links owned by root
DIR=/home/johnny/github/dotfiles

all: symlinks install
	@echo "Reminder: Vim plugins are managed within Vim with Vundle."

symlinks:
	@ln -sf $(DIR)/tmux/_tmux.conf ~/.tmux.conf
	@ln -sf $(DIR)/tmux/_tmuxline ~/.tmuxline
	@ln -sf $(DIR)/neovim/init.vim ~/.config/init.vim
	@ln -s ~/github/dotfiles/bash/_bashrc ~/.bashrc


install:
	$(DIR)/scripts/install.sh

