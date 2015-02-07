#! /bin/bash
# TODO: add tmux plugin installer

# packages to be installed
packages=(
    "tmux"
    "cmake"
    "zsh"
    "python"
    "python-dev"
    "vim"
    "ruby"
    "neovim"
    "wget"
    "task"
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

    # install gems
    # todo: check if gem already exists (gem list)
    sudo gem update
    for i in "${gems[@]}"; do
        echo "Installing Gem: $i"
        sudo gem install $i > /dev/null
    done

    # install vundle package manager
	rm -rf ~/.vim/bundle/vundle
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle

    # install tmux package manager
	rm -rf ~/.tmux/plugins/tpm
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

}


# check if packages should be installed
echo "Do you want to install common packages aswell. (yes|no)"
select yn in "Yes" "No"; do
    case $yn in
        No )  exit;;
        Yes ) install; exit;;
    esac
done
