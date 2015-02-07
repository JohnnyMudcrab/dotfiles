# TODO: created links owned by root
DIR=/home/johnny/github/dotfiles

all: symlinks install
	@echo "Reminder: Vim plugins are managed within Vim with Vundle."

symlinks:
	@ln -sf $(DIR)/zsh/_zshrc ~/.zshrc
	@ln -sf $(DIR)/zsh/_zshrc.local ~/.zshrc.local
	@ln -nsf $(DIR)/vim/_vim ~/.vim
	@ln -sf $(DIR)/vim/_vimrc ~/.vimrc
	@ln -nsf $(DIR)/vim/_vimconfig ~/.vimconfig
	@ln -sf $(DIR)/tmux/_tmux.conf ~/.tmux.conf
	@ln -sf $(DIR)/tmux/_tmuxline ~/.tmuxline
	@ln -sf $(DIR)/tmux/_tmuxinator ~/.tmuxinator
	@ln -sf $(DIR)/git/_gitconfig ~/.gitconfig
	@ln -sf $(DIR)/git/_gitignore_global ~/.gitignore_global
	@ln -sf $(DIR)/ctags/_ctags ~/.ctags
	@ln -sf $(DIR)/keymap/_Xmodmap ~/.Xmodmap

install:
	$(DIR)/scripts/install.sh

