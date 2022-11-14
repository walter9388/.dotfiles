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

#### zsh ####
read -p "Do you want to install zsh configuration? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # install
    sudo apt install zsh zsh-syntax-highlighting autojump zsh-autosuggestions 
    # link zsh files and dirs
    # mkdir -p ~/.zsh
    ln -s "$PWD/.zsh" ~/.zsh
    ln -s "$PWD/.zshrc" ~/.zshrc

    # make zsh the default shell (change /bin/bash by my user to /bin/zsh in /etc/passwd)
    LINE_TO_BE_CHANGED=$(cat /etc/passwd | grep "${USER}:")
    NEW_LINE=$(echo $LINE_TO_BE_CHANGED | sed "s/\/bin\/bash/\/bin\/zsh/g") 
    sudo sed -i s~$LINE_TO_BE_CHANGED~$NEW_LINE~g /etc/passwd
    echo "changed line in /etc/passwd from $LINE_TO_BE_CHANGED to $NEW_LINE"
fi



#### nvim ####
read -p "Do you want to install neovim configuration, plugins and themes? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # ubuntu
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt update
    sudo apt install neovim

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

    # win32yank.exe to let WSL copy/paste work
    sudo cp nvim/plugin/win32yank.exe /bin/win32yank.exe
    sudo chmod +x /bin/win32yank.exe
    ## if you need to redownload win32yank, get it from here:
    # curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
    # unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
fi

#### Link stuff ####
#ln -s "$PWD/.gitconfig" ~/.gitconfig
