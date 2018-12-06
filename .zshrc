# Path to your oh-my-zsh configuration.
ZSH=~/.oh-my-zsh/

ZSH_THEME="csk-rr"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
DISABLE_LS_COLORS="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(git themes zsh-completions zsh-syntax-highlighting)

# Path configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH
export LANG=en_US.UTF8
export EDITOR='vim'
#export BROWSER='google-chrome-stable'
#export TERM='xterm-256color'
export PATH=$PATH:/home/$USER/.gem/ruby/2.1.0/bin
export PATH="/home/$USER/.cask/bin:$PATH"
export GOPATH=/home/$USER/chai/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/home/$USER/.cabal/bin/
export PATH=$PATH:/home/$USER/.local/bin/
export PATH=$PATH:/home/$USER/chai/arcanist/bin
export PATH=$PATH:/home/$USER/chai/ghc/inplace/bin
export GIBBONDIR=/home/$USER/chai/tree-velocity
unset MALLOC_PERTURB_
#source $HOME/.cargo/env
export PATH=$PATH:/opt/ghc/bin

##########################  Color Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'       # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[01;44;33m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[01;32m'       # begin underline


##########################  Color Commands
if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


#######################################################################
############################ Aliases ##################################
#######################################################################


### Pacman/Yaourt
alias Y='yaourt'
alias pac='sudo packman -S'
alias pac-remove='sudo pacman -Rs'
alias pac-search='sudo pacman -Ss'
alias pac-list='sudo pacman -Ql'
alias pac-installed='sudo pacman -Qe'
alias pac-rem-unused='sudo pacman -Rsn $(pacman -Qdtq)'

### Ubuntu
alias ulock='gnome-screensaver-command -l'
alias agu='sudo apt-get update'
alias agi='sudo apt-get install'

### Directories
alias l='ls -lah'
alias c='clear'
alias ed='emacs --daemon'
alias e='emacsclient -t'
alias E='sudo emacsclient -t'
alias home='cd ~'
alias ..='cd ..'
alias k='exit'
alias rmr='rm -r'

### Misc
alias eZ="$EDITOR ~/.zshrc"
alias Z='source ~/.zshrc'
alias v='vim'
alias g='git'

## Apps
alias monitoroff='xset dpms force off'
alias m='mplayer'
alias twitter='turses'
alias news='newsbeuter'
alias irc='weechat-curses'
alias torrentz='~/scripts/torrentz_eu.sh'
alias tpb='~/scripts/tpb.sh'
alias py27='python2.7'
alias calc='python -ic "from __future__ import division; from math import *; from random import *"'
alias ssha='eval "$(ssh-agent -s)"'
discover ()
{
	keyword=$(echo "$@" |  sed 's/ /.*/g' | sed 's:|:\\|:g' | sed 's:(:\\(:g' | sed 's:):\\):g')
	locate -ir $keyword
}

record ()
{
	ffmpeg -f x11grab -r 30 -s 1600x900 -i :0.0 -vcodec libx264 -threads 0 "$1"
}

### Advanced Copy/Move ###
#alias cp='~/scripts/cp -gR'
#alias mv='~/scripts/mv -gR'

###### Transmission CLI ######

tsm-clearcompleted()
{
    transmission-remote -l | grep 100% | grep Done | \
    awk '{print $1}' | xargs -n 1 -I % transmission-remote -t % -r ;
}

tsm-count()
{
	echo "Blocklist rules:" $(curl -s --data \
								   '{"method": "session-get"}' localhost:9091/transmission/rpc -H \
								   "$(curl -s -D - localhost:9091/transmission/rpc | grep X-Transmission-Session-Id)" \
							  | cut -d: -f 11 | cut -d, -f1) ;
}
tsm() { transmission-remote --list ;}
tsm-blocklist() { $PATH_SCRIPTS/blocklist.sh ;}
tsm-daemon() { transmission-daemon ;}
tsm-quit() { killall transmission-daemon ;}
tsm-altspeedenable() { transmission-remote --alt-speed ;}
tsm-altspeeddisable() {	transmission-remote --no-alt-speed ;}
tsm-add() { transmission-remote --add "$1" ;}
tsm-askmorepeers() { transmission-remote -t"$1" --reannounce ;}
tsm-pause() { transmission-remote -t"$1" --stop ;}
tsm-start() { transmission-remote -t"$1" --start ;}
tsm-purge() { transmission-remote -t"$1" --remove-and-delete ;}
tsm-remove() { transmission-remote -t"$1" --remove ;}
tsm-info() { transmission-remote -t"$1" --info ;}
tsm-speed()
{
	while true;do clear; transmission-remote -t"$1" -i | grep Speed;sleep 1;done ;
}
tsm-ncurse() { transmission-remote-cli ;}

###################################################################

source $ZSH/oh-my-zsh.sh
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
