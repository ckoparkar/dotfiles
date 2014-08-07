# ZSH Theme - Preview: http://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
local return_code="%(?..%{$terminfo[bold]$fg[red]%}%? ↵%{$reset_color%})"

local user_host='%{$terminfo[bold]$fg[red]%}%n%{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[yellow]%} %~%{$reset_color%}'
local rvm_ruby=''
if which rvm-prompt &> /dev/null; then
  rvm_ruby='%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    rvm_ruby='%{$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
  fi
fi
local git_branch='$(git_prompt_info)%{$reset_color%}'

PROMPT="╭── %{$terminfo[bold]$fg[green]%}☢ ${user_host} %{$terminfo[bold]$fg[green]%}☢ ${current_dir} ${rvm_ruby} ${git_branch}
╰── %# "
RPS1="%{$reset_color%}${return_code} %{$terminfo[bold]$fg[yellow]%} [%T] %{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"