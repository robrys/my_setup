#!/usr/bin/env bash

# Updating/Initializing all submodules
git submodule update --init --recursive

# Move all files into home directory and load new bash profile
cp -r . $HOME/
source $HOME/.bash_profile

