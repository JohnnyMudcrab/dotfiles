#! /bin/bash

# packages to be installed
packages=(
    "tmux"
    "python3"
    "python3-dev"
    "python3-pip"
    "python3-venv"
    "locales"
    "vim"
    "wget"
    "git"
    "unzip"
    "ranger"
    "ack"
    "fzf"
    "ripgrep"
    "fd-find"
    "silversearcher-ag"
    "exuberant-ctags"
)

pips=(
    "compdb"
)

# repositories to be added
repositories=(
)

# function that checks if a repository exists and adds it if not
add_ppa() {
    grep -h "^deb.*$1" /etc/apt/sources.list.d/* >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Adding ppa:$1"
        sudo add-apt-repository -y ppa:$1
        return 0
    fi

    echo "ppa:$1 already exists"
    return 1
}

# install lazygit
install_lazygit() {
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
    sudo install /tmp/lazygit /usr/local/bin
    rm /tmp/lazygit.tar.gz /tmp/lazygit
}

# install latest stable neovim from pre-built binary
install_neovim() {
    curl -Lo /tmp/nvim.tar.gz \
        "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
    sudo tar -xzf /tmp/nvim.tar.gz -C /usr/local --strip-components=1
    rm /tmp/nvim.tar.gz
}

# install fnm (node version manager) and latest LTS node
install_fnm() {
    if [ ! -f "$HOME/.local/share/fnm/fnm" ]; then
        curl -fsSL https://fnm.vercel.app/install | bash --no-modify-config
    fi
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env --shell bash)"
    fnm install --lts
    fnm default lts-latest
}

# routine to install common packages
install() {
    # add repositories if not existent
    for i in "${repositories[@]}"; do
        add_ppa $i
    done

    # update package lists from repositories
    echo "Updating package list, please wait ..."
    sudo apt-get update >/dev/null
    echo "Update finished"

    # install packages
    for i in "${packages[@]}"; do
        echo "Installing Package: $i"
        sudo apt-get install $i -y >/dev/null
    done

    # install pips
    for i in "${pips[@]}"; do
        echo "Installing Pips: $i"
        pip install --break-system-packages $i >/dev/null
    done

    install_lazygit
    install_neovim
    install_fnm

    # install deno
    if [ ! -f "$HOME/.deno/bin/deno" ]; then
        curl -fsSL https://deno.land/x/install/install.sh | sh
    fi

    # install tmux plugin manager
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

    # install bash-it
    if [ ! -d "$HOME/.bash_it" ]; then
        git clone --depth=1 https://github.com/JohnnyMudcrab/bash-it.git ~/.bash_it
        ~/.bash_it/install.sh --no-modify-config
    fi
    source ~/.bash_it/bash_it.sh
    bashit enable alias ros2 git
    bashit enable completion git tmux

}

install

mkdir -p ~/.config/nvim
mkdir -p ~/.config/clangd

sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

export LANG=en_US.UTF-8

if [ -z "$(git config --global user.name)" ]; then
    echo "Your Name?"
    read varname
    git config --global user.name "$varname"
fi
if [ -z "$(git config --global user.email)" ]; then
    echo "Your Email?"
    read varemail
    git config --global user.email "$varemail"
fi
git config --global pull.rebase false
