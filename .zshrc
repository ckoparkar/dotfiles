# Path to your oh-my-zsh configuration.
#ZSH=/usr/share/oh-my-zsh/
ZSH=/home/cskksc/.oh-my-zsh/

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="csk"
#ZSH_THEME="agnoster"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
 COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git themes zsh-completions archlinux ruby zsh-syntax-highlighting)


# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
export LANG=en_US.UTF8
export EDITOR='emacsclient -t'
export BROWSER='luakit'

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
	export TERM='xterm-256color'
else
	export TERM='xterm-color'
fi

export PATH=$PATH:/home/cskksc/.gem/ruby/2.1.0/bin

######################## #Android
export PATH=$PATH:/opt/android-sdk/tools/:/opt/android-sdk/platform-tools/
export ANDROID_NDK=/home/cskksc/chai/android-ndk-r8b


# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"


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
    eval "`dircolors ~/.mydircolors`"
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

### Directories
alias ll='ls -lh'
alias la='ls -ah'
alias l='ls -lah'
alias c='clear'
alias ed='emacs --daemon'
alias e='emacsclient -t'
alias E='sudo emacsclient -t'
alias home='cd ~'
alias ..='cd ..'
alias k='exit'
alias rmr='rm -r'

### Zsh
alias eZ='emacsclient -t ~/.zshrc'
alias Z='source ~/.zshrc'
alias eB='emacsclient -t ~/.oh-my-zsh/themes/csk.zsh-theme'
alias eXT='emacsclient -t ~/.Xresources'
alias v='vim'

## Apps
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

####################

## PCL
alias pv='pcl_viewer'
export pcl_home='/home/cskksc/chai/my_pcl'
export pcl_data='/home/cskksc/chai/my_pcl/data'
kinect_record()
{
	cmd='$pcl_home/save_cloud/build/save_cloud'
	if [[ -n $2 ]]; then
		cmd=$cmd' '$1' '$2
	fi

	if [[ -n $4  ]]; then
		cmd=$cmd' '$3' '$4
	fi

	eval ${cmd}
}


## git
alias metamug_push='jgit push amazon-s3://.jgit_s3_public@metamug.gitrepo/projects/MetaScrapper cskksc'


###################################################################

source $ZSH/oh-my-zsh.sh
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
