#!/bin/bash

# stolen ideas from ThePrimeagen (https://www.youtube.com/watch?v=x2QJYq4IX6M&ab_channel=ThePrimeagen) and https://github.com/mrousavy/dotfiles/blob/master/install.sh

# SCRIPT TO INSTALL MY IMPORTANT DOTFILES AND PLUGINS TO USER DIR

which sudo &>/dev/null
[ $? -eq 0 ] && echo "sudo found. Starting install.sh..." || (echo "sudo is not installed! Please install sudo." && read && exit 1)

which curl &>/dev/null
[ $? -eq 0 ] && echo "curl found. Starting install.sh..." || (echo "curl is not installed! Please install curl." && read && exit 1)

which git &>/dev/null
[ $? -eq 0 ] && echo "git found. Starting install.sh..." || (echo "git is not installed! Please install git." && read && exit 1)

#### APT ####
read -p "Do you want to install required packages via apt? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Update sources
    sudo apt update
    sudo apt upgrade

    # Install Reqired packages
    sudo apt install curl git build-essential cmake python3 python3-dev python3-pip 
fi

#### nvim ####
read -p "Do you want to install neovim configuration, plugins and themes? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # ubuntu
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install neovim

    # link nvim dir to .config dir
    mkdir -p ~/.config
    ln -s nvim ~/.config/nvim

    ### make 'vim' open 'nvim'
    # Add my nvim command to the list of possible alternatives for the `vim` command
    sudo update-alternatives  --install $(which vim) vim $(which nvim) 10
    # Select nvim as default for vim
    sudo update-alternatives --set vim /usr/bin/nvim
    # if not sure of nvim path, check: `sudo update-alternatives --config vim`
    
    # install packer.lua (https://github.com/wbthomason/packer.nvim)
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

#### Link stuff ####
ln -s .gitconfig ~/.gitconfig
