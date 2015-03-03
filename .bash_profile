#!/usr/bin/env bash

# Finding things
function findin () {
    find . -exec grep -q "$1" '{}' \; -print
}

# Extracting files
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Print specific column
function fawk {
    first="awk '{print "
    last="}'"
    cmd="${first}\$${1}${last}"
    eval $cmd
}

# Make things lowercase
lowercase(){
    echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}

# Detect OS
UNAME=$(uname | tr "[:upper:]" "[:lower:]")
if [ "$UNAME" == "darwin" ]; then
    OS="mac"
else
    OS="linux"
fi

#ALIASES
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ll='ls -hal'
alias rm='rm -i'
alias diskspace='du -S | sort -n -r | more'
alias pastie='python $HOME/bin/pastie/pastie.py'
alias ctagit='ctags -R -f ./.git/tags .'
if [ "$OS" = "linux" ]; then
    alias co='sh $HOME/bin/rmate'
    alias gitInfo='ssh git@git.corp.appnexus.com info'
    alias adnxs='cd /usr/local/adnxs'
    alias maestroui='cd /usr/local/adnxs/maestro3-ui'
    alias maestroapi='cd /usr/local/adnxs/maestro3-api'
    alias tasker='cd /usr/local/adnxs/tasker-api'
    alias eos_rm='eos ps | grep $USER | awk '"'"'{ print $1 }'"'"' | while read inst ;  do eos kill -i $inst && eos rmc -i $inst; done'
    alias refresh='eval `ssh-agent`; ssh-add'
fi

# Activate z command
. $HOME/bin/z/z.sh

# Exposing editor for things
export EDITOR='vim'
if [ $OS = "linux" ]; then
    alias vi="vim"
fi

# Setting PATH for Python 2.7 AND Ruby
export PATH="$HOME:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/git_alias:$PATH"
if [ "$OS" = "mac" ]; then
    export PATH="$HOME/Python-2.7.3:$PATH"
    export PATH="/usr/local/opt/ruby/bin:$PATH"
    export PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH"
fi

export DATE=$(date +%Y-%m-%dT%H:%M:%S%z)

# Customize history as we know it
# Don't write duplicate lines in the bash_history
export HISTCONTROL=ignoredups

# Append to the history file, don't overwrite it. This will cause some
# duplicates, even with the setting above since t a new history setting is
# saved with each session.
#shopt -s histappend

# Large command history file
HISTFILESIZE=1000000
HISTSIZE=10000

# Setting for the new UTF-8 terminal support in Lion
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock

# Load bashrc if it exists
if [ -f $HOME/.bashrc ]; then
   source $HOME/.bashrc
fi

if [ $OS = "linux" ]; then
    # Setting up PROMPT
    source $HOME/bin/git-prompt.sh

    # Note these first four lines are optional
    export GIT_PS1_SHOWCOLORHINTS=true
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWUPSTREAM="verbose"
    export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]$(__git_ps1 "\[\033[01;33m\](%s)\[\033[00m\]")$ '
fi
