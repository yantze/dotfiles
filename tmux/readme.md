# Tmux Config

打印所有的颜色
```bash
for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"
done

# 一样
for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolor%-5i\x1b[0m" $i
    if ! (( ($i + 1 ) % 8 ))
        then echo
    fi
done
```


```
# 执行命令，比如看 Manpage、查 Perl 函数
bind m command-prompt "splitw -h 'exec man %%'"
bind e command-prompt "splitw -h 'exec %%'"
#bind @ command-prompt "splitw -h 'exec perldoc -f %%'"

bind-key u capture-pane \; save-buffer /tmp/tmux-buffer \; run-shell "$SHELL -c links /tmp/tmux-buffer"
# same function
# bind-key u capture-pane \; save-buffer /tmp/tmux-buffer \; new-window -n "links" '$SHELL -c "links< /tmp/tmux-buffer"'


# This quick snippet will have tmux notify you in the status area when a window has activity:
# setw -g monitor-activity on
# set -g visual-activity on

# bind-key -n M-c kill-pane \; select-layout
# bind-key -n M-n split-window \; select-layout


#默认启动应用
#new -s work # 新建名为 work 的会话，并启动 mutt
#neww rtorrent # 启动 rtorrent
#neww vim # 启动 vim
#neww zsh
#selectw -t 1 # 默认选择标号为 3 的窗口


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
