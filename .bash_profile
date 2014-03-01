#ALIASES

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ll='ls -l'
alias rm='rm -i'
alias co='sh $HOME/bin/rmate'
alias gitInfo='ssh git@git.corp.appnexus.com info'
alias diskspace='du -S | sort -n -r | more'
alias adnxs='cd /usr/local/adnxs'
alias maestroui='cd /usr/local/adnxs/maestro3-ui'
alias maestroapi='cd /usr/local/adnxs/maestro3-api'
alias tasker='cd /usr/local/adnxs/tasker-api'
alias eos_rm='eos ps | grep $USER | awk '"'"'{ print $1 }'"'"' | while read inst ;  do eos kill -i $inst && eos rmc -i $inst; done'
alias refresh='eval `ssh-agent`; ssh-add'

function fawk {
    first="awk '{print "
    last="}'"
    cmd="${first}\$${1}${last}"
    eval $cmd
}

# Activate z command
. $HOME/bin/z/z.sh

# Setting PATH for Python 2.7 AND Ruby
# The orginal version is saved in .bash_profile.pysave
PATH="/Users/dtrujillo/Python-2.7.3:/Users/dtrujillo/bin:/usr/local/opt/ruby/bin:/Library/Frameworks/Python.framework/Versions/2.7/bin:$HOME/bin:$HOME/git_alias:$HOME:${PATH}"
export PATH

# Setting for the new UTF-8 terminal support in Lion
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock

# Load bashrf if it exists
if [ -f $HOME/.bashrc ]; then
   source $HOME/.bashrc
fi

source /etc/bash_completion.d/git

# Note these first four lines are optional
export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM="verbose"
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]$(__git_ps1 "\[\033[01;33m\](%s)\[\033[00m\]")$ '
