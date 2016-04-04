# VIM 文档
> Vim 有很强的对称性观念，这份文档很多都来自其他 vimer 的教程。

整理： [yantze](http://github.com/yantze)

## 掌握这些可以高效使用 /*{{{*/
> 把本项目的 `_vimrc` 看完就可以玩转 vim 了。下面都是一些补充知识。

### 常用命令 /*{{{*/

`数字`是很有意义
```
删除50  = 50dd
下移20  = 20j
```

书签
```
`.          跳转至上次编辑位置
``          跳转上一次的位置
ma          把当前位置存成标签 `a`
`a          跳转到标签 `a` 处
```


宏
```
qx          开始记录宏，并将结果存入寄存器x，x代表1-9的数字
q           退出记录模式
@x          播放记录在x寄存器中的宏命令
```

寄存器
```
"a          将内容放入/存入a寄存器，可以支持多粘贴板
```
附：系统寄存器，名称为+，从系统粘贴板粘贴到vim中的命令为"+p。此处的+不表示操作符，二十一个寄存器。


跳转
```
fx          在当前行中找x字符，找到了就跳转至
;           重复上一个f命令，而不用重复的输入fx
tx          与fx类似，但是只是跳转到x的前一个字符处
Fx          跟fx的方向相反
),(         跳转到上/下一个语句
Ctrl+i / Ctrl+o 跳到之前的那个光标的位置，对称Ctrl+Shift+i or o
```

快速选中括号内的字符串
```
va( = vaw 括号之外，ext：'{'
vi( = vae 括号之内， ext：'{'
```


基础知识
```
w           跳动单词到第一个字母上
e           跳动单词到最后一个字母上
b           跳动到上一个单词前
C-F         屏幕内容向下
C-B         屏幕内容向上
G           文件的最后一行
gg          文件的开头
I           行首插入
A           行末插入
o           后空行插入
O           前空行插入
yy          复制一行
p           在行后粘贴，可粘贴上一次删除的内容
P           在行前粘贴
dw          直接删除一个单词，是在光标后的
3x          删除后面三个字符，X相反
gg=G        格式化
cw          就是删除字符进入
r           再输入一个字符可以替换
v           可视化选择后再输入r可以全部替换
s           删除当前,并进入插入模式
Shift+3     显示当前光标下，相同的字符，并且高亮
Shift+8     相反
Shift+5     可以跳到当前括号的对应尾括号
H           光标移劢到这个屏幕癿最上方那一行癿第一个字符
M           光标移劢到这个屏幕癿中夬那一行癿第一个字符
L           光标移劢到这个屏幕癿最下方那一行癿第一个字符
n<space>    向右移动n个字符
nG          移动到n行
n<enter>    光标向下移动n行
Ctrl+a      自动给数字加1
fenc=cp936  enc(encoding),fenc(fileencoding),fencs(fileencodings)

:e!         强行重编辑更便捷。
cw:         删除一个单词并进入插入模式
cc:         删除一行并进入插入模式。

zc          折叠代码
zo          打开折叠的代码
za          打开或关闭当前折叠
zM          关闭所有折叠
zR          打开所有折叠

zz          将当前行滚动到屏幕中央
gi          incredibly handy goes to Insert mode where you left it
            last time scenario: edit something, exit Insert, go look at something else,
            then  gi back to restart editing
```


```
~        切换大小写，当前字符
g~iw     切换当前字的大小写
gUiw     将当前字变成大写
guiw     将当前字变成小写
```

```
aw     选中一个字
ab     选中括号中的所有内容，包括括号本身
aB     选中{}括号中的所有内容
ib     选中括号中的内容，不含括号
iB     选中{}中的内容，不含{}
```


查找
```
/word  ?word 分别可以向后向前搜素内容
n，N 分别可以对之前用/搜索过得字符向后，向前搜索
:100,200s/word1/word2 /g  100到200行之间找 word1，改为 word2
```

替换
```
:1,$s/word1/word2/g 首行到末行找 word1，并将该字符串为 word2
:1,$s/word1/word2/gc 首行到末行找 word1，并将该字符串为 word2 且要confirm

:s/word1/word2
#将word1字符替换为word2 (只替换在光标所在的行)
:1,.s/word.*/word2
将文中第一行到当前行中，第一个的word*替换掉
:1,.s/word1.*/word2/g
将文中第一行到当前行中，所有的word*替换掉
:1,$s/word.*/word2/g  OR  :%s/word.*/word2/g
将第一行到最后一行所有出现的word替换
:g/text1/s/text2/text3
查找包含 text1 的行，用 text3 替换 text2
:g/^/exec "s/^/".strpart(line(".")." ", 0, 4)  在行首插入行号
```


注释行
```
:s/^/#      用"#"注释当前行
:2,5s/^ /#  在2~5行首添加"#"注释
:.,+3s/^/#  用"#"注释当前行和当前行后面的三行
:%s/^/#     用"#"注释所有行
```
删除所有注释行
```
:g/^#$//g
```
删除所有的空白行
```
:g/^$/d
或者在非交互情况下用shell执行
echo "wq"|ex -c "g/^$/d" filename
其中/d代表的是删除行内容，更多的介绍请用:help global查看
```








```
r, R (Replace mode): r 只代一个字符一次；R一直代光标所在，按下 ESC 为止

:r [filename] 在编辑数据中，读入另一个档案的数据，并且放在游标后面
:n1,n2 w [filename] 将 n1 到 n2 癿内容储存成 filename 这个档案。
```


目录操作
```
可以查看Vim所在的当前工作目录:
:pwd
切换到其它目
:cd dir
注意：如果没有指定目录，那么使用:cd命令，在Linux下，将回到home用户主目录；而在Windows下，则会显示当前工作目录。
如果想要回到前一个工作目录，可以使用  :cd -
如果在正文中需要用到系统中的路径
ctrl+x,ctrl+f
用ctrl+n, ctrl+p来切换
```


```
Ctrl+u 删除光标前的一行， Ctrl+w 删除前面一个单词
```


```
(           移到句子的开头
)           移到句子的结尾
{           移到段落的开头
}           移到下一个段落的开头
0           移到当前行的第一列
```


/*}}}*/

/*}}}*/

## practic experience /*{{{*/

主要的一些查询功能
:verbose map <所要查找的快捷键>
:echo $TERM
:verbose set term?
:set termcap
使用Ctrl-v来查看一些按钮的原来的代码

####配置里面<leader>rsl不同的实现方法
#####执行选中行命令
" function RunTheSelectLinesInSystem() range
"     echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| sh ')
" endfunction
" com -range=% -nargs=0 RCurLine :<line1>,<line2>call RunTheSelectLinesInSystem()
" you can use the method :'<,'>RCurLine

#####sed method
!!sed s/<search>/<replace>/<num>

#####get some lines out or in
To read in from file-name.txt into the current buffer
:read file-name.txt

To append the range of line 1 to line 300 from the current buffer to file-to-append.txt
:1,300write >> file-to-append.txt

You can also use marks instead of line numbers such as the visual marks
:'<,'>write >> file-to-append.txt

Or can write some line to a new file
:1,300w file.txt

#####row control
刪除包含有空格組成的空行： g/^\s*$/d
删除空白行： g/^$/d
删除以#开头的： s/^#.*$//g
删除以空格或tab開頭到結尾的空行 g/^[ |\t]*$/d
在行头加注释： s/^/#/g
:n,$s/string/sky/g 替换第n行开始到最后一行中每一行所有string为sky
删除以//的开头的注释行： cat a2.C | grep -v '//' > a3.C
g/pattern/d 是找到pattern, 删之
v/pattern/d 是找到非pattern,删之

#####row sort
排序并删除重复行 :sort u

#####添加选项到guivim的菜单栏
比如下面的是添加modeline到文件末尾
amenu Edit.Insert\ &modeline <C-\><C-N>ggOvim:ff=unix ts=4 ss=4<CR>vim60:fdm=marker<Esc>


###参考
http://www.richardzhong.com/category/vim/

### 拼写检查
```
set spell
设置后Vim会高亮拼写错误的单词。将光标移至错误单词，输入z=查看建议拼写。
autocmd FileType tex setlocal spell spelllang=en_us
spell spelllang=en, de
:set spell    启用拼写检查
:set nospell  关闭拼写检查
]s    移动到下一个拼写错误处
[s    移动到上一个拼写错误处
z=    选择正确的拼写
zg    添加用户拼写
```

### grammer语法检查
```
" en/fr/ge.. 
" 必须下载https://www.languagetool.org/zh/里面的检查软件
Plugin 'LanguageTool'
" :LanguageToolCheck
" Pressing <Enter>
" :LanguageToolClear
```

### 函数变量
```
let s:w_mydictwin=0
function! Mydict()
    if s:w_mydictwin
        let s:w_mydictwin=0
        close
        file
        return
    endif
    let s:w_mydictwin=1
    let fwords=getreg("z")
    setlocal buftype=nofile bufhidden=hide noswapfile
endfunction
```

###File opening tips
```
vim file1 file2 … -o opens file1, file2, … in stacked windows
vim file1 file2 … -O opens file1, file2, … side by side
vim file + opens file and move the cursor to the last line.
```

### 
```
把找到的内容放在文件头
g/pattern/t0
把找到的内容放在文件尾
g/pattern/t$
把找到的内容整行放在文件尾
g/pattern/m$
```

输入分割线---
```
72i-<esc>
所有行倒序
:g/^/m0
行间插入空行
:g/^/pu _
```


格式化那些整行的代码
```
:%s/{/\r{\r/g
:%s/}/\r}\r/g
:%s/;/;\r/g
```

^M是windows换行符,删除方法
```
:%s/\r/\r/g
:%s/^M$//g
%  指匹配整个文件
s  是置换的意思
^M 注意要用 Ctrl+V, Ctrl+M来输入
M  后的'$'代表匹配行尾的内容
g  则表示每行中匹配到的内容都要置换
```

统计匹配字符串的个数
```
:%s/字符串//gn
```

块编辑
```
esc
0       跳到行首
ctrl+v  可视块模式
jjj     下移3行
I       进入插入模式
//
Esc
```

unix 与 dos 换行符切换
```
set ff=unix
```

/*}}}*/

## Manual /*{{{*/

### 功能介绍 /*{{{*/

1. 查找/*{{{*/
   /xxx(?xxx)       表示在整篇文档中搜索匹配xxx的字符串, / 表示向下查找, ? 表示
                    向上查找.其中xxx可以是正规表达式,关于正规式就不多说了.
                    一般来说是区分大小写的, 要想不区分大小写, 那得先输入
                    :set ignorecase
                    查找到以后, 再输入 n 查找下一个匹配处, 输入 N 反方向查找.
   *(#)             当光标停留在某个单词上时, 输入这条命令表示查找与该单词匹配的
                    下(上)一个单词. 同样, 再输入 n 查找下一个匹配处, 输入 N 反方
                    向查找.
   g*(g#)           此命令与上条命令相似, 只不过它不完全匹配光标所在处的单词, 而
                    是匹配包含该单词的所有字符串.
   gd               本命令查找与光标所在单词相匹配的单词, 并将光标停留在文档的非注释段中第一次出现这个单词的地方.
   %                本命令查找与光标所在处相匹配的反括号, 包括 () [] {}
   f(F)x            本命令表示在光标所在行进行查找, 查找光标右(左)方第一个x字符.
                    找到后:
                    输入 ; 表示继续往下找
                    输入 , 表示反方向查找
/*}}}*/

2. 快速移动光标/*{{{*/
    在 vi 中, 移动光标和编辑是两件事, 正因为区分开来, 所以可以很方便的进行光标定
位和编辑. 因此能更快一点移动光标是很有用的.
   w(e)             移动光标到下一个单词.
   b                移动光标到上一个单词.
   0            移动光标到本行最开头.
   ^                移动光标到本行最开头的字符处.
   $                移动光标到本行结尾处.
   H                移动光标到屏幕的首行.
   M                移动光标到屏幕的中间一行.
   L                移动光标到屏幕的尾行.
   gg               移动光标到文档首行.
   G                移动光标到文档尾行.
   c-f              (即 ctrl 键与 f 键一同按下) 本命令即 page down.
   c-b              (即 ctrl 键与 b 键一同按下, 后同) 本命令即 page up.
   ''               此命令相当有用, 它移动光标到上一个标记处, 比如用 gd, * 等查
                    找到某个单词后, 再输入此命令则回到上次停留的位置.
   '.               此命令相当好使, 它移动光标到上一次的修改行.
   `.               此命令相当强大, 它移动光标到上一次的修改点.
   %                跳到与当前括号匹配的括号处，如当前在{，则跳转到与之匹配的}处
   w                跳到下一个字首，按标点或单词分割
   W                跳到下一个字首，长跳，如end-of-line被认为是一个字
   e                跳到下一个字尾
   E                跳到下一个字尾，长跳
   b                跳到上一个字
   B                跳到上一个字，长跳
   0                跳至行首，不管有无缩进，就是跳到第0个字符
   ^                跳至行首的第一个字符
   $                跳至行尾
   gg               跳至文件的第一行
   gd               跳至当前光标所在的变量的声明处
   [N]G             跳到第N行，如0G，就等价于gg，100G就是第100行
   fx               在当前行中找x字符，找到了就跳转至
   ;                重复上一个f命令，而不用重复的输入fx
   tx               与fx类似，但是只是跳转到x的前一个字符处
   Fx               跟fx的方向相反
   ),(              跳转到上/下一个语句
   *                查找光标所在处的单词，向下查找
   #                查找光标所在处的单词，向上查找
   H                移动光标到当前屏幕上最上边的一行
   M                移动光标到当前屏幕上中间的一行
   L                移动光标到当前屏幕上最下边的一行

/*}}}*/

3. 拷贝, 删除与粘贴/*{{{*/
    在 vi 中 y 表示拷贝, d 表示删除, p 表示粘贴. 其中拷贝与删除是与光标移动命令
结合的, 看几个例子就能够明白了.
   yw               表示拷贝从当前光标到光标所在单词结尾的内容.
   dw               表示删除从当前光标到光标所在单词结尾的内容.
   y0               表示拷贝从当前光标到光标所在行首的内容.
   d0               表示删除从当前光标到光标所在行首的内容.
   y$               表示拷贝从当前光标到光标所在行尾的内容.
   d$               表示删除从当前光标到光标所在行尾的内容.
   yfa              表示拷贝从当前光标到光标后面的第一个a字符之间的内容.
   dfa              表示删除从当前光标到光标后面的第一个a字符之间的内容.
   特殊地:
   yy               表示拷贝光标所在行.
   dd               表示删除光标所在行.
   D                表示删除从当前光标到光标所在行尾的内容.
]p     有缩进的粘贴，vim会自动调节代码的缩进
"a     将内容放入/存入a寄存器，可以支持多粘贴板
附：比如常用的一个寄存器就是系统寄存器，名称为+，所以从系统粘贴板粘贴到vim中的命令为"+p,注意此处的+不表示操作符，二十一个寄存器。
移动光标
在vim中移动光标跟其他的编辑器中有很大的区别，不过一旦学会了，就会飞速的在文本中移动了。
   关于拷贝, 删除和粘贴的复杂用法与寄存器有关, 可以自行查询.

编辑
r     替换一个字符
J     将下一行和当前行连接为一行
cc     删除当前行并进入编辑模式
cw     删除当前字，并进入编辑模式
c$     擦除从当前位置至行末的内容，并进入编辑模式
s     删除当前字符并进入编辑模式
S     删除光标所在行并进入编辑模式
xp     交换当前字符和下一个字符
u     撤销
ctrl+r     重做
.     重复上一个编辑命令
~     切换大小写，当前字符
g~iw     切换当前字的大小写
gUiw     将当前字变成大写
guiw     将当前字变成小写
>>     将当前行右移一个单位
<<     将当前行左移一个单位(一个tab符)
==     自动缩进当前行/*}}}*/

4. 数字与命令/*{{{*/
    在 vi 中数字与命令结合往往表示重复进行此命令, 若在扩展模式的开头出现则表示行
号定位. 如:
   5fx              表示查找光标后第 5 个 x 字符.
   5w(e)            移动光标到下五个单词.
   5yy              表示拷贝光标以下 5 行.
   5dd              表示删除光标以下 5 行.
   y2fa             表示拷贝从当前光标到光标后面的第二个a字符之间的内容.
   :12,24y          表示拷贝第12行到第24行之间的内容.
   :12,y            表示拷贝第12行到光标所在行之间的内容.
   :,24y            表示拷贝光标所在行到第24行之间的内容. 删除类似.

/*}}}*/


5. 快速输入字符/*{{{*/
    在 vi 中, 不要求你输入每一个字符, 可以有很多种方法快速输入一些字符.
    使用 linux/unix 的同学一定有一个经验, 在命令行下输入命令时敲入头几个字符再按
TAB 系统就会自动将剩下的字符补齐, 假如有多个匹配则会打印出来. 这就是著名的命令
补齐(其实windows中也有文件名补齐功能). vi 中有许多的字符串补齐命令, 非常方便.
   c-p(c-n)         在编辑模式中, 输入几个字符后再输入此命令则 vi 开始向上(下)搜
                   索开头与其匹配的单词并补齐, 不断输入此命令则循环查找. 此命令
                   会在所有在这个 vim 程序中打开的文件中进行匹配.
   c-x-l            在编辑模式中, 此命令快速补齐整行内容, 但是仅在本窗口中出现的
                   文档中进行匹配.
   c-x-f            在编辑模式中, 这个命令表示补齐文件名. 如输入:
                   /usr/local/tom 后再输入此命令则它会自动匹配出:
                   /usr/local/tomcat/
   abbr             即缩写. 这是一个宏操作, 可以在编辑模式中用一个缩写代替另一个
                   字符串. 比如编写java文件的常常输入 System.out.println, 这很
                   是麻烦, 所以应该用缩写来减少敲字. 可以这么做:
                   :abbr sprt System.out.println
                   以后在输入sprt后再输入其他非字母符号, 它就会自动扩展为System.
                   out.println
/*}}}*/

6. 替换/*{{{*/
    替换是 vi 的强项, 因为可以用正规表达式来匹配字符串.以下提供几个例子.
   :s/aa/bb/g       将光标所在行出现的所有包含 aa 的字符串中的 aa 替换为 bb
   :s/\/bb/g   将光标所在行出现的所有 aa 替换为 bb, 仅替换 aa 这个单词
   :%s/aa/bb/g      将文档中出现的所有包含 aa 的字符串中的 aa 替换为 bb
   :12,23s/aa/bb/g 将从12行到23行中出现的所有包含 aa 的字符串中的 aa 替换为 bb
   :12,23s/^/#/     将从12行到23行的行首加入 # 字符
   :%s= *$==        将所有行尾多余的空格删除
   :g/^\s*$/d        将所有不包含字符(空格也不包含)的空行删除.
/*}}}*/

7. 多文件编辑/*{{{*/
    在一个 vim 程序中打开很多文件进行编辑是挺方便的.
   :sp(:vsp) 文件名     vim 将分割出一个横(纵)向窗口, 并在该窗口中打开新文件.
                       从 vim6.0 开始, 文件名可以是一个目录的名称, 这样, vim 会
                       把该目录打开并显示文件列表, 在文件名上按回车则在本窗口打
                       开该文件, 若输入 O 则在新窗口中打开该文件, 输入 ? 可以看
                       到帮助信息.
   :e 文件名            vim 将在原窗口中打开新的文件, 若旧文件编辑过, 会要求保存.
   c-w-w                vim 分割了好几个窗口怎么办? 输入此命令可以将光标循环定位
                       到各个窗口之中.
   :ls                  此命令查看本 vim 程序已经打开了多少个文件, 在屏幕的最下方
                       会显示出如下数据:
                       1    %a       "usevim.html"          行 162
                       2    #        "xxxxxx.html"          行 0
                       其中:
                       1                表示打开的文件序号, 这个序号很有用处.
%a               表示文件代号, % 表示当前编辑的文件,
                                       # 表示上次编辑的文件
                       "usevim.html"    表示文件名.
                       行 162           表示光标位置.
   :b 序号(代号)        此命令将指定序号(代号)的文件在本窗口打开, 其中的序号(代号)
                       就是用 :ls 命令看到的.
   :set diff            此命令用于比较两个文件, 可以用
                       :vsp filename
                       命令打开另一个文件, 然后在每个文件窗口中输入此命令,就能看
                       到效果了.
/*}}}*/

8.宏替换/*{{{*/
    vi 不仅可以用 abbr 来替换文字, 也可以进行命令的宏定义. 有些命令输起来很费劲,
因此我把它们定义到 - 上, 这样就很方便了.这些配置可以预先写到 ~/.vimrc
(windows 下为 $VIM/_vimrc) 中, 写进去的时候不用写前面的冒号.
   :nmap  :nohls               取消被搜索字串的高*r>   :nmap  w                   命令模式下转移光标到不同窗口
   :imap                  输入模式下运行
   :nmap  :%s= *$==           删除所有行尾多余的空格.
   :imap                同上
   :java 中: (注, 这里为什么说 java 中, 因为以下定义对其他文件格式不起作用, 下文
             会说到如何实现这一点)
   :nmap  :comp javac:mak -d . %
        此命令用 javac 编译 java 文件, 它会自动将光标定位到出错点. 不过这需要定
        义一个 javac.vim 文件在 $VIM/compiler 下, 在 javac.vim 里面只有两行字:
           setlocal makeprg=javac
           setlocal errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
   :nmap  :comp ant:mak
        此命令用 ant 编译 java 文件, 它会自动将光标定位到出错点. 一般来说, 安装
        vim 后已经有了compiler/ant.vim文件, 因此这个命令可以直接使用. 但是需要
        在当前目录下有 build.xml 文件, 当然还必须安装 ant 才行.
   :nmap  :cl                  此命令用于查看所有的编译错误.
   :imap
   :nmap  :cc                  此命令用于查看当前的编译错误.
   :imap
   :nmap  :cn                  此命令用于跳到下一个出错位置.
   :imap
   :nmap  :cp                  此命令用于跳到上一个出错位置.
   :imap
   :nmap  :JavaBrowser
        此命令用于在窗口左部分割出一个新窗口, 里面的内容是 java 的资源树, 包括
        本文件中出现的类, 类的成员变量及成员方法, 就好像 JCreator 表现的那样.
        在这个窗口中输入 ? 会看到帮助. 嘿嘿, 很好用, 不过需要 ctags 支持.
   :imap  /*}}}*/

9. TAB/*{{{*/
    TAB 就是制表符, 单独拿出来做一节是因为这个东西确实很有用.
    >                   输入此命令则光标所在行向右移动一个 tab.
    5>>                  输入此命令则光标后 5 行向右移动一个 tab.
    :12,24>              此命令将12行到14行的数据都向右移动一个 tab.
    :12,24>>             此命令将12行到14行的数据都向右移动两个 tab.
    那么如何定义 tab 的大小呢? 有人愿意使用 8 个空格位, 有人用4个, 有的用2个.
    有的人希望 tab 完全用空格代替, 也有的人希望 tab 就是 tab. 没关系, vim 能
    帮助你.以下的设置一般也都先写入配置文件中, 免得老敲.
    :set shiftwidth=4    设置自动缩进 4 个空格, 当然要设自动缩进先.
    :set sts=4           即设置 softtabstop 为 4. 输入 tab 后就跳了 4 格.
    :set tabstop=4       实际的 tab 即为 4 个空格, 而不是缺省的 8 个.
:set expandtab       在输入 tab 后, vim 用恰当的空格来填充这个 tab.
/*}}}*/

10. autocmd/*{{{*/
     这个命令十分的强大, 可以用这个命令实现对不同的文件格式应用不同的配置; 可以
在新建文件时自动添加上版权声明等等. 这些命令一般定义在 ~/.vimrc 这样的配置文件
里面. 由于他很强大, 所以我不能给出很具体的说明, 只能举几个例子, 详细的请看帮助.
   :autocmd!                删除所有之前的自动命令.
   autocmd FileType         java   source ~/.vim/files/java.vim
   autocmd FileType         java   source ~/.vim/files/jcommenter.vim
     以上两条命令让我在打开 java 文件时才应用后面提到的两个配置文件.
   autocmd BufNewFile       *.java   0r ~/.vim/files/skeletons/java.skel
     以上这条命令让我在新建 java 文件时自动加入 java.skel 文件的内容.
   autocmd BufNewFile       *.java   normal gnp
     以上这条命令让我在新建 java 文件时自动运行 gnp 命令, 这个命令进行一些特殊化
     处理, 比如将新 java 文件中的 __date__ 替换成今天的日期什么的.

    set suffixes=.bak,~,.o,.h,.info,.swp,.aux,.bbl,.blg,.dvi,.lof,.log,.lot,.ps,.toc
    这样在vim中打开文件时, 按 tab 键补齐文件名时它会忽略上述文件.
/*}}}*/

11. 多标签功能/*{{{*/
1、打开新标签页
启动 Vim 时用 "vim -p filename ..."
:tabe[dit] *:tabe**:tabedit**:tabnew*
:tabnew 在当前标签页之后打开带空窗口的新标签页。

:tabe[dit] [++opt] [+cmd] {file}
:tabnew [++opt] [+cmd] {file}
打开新标签页并编辑 {file}，其余和 |:edit| 类同。

:tabf[ind] [++opt] [+cmd] {file}*:tabf**:tabfind*
打开新标签页并编辑 'path' 里的 {file}，其余和 |:find| 类同。
{仅当编译时加入 |+file_in_path| 特性才有效}

:[count]tab {cmd}*:tab*
执行 {cmd}，如果它打开新窗口，使用新标签页代替。不能用于
|:diffsplit|、|:diffpatch|、|:execute| 和 |:normal|。
如果省略 [count]，标签页出现在当前标签页之后。如果指定
[count]，新标签页出现在第 [count] 个标签页之后。":0tab cmd" 使
新标签页出现在第一个位置。例如:
:tab split " 在新标签页上打开当前缓冲区
:tab help gt " 打开标签页显示 "gt" 的帮助

2、关闭标签页
*:tabc**:tabclose*
:tabc[lose][!] 关闭当前标签页。
如下情形使该命令失败:
- 屏幕上只有一个标签页。 *E784*
- 如果 'hidden' 没有置位，没有 [!]，缓冲区有修改，而且该缓冲区
没有其它窗口。
缓冲区的修改不会被写入，也不会丢失。所以这可以说是个 "安全的"
命令。

:tabc[lose][!] {count}
关闭第 {count} 个标签页。失败条件和上面的 ':tabclose' 相同。

*:tabo**:tabonly*
:tabo[nly][!] 关闭所有其它的标签页。
如果置位 'hidden' 选项，所有关闭窗口的缓冲区成为隐藏。
如果没有置位 'hidden' 但置位 'autowrite' 选项，写回修改过的缓
冲区。否则，包含修改过的缓冲区的窗口不会被删除。但如果给出
[!]，这些窗口成为隐藏。修改过的缓冲区永远不会被放弃，所以永远
不被丢失这些改动。

3、切换到另一个标签页
:tabn[ext] *:tabn**:tabnext**gt*
<C-PageDown>*CTRL-<PageDown>**<C-PageDown>*
gt *i_CTRL-<PageDown>**i_<C-PageDown>*
转到下一个标签页。最后一个标签页则回绕到第一个。

:tabn[ext] {count}
{count}<C-PageDown>
{count}gt 转到第 {count} 个标签页。首个标签页编号为 1。


:tabp[revious] *:tabp**:tabprevious**gT**:tabN*
:tabN[ext] *:tabNext**CTRL-<PageUp>*
<C-PageUp>*<C-PageUp>**i_CTRL-<PageUp>**i_<C-PageUp>*
gT 转到前一个标签页。首个标签页则回绕到最后一个。

:tabp[revious] {count}
:tabN[ext] {count}
{count}<C-PageUp>
{count}gT 转到前面 {count} 个标签页。首个标签页则回绕到最后一个。

:tabr[ewind] *:tabfir**:tabfirst**:tabr**:tabrewind*
:tabfir[st] 转到第一个标签页。

*:tabl**:tablast*
:tabl[ast] 转到最后一个标签页。


4、其它命令:
*:tabs*
:tabs 列出标签页和它们包含的窗口。
当前窗口显示 ">"。
修改过的缓冲区显示 "+"。


5、重新排列标签页:

:tabm[ove] [N] *:tabm**:tabmove*
把当前标签页移到第 N 个标签页之后。用 0 使当前标签页成为首个标
签页。如果没有 N，当前标签页成为最后一个。


6、循环遍历所有标签页:

*:tabd**:tabdo*
:tabd[o] {cmd} 对每个标签页执行 {cmd}。
大致相当于:
:tabfirst
:{cmd}
:tabnext
:{cmd}
等等
只对每个标签页的当前窗口进行操作。如果某个标签页出现错误，不再
继续访问其余的标签页。
最后一个标签页 (或任何出错的标签页) 成为当前标签页。
{cmd} 可以包含 '|' 以连接多个命令。
{cmd} 不能打开标签页、关闭标签页或重排标签页。
{Vi 无此功能}{仅当编译时加入 |+listcmds| 特性才有效}
:tabe fn     在一个新的标签页中编辑文件fn
gt     切换到下一个标签页
gT     切换到上一个标签页
:tabr     切换到第一个标签页
:tabl     切换到最后一个标签页
:tabm [N]     把当前tab移动到第N个tab之后
对，正如你所想象的那样，跟eclipse, ue等的标签页是一个意思！
窗口命令
ctrl+w s     水平分割窗口
ctrl+w w     切换窗口
ctrl+w q     退出当前窗口(由于同时有多个文件，此命令不会影响其他窗口)
ctrl+w v     垂直分割窗口
其他
vim在保存之前不会对文件做实际的修改，只是加载到缓冲区中，对文件的编辑其实是对缓冲区的编辑，直到:w时才会存入物理文件。

:e file     把file加载到新的缓冲区中
:bn     跳转到下一个缓冲区
:bd     删除缓冲区(关闭文件)
:sp fn     分割窗口，并将fn加载到新的窗口中
退出编辑器

:w     将缓冲区写入文件，即保存修改
:wq     保存修改并退出
:x     保存修改并退出
:q     退出，如果对缓冲区进行过修改，则会提示
:q!     强制退出，放弃修改
/*}}}*/

模式情景

Normal

移动光标
h,j,k,l     上，下，左，右
ctrl-f     上翻一页
ctrl-b     下翻一页
%     跳到与当前括号匹配的括号处，如当前在{，则跳转到与之匹配的}处
w     跳到下一个字首，按标点或单词分割
W     跳到下一个字首，长跳，如end-of-line被认为是一个字
e     跳到下一个字尾
E     跳到下一个字尾，长跳
b     跳到上一个字
B     跳到上一个字，长跳
0     跳至行首，不管有无缩进，就是跳到第0个字符
^     跳至行首的第一个字符
$     跳至行尾
gg     跳至文件的第一行
gd     跳至当前光标所在的变量的声明处
[N]G     跳到第N行，如0G，就等价于gg，100G就是第100行
fx     在当前行中找x字符，找到了就跳转至
;     重复上一个f命令，而不用重复的输入fx
tx     与fx类似，但是只是跳转到x的前一个字符处
Fx     跟fx的方向相反
),(     跳转到上/下一个语句
*     查找光标所在处的单词，向下查找
#     查找光标所在处的单词，向上查找
`.     跳转至上次编辑位置

在屏幕上移动
H     移动光标到当前屏幕上最上边的一行
M     移动光标到当前屏幕上中间的一行
L     移动光标到当前屏幕上最下边的一行
书签
ma     把当前位置存成标签a
`a     跳转到标签a处

插入模式
i     从当前光标处进入插入模式
I     进入插入模式，并置光标于行首
a     追加模式，置光标于当前光标之后
A     追加模式，置光标于行末
o     在当前行之下新加一行，并进入插入模式
O     在当前行之上新加一行，并进入插入模式
Esc     退出插入模式


可视模式
标记文本
v     进入可视模式，单字符模式
V     进入可视模式，行模式
ctrl+v     进入可视模式，列模式，类似于UE的列模式
o     跳转光标到选中块的另一个端点
U     将选中块中的内容转成大写
O     跳转光标到块的另一个端点
aw     选中一个字
ab     选中括号中的所有内容，包括括号本身
aB     选中{}括号中的所有内容
ib     选中括号中的内容，不含括号
iB     选中{}中的内容，不含{}

对标记进行动作
>     块右移
<     块左移
y     复制块
d     删除块
~     切换块中内容的大小写






:qx     开始记录宏，并将结果存入寄存器x
q     退出记录模式
@x     播放记录在x寄存器中的宏命令
稍微解释一下，当在normal模式下输入:qx后，你对文本的所有编辑动作将会被记录下来，再次输入q即退出了记录模
式，然后输入@x对刚才记录下来的命令进行重复，此命令后可跟数字，表示要重复多少次，比如@x20，可以重复20次。这个在文本的批处理中是非常有用的。


v     进入可视模式，单字符模式
V     进入可视模式，行模式
ctrl+v     进入可视模式，列模式，类似于UE的列模式
o     跳转光标到选中块的另一个端点
U     将选中块中的内容转成大写
O     跳转光标到块的另一个端点



缓冲区跳转
            :n   编辑下一个文件。
            :2n 编辑下二个文件。
            :N   编辑前一个文件。注意，这种用法只能用于 argument list 的情形。
            :rew 回到首文件
            :args 查看当前编辑缓冲文件状态
            :e# 或 Ctrl-^   编辑前一个档案，用于两文件互相编辑时相当好用。这种用法不管是 argument list 或buffer list 档案间皆可使用。 使用Ctrl－^ 命令更便捷，但如终端类型不正确该功能将无效。
            用:ls来显示缓冲区中的文件，编号后边有#的代表是前一个文件，可以通过:e#来进入，有%a的代表是当前文件，什么也没有的可以通过:bn来进入，这里的n代表文件编号。
            :b文件名或编号   移至该文件。
            在 :ls 中就会出示各文件的编号，这个编号在未离开 vim 前是不会变的。这个指令 elvis 也是可以使用。当然 :e#编号 也是可以的，这样的用法则是所有 vi clone 都通用了。
            在 buffers 中，减号 - 表示这个 buffer 并未载入，不过，不必担心，载入相当快速的。加号 + 表示这个 buffer 已经修改过了。
            :bn   buffer next。这里的n代表字母n
            :bl   buffer last。

其他命令
            :files 或 :buffers 或 :ls   会列出目前 buffer 中的所有文件。
            在 elvis 中可使用 :b 来叫出 buffers。
            :f 或 Ctrl-g   显示目前编辑的文件名、是否经过修改及目前光标所在之位置。
            :f 文件名   改变编辑中的文件名。(file)
            :r 文件名   在光标所在处插入一个文件的内容。(read)
            :35 r 文件名   将文件插入至 35 行之后。
            gf   这是 vim 的特殊打开文件的方法，会打开光标所在处的 word 为名的文件，当然，这个文件要在当前目录内，否则会创建新文件。
  大写 K        看光标所指标识符的 man 帮助页

 

软件扩展

vimperator
安装vimperator插件
在firefox里输入伪vim命令
:set editor=gvim -f
在系统的path环境变量中加入gvim.exe的路径，比如俺的是 D:\Program Files\Vim\vim72，很可能要重启电脑才能生效
只要光标停留在目标网页的文本框里，就可以使用ctrl + i (<C + i>)快捷键biu的一下呼出gvim编辑文本。



vim去掉\r\n 中^M的方法
1    :%s//r/  (推荐)
2    :%s//r//g
3    :%s/[ctrl-v][ctrl-m]//g(中间CTRL部分不是输入，而是按键，显示在屏幕上是  :%s/^M//g)
4    还有一个解决方法就是对这类文本进行 转换。vim内部就可以做这件事情。首先打开文本，然后 set fileformat=unix；再重新保存该文件覆盖原文件就可以去除:^M了
set fileformats=unix

ZZ：保存当前文档并退出VIM

多窗口
稍微详细的讲解多窗口的编辑
默认情况下，Vim只为一个session打开一个窗口，可以用参数**-o**来打开多个窗口，如:vim -o file1 fiel2，默认这个session会水平分割两个窗口显示，另外参数o后面还可以跟数字:vim -o3 file1 file2 这样Vim会打开三个窗口，最后一个窗口会留空白.
打开窗口
如果vim已开启，那么在normal模式如下命令使用：
水平分割窗口
:split             当前窗口一分为二，两个窗口显示相同内容。
:10split           新窗口的高度10行
:split otherfile   新窗口中打开otherfile
:new               功能和split一样
:sp                split的缩写形式
ctrl+w+s           分割窗口的快捷方式
:q                 关闭当前窗口
垂直分割窗口
:vsplit 以上所有命令都适用于打开垂直分割窗口，只要在前面加v(vetical)

鼠标操作
gvim默认支持鼠标移动光标操作。
vim可以设置 :set mouse=a,我猜a就是available的意思。

键盘操作
ctrl+w+k  使用ctrl+w(window)结合hjkl来移动。先按住CTRL+w，在按k，光标就移到上面窗口。hjkl前面可加数字，移动多个窗口
ctrl+w+T  大写T)移动当前窗口至新的标签页(tab，下节专业讲讲标签页)
ctrl+w+K  (大写K)HJKL四个组合命令(移动并回流窗口命令，窗口和光标一起移动)

复杂功能
可以使用 ex-mode，执行多行命令，用 gQ 进入该模式  输入vi可返回

调整窗口尺寸
gvim鼠标支持拖拉动作来改变窗口大小。我想你不会这么做，命令行才是高效率工作。
ctrl+w结合+-= 当然+-=前面可以接数字，分表代表增大、减小、均分窗口。
resize -4 明确指定窗口减少多少
ctrl+w结合< > 增加窗口宽度

 
网易邮箱的总结

%s/字符串//gn                                   vim统计匹配字符串的个数

gd                                                     从变量的调用跳转到它的局部声明。


:%s/{/\r{\r/g
:%s/}/\r}\r/g
:%s/;/;\r/g                                           格式化那些整行的代码：2012.4.5


^M 是 windows换行符 删除方法
:%s/\r/\r/g
:%s/^M$//g
% 指匹配整个文件，s 是置换的意思，^M 注意要用 Ctrl + V Ctrl + M 来输入，M 后的 $ 代表匹配行尾的内容，g 则表示每行中匹配到的内容都要置换。


支持utf-16
set fileencodings=utf-8,ucs-bom,gbk,cp936,latin-1


fx     在当前行中找x字符，找到了就跳转至
;     重复上一个f命令，而不用重复的输入fx
`.     跳转至上次编辑位置
``     跳转上一次的位置

书签
ma     把当前位置存成标签a
`a     跳转到标签a处


~     切换大小写，当前字符


有个人总结的也不错：http://blog.csdn.net/kidxueying/article/details/6854962

 
1. 查找
   /xxx(?xxx)       表示在整篇文档中搜索匹配xxx的字符串, / 表示向下查找, ? 表示
                   向上查找.其中xxx可以是正规表达式,关于正规式就不多说了.
                   一般来说是区分大小写的, 要想不区分大小写, 那得先输入
                   :set ignorecase
                   查找到以后, 再输入 n 查找下一个匹配处, 输入 N 反方向查找.
   *(#)             当光标停留在某个单词上时, 输入这条命令表示查找与该单词匹配的
                   下(上)一个单词. 同样, 再输入 n 查找下一个匹配处, 输入 N 反方
                   向查找.
   g*(g#)           此命令与上条命令相似, 只不过它不完全匹配光标所在处的单词, 而
                   是匹配包含该单词的所有字符串.
   gd               本命令查找与光标所在单词相匹配的单词, 并将光标停留在文档的非
                   注释段中第一次出现这个单词的地方.
   %                本命令查找与光标所在处相匹配的反括号, 包括 () [] {}
   f(F)x            本命令表示在光标所在行进行查找, 查找光标右(左)方第一个x字符.
                   找到后:
                   输入 ; 表示继续往下找
                   输入 , 表示反方向查找
2. 快速移动光标
    在 vi 中, 移动光标和编辑是两件事, 正因为区分开来, 所以可以很方便的进行光标定
位和编辑. 因此能更快一点移动光标是很有用的.
   w(e)             移动光标到下一个单词.
   b                移动光标到上一个单词.
   p;               移动光标到本行最开头.
   ^                移动光标到本行最开头的字符处.
   $                移动光标到本行结尾处.
   H                移动光标到屏幕的首行.
   M                移动光标到屏幕的中间一行.
   L                移动光标到屏幕的尾行.
   gg               移动光标到文档首行.
   G                移动光标到文档尾行.
   c-f              (即 ctrl 键与 f 键一同按下) 本命令即 page down.
   c-b              (即 ctrl 键与 b 键一同按下, 后同) 本命令即 page up.
   ''               此命令相当有用, 它移动光标到上一个标记处, 比如用 gd, * 等查
                    找到某个单词后, 再输入此命令则回到上次停留的位置.
   '.               此命令相当好使, 它移动光标到上一次的修改行.
   `.               `此命令相当强大, 它移动光标到上一次的修改点.
3. 拷贝, 删除与粘贴
    在 vi 中 y 表示拷贝, d 表示删除, p 表示粘贴. 其中拷贝与删除是与光标移动命令
结合的, 看几个例子就能够明白了.
   yw               表示拷贝从当前光标到光标所在单词结尾的内容.
   dw               表示删除从当前光标到光标所在单词结尾的内容.
   y0               表示拷贝从当前光标到光标所在行首的内容.
   d0               表示删除从当前光标到光标所在行首的内容.
   y$               表示拷贝从当前光标到光标所在行尾的内容.
   d$               表示删除从当前光标到光标所在行尾的内容.
   yfa              表示拷贝从当前光标到光标后面的第一个a字符之间的内容.
   dfa              表示删除从当前光标到光标后面的第一个a字符之间的内容.
   特殊地:
   yy               表示拷贝光标所在行.
   dd               表示删除光标所在行.
   D                表示删除从当前光标到光标所在行尾的内容.
   关于拷贝, 删除和粘贴的复杂用法与寄存器有关, 可以自行查询.
4. 数字与命令
    在 vi 中数字与命令结合往往表示重复进行此命令, 若在扩展模式的开头出现则表示行
号定位. 如:
   5fx              表示查找光标后第 5 个 x 字符.
   5w(e)            移动光标到下五个单词.
   5yy              表示拷贝光标以下 5 行.
   5dd              表示删除光标以下 5 行.
   y2fa             表示拷贝从当前光标到光标后面的第二个a字符之间的内容.
   :12,24y          表示拷贝第12行到第24行之间的内容.
   :12,y            表示拷贝第12行到光标所在行之间的内容.
   :,24y            表示拷贝光标所在行到第24行之间的内容. 删除类似.
5. 快速输入字符
    在 vi 中, 不要求你输入每一个字符, 可以有很多种方法快速输入一些字符.
    使用 linux/unix 的同学一定有一个经验, 在命令行下输入命令时敲入头几个字符再按
TAB 系统就会自动将剩下的字符补齐, 假如有多个匹配则会打印出来. 这就是著名的命令
补齐(其实windows中也有文件名补齐功能). vi 中有许多的字符串补齐命令, 非常方便.
   c-p(c-n)         在编辑模式中, 输入几个字符后再输入此命令则 vi 开始向上(下)搜
                   索开头与其匹配的单词并补齐, 不断输入此命令则循环查找. 此命令
                   会在所有在这个 vim 程序中打开的文件中进行匹配.
   c-x-l            在编辑模式中, 此命令快速补齐整行内容, 但是仅在本窗口中出现的
                   文档中进行匹配.
   c-x-f            在编辑模式中, 这个命令表示补齐文件名. 如输入:
                   /usr/local/tom 后再输入此命令则它会自动匹配出:
                   /usr/local/tomcat/
   abbr             即缩写. 这是一个宏操作, 可以在编辑模式中用一个缩写代替另一个
                   字符串. 比如编写java文件的常常输入 System.out.println, 这很
                   是麻烦, 所以应该用缩写来减少敲字. 可以这么做:
                   :abbr sprt System.out.println
                   以后在输入sprt后再输入其他非字母符号, 它就会自动扩展为System.
                   out.println
6. 替换
    替换是 vi 的强项, 因为可以用正规表达式来匹配字符串.以下提供几个例子.
   :s/aa/bb/g       将光标所在行出现的所有包含 aa 的字符串中的 aa 替换为 bb
   :s/\/bb/g   将光标所在行出现的所有 aa 替换为 bb, 仅替换 aa 这个单词
   :%s/aa/bb/g      将文档中出现的所有包含 aa 的字符串中的 aa 替换为 bb
   :12,23s/aa/bb/g 将从12行到23行中出现的所有包含 aa 的字符串中的 aa 替换为 bb
   :12,23s/^/#/     将从12行到23行的行首加入 # 字符
   :%s= *$==        将所有行尾多余的空格删除
   :g/^\s*$/d        将所有不包含字符(空格也不包含)的空行删除.
 
VIM的编码系统

快速配置(支持utf-16)
>set fileencodings=utf-8,ucs-bom,gbk,cp936,latin-1

字符编码转换
如果只是要简单的转换文件编码，打开文件后
>:set fileencodings=utf-8 ，然后 w (存盘)一下即可转化为 utf8 格式，
:set fileencodings=cp936  ，然后 w (存盘)一下即可转化为 ANSI 格式。


Vim对中文编码的支持
1、支持中文编码的基础
Vim要更好地支持中文编码需要两个特性：+multi_byte和+iconv，可以用:version命令检查当前使用的Vim是否支持。
2、影响中文编码的设置项
Vim中有几个选项会影响对多字节编码的支持：
•    encoding(enc)：encoding是Vim的内部使用编码，encoding的设置会影响Vim内部的Buffer、消息文字等。在 Unix环境下，encoding的默认设置等于locale；Windows环境下会和当前代码页相同。在中文Windows环境下encoding的 默认设置是cp936(GBK)。
•    fileencodings(fenc)：Vim在打开文件时会根据fileencodings选项来识别文件编码，fileencodings可以同时设置多个编码，Vim会根据设置的顺序来猜测所打开文件的编码。
•    fileencoding(fencs) ：Vim在保存新建文件时会根据fileencoding的设置编码来保存。如果是打开已有文件，Vim会根据打开文件时所识别的编码来保存，除非在保存时重新设置fileencoding。
•    termencodings(tenc)：在终端环境下使用Vim时，通过termencoding项来告诉Vim终端所使用的编码。
3、Vim中的编码转换
Vim内部使用iconv库进行编码转换，如果这几个选项所设置的编码不一致，Vim就有可能会转换编码。打开已有文件时会从文件编码转换到 encoding所设置的编码；保存文件时会从encoding设置的编码转换到fileencoding对应的编码。经常会看到Vim提示[已转换]，这是表明Vim内部作了编码转换。终端环境下使用Vim，会从termencoding设置的编码转换到encoding设置的编码。
可以用|:help encoding-values|列出Vim支持的所有编码。
4、具体应用环境的设置
•    只编辑GBK编码的文件
set fileencodings=cp936
set fileencoding=cp936
set encoding=cp936
•    只编辑UTF-8编码的中文文件
set fileencodings=utf-8
set fileencoding=utf-8
set encoding=cp936 或者 set encoding=utf-8
•    同时支持GBK和UTF-8编码
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8
set encoding=cp936 或者 set encoding=utf-8
•    如果在终端环境下使用Vim，需要设置termencoding和终端所使用的编码一致。例如：
set termencoding=cp936 或者 set termencoding=utf-8
Windows记事本编辑UTF-8编码文件时会在文件头上加上三个字节的BOM：EFBBBF。如果fileencodings中设 置ucs-bom的目的就是为了能够兼容用记事本编辑的文件，不需要的话可以去掉。Vim在保存UTF-8编码的文件时会去掉BOM。去掉BOM的最大好 处是在Unix下能够使用cat a b>c来正确合并文件，这点经常被忽略。
'去掉utf-8 BOM
:set nobomb
'保留utf-8 BOM
:set bomb


5、FAQ
1.    为什么在Vim中一次只能删除半个汉字？
因为encoding设置错误，把encoding设置为cp936就可以解决此问题。在Unix环境下Vim会根据locale来设置默认的encoding，如果没有正确设置locale并且没有设置encoding就会一次只能删除半个汉字。
2.    VIM为什么不能输入繁体字？
把euc-cn或者GB2312改为cp936就可以了。euc-cn是GB2312的别名，不支持繁体汉字。cp936是GBK的别名，是GB2312的超集，可以支持繁体汉字。
3.    VIM为什么提示不能转换？
因为在编译Vim时没有加入iconv选项，重新编译Vim才能解决。
4.    如何打开一个GBK编码的文件并另存为UTf-8编码？
保存文件时运行命令|:set fileencoding=utf-8|就可以了。
vim里面的编码主要跟三个参数有关：enc(encoding), fenc(fileencoding)和fencs(fileencodings)

其 中fenc是当前文件的编码，也就是说，一个在vim里面已经正确显示了的文件(前提是你的系统环境跟你的enc设置匹配)，你可以通过改变 fenc后再w来将此文件存成不同的编码。比如说，我:set fenc=utf-8然后:w就把文件存成utf-8的了，:set fenc=gb18030再:w就把文件存成gb18030的了。这个值对于打开文件的时候是否能够正确地解码没有任何关系。

fencs就是用来在打开文件的时候进行解码的猜测列表。文件编码没有百分百正确的判断方法，所以vim只能猜测文件编码。比如我的vimrc里面这个的设置是

set fileencodings=utf-8,gb18030,utf-16,big5

所 以我的vim每打开一个文件，先尝试用utf-8进行解码，如果用utf-8解码到了一半出错(所谓出错的意思是某个地方无法用utf-8正确地解码)， 那么就从头来用gb18030重新尝试解码，如果gb18030又出错(注意gb18030并不是像utf-8似的规则编码，所以所谓的出错只是说某个编 码没有对应的有意义的字，比如0)，就尝试用utf-16，仍然出错就尝试用big5。这一趟下来，如果中间的某次解码从头到尾都没有出错，那么 vim就认为这个文件是这个编码的，不会再进行后面的尝试了。这个时候，fenc的值就会被设为vim最后采用的编码值，可以用:set fenc?来查看具体是什么。

当然这个也是有可能出错的，比如你的文件是gb18030编码的，但是实际上只有一两个字符是中文，那么有可能他们正好也能被utf-8解码，那么这个文件就会被误认为是utf-8的导致错误解码。

至 于enc，其作用基本只是显示。不管最后的文件是什么编码的，vim都会将其转换为当前系统编码来进行处理，这样才能在当前系统里面正确地显示出来，因此 enc就是干这个的。在windows下面，enc默认是cp936，这也就是中文windows的默认编码，所以enc是不需要改的。在 linux下，随着你的系统locale可能设为zh_CN.gb18030或者zh_CN.utf-8，你的enc要对应的设为gb18030或者 utf-8(或者gbk之类的)。

最后再来说一下新建空文件的默认编码。看文档好像说会采用fencs里面的第一个编码作为新建文件的默 认编码。但是这里有一个问题，就是fencs 的顺序跟解码成功率有很大关系，根据我的经验utf-8在前比gb18030在前成功率要高一些，那么如果我新建文件默认想让它是gb18030编码怎么 办？一个方法是每次新建文件后都:set fenc=gb18030一下，不过我发现在vimrc里面设置fenc=gb18030也能达到这个效果。



Vim中有几个选项会影响对多字节编码的支持：
encoding(enc)：encoding是Vim的内部使用编码，encoding的设置会影响Vim内部的Buffer、消息文字等。在 Unix环境下，encoding的默认设置等于locale；Windows环境下会和当前代码页相同。在中文Windows环境下encoding的 默认设置是cp936(GBK)。
fileencodings(fenc)：Vim在打开文件时会根据fileencodings选项来识别文件编码，fileencodings可以同时设置多个编码，Vim会根据设置的顺序来猜测所打开文件的编码。
fileencoding(fencs) ：Vim在保存新建文件时会根据fileencoding的设置编码来保存。如果是打开已有文件，Vim会根据打开文件时所识别的编码来保存，除非在保存时重新设置fileencoding。
termencodings(tenc)：在终端环境下使用Vim时，通过termencoding项来告诉Vim终端所使用的编码。


参考链接
每日一VIM：http://liuzhijun.iteye.com/category/270228
技巧：http://linux.chinaunix.net/techdoc/desktop/2009/07/04/1121975.shtml




折叠/*{{{*/
via:http://www.cnblogs.com/welkinwalker/archive/2011/05/30/2063587.html

set foldmethod=indent "set default foldmethod
"zi 打开关闭折叠
"zv 查看此行
zm 关闭折叠
zM 关闭所有
zr 打开
zR 打开所有
zc 折叠当前行
zo 打开当前折叠
zd 删除折叠
zD 删除所有折叠


1. 折叠方式
可用选项 'foldmethod' 来设定折叠方式：set fdm=*****。
有 6 种方法来选定折叠：
manual          手工定义折叠
indent          更多的缩进表示更高级别的折叠
expr            用表达式来定义折叠
syntax          用语法高亮来定义折叠
diff            对没有更改的文本进行折叠
marker          对文中的标志折叠
注意，每一种折叠方式不兼容，如不能即用expr又用marker方式，我主要轮流使用indent和marker方式进行折叠。

使用时，用：set fdm=marker 命令来设置成marker折叠方式(fdm是foldmethod的缩写)。
要使每次打开vim时折叠都生效，则在.vimrc文件中添加设置，如添加：set fdm=syntax，就像添加其它的初始化设置一样。

2. 折叠命令
选取了折叠方式后，我们就可以对某些代码实施我们需要的折叠了，由于我使用indent和marker稍微多一些，故以它们的使用为例：
如果使用了indent方式，vim会自动的对大括号的中间部分进行折叠，我们可以直接使用这些现成的折叠成果。
在可折叠处(大括号中间)：
zc      折叠
zC      对所在范围内所有嵌套的折叠点进行折叠
zo      展开折叠
zO      对所在范围内所有嵌套的折叠点展开
[z      到当前打开的折叠的开始处。
]z      到当前打开的折叠的末尾处。
zj      向下移动。到达下一个折叠的开始处。关闭的折叠也被计入。
zk      向上移动到前一折叠的结束处。关闭的折叠也被计入。

当使用marker方式时，需要用标计来标识代码的折叠，系统默认是{{{和}}}，最好不要改动之
我们可以使用下面的命令来创建和删除折叠：
zf                  创建折叠，比如在marker方式下：
zf56G               创建从当前行起到56行的代码折叠；
10zf或10zf+或zf10↓  创建从当前行起到后10行的代码折叠。
10zf-或zf10↑        创建从当前行起到之前10行的代码折叠。
在括号处zf%         创建从当前行起到对应的匹配的括号上去((), {}, [], <>等)。
zd                  删除 (delete) 在光标下的折叠。仅当 'foldmethod' 设为 "manual" 或 "marker" 时有效。
zD                  循环删除 (Delete) 光标下的折叠，即嵌套删除折叠。
                    仅当 'foldmethod' 设为 "manual" 或 "marker" 时有效。
zE                  除去 (Eliminate) 窗口里“所有”的折叠。
                    仅当 'foldmethod' 设为 "manual" 或 "marker" 时有效。



使用Vim的折叠功能书写程序代码

折行的用处：
2 创建折行进行大纲预览
2 移动到某处进行编辑
2 使用jzij打开文本进行编辑
2 编辑完毕后再用jzij打开折行进行移动

打开vim的折叠功能，请在~/.vimrc 中加入:set foldmethod=marker ，使用vim默认的折叠标签进行处理。使用方法如下：
1. 加折叠标签
    在normal模式下，从键盘输入zf并回车，您就会看到折叠在一起的两行标签如下：
    /*{{{*/
    这里输入程序代码
    /*}}}*/

2. 输入程序代码后，将代码折叠起来使用如下命令(normal模式)：
    zc 回车

3. 打开折叠的程序有以下几种方法
    a. 在折叠的行上移动光标
    b. 在normal模式下输入zo并回车

4. 给一段文字加折行(normal 模式)
    zfap

5. zr命令可以打开折叠几层的内容 zm使用内容折叠的更多一些(多层折叠操作时可反复使用).

6. 嵌套了多层的折行, 也可以用zR命令一次打开所有折行.

7. 关闭所有的嵌套折行使用zM

8. 可以用jznj命令来禁用一个折行. 然后用jzNj还可以恢复它. jzij命令则可以在两者之间切换.
/*}}}*/

/*}}}*/



VIM 寄存器
将寄存器与各种删除、复制、粘贴命令组合使用，能够大大提高编辑文本的效率。
指定寄存器
在复制或删除文本时，可以使用"register命令将文本放入指定的寄存器中。例如以下命令，将复制的文本放到寄存器a中，同时文本也会被放入未命名寄存器中。
"ayy
如果再使用相应的大写字母来指定寄存器，那么会将当前行内容追加到寄存器a中，这时该寄存器中就有了两行文本。
"Ayy
查看寄存器
使用registers命令，可以查看特定寄存器中的内容。例如以下命令，可以查看寄存器a中的内容：

如果想要查看所有寄存中的内容，可以使用以下命令：
:registers
寄存器类别
寄存器可以分为以下9类：
类别    符号    描述
未命名寄存器    "   上一次复制或删除的文本
数字寄存器  0-9 文本删除历史
短删除寄存器    -   删除少于一行的文本
命名寄存器  a-z,A-Z 存放文本
只读寄存器  %   当前文件的名字
#   交替文件的名字
.   上一次插入的文本
:   上一次执行的命令
表达式寄存器    ＝  返回表达式结果
选择和拖拽寄存器    *   系统剪切板
+   系统剪切板（X11）
~   拖拽的文本
黑洞寄存器  _   永久删除的文本
搜索模式寄存器  /   搜索模式
未命名寄存器（The Unnamed Register） 当使用y命令复制文本，或使用d、c、s、x命令删除文本时，文本将自动被放入""未命名寄存器。即使你在复制或删除文本时，已经指定了寄存器（例如使用"xdd命令），这些文本也将会被同时放入"x和""寄存器。
数字寄存器（The Numbered Registers） "0始终存放最近删除的文本。"1也包含上次删除的文本。区别在于："0不断被删除的文本所覆盖；而如果删除文本时，指定了寄存器或者文本小于一行，那么"1将不会被更新。 数字寄存器1-9可以看作是删除历史， 你可以从中找到早先删除的文本。比如你使用了三次dd命令，那么这三行文本被分别存放在寄存器1,2,3中，可以通过命令"1P,"2P,"3P将这些文本再粘贴回来。
短删除寄存器（The Small Delete Register） 当删除少于一行的文本时，除非指定了某个寄存器，否则这些内容将会被放入"-短删除寄存器中。
命名寄存器（The Named Registers） 当文本被放入以小写字母命名的寄存器（例如"a）时，该寄存器原有的内容将被覆盖；而使用以大写字母命名的寄存器（例如"A）时，将会把文本追加到原有内容之后。
只读寄存器（The Read-Only Registers） 你只能从4个只读寄存器中粘贴内容，而不能放入文本。"%包含当前文件名；"#包含交替文件名；".包含最近插入的文本；":包含上次执行的命令行。
表达式寄存器（The Expression Register） 当我们输入"=，就会在Vim底部显示一个以“＝”开始的提示行，可以在这里输入表达式并按回车键确认。随后使用命令p将表达式的结果粘贴到文本中。例如要在文本中插入38*56的值，首先进入命令模式，输入"=，在屏幕底部的提示行中输入“38*56”并按回车，然后输入命令p，这样就可以将计算结果插入文本中了。在表达式寄存器中，不仅可以使用通常的算术运算符，还可以使用Vim特定的函数和运算符。例如通过表达式寄存器来得到环境变量的值（例如"=$HOME）。如果没有输入任何表达式而直接按回车键，那么Vim将执行最近使用过的表达式。
选择和拖拽寄存器（The Selection and Drop Registers） 有3个寄存器用于保存选中的文本："*用于访问系统剪切板。在Windows下，"*和"+相同；在Linux下，"+包含选中的文本，"*包含复制的文本。使用"+y命令，可以将当前选中的文文本复制到系统剪切板中。而"+p命令，则可以粘贴系统剪切板中的内容。通过剪切板寄存器，能够在不同的Vim编辑器或者是其他应用程序之间，进行文本交换。"~包含上次从其它应用程序拖拽到Gvim中的文本。
黑洞寄存器（The Black Hole Register） 任何放入"_中的文本都将不复存在。如果想要永久删除某些文本而不是将他放入1-9中的某个寄存中，就可以使用黑洞寄存器。例如：命令dd将删除一行文本并将其放入寄存器1中；而命令"_dd则将该行文本放入黑洞寄存器中，这些文本也就会永久消失了，而寄存器1中的文本会保持不变。
搜索模式寄存器（Search Pattern Register） 当你通过/命令进行搜索时，所使用的模式将自动被放入"/寄存器。
粘贴寄存器
命令:put会将寄存中的内容粘贴到指定的文本行后面。使用以下命令，可以将寄存器中的内容粘贴到第五行的后面:
:5put a
如果要将文本放在这一行的前面，可以用以下命令：
:5put! a
你也可以使用p命令，将x寄存中的文本粘贴到光标之后：
"xp
而P命令，则将x寄存中的文本粘贴到光标之前：
"xP
如果直接使用p或P命令，而没有指明特定寄存器，那么将粘贴未命名寄存器中的内容。
使用以下命令，可以粘贴上次插入的文本，方便你录入重复的内容：
".P
如果要粘贴系统剪切板中的内容，在Insert mode下可以利用快捷键Shift+Ins，而在Normal mode下，可以使用以下命令：
"*p

:reg列出所有寄存器
"a5y:将5行存储到寄存器a
"ap：复制寄存器a的内容


vim标记
```
Ctrl+i/o 跳转到较早/较晚的地方，
:marks  列出所有的标记
m{a-zA-Z} 用标记 {a-zA-Z} 记录当前位置
`{a-z}        至当前文件中的标记 {a-z}
`{A-Z}        至任何文件中的标记 {A-Z}
`{0-9}        至 Vim 上次退出的位置
``          至上次跳转之前的位置
`"            至上次编辑此文件的位置
`[           至上次被操作或放置的文本的开始
`]           至上次被操作或放置的文本的结尾
`<           至 (前次) 可视区域的开始
`>           至 (前次) 可视区域的结尾
`.          至当前文件最后被改动的位置
```

we can bookmark locations in the buffer m<letter> sets mark named  <letter> at current location
```
`<letter> jumps precisely to that mark
‘<letter> jumps to the line with the mark
lowercase letter: mark is local to the buffer
uppercase letter: mark is global, your buffer will be switched to the file with the mark
:marks shows you your current marks

marks are very handy for changing text set a mark (let’s say  ma ) then you can do:
d`a - delete text from cursor to mark a
c`a - change text from cursor to mark a
=’a - reformat lines from current one to the one with mark a

let’s say you jump somewhere how do you go back?
`` moves you between the last two locations
you can set  ` (the context mark) explicitly:
    m`, jump elsewhere, then come back with ``
tip:  CTRL-O and  CTRL-I move between
positions in the full jump history, but can’t be
used as motions
‘. and  `. - jump to the line or exact location of
the last modification
```
/*}}}*/


### 插件详细介绍 /*{{{*/
emmet(zen coding)
是横扫各大小编辑器的快速编码插件，其使用类`CSS`选择器的语法实现扩展性编码，确实够酷、够快

`Zen Coding`在`Vim`下的默认触发键是`Ctrl + Y + ,`（注意，最后还有一个逗号）

调用规则
```
`1`、单个元素：`div`
`2`、带`id`的元素，使用`#`号：`div#name`
`3`、带`class`的元素，使用点号（`.`）：`div.header`
`4`、`id`与`class`是可以同时使用的，如果`class`名中含多个单词，可以使用点号（`.`）进行连接：`div#name.header.one`
`5`、子元素使用大于号（`>`），子元素的子元素可以连写：`div>p>h1`
`6`、同级兄弟元素使用加号（`+`），可以使用括号避免歧义：`div>p>(h1+h2)`
`7`、多项相同的元素，使用星号（`*`）：`ul>li*5`
`8`、带有序号的元素，使用美元符（`$`），从`1`开始自动递增：`div>p#id$*5`
`9`、如果需要指定序号的位数，只须多写几个美元符（`$`）即可：`div>p#id$$$*5`
```

常用缩写
```
html:4t  传统的`HTML4.01`模板
html:5  `HTML5`模板
style  样式标签
script  脚本标签
link  `link`标签
a  链接标签
```
更多用法可以查看":help emmet"
本文修改于：https://github.com/ruchee/backup2/blob/master/code/linux/vim/zencoding.wiki
/*}}}*/

### Vim 正则表达式 /*{{{*/
```
*    指前面所出现的字元或字元集合，出现0或0次以上；
\+    匹配内容同上，只不过出现次数不包括0次；
\=    指前面所出现的字元，仅出现0次或者1次；
\|    这个是多选，同or的意思相同，无论满足哪个条件都可以匹配；
\{n,m}    指前面所出现的字元或字元集合最少出现n次，最多出现m次；
上面这个可以演变一下几种，
\{n}    指前面所出现的字元或字元集合出现次数为n次；
\{n,}    指前面所出现的字元或字元集合最少出现为n次；
\{,m}    指前面所出现的字元或字元集合最多出现为m次；
^    匹配行首，在这个后面的字元出现在行首才符合；
$    匹配行尾，在这个之前的字元出现在行尾才符合；
[...]    字元集合，表示符合括号中所有字元中的其中一个；
[^...]    上面这个的补集，表非括号中字元的其中一个；
.    代表除换行字外的任一单一字元；千万不要小看了它，天大的符号(某网友语)自然不一般，在VIM的normal模式下，它可以重复上次的命令；在这边又可以表示任一字元，果然名不虚传；
讲了这么多来点实际的例子。
写elan单片机程序时，程序的标号都必须顶在最前，而且后面有个":"，如果忘记打了这个":"怎么办？一个一个找，再加上，当然也是可以。如果用VIM，就不用那么麻烦了。对了，用VIM的替代然后加上强大的正则表达式。看看VIM的神奇吧，敲入
:%s/^[a-zA-Z].*[^:]$/&:/gc
^[a-zA-Z]表示匹配行首为字母，可以排除不是顶在最前的其它指令，还可以排除顶在最前面的注释，因为注释使用";"打头，不在范围之内。
[^:]$表示匹配行尾不是以":"结尾的东东。然后那个".*"就表示中间任意字元都行。这样只要行首和行尾符合的都会在后面加上":"了。怎么样，好用吧！
其实关于那个[a-zA-Z]在VIM中有简单的表示方法，再来看看正则表达式中的一些简写
\s    表示空白字元，即 Space 或 Tab 。
\S    表示非空白字元
\d    表示数字，即[0-9]。
\D    表示非数字，即[^0-9]。
\w    表示一般字元，包括下划线。即[0-9a-zA-Z_]。
\W    表示非一般字元，即[^0-9a-zA-Z]。
\a    表示英文字母，即[a-zA-Z]。
\A    表示非英文字母，即[^a-zA-Z]。
\l    表示小写字母，即[a-z]。
\L    表示非小写字母，即[^a-z]。
\u    表示大写字母，即[A-Z]。
\U    表示非大写字母，即[^A-Z]。
看完了上面的这些简写表示，上面那个例子其实可以改写如下：
:%s/^\a.*[^:]$/&:/gc
可以达到同样的效果。
再来一个例子，写程序时难免会在某些行尾会留下一些多余的空格或者TAB指令，虽然没什么影响，但用VIM同样可以轻松找到这些多余的空指令，并删除。看看下面这个指令：
:%s/\s$//gc
试用一下，好像不错，末尾的空白指令都被删除了！但是仔细去看如果行尾有不止一个的空白指令，上面那个就只会取代最后一个空白指令，而忽略其它的空白指令。让我们动手再改进一下！用到前面的\+，这样就基本上ok了！不管行尾有多少空白指令都可以匹配到了！
:%s/\s\+$//gc
```

量词
```
vim的量词与perl相比一点也不逊色。
vim    Perl    意义
*    *    0个或多个(匹配优先)
\+    +    1个或多个(匹配优先)
\? 或 \=    ?    0个或1个(匹配优先)，\?不能在 ? 命令(逆向查找)中使用
\{n,m}    {n,m}    n个到m个(匹配优先)
\{n,}    {n,}    最少n个(匹配优先)
\{,m}    {,m}    最多m个(匹配优先)
\{n}    {n}    恰好n个
\{-n,m}    {n,m}?    n个到m个(忽略优先)
\{-}    *?    0个或多个(忽略优先)
\{-1,}    +?    1个或多个(忽略优先)
\{-,1}    ??    0个或1个(忽略优先)
从上表中可见，vim的忽略优先量词不像perl的 *? +? ?? 那样，而是统一使用 \{- 实现的。这大概跟忽略优先量词不常用有关吧。
环视和固化分组
vim居然还支持环视和固化分组的功能，强大，赞一个。关于环视的解释请参考Yurii的《精通正则表达式》一书吧。
vim    Perl    意义
\@=    (?=    顺序环视
\@!    (?!    顺序否定环视
\@<=    (?<=    逆序环视
\@<!    (?<!    逆序否定环视
\@>    (?>    固化分组
\%(atom\)    (?:    非捕获型括号
和perl稍有不同的是，vim中的环视和固化分组的模式的位置与perl不同。例如，查找紧跟在 foo 之后的 bar，perl将模式写在环视的括号内，而vim将模式写在环视的元字符之前。
```
/*}}}*/



modeline vim: set ts=4 sw=4 tw=0 et fdm=marker foldlevel=0 foldenable foldlevelstart=99 :
