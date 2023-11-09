#! /bin/bash

# packages to be installed
packages=(
	"tmux"
	"cmake"
	"python3"
	"python3-dev"
	"python3-pip"
	"python3-venv"
	"locales"
	"vim"
	"wget"
	"git"
	"ranger"
	"ack-grep"
	"ripgrep"
	"fd-find"
	"snapd"
	"silversearcher-ag"
	"exuberant-ctags"
	"build-essential"
)

# packages to be installed
snaps=(
	"node --classic --channel=14"
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
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit /usr/local/bin
}

# install neovim 0.9.1
install_neovim() {
	pushd ~/github/
	git clone https://github.com/neovim/neovim
	pushd neovim
	git checkout tags/0.9.4
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
	popd
	popd
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

	# install snaps
	for i in "${snaps[@]}"; do
		echo "Installing Snaps: $i"
		sudo snap install $i >/dev/null
	done

	# install pips
	for i in "${pips[@]}"; do
		echo "Installing Pips: $i"
		pip install $i >/dev/null
	done

	install_lazygit
	install_neovim

	# install deno
	curl -fsSL https://deno.land/x/install/install.sh | sh

	# install vim plug for neovim
	# rm -rf ~/.local/share/nvim/site/autoload/plug.vim
	# sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	#       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	# pip install pynvim --upgrade

	# install tmux package manager
	rm -rf ~/.tmux/plugins/tpm
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

	# install bash-it
	rm -rf ~/.bash_it
	git clone --depth=1 https://github.com/JohnnyMudcrab/bash-it.git ~/.bash_it
	~/.bash_it/install.sh --no-modify-config

}

install

mkdir -p ~/.config/nvim
mkdir -p ~/.config/clangd

sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

export LANG=en_US.UTF-8

echo "Your Name?"
read varname
git config --global user.name $varname
echo "Your Email?"
read varemail
git config --global user.email $varemail
git config --global pull.rebase false
