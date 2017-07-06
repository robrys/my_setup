#!/usr/bin/env bash

# Updating/Initializing all submodules
#git submodule update --init --recursive

# Move all files into home directory and load new bash profile
cp -r dotfiles/. $HOME
cp -r bin $HOME/bin
cp -r git_alias $HOME/bin

mkdir -p $HOME/.config/nvim
cp flake8 $HOME/.config/flake8
cp init.vim $HOME/.config/nvim/init.vim

# TODO Re-evaluating
#cp -r .vim $HOME/


# Setting up bash profile
sudo cp $HOME/bin/git-prompt.sh /etc/bash_completion.d/git
# source $HOME/.bash_profile

# Determine OS platform
UNAME=$(uname | tr "[:upper:]" "[:lower:]")
CENTOS_FILE="/etc/redhat-release"
UBUNTU_FILE="/etc/os-release"

# Packages
# Mac
if [ "$UNAME" == "darwin" ]; then
    # Install Homebrew
    # http://brew.sh/
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # Install Command Line Tools
    # NOTE: Assume alreaady installed
    #xcode-select --install

    # Install pkgs
    brew install neovim tmux

    # Install node and other modules
    brew install node
    npm install forever express -g
# Centos Linux
elif [ -f $CENTOS_FILE ]; then
    sudo yum install cmake make gcc gcc-c++ nodejs redis
# Ubuntu Linux
elif [ -f $UBUNTU_FILE ]; then
    sudo apt-get update; sudo apt-get -y install curl cmake make gcc python-setuptools python-dev python-pip build-essential tig python3-pip python-yaml npm nodejs redis-server python-psycopg2 apache2 php5 pkg-config wget git automake libtool

    # sudo apt-get install appnexus-maestro-tools schema-tool

    sudo pip install --upgrade virtualenv; sudo pip install flake8; # sudo pip install neovim; sudo pip3 install neovim
fi

# TODO: Potentially re-enable
# NPM Installation
# sudo npm install forever express -g

# Install oh-my-zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Build neovim from source
echo "Building neovim stable..."
git clone https://github.com/neovim/neovim.git
cd neovim
rm -r build
make clean
make CMAKE_BUILD_TYPE=Release
sudo make install
cd ..

# Build tmux from source
echo "Building libevent stable..."
wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
tar -xzf libevent-2.1.8-stable.tar.gz
cd libevent-2.1.8-stable
./configure && make
sudo make install
cd ..

echo "Building ncurses stable..."
wget https://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz
tar -xzf ncurses-6.0.tar.gz
cd ncurses-6.0
./configure && make
sudo make install
cd ..

echo "Building tmux stable..."
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure && make
sudo make install
cd ..

# Installing tmux mem cpu plugin
if [ "$UNAME" == "darwin" ]; then
    cd $HOME/bin/tmux-mem-cpu-load
    cmake .
    make
    sudo make install
fi
echo "Run :PluginInstall in vim to complete Vundle Installation"
