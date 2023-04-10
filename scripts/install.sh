#! /bin/bash

# packages to be installed
packages=(
    "tmux"
    "cmake"
    "python3"
    "python3-dev"
    "locales"
    "vim"
    "neovim"
    "wget"
    "ack-grep"
    "ripgrep"
    "fd-find"
    "silversearcher-ag"
    "exuberant-ctags"
    "build-essential"
    )

# packages to be installed
snaps=(
    "node"
    )

# repositories to be added
repositories=(
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

# routine to install common packages
install() {
    # add repositories if not existent
    for i in "${repositories[@]}"; do
        add_ppa $i
    done

    # update package lists from repositories
    echo "Updating package list, please wait ..."
    sudo apt-get update > /dev/null
    echo "Update finished"

    # install packages
    for i in "${packages[@]}"; do
        echo "Installing Package: $i"
        sudo apt-get install $i -y > /dev/null
    done

    # install packages
    for i in "${snaps[@]}"; do
        echo "Installing Snaps: $i"
        sudo snap install $i > /dev/null
    done

    # install vim plug for neovim
	rm -rf ~/.local/share/nvim/site/autoload/plug.vim
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    # install tmux package manager
	rm -rf ~/.tmux/plugins/tpm
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    # install bash-it
    rm -rf ~/.bash_it
    git clone --depth=1 https://github.com/JohnnyMudcrab/bash-it.git ~/.bash_it
    ~/.bash_it/install.sh --no-modify-config


}

install;

mkdir -p ~/.config/nvim
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

export LANG=en_US.UTF-8

bash-it enable alias git
bash-it completion alias tmux

echo Your Name?
read varname
git config --global user.name $varname
echo Your Email?
read varemail
git config --global user.email $varemail
git config pull.rebase false
