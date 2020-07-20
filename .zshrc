# Path to your oh-my-zsh configuration.
ZSH=~/.oh-my-zsh/

ZSH_THEME="csk-rr"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git themes zsh-completions nix-shell)

export LANG=en_US.UTF8
export EDITOR='vim'
unset MALLOC_PERTURB_

# Coq things
# export OPAMROOT=~/opam-coq.8.8.2
# eval `opam config env`

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


### Debian
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
  if [[ -n ${IN_NIX_SHELL} && ${IN_NIX_SHELL} != "1" ]] then
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
