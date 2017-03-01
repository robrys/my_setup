#!/usr/bin/env bash

# Updating/Initializing all submodules
git submodule update --init --recursive

# Move all files into home directory and load new bash profile
cp saveagent $HOME/.ssh/saveagent
cp .bash_profile $HOME/
cp .gitmodules $HOME/
cp .gitconfig $HOME/
cp -r bin $HOME/bin

# Re-evaluating
#cp .tmux.conf $HOME/
#cp .vimrc $HOME/
#cp .zshrc $HOME/
#cp -r .vim $HOME/


# Setting up bash profile
sudo cp $HOME/bin/git-prompt.sh /etc/bash_completion.d/git
source $HOME/.bash_profile

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

    # Install node and other modules
    brew install node
    npm install forever express -g
# Centos Linux
elif [ -f $CENTOS_FILE ]; then
    sudo yum install cmake make gcc gcc-c++ nodejs redis
# Ubuntu Linux
elif [ -f $UBUNTU_FILE ]; then
    sudo apt-get update; sudo apt-get -y install cmake make gcc nodejs
fi

# NPM Installation
sudo npm install forever express -g

# Add Vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install oh-my-zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Installing tmux mem cpu plugin
if [ "$UNAME" == "darwin" ]; then
    cd $HOME/bin/tmux-mem-cpu-load
    cmake .
    make
    sudo make install
fi
echo "Run :PluginInstall in vim to complete Vundle Installation"
