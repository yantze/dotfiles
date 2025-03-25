
[ -f /etc/bashrc ] && . /etc/bashrc

# Append to the history file
shopt -s histappend

# Check the window size after each command ($LINES, $COLUMNS)
shopt -s checkwinsize

# Better-looking less for binary files
[ -x /usr/bin/lesspipe    ] && eval "$(SHELL=/bin/sh lesspipe)"

# Bash completion
[ -f /etc/bash_completion ] && . /etc/bash_completion

# Disable CTRL-S and CTRL-Q
[[ $- =~ i ]] && stty -ixoff -ixon

[ -z "$TMPDIR" ] && TMPDIR=/tmp

if [ "$PLATFORM" = Linux ]; then
  PS1="\[\e[1;38m\]\u\[\e[1;34m\]@\[\e[1;31m\]\h\[\e[1;30m\]:"
  PS1="$PS1\[\e[0;38m\]\w\[\e[1;35m\]> \[\e[0m\]"
else
  # git-prompt
  __git_ps1() { :;}
  if [ -e ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
  fi
  PS1='\[\e[34m\]\u\[\e[1;32m\]@\[\e[0;33m\]\h\[\e[35m\]:\[\e[m\]\w\[\e[1;30m\]$(__git_ps1)\[\e[1;31m\]> \[\e[0m\]'
fi

[[ -r /usr/local/etc/profile.d/bash_completion.sh ]] && . /usr/local/etc/profile.d/bash_completion.sh
if [[ $- == *i* ]]; then
  _fzf_setup_completion path git
  _fzf_setup_completion host tssh
fi

