#!/usr/bin/env bash

# Updating/Initializing all submodules
git submodule update --init --recursive

# Move all files into home directory and load new bash profile
cp -r .* $HOME/
cp -r bin $HOME/bin


# Setting up bash profile
sudo cp $HOME/bin/git-prompt.sh /etc/bash_completion.d/git
source $HOME/.bash_profile

# Determine OS platform
UNAME=$(uname | tr "[:upper:]" "[:lower:]")

# Packages
# Mac
if [ "$UNAME" == "darwin" ]; then
    # Install Homebrew
    # http://brew.sh/
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # Install Command Line Tools
    xcode-select --install

    # Install node and other modules
    brew install node
    npm install forever express -g
# Linux
else
    sudo yum install cmake make gcc gcc-c++ nodejs redis
    sudo npm install forever -g
fi

# Install oh-my-zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Installing tmux mem cpu plugin
cd $HOME/bin/tmux-mem-cpu-load
cmake .
make
sudo make install
