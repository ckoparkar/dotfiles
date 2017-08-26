#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GPG_AGENT_INFO SSH_AUTH_SOCK

# xbindkeys
if [ `type -P xbindkeys` ]; then
    # Load custom keyboard key bindings
    xbindkeys
fi;

# xresources and xmodmap
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap

# i3
xrandr --dpi 220
# xrandr --dpi 142
feh --bg-scale ~/chai/dotfiles/wall.png
exec i3
# exec gnome-session
