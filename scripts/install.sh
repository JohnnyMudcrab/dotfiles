#! /bin/bash

set -euo pipefail

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
    "curl"
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
    if grep -qh "^deb.*$1" /etc/apt/sources.list.d/* 2>/dev/null; then
        echo "ppa:$1 already exists"
        return 0
    fi

    echo "Adding ppa:$1"
    sudo add-apt-repository -y "ppa:$1"
}

# latest release tag of a github repo, resolved without the rate limited api
latest_tag() {
    local tag
    tag=$(curl -fsSLI -o /dev/null -w '%{url_effective}' "https://github.com/$1/releases/latest" | sed 's#.*/tag/##')
    if [[ $tag != v* ]]; then
        echo "$1: cannot determine latest release" >&2
        return 1
    fi
    echo "$tag"
}

installed_neovim() {
    command -v nvim >/dev/null && nvim --version | awk 'NR==1 {print $2}' || true
}

installed_lazygit() {
    command -v lazygit >/dev/null && lazygit --version | grep -Po 'version=\K[0-9][^,]*' | head -1 || true
}

# install lazygit, skipped when the latest release is already in place
install_lazygit() {
    local tag version
    tag=$(latest_tag jesseduffield/lazygit)
    version=${tag#v}

    if [[ $(installed_lazygit) == "$version" ]]; then
        echo "lazygit $version is up to date"
        return 0
    fi

    echo "Installing lazygit $version"
    curl -fLo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/${tag}/lazygit_${version}_Linux_x86_64.tar.gz"
    tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
    sudo install /tmp/lazygit /usr/local/bin
    rm /tmp/lazygit.tar.gz /tmp/lazygit
}

# install latest stable neovim from pre-built binary
install_neovim() {
    local tag
    tag=$(latest_tag neovim/neovim)

    if [[ $(installed_neovim) == "$tag" ]]; then
        echo "neovim $tag is up to date"
        return 0
    fi

    echo "Installing neovim $tag"
    curl -fLo /tmp/nvim.tar.gz \
        "https://github.com/neovim/neovim/releases/download/${tag}/nvim-linux-x86_64.tar.gz"
    sudo tar -xzf /tmp/nvim.tar.gz -C /usr/local --strip-components=1
    rm /tmp/nvim.tar.gz
}

# claude code on request. It lands in ~/.local/bin, which bash/_bashrc puts on
# PATH, and leaves the shell configuration alone (checked in a throwaway HOME).
claude_installed() {
    command -v claude >/dev/null || [ -x "$HOME/.local/bin/claude" ]
}

# asked up front, while you are still watching; installed after apt
ask_claude() {
    WANT_CLAUDE=no
    claude_installed && return 0
    if [ -t 0 ]; then
        local answer
        read -r -p "Install Claude Code? [y/N] " answer || answer=""
        case "$answer" in [yYjJ]*) WANT_CLAUDE=yes ;; esac
    fi
}

install_claude() {
    if [ "$WANT_CLAUDE" = yes ]; then
        curl -fsSL https://claude.ai/install.sh | bash
    elif claude_installed; then
        echo "claude code already installed, it updates itself"
    else
        echo "claude code skipped"
    fi
}

# install fnm (node version manager) and latest LTS node
install_fnm() {
    # --skip-shell: ~/.bashrc is a symlink into this repo and sets fnm up already
    if [ ! -f "$HOME/.local/share/fnm/fnm" ]; then
        curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
    fi
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env --shell bash)"
    fnm install --lts
    fnm default lts-latest
}

# routine to install common packages
install() {
    ask_claude

    # add repositories if not existent
    for i in "${repositories[@]}"; do
        add_ppa "$i" || echo "ppa:$i failed" >&2
    done

    # update package lists from repositories
    echo "Updating package list, please wait ..."
    sudo apt-get update >/dev/null
    echo "Update finished"

    # install packages, a single unavailable one must not stop the run
    for i in "${packages[@]}"; do
        echo "Installing Package: $i"
        sudo apt-get install "$i" -y >/dev/null || echo "apt: $i failed" >&2
    done

    # install pips
    for i in "${pips[@]}"; do
        echo "Installing Pips: $i"
        pip install --break-system-packages "$i" >/dev/null || echo "pip: $i failed" >&2
    done

    install_lazygit
    install_neovim
    install_fnm
    install_claude

    # install deno, without prompts and without touching ~/.bashrc
    if [ ! -f "$HOME/.deno/bin/deno" ]; then
        curl -fsSL https://deno.land/install.sh | sh -s -- -y --no-modify-path
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

    # bash-it's init is neither -e nor -u clean
    (
        set +eu
        source ~/.bash_it/bash_it.sh
        bash-it enable alias ros2 git
        bash-it enable completion git tmux
    )
}

install

mkdir -p ~/.config/nvim
mkdir -p ~/.config/clangd

sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

export LANG=en_US.UTF-8

if [ -z "$(git config --global user.name)" ]; then
    echo "Your Name?"
    read -r varname
    git config --global user.name "$varname"
fi
if [ -z "$(git config --global user.email)" ]; then
    echo "Your Email?"
    read -r varemail
    git config --global user.email "$varemail"
fi
git config --global pull.rebase false
