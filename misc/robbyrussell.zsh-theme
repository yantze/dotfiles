#local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
#PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
#cyan 土黄色
#%c代表的是当前路径
#%3~代表的是当前主目录使用~，其余的是用绝对路
#
#no git status
#PROMPT='${ret_status}%{$fg_bold[green]%}%p%{$fg[green]%}%3~%{$fg_bold[blue]%} $(git_prompt_info)%{$fg_bold[blue]%}% $%{$reset_color%}'

local ret_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%}%s)"
PROMPT='${ret_status}%{$fg_bold[green]%}%p%{$fg[green]%}%3~%{$fg_bold[blue]%} $%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
