一切竟在不言中
---

## install
可以參考 makefile 裏面的安裝方法

## feature
- common clipboard 系统级的共享粘贴板
- global env variable 判断 ~/.bin/env 内容设置为当前的全局变量, `echo home > ~/.bin/env`
- auto print ls 用 cd 进入目录，自动打印当前目录内容


## subtree

### add a subtree
```
# 跟 submodule 一樣，下載 subtree 並且合併（squash）成一個 commits
git subtree add --prefix wiki https://github.com/yantze/wiki.git master --squash
```

### push 
```
# 先 commit 主 repo，然後：
git remote wiki https://github.com/yantze/wiki.git
git subtree push --prefix module/wiki wiki master
```

### other
其它的方法 `https://github.com/yantze/dotfiles/Makefile` 有详细的代码.

### zsh-completions install guide

##### Include the directory in your $fpath, for example by adding in ~/.zshrc:
fpath=(path/to/zsh-completions/src $fpath)

##### You may have to force rebuild zcompdump:
rm -f ~/.zcompdump; compinit


## ref
講了用 stow 、subtree、hub、png等dotfiles 管理辦法，很強大。
- https://github.com/jcouyang/dotfiles
- https://github.com/rhyzx/.config

[Making the clipboard work between iTerm2, tmux, vim and OS X.](https://evertpot.com/osx-tmux-vim-copy-paste-clipboard/)

