#!/usr/bin/env bash

# Updating/Initializing all submodules
git submodule update --init --recursive


# Packages
sudo yum install cmake make gcc gcc-c++ nodejs redis
sudo npm install forever -g

# Move all files into home directory and load new bash profile
cp -r .* $HOME/
cp -r bin $HOME/bin


# Installing tmux mem cpu plugin
pushd $HOME/bin/tmux-mem-cpu-load
cmake .
make
sudo make install
popd


# Setting up bash profile
sudo cp $HOME/bin/git-prompt.sh /etc/bash_completion.d/git
source $HOME/.bash_profile

