dotfiles
---

## Install
```

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/yantze/dotfiles ~/.dotfiles
ln -s ~/.dotfiles/bin ~/.bin
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
echo '. ~/.dotfiles/zshrc/zshrc' >> ~/.zshrc

```

## Feature
- common clipboard - 系统级的共享粘贴板
- global env variable - 判断 ~/.env 内容, 设置当前的全局变量 MYENV, 通过 myenv 设置
- auto print ls - 用 cd 进入目录，自动打印当前目录内容

## bin 介绍
- composer - 指定 extension 来启动 composer,不用担心 debug 会影响速度.
- rg - ripgrep, 

## Ref
- [Making the clipboard work between iTerm2, tmux, vim and OS X.](https://evertpot.com/osx-tmux-vim-copy-paste-clipboard/)

