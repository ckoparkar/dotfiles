#!/bin/bash

set -eo pipefail

# Install basic things (after an Ubuntu minimal install)
sudo apt-get update
sudo apt-get install vim build-essential zsh i3 curl python feh gnome-screensaver xbindkeys
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Link config files
echo "Setting up config files..."
ln -s ~/chai/dotfiles/.zshrc ~/.zshrc
ln -s ~/chai/dotfiles/.xsessionrc ~/.xsessionrc
ln -s ~/chai/dotfiles/.Xmodmap ~/.Xmodmap
ln -s ~/chai/dotfiles/.gitcongig ~/.gitconfig
mkdir -p ~/.config/i3 ~/.config/i3status
ln -s ~/chai/dotfiles/i3/config ~/.config/i3/config
ln -s ~/chai/dotfiles/i3status/config ~/.config/i3status/config
ln -s ~/chai/dotfiles/csk-rr.zsh-theme ~/.oh-my-zsh/themes/csk-rr.zsh-theme
chsh -s /bin/zsh
echo "Done"

# Install and setup Emacs
echo "Setting up Emacs"
sudo apt-add-repository ppa:kelleyk/emacs
sudo apt-get update
sudo apt-get install emacs26
git clone https://github.com/ckoparkar/dotemacs.git
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
cd ~/.emacs.d
cask install
