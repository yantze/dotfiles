##VIM使用说明
###常用命令-比较强大且要记住的功能

####Key
```
Ctrp+P      快速查找当前文件夹下所有子目录的文件
:ag         查找当前目录下的所有文件的关键字
,gd         使用YCM的快速查找定义
,ci         注释当前行/可选中
,cm         块注释/可选中
```


####Tips
```
c/c++/objc/objc++   可以使用YCM
路径补全            可以使用YCM
```


###VIMRC的配置方法

使用本配置有两个方法：

下载zip文件:[下载地址](https://github.com/yantze/vimrc/archive/master.zip)
拷贝到vim的windows安装目录下

比如：E:\Program Files\vim

拷贝后文件的列表应该是这样：
```
+---vim74
+---vimfiles
+---script
+---_vimrc
+---_gvimrc
+---_vimrc.bundles
\---pluginchange_log.txt
```

拷贝到*nix的个人目录下
比如~/vimrc
文件列表应该是这样：
```
+---vimfiles
+---misc
+---pluginchange_log.txt
+---README.md
+---script
+---_gvimrc
+---_vimrc
\---_vimrc.bundles
```


直接使用github克隆
如果安装了git可以使用
    git clone https://github.com/yantze/vimrc.git 
可以获得相应的文件然后根据上面的文件再配置
配置完成

###接下来
如果是初学者，要学会这几个技巧
vim有很多的‘模式’，在normal模式下
jkhl: 这四个键分别代表：下上左右
按字母i，进入insert插入模式，然后就可以输入文字
按ESC键，退出insert进入normal模式
退出要先按英文冒号:然后输入q

这些是基本的规则，如果要熟练的话，需要做一些高级的练习：

[简明Vim练级攻略](http://coolshell.cn/articles/5426.html)

[vim游戏](http://vim-adventures.com/)



###一些常用快捷键说明
/xxx                    查找xxx字符串
,ci                     注释选定行(自动识别文件类型后添加注释)
,n/,p                   切换buffer的标签(因为vim的一个窗口里面有多个buffer)
10G                     数字10和大写的G，跳到第十行

:s/x/b                  用"#"注释当前行
:2,50s/x/b              在2~50行替换x为b
:.,+3s/x/b              在前行和当前行后面的三行，替换x为b
:%s/x/b                 在所有行替换x为b
:set notextmode         这个可以去掉^M这个符号
:set pastetoggle        可以解决在linux命令行复制内容的时候，内容被识别为vim操作和乱序缩进

f                       查找当前行的字符
gb                      go browser，光标下如果是url链接，自动用默认浏览器打开链接，如果是选中的字符串，就用浏览器搜索
gf                      如果光标下是一个文件链接，则可以用vim自动打开这个文件
gd                      找到光标下的标签定义
Ctrl+Tab/Ctrl+Shift+Tab 切换vim标签
Ctrl+w,v/h              在gvim下创建多窗口
Ctrl+h/j/k/l            在gvim下切换多窗口


初入门的你，以后坑肯定会遇到这两个东西 <leader>和<buffer>
<leader>默认是一个按钮，指的是反斜杠'\'，不过我在配置中设置成了',',减少小指的负担。
<buffer>其实就是你当前下面的buffer而已。

当你了解到了基本的使用方法后，你可以读看看我在.vimrc中的文档，里面有很多详细的技巧，熟悉后能和sublime和notepad++匹敌
当然_vimrc.bundles这个文件里面是需要加载的插件，里面有介绍每个插件是拿来干嘛的，也可以了解一下
我之前学习vim的时候，收集到的一些资料，这次重新复习了里面的内容，整理了一下发布了出来，就把它当成中级vim的入门手册吧，[下载地址](https://github.com/yantze/vimrc/blob/master/VIMdoc.md)。



###Thanks

这份vim配置的所以完成，会如此热爱vim，是看到了ruchee的vimrc的配置
其完善的配置让我感觉vim是如此的简单
[ruchee](https://github.com/ruchee/vimrc)


我也参考了很多的vim配置:
[vimfiles](https://github.com/coderhwz/vimfiles)
[dotfiles](https://github.com/luin/dotfiles)
[vimrc](https://github.com/rhyzx/vimrc)
[dotvim](https://github.com/lilydjwg/dotvim)

同时有一些技巧：
[Seven habits of effective text editing](http://www.moolenaar.net/habits.html) vim主要作者写的



如果有vba的vim插件,需要用vimball方式安装
用vim打开vba格式的文件，输入
:so %
即可安装，然后:q退出。
删除插件也很方便，直接在vim里输入
:RmVimball 插件名

比如我其中一个插件manviewpage.vba就是用这个方法

manviewpage有很多用法，用在php中是从php.net中查找相关的内容
在vim窗口下，:Man glob就可以查看关于glob的相关语法和示例
这个插件在linux或者mac cli下运行
因为需要安装text browser软件links或者elinks、links2也可以


