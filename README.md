dotfiles
---

## Install
Check [Install Script](./install.sh)

## Summary
- ~/.config 用户配置文件目录
- ~/.local 本系统适配的软件目录

## Feature
- common clipboard - 系统级的共享粘贴板
- global env variable - 判断 ~/.env 内容, 设置当前的全局变量 MYENV, 通过 myenv 设置
- auto print ls - 用 cd 进入目录，自动打印当前目录内容

## bin 介绍
- composer - 指定 extension 来启动 composer,不用担心 debug 会影响速度.
- rg - 使用 grep warp 了一个方法，使用起来类似 ripgrep
- c - 复制命令输出
- xpl - 用系统的文件管理器 ui 打开指定目录

## 需要手动设置快捷键
- 设置 Don't not Distrib 快捷键： `Ctrl+Option+Command+\`
- 设置 Chrome 固定标签页 快捷键： `Ctron+Option+Command+p`

## Ref
- [Making the clipboard work between iTerm2, tmux, vim and OS X.](https://evertpot.com/osx-tmux-vim-copy-paste-clipboard/)

