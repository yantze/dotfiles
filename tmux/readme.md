# Tmux Config

打印所有的颜色
```bash
source tmux_colors.sh
```

```shell
# Copy and Paste
# 按 C-a [ 进入复制模式，如果有设置 setw -g mode-keys vi 的话，可按 vi 的按键模式操作。移动至待复制的文本处，按一下空格，结合 vi 移动命令开始选择，选好后按回车确认。
# 按 C-a ] 粘贴已复制的内容。
# 在 vim 的情况下，可能不能通过上面的方法复制内容，可以按住 shift 用鼠标选择要复制的内容可以复制内容到系统的粘贴板
```


```
# fix the Shift+Page Up/Down
# set -g terminal-overrides 'xterm*:smcup@:rmcup@'

# mapping the sequence for <M-Up> proved more difficult than I expected.
# set -g xterm-keys on
# After doing that, my mappings of <Esc>[1;3A seemed to work.
# tmux -v , can watch the current dir tmux log file have some specil key


# Mouse works as expected
# when open the mouse, you want to use putty copy str to system
# you can use Shift + mouse
# you can use Shift + middleclick , it is more powerful than mouse
# there also use middleclick to select to copy some thing to tmux clipboard and use click midddleclick to paste

# mouse can scroll version >= 2.1
# https://github.com/tmux/tmux/issues/495
# set -g mouse on

# https://github.com/lifepillar/vim-solarized8
# https://github.com/icymind/NeoSolarized
# hack to make vim work well in tmux
# set t_8f=[38;2;%lu;%lu;%lum
# set t_8b=[48;2;%lu;%lu;%lum

# let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
# let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"


# set 就是 set-option 的参数介绍：
# If -g is given, the global session or window option is set.
# a server option with -s, otherwise a session option.

# set -g default-terminal "tmux-256color"
# this is less same tmux -2 , the tmux -2 is more compatible
# 让终端支持斜体展示
# https://9.obelus.net/2017/05/05/italic_in_terminal_and_tmux.html

# True Color 的支持，在外面是 xterm-256color*, 在里面是 tmux-256color*
# https://github.com/tmux/tmux/issues/696
# set -g default-terminal "xterm-256color"
# set-option -ga terminal-overrides ",xterm-256color:Tc"
# set -g default-terminal 'tmux-256color'
# set-option -ga terminal-overrides ",xterm-256color:Tc"
# set -as terminal-overrides ',xterm*:Tc:sitm=\E[3m'
# set-option -ga terminal-overrides ",xterm-256color*:Tc:smso=^[[3m"
# set-option -ga terminal-overrides ",xterm-256color:Tc"


# 执行命令，比如看 Manpage、查 Perl 函数
bind m command-prompt "splitw -h 'exec man %%'"
bind e command-prompt "splitw -h 'exec %%'"
# bind @ command-prompt "splitw -h 'exec perldoc -f %%'"

bind-key u capture-pane \; save-buffer /tmp/tmux-buffer \; run-shell "$SHELL -c links /tmp/tmux-buffer"
# same function
# bind-key u capture-pane \; save-buffer /tmp/tmux-buffer \; new-window -n "links" '$SHELL -c "links< /tmp/tmux-buffer"'


# This quick snippet will have tmux notify you in the status area when a window has activity:
# setw -g monitor-activity on
# set -g visual-activity on

# bind-key -n M-c kill-pane \; select-layout
# bind-key -n M-n split-window \; select-layout


# 默认启动应用
# new -s work # 新建名为 work 的会话，并启动 mutt
# neww rtorrent # 启动 rtorrent
# neww vim # 启动 vim
# neww zsh
# selectw -t 1 # 默认选择标号为 3 的窗口


# Base useage
# new  -s SessionName -n WindowName Command
# neww -n foo/bar foo
# splitw -v -p 50 -t 0 bar
# selectw -t 2
# selectp -t 0
# would open 2 windows, the second of which would be named foo/bar and would be split vertically in half (50%) with foo running above bar. Focus would be in window 2 (foo/bar), top pane (foo).
# the base-index have effect

# some function origin base on
# https://wiki.archlinux.org/index.php/tmux

# bind V neww -n vim vim
# bind L neww -n log -t 4 'tail -f log/unicorn.stderr.log' \; splitw 'tail -f log/development.log' \; resizep -U 10 \; selectp -U \; splitw -h \; send 'unidev && bundle exec compass watch' 'C-m'
# bind R neww -n repl -t 3 \; send 'rails c' 'C-m'
# bind S source-file ~/.local/tmux/session1
```

## show-buffer, save-buffer, loadb
show-buffer will do octal encoding of C0 control characters and non-ASCII bytes (e.g. accented Latin characters, etc.)

## Res
- https://unix.stackexchange.com/questions/56477/how-to-copy-from-to-the-tmux-clipboard-with-shell-pipes
