#!/bin/bash

# Install basic things (after an Ubuntu minimal install)
sudo apt-get update
sudo apt-get install vim build-essential zsh i3 curl python
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Copy config files
echo "Setting up config files..."
ln -s ~/chai/dotfiles/.zshrc ~/.zshrc
ln -s ~/chai/dotfiles/.xsessionrc ~/.xsessionrc
ln -s ~/chai/dotfiles/.Xmodmap ~/.Xmodmap
ln -s ~/chai/dotfiles/.gitcongig ~/.gitconfig
ln -s ~/chai/dotfiles/i3 ~/.config/i3
ln -s ~/chai/dotfiles/i3status/ ~/.config/i3status
cp ~/chai/dotfiles/csk-rr.zsh-theme ~/.oh-my-zsh/themes/
chsh -s /bin/zsh
echo "Done"

# Install and setup Emacs
echo "Setting up Emacs"
sudo apt-add-repository ppa:kelleyk/emacs
sudo apt-get update
sudo apt-get install emacs26
git clone git@github.com/ckoparkar/dotemacs.git ~/.emacs
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
cd ~/.emacs
cask install
