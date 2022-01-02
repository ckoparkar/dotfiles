local return_code="%(?..%{$terminfo[bold]$fg[red]%}%? ↵%{$reset_color%})"
local user_host='%{$terminfo[bold]$fg[red]%}%n%{$reset_color%}'
local current_dir='%{$terminfo[bold]%} %~%{$reset_color%}'
local git_branch='$(git_prompt_info)%{$reset_color%}'
local ret_status="%(?:%{$terminfo[bold]$FG[002]%}➜ :%{$terminfo[bold]$fg[red]%}➜ %s)"

PROMPT="${ret_status} ${user_host} ${current_dir} ${git_branch} [%T]
%# "

ZSH_THEME_GIT_PROMPT_PREFIX="%{$terminfo[bold]$fg[blue]%}git:("
ZSH_THEME_GIT_PROMPT_SUFFIX=") %{$reset_color%}"
