#! /bin/bash

# check if script is executed with sudo privileges
if [ "$(id -u)" != "0" ]; then
	echo "If you want to install packages aswell, please run make with sudo privileges"
	exit 1
fi

# packages to be installed
packages=(
    "tmux"
    "cmake"
    "zsh"
    "python"
    "vim"
    "gem"
    "neovim"
    "wget"
    "ack-grep"
    "silversearcher-ag"
    "exuberant-ctags"
    "build-essential"
    )

# repositories to be added
repositories=(
    "neovim-ppa/unstable"
    )

# gems to be installed
gems=(
    "tmuxinator"
    )

# function that checks if a repository exists and adds it if not
add_ppa() {
  grep -h "^deb.*$1" /etc/apt/sources.list.d/* > /dev/null 2>&1
  if [ $? -ne 0 ]
  then
    echo "Adding ppa:$1"
    sudo add-apt-repository -y ppa:$1
    return 0
  fi

  echo "ppa:$1 already exists"
  return 1
}

# add repositories if not existent
for i in "${repositories[@]}"; do
    add_ppa $i
done

# update package lists from repositories
echo "Updating package list, please wait ..."
apt-get update > /dev/null
echo "Update finished"

# install packages
for i in "${packages[@]}"; do
    echo "Installing Package: $i"
    apt-get install $i -y > /dev/null
done

# install gems
# todo: check if gem already exists (gem list)
gem update
for i in "${gems[@]}"; do
    echo "Installing Gem: $i"
    gem install $i > /dev/null
done
