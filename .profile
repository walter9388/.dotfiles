#### THIS .profile FILE IS USED FOR BOTH BASH AND ZSH!!!! (see install.sh to see that this is linked to both .profile and .zprofile)
# ~/.profile is not loaded by zsh at login.
# zsh loads ~/.zprofile at login.
# zsh loads ~/.zshrc when starting a new terminal session.


# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export PATH="$HOME/.poetry/bin:$PATH"
. "$HOME/.cargo/env"

source ~/.nvm/nvm.sh

export EDITOR='nvim'
export VISUAL='nvim'

# spark
SPARK_DIR=~/.local/lib/spark
if [ -d "$DIRECTORY" ]; then
    export SPARK_HOME=$SPARK_DIR
    export PATH=$PATH:$SPARK_HOME/bin
fi

# pyenv
PYENV_DIR="$HOME/.pyenv"
if [ -d "$DIRECTORY" ]; then
    export PYENV_ROOT=$PYENV_DIR
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi


