##说明

###安装
这个软件需要先安装vim最新版本
windows安装gvim
[官网vim7.4](ftp://ftp.vim.org/pub/vim/pc/gvim74.exe)

*nix(unix,linux)安装vim
默认都安装了vim,但版本不一定高
vim支持7.2+版本以上，对于最新版本，配置会有更多的特性

###然后
使用本配置有两个方法：

下载zip文件:[下载地址]()
拷贝到vim的windows安装目录下
比如：E:\Program Files\vim
拷贝后文件的列表应该是这样：
+---vim74
+---vimfiles
+---script
+---_vimrc
+---_gvimrc
+---_vimrc.bundles
\---pluginchange_log.txt

拷贝到*nix的个人目录下
比如~/.config
文件列表应该是这样：
+---vimfiles
+---misc
+---pluginchange_log.txt
+---README.md
+---script
+---_gvimrc
+---_vimrc
\---_vimrc.bundles


直接使用github克隆
如果安装了git可以使用
git clone https://github.com/yantze/.config.git 
可以获得相应的文件然后根据上面的文件再配置

###接下来
现在就可以用了，have enjoy!
如果是初学者，要学会这几个技巧
vim有很多的‘模式’，在normal模式下
jkhl: 这四个键分别代表：下上左右
按字母i，进入insert插入模式，然后就可以输入文字
按ESC键，退出insert进入normal模式
退出要先按英文冒号:然后输入q

这些是基本的规则，如果要熟练的话，需要做一些高级的练习：
[简明Vim练级攻略](http://coolshell.cn/articles/5426.html)
[vim游戏](http://vim-adventures.com/)


下次会配上我自己写的vim文档,不过基础还是需要上面的练习.



这份vim配置的所以完成，会如此热爱vim，是看到了ruchee的vimrc的配置
其完善的配置让我感觉vim是如此的简单
[ruchee](https://github.com/ruchee/vimrc)


我也参考了很多的vim配置:
[vimfiles](https://github.com/coderhwz/vimfiles)
[dotfiles](https://github.com/luin/dotfiles)
[.config](https://github.com/rhyzx/.config)
