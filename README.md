## 一切竟在不言中

### 安装
可以參考 makefile 裏面的安裝方法


###参考
https://github.com/rhyzx/.config
講了用 stow 、subtree、hub、png等dotfiles 管理辦法，很強大。https://github.com/jcouyang/dotfiles

### subtree 管理

#### substree wiki
https://github.com/yantze/wiki.git
git subtree add --prefix wiki https://github.com/yantze/wiki.git master --squash
跟 submodule 一樣，下載 subtree 並且合併（squash）成一個 commits

### push wiki
先 commit 主 repo，然後：
git remote wiki https://github.com/yantze/wiki.git
git subtree push --prefix module/wiki wiki master




暂时放在这里
##GET技能列表

```
php parse xml dom
yar: the api interface
msgpack: the binary package transmit, more like google buffer protocol
docker:step to "don't need to run SSHd in Docker containers"
d3.js:simple data display
openwrt:i can run a openwrt_x86 on hyper-v with dnsmasq ipset and so on.
qt5:step to some simple ui like xcode's storyboard.video and wave form.
ios swift:simple ui
radius:the complax config i had done.only freeradius;
memcached: the key/value storage.
redis:like memcached but more.
```





###zsh-completions install guide
#####Include the directory in your $fpath, for example by adding in ~/.zshrc:
fpath=(path/to/zsh-completions/src $fpath)

#####You may have to force rebuild zcompdump:
rm -f ~/.zcompdump; compinit



