
if [[ -n $TMUX ]]; then
  # support italic with terminfo
  # set -g default-terminal "tmux-256color"
  # export TERM='screen-256color'

  # count tmux current window panes
  # pane_count=$(tmux display-message -p '#{window_panes}')
  # if [[ $pane_count = 1 ]]; then
  #   # auto rename tmux window is off
  #   # tmux rename-window ''
  # fi
  echo in tmux
fi

if [[ $TERM = "screen" || $TERM_MANAGER = "screen" ]]; then
  # screen
  # C-a D D (quick exit)
  alias t='screen -R hi'
  alias ta='screen -R'
  alias tn='screen -S'
  alias tl='screen -list'
  alias st='screen -t'
  # 随便个可以attach的
  alias tt='screen -dRR'
else
  # Tmux
  #设置窗口的名字为hi
  alias t='tmux -2 -u attach || tmux -2 -u new-session -s hi'
  #新建一個有名字的窗口
  alias tn='tmux -2 -u new-session -s'
  # alias tmn='tmux new -s $(basename $(pwd))'
  alias tl='tmux list-sessions'
  #附上一個有名字的窗口
  # alias ta='tmux attach -t'
  alias ta='tmux attach -d -t'
  #设置tmux标签的名字，直到退出为止
  alias st='set-window-title'
fi

