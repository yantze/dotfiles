##VIM 使用说明

###常用命令-强大且要记住的功能(适用于本vim配置)
####Key
```
Ctrl+P          快速查找当前文件夹下所有子目录的文件,ctrl+j/k上下选择文件
:ag             查找当前目录下的所有文件的关键字
,gd             使用YCM的快速查找头文件定义,类似vs中的F12
,ci             注释当前行(可选中)
,cm             块注释(可选中)
key<Tab>        UltiSnip And YCM 可以自动补全，UltiSnip对py，ycm对c好一些
                <c-j/k>上下选择下一个瞄准位
<c-n><c-j/k>    用<c-n>当前选中的行，用<c-j/k>来移动行的位置(vim-multipe-cursors)
<m-j/k>         用alt/command+j/k移动当前行的位置(功能同上)
<c-n>           不停的选中<c-n>,可以执行多光标编辑
                <c-p>回到前一个,<c-x>放弃当前这个光标到下一个
                其中i,a,I,A可以在insert模式，c,s可以在normal模式，c是清除当前选中的文字
                有个小bug,就是在多光标选中模式下，要先按i或者a这个键，再按I/A
,mt             生成每个语言的ctags文件，可以通过ctrl+]跳转和ctrl+t返回
+/-             +可以扩大选择区域/-相反
,bb /,bn<type char> 按等于号对其或者自定义符号对齐
:Sw             当需要root权限保存时，不用重新打开
:DiffSaved      比较在保存文件之后修改了什么那些内容
:Man glob       查看linux关于glob的man文档(only linux/mac)
:Man glob.php   查看从php.net中访问glob的相关语法和示例(only linux/mac)
K               判断文件类型，自动调用:Man function/command name
```


####PHP补全
可以使用Ctrl+x,Ctrl+o来补全内容

####Snip
一旦你输入下面的字符，按Tab键自动补全
```
#!
class
html5
```


####Vim学习
[简明Vim练级攻略](http://coolshell.cn/articles/5426.html)

[vim游戏](http://vim-adventures.com/)



###一些常用快捷键说明
```
/xxx                    查找xxx字符串
,ci                     注释选定行(自动识别文件类型后添加注释)
,n/,p                   切换buffer的标签(因为vim的一个窗口里面有多个buffer)
                        同时设置了新的快捷键F2/F3对应,n/,p
10G                     数字10和大写的G，跳到第十行

:s/^/#                  用"#"注释当前行 ,":s/<search>/<replace>"
:%s/x/b                 在所有行替换x为b,":%s/<search>/<replace>"
:2,50s/x/b              在2~50行替换x为b
:.,+3s/x/b              在前行和当前行后面的三行，替换x为b
:set notextmode         这个可以去掉^M这个符号
:set pastetoggle        可以解决在linux命令行复制内容的时候，
                        内容被识别为vim操作和乱序缩进,在我的配置中快捷键为F4

f<char>                 查找当前行的字符
gb                      go browser，光标下如果是url链接，自动用默认浏览器打开链接，
                        如果是选中的字符串，就用浏览器搜索, ,gb是另外一个插件提供的同样功能
gf                      如果光标下是一个文件路径，则可以用vim自动打开这个文件
gd                      找到光标下的标签定义
Ctrl+Tab/Ctrl+Shift+Tab 切换vim标签
Ctrl+w,v/h              在gvim下创建多窗口
Ctrl+h/j/k/l            在gvim下切换多窗口
]p                      和p的功能差不多，但是它会自动调整被粘贴的文本的缩进去适应当前代码的位置
K                       在Man里面查找光标当前所在处的词
Ctrl+X,Ctrl+O           自动补全,ycm占用Ctrl+n/p
zz                      把当前行移到屏幕中间
```


###一些不常用但是实用的设置
```
:set display=uhex       这个是用来查看^@这种不可显示的字符，自动转换这些字符为hex进制
                        也可以ga查看当前光标的进制
,16                     转换当前文件为16进制，,r16为恢复，只有十六进制部分修改才有用
:vert command           垂直打开command中的命令,示例 :vert h manpageview
```

####Tips
```
c/c++/objc/objc++   可以使用YCM
路径补全            可以使用YCM
光标定位            <c-o/i>上下选择前一次后一次光标位.
各个语言的补全      看~/.vim/snippets
ctags               可以自行在c/php等头文件建立ctags文件
                    c比如/usr/local/include, php比如pear的包管理中
```

###debug
debug主要用vdebug插件实现
python:
pip install pydbgp
在vim中某行按F9插入断点,按F5开始debug，<leade>F5结束断点
在20秒内，执行pydbgp.py -d localhost:9000 需要debug的python文件
```
F10           step over
F11           step into
<leader><F11> step out
F1            执行代码到当前行
<leader>ec    执行当前行的代码(后期快捷键可能会变动)
```
其它语言由于暂时没有实验过，可以去查:h vdebug


###Thanks

这份vim配置的所以完成，会如此热爱vim，是看到了ruchee的vimrc的配置

其完善的配置让我感觉vim生命的质量
[ruchee](https://github.com/ruchee/vimrc)


我也参考了很多其它优秀的vim配置:
[vimfiles](https://github.com/coderhwz/vimfiles)
[dotfiles](https://github.com/luin/dotfiles)
[vimrc](https://github.com/rhyzx/vimrc)
[dotvim](https://github.com/lilydjwg/dotvim)

同时有一些技巧：
[Seven habits of effective text editing](http://www.moolenaar.net/habits.html) vim主要作者写的



###一些说明
`<leader>和<buffer>`
`<leader>`默认是一个按钮，指的是反斜杠'\'，不过我在配置中设置成了',',减少小指的负担。
`<buffer>`其实就是你当前下面的buffer而已。
`.vimrc`是vim的配置文件，我在里面引用了很多详细和实用的技巧，这个一定要循序渐进才能浑然天成
`_vimrc.bundles`是加载的插件，里面有介绍每个插件的作用

我之前学习vim的时候，收集到的一些资料，这次重新复习了里面的内容，整理了一下发布了出来，把它当成中级vim的入门手册吧
[查看](https://github.com/yantze/vimrc/blob/master/VIMdoc.md)


mac下的terminal中,可能会出现菜单栏是黑色的,可以去
```
~/.dotfiles/vimrc/vimfiles/bundle/vim-airline/autoload/airline/themes/serene.vim
```
中改一下背景颜色,把第四行的 let s:termbg = 232 改成 235

