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
plugins=(git themes zsh-completions zsh-syntax-highlighting nix-shell)

export LANG=en_US.UTF8
export EDITOR='vim'

# Path configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH
#export BROWSER='google-chrome-stable'
#export TERM='xterm-256color'
export PATH=$PATH:$HOME/.gem/ruby/2.1.0/bin
export GOPATH=$HOME/chai/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.cabal/bin/
export PATH=$PATH:$HOME/.local/bin/
export PATH=$PATH:$HOME/chai/arcanist/bin
export PATH=$PATH:$HOME/chai/ghc/inplace/bin
export PATH=$PATH:$HOME/.cask/bin
export GIBBONDIR=$HOME/chai/tree-velocity
unset MALLOC_PERTURB_
source $HOME/.cargo/env
export PATH=$PATH:/opt/ghc/bin

# Coq things
# export OPAMROOT=~/opam-coq.8.8.2
# eval `opam config env`

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

### Misc
alias rm='rm -i'
alias l='ls -lah'
alias c='clear'
alias ..='cd ..'
alias k='exit'
alias rmr='rm -r'
alias ed='emacs --daemon=ed'
alias e='emacsclient -t --socket-name ed'
alias E='sudo emacsclient -t'
alias eZ="$EDITOR ~/.zshrc"
alias Z='source ~/.zshrc'
alias v='vim'
alias g='git'

hidpi () {
    xrandr --output eDP-1 --dpi 192
    i3-msg restart
}

lodpi () {
    xrandr --output eDP-1 --dpi 96
    i3-msg restart
}

record () {
    ffmpeg -f x11grab -r 30 -s 1920x1080 -i :0.0 -vcodec libx264 -threads 0 "$1"
}


###################################################################
# Phoenix things

function prompt_nix_shell_precmd {
  if [[ -n ${IN_NIX_SHELL} && ${IN_NIX_SHELL} != "0" ]] then
    if [[ -n ${IN_WHICH_NIX_SHELL} ]] then
      NIX_SHELL_NAME=": ${IN_WHICH_NIX_SHELL}"
    fi
    NIX_PROMPT="%F{8}[%F{3}nix-shell${NIX_SHELL_NAME}%F{8}]%f"
    if [[ $PROMPT != *"$NIX_PROMPT"* ]] then
      PROMPT="$NIX_PROMPT $PROMPT"
    fi
  fi
}

# Show [nix-shell] in the prompt
function prompt_nix_shell_setup {
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd prompt_nix_shell_precmd
}

if [ "$HOSTNAME" = "phoenix.sice.indiana.edu" ]; then
    export PATH="/l/racket-7.2/bin:$PATH"
    source $HOME/.nix-profile/etc/profile.d/nix.sh
    prompt_nix_shell_setup
fi


###################################################################

source $ZSH/oh-my-zsh.sh
