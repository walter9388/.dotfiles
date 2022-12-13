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


#### Rust/Cargo #### (needed for tree-sitter in neovim)
if [[ $REPLY =~ ^[Yy]$ ]];
then
    # install rust
    curl https://sh.rustup.rs -sSf | sh
fi



#### zsh ####
read -p "Do you want to install zsh configuration? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # install (plugins now done below and put in oh-my-zsh)
    sudo apt install zsh # zsh-syntax-highlighting autojump zsh-autosuggestions 

    # use oh-my-zsh for themes
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
    # remove .zshrc created by oh-my-zsh
    rm ~/.zshrc

    # use custom theme
    ln -s "$PWD/waldron.zsh-theme" ~/.oh-my-zsh/custom/themes/waldron.zsh-theme

    # install some plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions # zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting # zsh-syntax-highlighting

    # link zsh files and dirs
    # mkdir -p ~/.zsh
    # ln -s "$PWD/.zsh" ~/.zsh
    ln -s "$PWD/.zshrc" ~/.zshrc

    ### this can be ignored now as oh-my-zsh asks you if you want to make zsh the default shell
    # # make zsh the default shell (change /bin/bash by my user to /bin/zsh in /etc/passwd)
    # LINE_TO_BE_CHANGED=$(cat /etc/passwd | grep "${USER}:")
    # NEW_LINE=$(echo $LINE_TO_BE_CHANGED | sed "s/\/bin\/bash/\/bin\/zsh/g") 
    # sudo sed -i s~$LINE_TO_BE_CHANGED~$NEW_LINE~g /etc/passwd
    # echo "changed line in /etc/passwd from $LINE_TO_BE_CHANGED to $NEW_LINE"
fi


#### nvim/tmux ####
read -p "Do you want to install neovim/tmux configuration, plugins and themes? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    ### nvim
    # ubuntu
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt install neovim

    # link nvim dir to .config dir
    mkdir -p ~/.config
    ln -s "$PWD/nvim" ~/.config/nvim

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

    # install tree-sitter-cli for Packer package tree-sitter
    cargo install tree-sitter-cli
    


    ### tmux
    sudo apt install tmux

    # link .tmux dir to ~/.tmux
    ln -s "$PWD/.tmux.conf" ~/.tmux.conf

    # install tpm (tmux package manager)
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


    ## Ignore for now... this can be run from inside tmux instead...
    # i.e. run tmux source ~/.tmux.conf or :source-file ~/.tmux.conf inside tmux
    #      then do prefix + I to install all the plugins

    # source .tmux.conf
    tmux source ~/.tmux.conf

    # install plugins from .tmux.conf (same as prefix + I when inside tmux)
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh
fi

#### Link stuff ####
read -p "Do you want to remove any existing dotfiles (e.g. .gitconfig, .profile, etc.)? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    rm -f ~/.gitconfig
    rm -f ~/.profile
    rm -f ~/.zprofile
fi
# gitconfig
ln -s "$PWD/.gitconfig" ~/.gitconfig
# profile is the same for bash (.profile) or zsh (.zprofile)
ln -s "$PWD/.profile" ~/.profile
ln -s "$PWD/.profile" ~/.zprofile
