# ZSH Theme - Preview: http://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
local return_code="%(?..%{$terminfo[bold]$fg[red]%}%? ↵%{$reset_color%})"

local user_host='%{$terminfo[bold]$fg[red]%}%n%{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[yellow]%} %~%{$reset_color%}'
local git_branch='$(git_prompt_info)%{$reset_color%}'

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"

PROMPT="${ret_status} ${user_host} ${current_dir} ${git_branch}
%# "
RPS1="%{$reset_color%}${return_code} %{$terminfo[bold]$fg[yellow]%} [%T] %{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
