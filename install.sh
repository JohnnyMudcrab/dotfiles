#!/bin/zsh

# remove existing links
rm ~/.bashrc
rm ~/.gitconfig
rm ~/.config/terminator/config
rm ~/.tmux.conf
rm ~/.tmuxline
rm -rf ~/.tmuxinator
rm ~/.vimconfig
rm ~/.vimrc
rm ~/.Xmodmap
rm ~/.zshrc
rm ~/.zshrc.local

# create links
ln -s ~/github/dotfiles/_bashrc ~/.bashrc
ln -s ~/github/dotfiles/_gitconfig ~/.gitconfig
ln -s ~/github/dotfiles/_terminatorconf ~/.config/terminator/config
ln -s ~/github/dotfiles/_tmux.conf ~/.tmux.conf
ln -s ~/github/dotfiles/_tmuxline ~/.tmuxline
ln -s ~/github/dotfiles/_tmuxinator ~/.tmuxinator
ln -s ~/github/dotfiles/_vimconfig ~/.vimconfig
ln -s ~/github/dotfiles/_vimrc ~/.vimrc
ln -s ~/github/dotfiles/_Xmodmap ~/.Xmodmap
ln -s ~/github/dotfiles/_zshrc ~/.zshrc
ln -s ~/github/dotfiles/_zshrc.local ~/.zshrc.local

