# Path to your oh-my-zsh configuration.
ZSH=/Users/chaitanya/.oh-my-zsh/

ZSH_THEME="robbyrussell"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
DISABLE_LS_COLORS="true"


# Uncomment following line if you want red dots to be displayed while waiting for completion
 COMPLETION_WAITING_DOTS="true"

plugins=(git themes zsh-completions archlinux ruby zsh-syntax-highlighting rvm)

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
export LANG=en_US.UTF8
export EDITOR='emacsclient -t'

export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/Users/chaitanya/.cask/bin:$PATH"

#Color Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'       # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[01;44;33m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[01;32m'       # begin underline


#Color Commands
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
#alias eB='emacsclient -t ~/.oh-my-zsh/themes/csk.zsh-theme'
alias eXT='emacsclient -t ~/.Xresources'
alias v='vim'

##
alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"

source $ZSH/oh-my-zsh.sh
