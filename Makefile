DIR=/home/johnny/github/dotfiles

all: symlinks install vundle
	@echo "Reminder: Vim plugins are managed within Vim with Vundle."

symlinks:
	@ln -sf $(DIR)/zsh/_zshrc ~/.zshrc
	@ln -sf $(DIR)/zsh/_zshrc.local ~/.zshrc.local
	@ln -nsf $(DIR)/vim/_vim ~/.vim
	@ln -sf $(DIR)/vim/_vimrc ~/.vimrc
	@ln -nsf $(DIR)/vim/_vimconfig ~/.vimconfig
	@mkdir -p ~/.config/terminator/
	@ln -sf $(DIR)/terminator/_terminatorconf ~/.config/terminator/config
	@ln -sf $(DIR)/tmux/_tmux.conf ~/.tmux.conf
	@ln -sf $(DIR)/tmux/_tmuxline ~/.tmuxline
	@ln -sf $(DIR)/tmux/_tmuxinator ~/.tmuxinator
	@ln -sf $(DIR)/git/_gitconfig ~/.gitconfig
	@ln -sf $(DIR)/git/_gitignore_global ~/.gitignore_global
	@ln -sf $(DIR)/ctags/_ctags ~/.ctags
	@ln -nsf $(DIR)/bundle ~/.vim/bundle
	@ln -sf $(DIR)/keymap/_Xmodmap ~/.Xmodmap

install:
	sh $(DIR)/scripts/install.sh

vundle: symlinks
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
