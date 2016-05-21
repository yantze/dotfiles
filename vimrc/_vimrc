" author: yantze
" $VIM/_vimrc.bundles " the package location

" 下面的两行，配置基本保持不变,一般不需要修改,所以折叠,可以用za打开
" two lines below folded because of not often changing
" Environment {{{

    " Identify platform {
        silent function! OSX()
            if system('uname')=~'Darwin'
                let g:test = ''
            else
                let g:test = ''
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win16') || has('win32') || has('win64'))
        endfunction
    " }

    " Windows Compatible {
        if WINDOWS()
            let g:isWIN = 1
            " set runtimepath=$HOME.'\.vim',$VIM.'\vimfiles',$VIMRUNTIME
            if has("statusline")
                set statusline  =%<%f\ %h%m%r%=%{(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\")}
                set statusline +=%{\"[\".&ff.\"]\"} "file format
                set statusline +=%k
                set statusline +=\ %h%m%r%=%-14.(%l,%c%V%)\ %P
            endif
        else
            let g:isWIN = 0
            " 兼容windows的环境变量$VIM
            let $VIM = $HOME."/.vim"
            " 没有效果，待定
            set shell=/bin/sh
        endif
    " }

    " Adapter {
        " Adapte with putty because of putty only support the 7 character
        if $TERM == 'screen'
            "from: http://vim.wikia.com/wiki/Get_Alt_key_to_work_in_terminal
            set <m-j>=j
            set <m-h>=h
            set <m-k>=k
            set <m-l>=l
            "from: https://groups.google.com/forum/#!topic/vim_use/uKOmY-mHo_k
            " 导致 ESC 延迟反应
            "below set <esc> wait the next key millionstime
            set timeout timeoutlen=3000 ttimeoutlen=100
        endif
        " the ^[ is an Esc char that comes before the 'a'
        " In most default configs, ^[a may be typed by pressing first <C-v>, then <M-a>

        " http://vim.1045645.n5.nabble.com/Mapping-meta-key-within-tmux-td5716437.html
        " Fix screen's key bindings.
        " if &term == "screen"
        "     " These work from my HP keyboard in PuTTY on Windows XP.
        "     map <Esc>[D   <S-Left>
        "     map <Esc>[C   <S-Right>
        "     map <Esc>[11~ <F1>
        "     map <Esc>[12~ <F2>
        "     map <Esc>[13~ <F3>
        "     map <Esc>[14~ <F4>
        "     map <Esc>[15~ <F5>
        "     map <Esc>[16~ <F6>
        "     map <Esc>[17~ <F7>
        "     map <Esc>[18~ <F8>
        "     map <Esc>[19~ <F9>
        "     map <Esc>[21~ <F10
        "     map <Esc>[23~ <F11>
        "     map <Esc>[24~ <F12>
        " endif

        " if &term=="xterm"
        "     set t_Co=8
        "     set t_Sb=[4%dm
        "     set t_Sf=[3%dm
        " endif
    " }

    " Package manager{
        " 添加vundle插件管理器
        set nocompatible               " 设置不与之前版本兼容 be iMproved
        filetype off                   " 检测文件类型 required!
        " set vimrc_no_plugin=1 to do not add-on plugin
        " let g:vimrc_no_plugin=1
        if !exists("g:vimrc_no_plugin")
            " if filereadable(expand("$VIM/_vimrc.bundles"))
                if filereadable(expand("$VIM/bundle/Vundle.vim/README.md"))
                    set rtp+=$VIM/bundle/Vundle.vim  "添加vendle环境变量
                    source $VIM/_vimrc.bundles
                endif
            " endif
        endif
        " you can put it in tmpfs:/dev/shm/.dotfiles/vimrc/vimfiles/bundle/Vundle.vim
        " 安装新的插件 :PluginInstall
        " 在命令行运行 vim +PluginInstall +qall
        " 更新插件:PluginUpdate
        " 清除不再使用的插件:PluginClean,
        " 列出所有插件:PluginList
        " 查找插件:PluginSearch

    " }

    " Basic {
        "set powerline
        "set guifont=Powerline
        " Uncomment the following to have Vim jump to the last position when reopening a file
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

        " set vimrc
        let $VIMRC=$MYVIMRC

        if has('clipboard')
            if has('unnamedplus')  " When possible use + register for copy-paste
                set clipboard=unnamed,unnamedplus
            else  
                " On mac and Windows, use * register for copy-paste
                " windows/mac 粘贴板一起用，不方便
                set clipboard=unnamed
            endif
        endif

    " }

    " 判断是否处于GUI界面
    if has("gui_running")
        let g:isGUI = 1
    else
        let g:isGUI = 0
    endif

" }}}

" Functions {{{

" there func is for internal function invoal
" not relate the other plugin

func! RemoveTabs()
    if &shiftwidth == 2
        exec "%s/	/  /g"
    elseif &shiftwidth == 4
        exec "%s/	/    /g"
    elseif &shiftwidth == 6
        exec "%s/	/      /g"
    elseif &shiftwidth == 8
        exec "%s/	/        /g"
    else
        exec "%s/	/ /g"
    end
endfunc

" Diff current unsaved file
function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction

" Clean close
function! CleanClose(tosave,bang)
    if a:bang == 1
        let bng = "!"
    else
        let bng = ""
    endif
    if (a:tosave == 1)
        w!
    endif
    let todelbufNr = bufnr("%")
    let newbufNr = bufnr("#")
    if ((newbufNr != -1) && (newbufNr != todelbufNr) && buflisted(newbufNr))
        exe "b".newbufNr
    else
        exe "bnext".bng
    endif

    if (bufnr("%") == todelbufNr)
        new
    endif
    exe "bd".bng.todelbufNr
endfunction

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX files.
function! AppendModeline()
    let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
                \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), l:modeline)
endfunction

" Mydict, use *dict* in vim {
function! Mydict()
    let expl=system('dict ' . expand("<cword>"))
    windo if expand("%")=="dict.tmp" | q! | endif
    " botright vertical 33split dict.tmp
    botright 12split dict.tmp
    " botright cwindow
    setlocal buftype=nofile bufhidden=hide noswapfile
    set report=2 " ignore the following 'one line' substitution
    set nonu
    1s/^/\=expl/
    1
    set report=0 " recovery the 'report' setting
endfunction
" Mydict }

" 编译并运行
func! Compile_Run_Code()
    exec "w"
    if &filetype == "c"
        if g:isWIN
            exec !gcc -Wall -std=c11 -o %:r %:t && %:r.exe"
        else
            exec "!clang -Wall -std=c11 -o %:r %:t && ./%:r"
            " exec "!gcc -Wall -o %:r %:t && ./%:r"
        endif
    elseif &filetype == "cpp"
        if g:isWIN
            exec "!g++ -Wall -std=c++11 -o %:r %:t && %:r.exe"
        else
            " exec "!g++ -Wall -std=c++11 -o %:r %:t && ./%:r"
            exec "!clang++ -Wall -std=c++11 -o %:r %:t && ./%:r"
        endif
    elseif &filetype == "d"
        if g:isWIN
            exec "!dmd -wi %:t && %:r.exe"
        else
            exec "!dmd -wi %:t && ./%:r"
        endif
    elseif &filetype == "go"
        exec "!go run %:t"
    elseif &filetype == "rust"
        if g:isWIN
            exec "!rustc %:t && %:r.exe"
        else
            exec "!rustc %:t && ./%:r"
        endif
    elseif &filetype == "java"
        exec "!javac %:t && java %:r"
    elseif &filetype == "groovy"
        exec "!groovy %:t"
    elseif &filetype == "scala"
        exec "!scala %:t"
    elseif &filetype == "clojure"
        exec "!clojure -i %:t"
    elseif &filetype == "cs"
            exec "!mcs %:t && mono %:r.exe"
    elseif &filetype == "fsharp"
        if g:isWIN
            exec "!fsc %:t && %:r.exe"
        else
            exec "!fsharpc %:t && ./%:r.exe"
        endif
    elseif &filetype == "scheme" || &filetype == "racket"
        exec "!racket -fi %:t"
    elseif &filetype == "lisp"
        exec "!sbcl --load %:t"
    elseif &filetype == "ocaml"
        if g:isWIN
            exec "!ocamlc -o %:r.exe %:t && %:r.exe"
        else
            exec "!ocamlc -o %:r %:t && ./%:r"
        endif
    elseif &filetype == "haskell"
        if g:isWIN
            exec "!ghc -o %:r %:t && %:r.exe"
        else
            exec "!ghc -o %:r %:t && ./%:r"
        endif
    elseif &filetype == "lua"
        exec "!lua %:t"
    elseif &filetype == "perl"
        exec "!perl %:t"
    elseif &filetype == "php"
        exec "!php %:t"
    elseif &filetype == "python"
        exec "!python %:t"
    elseif &filetype == "ruby"
        exec "!ruby %:t"
    elseif &filetype == "elixir"
        exec "!elixir %:t"
    elseif &filetype == "julia"
        exec "!julia %:t"
    elseif &filetype == "dart"
        exec "!dart %:t"
    elseif &filetype == "haxe"
        exec "!haxe -main %:r --interp"
    elseif &filetype == "r"
        exec "!Rscript %:t"
    elseif &filetype == "coffee"
        exec "!coffee -c %:t && node %:r.js"
    elseif &filetype == "ls"
        exec "!lsc -c %:t && node %:r.js"
    elseif &filetype == "typescript"
        exec "!tsc %:t && node %:r.js"
    elseif &filetype == "javascript"
        exec "!node %:t"
    elseif &filetype == "sh"
        exec "!bash %:t"
    endif
endfunc

" 生成cscope和tags文件
function! Do_CsTag()
    let dir = getcwd()
    if filereadable("tags")
        if(g:iswindows==1)
            let tagsdeleted=delete(dir."\\"."tags")
        else
            let tagsdeleted=delete("./"."tags")
        endif
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable("cscope.files")
        if(g:iswindows==1)
            let csfilesdeleted=delete(dir."\\"."cscope.files")
        else
            let csfilesdeleted=delete("./"."cscope.files")
        endif
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if(g:iswindows==1)
            let csoutdeleted=delete(dir."\\"."cscope.out")
        else
            let csoutdeleted=delete("./"."cscope.out")
        endif
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        "silent! execute "!ctags -R --c-types=+p --fields=+S *"
        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    endif
    if(executable('cscope') && has("cscope") )
        if(g:iswindows!=1)
            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
        else
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
        endif
        silent! execute "!cscope -b"
        execute "normal :"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
endfunction

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
    let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
                \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), l:modeline)
endfunction
" }}}

" Setting {{{

" Theme {{{
" 设置着色模式和字体
if g:isWIN
    " 使用GUI界面时的设置
    if g:isGUI
        " 启动gvim时窗口的大小
        " set lines=42 columns=170
        " 启动时自动最大化窗口
        " au GUIEnter * simalt ~x

        " winpos 20 20             " 指定窗口出现的位置，坐标原点在屏幕左上角
        " set lines=20 columns=90  " 指定窗口大小，lines为高度，columns为宽度
        set guioptions+=c        " 使用字符提示框
        set guioptions-=m        " 隐藏菜单栏
        set guioptions-=T        " 隐藏工具栏
        set guioptions-=L        " 隐藏左侧滚动条
        set guioptions-=r        " 隐藏右侧滚动条
        " set guioptions-=b        " 隐藏底部滚动条
        " set showtabline=1        " 隐藏Tab栏
        set guioptions+=aA       " get some autoselect interaction with the system clipboard

        " colortheme list: molokai autumn blackboard asu1dark busybee tomorrow
        " colorscheme solarized  " deep blue
        " colorscheme morning    " white

        " let g:zenburn_transparent = 1 " black
        let g:zenburn_high_Contrast = 1
        colorscheme zenburn      " grey, my fav
        " colorscheme desertEx

        " set font
        set guifont=Consolas:h12
        " set guifont=Monaco:h11
        " set guifont=Source\ Code\ Pro\ Regular:h15
        " set guifont=YaHei\ Consolas\ Hybrid:h13
        " set guifont=Source\ Code\ Pro:h13

    else
        colorscheme ir_black
        " 兼容windows下cmd的gb2312
        " set enc=cp936
        " help encoding-table
        set termencoding=cp936
        " In order to reload a file with proper encoding you can do:
        " :e! ++enc=<the_encoding>.
        " dos里面<backspace>和<c-h>完全链接了，要取消<c-h>的映射
        iunmap <c-h>


    endif
else
    if g:isGUI
        set guifont=Monaco\ 11
        " set guifont=YaHei\ Consolas\ Hybrid:h13
        set background=light
        colorscheme solarized
        set lines=38 columns=140

    else
        " set background=light
        " g:solarized_termcolors= 16 | 256
        " g:solarized_termtrans = 0 | 1
        " g:solarized_degrade = 0 | 1
        " g:solarized_bold = 1 | 0 
        " g:solarized_underline = 1 | 0 
        " g:solarized_italic = 1 | 0 
        " g:solarized_contrast = “normal”| “high” or “low” 
        " g:solarized_visibility= “normal”| “high” or “low”

        " colortheme list: ir_black grb256 BusyBee pt_black solarized
        colorscheme pt_black
    endif
endif
" }}}

" Base Setting {{{

syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype plugin indent on    " 启用自动补全
set ic                       " 忽略大小写查找
set visualbell t_vb=         " 关闭visual bell/声音
au GuiEnter * set t_vb=      " 关闭beep/屏闪

" 文件配置
" set fileformats=unix                             " 设定换行符
set bsdir=buffer                                 " 设定文件浏览器目录为当前目录
set enc=utf-8                                    " 设置编码
set fenc=utf-8                                   " 设置文件编码
set fencs=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936 " 设置文件编码检测类型及支持格式
set shortmess+=filmnrxoOtT                       " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash  " Better Unix / Windows compatibility
" set virtualedit=onemore                          " Allow for cursor beyond last character
" set bsdir=buffer                               " 设定文件浏览器目录为当前目录,default value
" set autochdir

" 把这个快捷键放在这里主要是因为dos的vim对这个不支持，其它的系统支持
imap <c-h> <ESC>I


" 基本设置
" set my leader
let mapleader=","
" map : to ;
map ; :

set backspace=2              " 设置退格键可用
set autoindent               " 自动对齐
set smartindent              " 智能自动缩进
set nu!                      " 显示行号
set ruler                    " 右下角显示光标位置的状态行
set hidden                   " 允许在有未保存的修改时切换缓冲区
set laststatus=2             " 开启状态栏信息
set cmdheight=2              " 命令行的高度，默认为1，这里设为2
set writebackup              " 设置无备份文件
set autoread                 " 当文件在外部被修改时自动更新该文件
set nobackup                 " 不生成备份文件
set noswapfile               " 不生成交换文件
set wildmenu                 " 在命令行下显示匹配的字段到状态栏里面
set list                     " 显示特殊字符，其中Tab使用高亮竖线代替，尾部空白使用高亮点号代替
set listchars=tab:\|\ ,trail:. "设置tab/尾部字符用什么填充
set t_Co=256                 " 设置文字可以显示多少种颜色
set cursorline               " 突出显示当前行
set history=50               " keep 50 lines of command line history
set incsearch                " 开启实时搜索功能,查询时非常方便，如要查找book单词，当输入到/b时，会自动找到第一个b开头的单词，当输入到/bo时，会自动找到第一个bo开头的单词
set hlsearch                 " 开启高亮显示结果
set nowrapscan               " 搜索到文件两端时不重新搜索
set mouse=a                  " 启用鼠标
set lbr                      " 不在单词中间断行(linebreak)
" set nowrap                   " 设置不自动换行
" set tw=78                    "超过80个字符就折行(textwrap)
" set viminfo='20,\"50         " read/write a .viminfo file, don't store more than 50 lines of registers
set display=lastline         " 不要显示@@@@@


" set ambiwidth=double         "如果全角字符不能识别一般用这个(自动用宽字符显示)
set fo+=mB                   "打开断行模块对亚洲语言支持
set ai!                      " autoindent 设置自动缩进
" set showmatch                " 显示括号配对情况
" set lsp=0                    "设置行间距

" Tab
set tabstop=4
set cindent shiftwidth=4
set expandtab                " 将Tab自动转化成空格 [需要输入真正的Tab键时，使用 Ctrl+V + Tab]
" 详细的tab设置：http://blog.chinaunix.net/uid-24774106-id-3396220.html
"set ts=4 sw=4 et  "也可以一行写完:ts=tabstop=4 sw=shiftwidth=4 et=expandtab
set smarttab                 "在行首按TAB将加入sw个空格，否则加入ts个空格;按Backspace可以删除4个空格



" }}}

" System Setting {{{
if g:isWIN
else
    " 在 macvim 中，不支持
    set nu!
endif
if v:version > 703
    set relativenumber " 开启相对行号
    set undofile                 " 重新打开文件可恢复上次关闭的撤销记录,默认filename.un~, only use for `vim --version` have +persistent_undo feature

    " 替换原来的查找，可以同时显示多个查找关键字(Easymotion)
    if !exists("g:vimrc_no_plugin")
        if filereadable(expand("$VIM/bundle/vim-easymotion/README.md"))
            map  / <Plug>(easymotion-sn)
            omap / <Plug>(easymotion-tn)
        endif
    endif
endif
" }}}

" Local Setting {{{
    if filereadable(expand("~/.local/.vimrc_local"))
        source ~/.local/.vimrc_local
    endif
" }}}

" Other {{{

" tabn/tabp 切换tab
" tabnew 创建新窗口
" :retab 对当前文档重新替换tab为空格
" 用Ctrl+v Tab可以产生原生的Tab
" <leader>Space 打开Goyo编写环境
" :e $m<tab> 自动扩展到:e $MYVIMRC 然后打开_vimrc
"
" 少用
" ga 转换光标下的内容为多进制
" :set notextmode  去掉^M这个符号
" :set paste  这个可以解决在linux下面有些字母会被执行 nopaste pastetoggle
" 碰到不能输入*号键，先按Ctrl+v，再输入想要输入的特殊符号
" gCtrl+g 统计字数
" Ctrl+x, Ctrl+f 补全当前要输入的路径
"
"
" manpageview phpfunctionname.php
" 可以使用快捷键K查询
" 说明，比如你在centos里面装了man-pages，当你用K查询的时候，自动会弹出man 你光标下面的词
" manpageview 替代了插件pydoc.vim
" 查找当前的单词意思,quick close: ZZ/:q
nmap <silent><leader>K :call Mydict()<CR>
"

" ===js===
" 需要用nodejs下的包安装工具npm安装npm install -g jshint
" shell测试：jshint -version
"


" 这个主要用来对txt文档也可以用taglist列表
au BufReadPre *.txt,*.log,*.ini setlocal ft=txt

au BufReadPre * if getfsize(expand("%")) > 10000000 | syntax off | endif

au BufRead,BufNewFile *.js set filetype=javascript syntax=jquery


" there use special tech, when you put ':ag ', will display ':Ag '
" cnoreabbrev ag Ag
cabbrev ag <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Ag' : 'ag')<CR>
" search the cur word by ag
command! Agg exe 'Ag -Q ' . expand('<cword>')

" Syntastic
let g:syntastic_check_on_open        = 0
let g:syntastic_enable_signs         = 1
let g:syntastic_error_symbol         = '!!'
let g:syntastic_style_error_symbol   = '!¡'
let g:syntastic_warning_symbol       = '??'
let g:syntastic_style_warning_symbol = '?¿'

let c_no_curly_error = 1

let g:syntastic_c_checker          = "clang"
let g:syntastic_c_compiler_options = "-std=c11"

let g:syntastic_cpp_checker          = "clang++"
let g:syntastic_cpp_compiler_options = "-std=c++11"

let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'passive_filetypes': ['elixir', 'javascript'] }





let g:iswindows=1
autocmd BufEnter * lcd %:p:h
map <F12> :call Do_CsTag()<CR>
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>

" Set 'comments' to format dashed lists in comments. setlocal only can use cur
" file
" 无效果
" set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://

" au BufWritePre /tmp/* setl undofile
" hahaha" dfsdjfksdj
" z则次

" Ctrl + h/j/k/l 移动光标到上下左右位置
" Ctrl + H/J/K/L 移动窗口到上下左右位置
" '+1~9 上次打开的文件
" m+1~9 mark 1~9文件的位置
" :vert diffsplit main.c
" dp : diffput,把增加的部分放到另外一边
"
" insert schema, ctrl+w and other keys likes emacs

let g:phpcomplete_relax_static_constraint = 1
let g:phpcomplete_complete_for_unknown_classes = 1
let g:phpcomplete_search_tags_for_variables = 1
let g:phpcomplete_mappings = {
  \ 'jump_to_def': ',g',
  \ }
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Modify word boundary characters
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remove - as a word boundary (i.e. making a keyword character)
set iskeyword+=-
" remove $ as a word boundary (i.e. making a keyword character)
set iskeyword+=$
set wrap linebreak nolist

" map j to gj and k to gk, so line navigation ignores line wrap
nnoremap j gj
nnoremap k gk
" mapping search with Ack
"nnoremap <leader>f :Ack<space>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Wild settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable image files
set wildignore+=*.psd,*.png,*.jpg,*.gif,*.jpeg

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*,*.un~

" Node and JS stuff
set wildignore+=*/node_modules/*,*.min.js

" WP Language files
set wildignore+=*.pot,*.po,*.mo

" Fonts and such
set wildignore+=*.eot,*.eol,*.ttf,*.otf,*.afm,*.ffil,*.fon,*.pfm,*.pfb,*.woff,*.svg,*.std,*.pro,*.xsf

" \ig                        --显示/关闭对齐线
" 0 or ^ or $                --跳至 行首 or 第一个非空字符 or 行尾
"

"
" [ Ctrl+D                   --跳至当前光标所在变量的首次定义位置 [从文件头部开始]
" [ Ctrl+I                   --跳至当前光标所在变量的首次出现位置 [从文件头部开始]
" [ D                        --列出当前光标所在变量的所有定义位置 [从文件头部开始]
" [ I                        --列出当前光标所在变量的所有出现位置 [从文件头部开始]
"
" ---------- 文本操作 ----------
"
" dw de d0 d^ d$ dd          --删除
" cw ce c0 c^ c$ cc          --删除并进入插入模式
" yw ye y0 y^ y$ yy          --复制
" vw ve v0 v^ v$ vv          --选中
"
" di分隔符                   --删除指定分隔符之间的内容 [不包括分隔符]
" ci分隔符                   --删除指定分隔符之间的内容并进入插入模式 [不包括分隔符]
" yi分隔符                   --复制指定分隔符之间的内容 [不包括分隔符]
" vi分隔符                   --选中指定分隔符之间的内容 [不包括分隔符]
"
" da分隔符                   --删除指定分隔符之间的内容 [包括分隔符]
" ca分隔符                   --删除指定分隔符之间的内容并进入插入模式 [包括分隔符]
" ya分隔符                   --复制指定分隔符之间的内容 [包括分隔符]
" va分隔符                   --选中指定分隔符之间的内容 [包括分隔符]
"
" Xi和Xa都可以在X后面加入一个数字，以指代所处理的括号层次
" 如 d2i( 执行的是删除当前光标外围第二层括号内的所有内容
"
" dt字符                     --删除本行内容，直到遇到第一个指定字符 [不包括该字符]
" ct字符                     --删除本行内容，直到遇到第一个指定字符并进入插入模式 [不包括该字符]
" yt字符                     --复制本行内容，直到遇到第一个指定字符 [不包括该字符]
" vt字符                     --选中本行内容，直到遇到第一个指定字符 [不包括该字符]
"
" df字符                     --删除本行内容，直到遇到第一个指定字符 [包括该字符]
" cf字符                     --删除本行内容，直到遇到第一个指定字符并进入插入模式 [包括该字符]
" yf字符                     --复制本行内容，直到遇到第一个指定字符 [包括该字符]
" vf字符                     --选中本行内容，直到遇到第一个指定字符 [包括该字符]
"
" XT 和 XF 是 Xt/Xf 的反方向操作
"
" ---------- 便捷操作 ----------
"
" Ctrl + A                   --将当前光标所在数字自增1        [仅普通模式可用]
" Ctrl + X                   --将当前光标所在数字自减1        [仅普通模式可用]
" m字符       and '字符      --标记位置 and 跳转到标记位置
" q字符 xxx q and @字符      --录制宏   and 执行宏

" 对部分语言设置单独的缩进
au FileType scala,clojure,lua,ruby,eruby,dart,coffee,slim,jade,sh set shiftwidth=2
au FileType scala,clojure,lua,ruby,eruby,dart,coffee,slim,jade,sh set tabstop=2

" 根据后缀名指定文件类型
au BufRead,BufNewFile *.h   setlocal ft=c
au BufRead,BufNewFile *.sql setlocal ft=mysql
au BufRead,BufNewFile *.tpl setlocal ft=smarty
au BufRead,BufNewFile *.txt setlocal ft=txt

" 针对部分语言取消指定字符的单词属性
au FileType clojure  set iskeyword-=.
au FileType clojure  set iskeyword-=>
au FileType perl,php set iskeyword-=$
au FileType ruby     set iskeyword+=!
au FileType ruby     set iskeyword+=?

" 去掉BOM
" set nobomb; set fileencoding=utf8; w

" js-beautify 格式化网页代码
autocmd FileType javascript noremap <buffer>  <s-f> :call JsBeautify()<cr>
autocmd FileType html noremap <buffer> <s-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <s-f> :call CSSBeautify()<cr>
autocmd FileType javascript vnoremap <buffer>  <s-f> :call RangeJsBeautify()<cr>
autocmd FileType html vnoremap <buffer> <s-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <s-f> :call RangeCSSBeautify()<cr>

" Emmet.vim
" div>p#foo$*3>a
" https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL

" Enable folding with the spacebar
set foldmethod=indent        " 选择代码折叠类型, other:marker,indent,syntax
set foldlevel=99             " 禁止自动折叠 also same: set [no]foldenable
au BufWinLeave * silent mkview  " 保存文件的折叠状态
au BufRead * silent loadview    " 恢复文件的折叠状态
nnoremap <space> za             " 用空格来切换折叠状态
" nnoremap 里第一个 n 代表 normal mode，后面的 noremap 代表不要重复映射，这是避免一个按键同时映射多个动作用的

au FileType javascript set sw=2



"vim 插件调试
"检测插件加载时间
"vim filename --startuptime 'time.txt'
"下面代码可以检测加载插件总用时
"awk '{print $2}' time.txt | sed '/[0-9].*:/d' | awk '{sum+=$1} END {print sum}'
"检测vim在干什么 vim filename -V > savefilename
"
"

" c/c++环境开发IDE
" c开发介绍：http://blog.csdn.net/bokee/article/details/6633193
" Ctags
"inoremap  <c-]> <c-x><c-]> "ctags 补全快捷键
" 用ctrl+]和Ctrl+t跳转定义和返回
nmap <silent><leader>mt :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q <cr><cr>:echo 'Generate Ctags Done'<cr>
" nmap <leader>mt <ESC>:!ctags -R --languages=
" set tags+=~/gitdb/rails/tags
" 生成cscope
" nmap <leader>gc :!cscope -Rbq -f cscope/cs.out <CR><CR>:echo 'generate cscope done'<cr>
" cscope的使用
" <leader>f
" s: Find this C symbol
" g: Find this definition
" d: Find functions called by this function
" c: Find functions calling this function
" t: Find this text string
" e: Find this egrep pattern
" f: Find this file
" i: Find files #including this file
" 使用taglist <leader>tl
" 在. -> :: 等地方可以自动补全

"
"
"marker 使用
" m 0~9 标记文件
" ' 0~9 随时打开文件

" tips: 从vim暂时的切换到Console
" 暂停vim方式:Ctrl+z, jobs, fg
" 使用vim的sh命令启动新console :sh
" 使用!bash启动一个console
" 直接执行:!命令

" }}}
" }}}

" Shorcut {{{

" =======
" 自定义快捷键
" =======


" Win paste
" imap <C-V> <C-r>+

" 把 CTRL-S 映射为 保存
" imap <C-S> <C-C>:w<CR>


" 用两个<CR>可以隐藏执行命令后出现的提示信息"
" map F :call FormatCode() <CR><CR>
" map <silent>F 也可以隐藏
" F                   格式化输出(已抛弃,js-beautify better)
" map F :%s/{/{\r/g <CR> :%s/}/}\r/g <CR>  :%s/;/;\r/g <CR> gg=G


" Ctrl + H            光标移当前行行首/已经搬到兼容区
" imap <c-h> <ESC>I

" Ctrl + J            光标移下一行行首
imap <c-j> <ESC><Down>I

" Ctrl + K            光标移上一行行尾
imap <c-k> <ESC><Up>A

" Ctrl + L            光标移当前行行尾
imap <c-l> <ESC>A

" Alt  + H            光标左移一格
imap <m-h> <Left>

" Alt  + J            光标下移一格
imap <m-j> <Down>

" Alt  + K            光标上移一格
imap <m-k> <Up>

" Alt  + L            光标右移一格
imap <m-l> <Right>

" \c                  复制至公共剪贴板
vmap <leader>c "+y

" \a                  复制所有至公共剪贴板
nmap <leader>a <ESC>ggVG"+y<ESC>

" \v                  从公共剪贴板粘贴
imap <leader>v <ESC>"+p
nmap <leader>v "+p
vmap <leader>v "+p

" \bb                 按=号对齐代码 [Tabular插件]
nmap <leader>bb :Tab /=<CR>

" \bn                 自定义对齐    [Tabular插件]
nmap <leader>bn :Tab /

" \tl                 打开Taglist/TxtBrowser窗口，在右侧栏显示
nmap <leader>tl :Tlist<CR><c-l>

" \ff                 打开文件搜索窗口，在状态栏显示 [ctrlp.vim插件]
nmap <leader>ff :CtrlP<CR>

" \16                 十六进制格式查看
nmap <leader>16 <ESC>:%!xxd<ESC>

" \r16                返回普通格式
nmap <leader>r16 <ESC>:%!xxd -r<ESC>

" \rb                 一键去除所有尾部空白
" imap <leader>rb <ESC>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nmap <leader>rb <ESC>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
vmap <leader>rb <ESC>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" \rt                 一键替换全部Tab为空格
" imap <leader>rt <ESC>:call RemoveTabs()<CR>
nmap <leader>rt :call RemoveTabs()<CR>
vmap <leader>rt <ESC>:call RemoveTabs()<CR>

" \rl
nmap <leader>rl :so ~/.vimrc<CR>

" \r<cr>                 一键替换全部Tab为空格
" imap <leader>rcr <ESC>:%s/\r//g<CR>
nmap <leader>r<cr> :%s/\r//g<CR>
vmap <leader>r<cr> <ESC>:%s/\r//g<CR>

" \th                 一键生成与当前编辑文件同名的HTML文件 [不输出行号]
" imap <leader>th <ESC>:set nonumber<CR>:set norelativenumber<CR><ESC>:TOhtml<CR><ESC>:w %:r.html<CR><ESC>:q<CR>:set number<CR>:set relativenumber<CR>
nmap <leader>th <ESC>:set nonumber<CR>:set norelativenumber<CR><ESC>:TOhtml<CR><ESC>:w %:r.html<CR><ESC>:q<CR>:set number<CR>:set relativenumber<CR>
vmap <leader>th <ESC>:set nonumber<CR>:set norelativenumber<CR><ESC>:TOhtml<CR><ESC>:w %:r.html<CR><ESC>:q<CR>:set number<CR>:set relativenumber<CR>

" move lines up or down (command - D)
nmap <m-j> mz:m+<cr>`z
nmap <m-k> mz:m-2<cr>`z
vmap <m-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <m-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Tab move lines left or right (c-Ctrl,s-Shift)
"nmap    <c-tab>     v>
"nmap    <s-tab>     v<
"vmap    <c-tab>     >gv
"vmap    <s-tab>     <gv

:nmap <c-tab> :tabn<CR>
:map <c-tab> :tabn<CR>
imap <c-tab> <Esc>:tabn<CR>i

:nmap <c-s-tab> :tabp<CR>
:map <c-s-tab> :tabp<CR>
imap <c-s-tab> <Esc>:tabp<CR>i

" 下一个缓冲区
:nmap <leader>n :bn<CR>
:map <leader>n :bn<CR>
imap <leader>n <Esc>:bp<CR>i
:nmap <c-F3> :bn<CR>
:map <c-F3> :bn<CR>
imap <c-F3> <Esc>:bp<CR>i


" 上一个缓冲区
:nmap <leader>p :bp<CR>
:map <leader>p :bp<CR>
imap <leader>p <Esc>:bp<CR>i
:nmap <c-F2> :bp<CR>
:map <c-F2> :bp<CR>
imap <c-F2> <Esc>:bp<CR>i

" \R         一键保存、编译、运行
imap <leader>R <ESC>:call Compile_Run_Code()<CR>
nmap <leader>R :call Compile_Run_Code()<CR>
vmap <leader>R <ESC>:call Compile_Run_Code()<CR>

" \rsl       执行选中行命令
" run the select line in bash
vmap <leader>rsl <esc>:'<,'>:w !sh <CR>
" run the select line output result
vmap <leader>rso <esc>:'<,'>!sh <CR>
" FYI: omitting :w will replace the selection with the command's output.

" \ml        add modeline, display like this: " vim: set ts=4 sw=4 tw=78 et :
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" tabs
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
" map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Line(s) move up/down
nnoremap <silent> <C-k>  :m-2<CR>==
nnoremap <silent> <C-j>  :m+<CR>==
xnoremap <silent> <C-k>  :m'<-2<CR>gv=gv
xnoremap <silent> <C-j>  :m'>+<CR>gv=gv

" Process past
set pastetoggle=<F3>
nnoremap <F3> :set invpaste paste?<CR>
imap <F3> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F3>
" no num and relative
nnoremap <leader><F3> :set relativenumber!<CR>:set nu!<CR>
imap <leader><F3>     :set relativenumber!<CR>:set nu!<CR>

" 切换窗口光标
" switch window
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"nnoremap <leader>w <C-W>w

nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" }}}

" Language {{{

" Python {{{
    " Base Setting {
        " python highlight
        let python_highlight_all = 1
        let b:python_version_2 = 1
        let g:python_version_2 = 1

        au BufRead *.wsgi setl filetype=python

        au BufNewFile,BufRead *.py,*.pyw
            \ set tabstop=4 |
            \ set softtabstop=4 |
            \ set shiftwidth=4 |
            \ set textwidth=79 |
            \ set expandtab |
            \ set autoindent |
            \ set fileformat=unix |

        " Use UNIX (\n) line endings.
        au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

        au BufNewFile,BufRead *.js,*.html,*.css
            \ set tabstop=2 |
            \ set softtabstop=2 |
            \ set shiftwidth=2 |

        " Display tabs at the beginning of a line in Python mode as bad.
        " au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
        " Make trailing whitespace be flagged as bad.
        " au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/


        " 支持Virtualenv虚拟环境

        " 上面“转到定义”功能的一个问题，就是默认情况下Vim不知道virtualenv虚拟环境的情况，所以你必须在配置文件中添加下面的代码，使得Vim和YouCompleteMe能够发现你的虚拟环境：

        " python with virtualenv support
        " py << EOF
        " import os
        " import sys
        " if 'VIRTUAL_ENV' in os.environ:
        "   project_base_dir = os.environ['VIRTUAL_ENV']
        "   activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
        "   execfile(activate_this, dict(__file__=activate_this))
        " EOF
        " 这段代码会判断你目前是否在虚拟环境中编辑，然后切换到相应的虚拟环境，并设置好你的系统路径，确保YouCompleteMe能够找到相应的site packages文件夹。
        " 上面的代码似乎已经被下面的插件智能解 决
        " https://github.com/jmcantrell/vim-virtualenv
        " 如果有一天一直使用 python  可以考虑把 python 放在单独的一个文件配置中, 参考这篇文章
        " https://segmentfault.com/a/1190000003962806
    " }
" }}}

" PHP {{{
    " Base Setting {
        "只有在是PHP文件时，才启用PHP补全
        function! AddPHPFuncList()
            set dictionary+=$HOME/.vim/vimfiles/resource/php-offical.dict
            set complete-=k complete+=k
        endfunction

        " Map <leader>el to error_log value
        " takes the whatever is under the cursor and wraps it in error_log( and
        " print_r( with parameter true and a label
        au FileType php nnoremap <leader>el ^vg_daerror_log( '<esc>pa=' . print_r( <esc>pa, true ) );<cr><esc>

        au FileType php call AddPHPFuncList()
        au FileType php setlocal omnifunc=syntaxcomplete#Complete
        au BufNewFile,BufRead *.phtml set filetype=php

        " set tags+= ~/.vim/vimfiles/resource/tags-php

        " autocmd FileType php setlocal omnifunc=phpcomplete#CompleteTags
        " 除了使用Tab这个补全的方式，还可以使用Ctrl+x，Ctrl+o来补全上面文件的内置函数

        " function! RunPhpcs()
            " let l:filename=@%
            " let l:phpcs_output=system('phpcs --report=csv --standard=YMC '.l:filename)
            " let l:phpcs_list=split(l:phpcs_output, "\n")
            " unlet l:phpcs_list[0]
            " cexpr l:phpcs_list
            " cwindow
            " endfunction

            " set errorformat+=\"%f\"\\,%l\\,%c\\,%t%*[a-zA-Z]\\,\"%m\"
        " command! Phpcs execute RunPhpcs()
        " php debug
        let g:vdebug_keymap = {
        \    "run"               : "<F5>",
        \    "set_breakpoint"    : "<F9>",
        \    "run_to_cursor"     : "<F1>",
        \    "get_context"       : "<F2>",
        \    "detach"            : "<F7>",
        \    "step_over"         : "<F10>",
        \    "step_into"         : "<F11>",
        \    "step_out"          : '<leader><F11>',
        \    "close"             : '<leader><F5>',
        \    "eval_under_cursor" : "<Leader>ec",
        \    "eval_visual"       : "<Leader>ev",
        \}
        let g:vdebug_options = {
        \    "port"               : 9000,
        \    "server"             : 'localhost',
        \    "timeout"            : 20,
        \    "on_close"           : 'detach',
        \    "break_on_open"      : 0,
        \    "path_maps"          : {},
        \    "debug_window_level" : 0,
        \    "debug_file_level"   : 0,
        \    "debug_file"         : "",
        \    "watch_window_style" : 'expanded',
        \    "marker_default"     : '*',
        \    "marker_closed_tree" : '+',
        \    "marker_open_tree"   : '-'
        \}

        " 要让vim支持php/js的错误查询，先安装syntastic插件
        " 然后用php对应的版本pear install PHP_CodeSniffer-2.0.0a2
        " shell测试：phpcs index.php
        " phpcs，tab 4个空格，编码参考使用CodeIgniter风格
        " let g:syntastic_phpcs_conf = "--tab-width=3 --standard=Zend"
        " let g:syntastic_phpcs_conf = "--tab-width=4 --standard=CodeIgniter"
        " 也可以在cli中执行下面的命令
        " phpcs --config-set default_standard Zend
        " 如果怕被phpcs提示的错误吓倒，可以把Zend改成none,这样就只会提示一些常见的错误
        "
        let g:phpqa_messdetector_ruleset = ''
        let g:phpqa_messdetector_cmd = '/usr/bin/phpmd'
        " 在打开文件的时候检查
        let g:phpqa_messdetector_autorun = 0
    " }
" }}}

" Node {{{
let g:used_javascript_libs = 'underscore,jquery,react'

" }}}

" }}}

" Plugins {{{

" =======
" Plugins
" =======

" NERDTree
let NERDTreeQuitOnOpen = 1
let NERDChristmasTree=1
let g:NERDTreeWinSize = 18
" autocmd VimEnter * NERDTree " auto start nerdtree
" autocmd vimenter * if !argc() | NERDTree | endif " if not file start too
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " when no file colse nerdtree
let NERDTreeIgnore = ['\.pyc$','\.sock$', '\~$', '\#.*#$'] "不显示的文件
map <leader>fl :NERDTreeToggle<CR>
" 不显示项目树上额外的信息，例如帮助、提示
let NERDTreeMinimalUI=1


" tComment - inherit the NERD_commenter shortkey
map <leader>ci <Plug>TComment_<Leader>__
map <leader>cm <Plug>TComment_<Leader>_b
" NERD_commenter      注释处理插件
" let loaded_nerd_tree = 1
" let NERDSpaceDelims = 1                        " 自动添加前置空格


" RUBY
" auto completed
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
autocmd FileType ruby compiler ruby


" vim-markdown
" 设置md文件是否用自己的方式折叠
let g:vim_markdown_folding_disabled = 1




"set zen coding
 let g:user_zen_settings = {
  \  'php' : {
  \    'extends' : 'html',
  \    'filters' : 'c',
  \  },
  \  'xml' : {
  \    'extends' : 'html',
  \  },
  \  'haml' : {
  \    'extends' : 'html',
  \  },
  \  'erb' : {
  \    'extends' : 'html',
  \  },
  \}


"scss,sass
au BufRead,BufNewFile *.scss set filetype=scss
au BufRead,BufNewFile *.sass set filetype=scss

"coffee script
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
hi link coffeeSpaceError NONE
hi link coffeeSemicolonError NONE
hi link coffeeReservedError NONE
map <leader>cf :CoffeeCompile watch vert<cr>

"let skim use slim syntax
au BufRead,BufNewFile *.skim set filetype=slim


" Enable omni completion.还不确定这个有什么用
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
" autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

" neocomplcache setting
" Enable heavy omni completion.
" if !exists('g:neocomplcache_omni_patterns')
"   let g:neocomplcache_omni_patterns = {}
" endif
" let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

" minitest
" set completefunc=syntaxcomplete#Complete


"auto completed
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0





" 配置高亮括号 kien/rainbow_parentheses.vim
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

"自定义关联文件类型
au BufNewFile,BufRead *.less set filetype=css

" Indent_guides       显示对齐线
let g:indent_guides_enable_on_vim_startup = 1  " 默认关闭
let g:indent_guides_guide_size            = 1  " 指定对齐线的尺寸
" 因为go自动会添加tab, 使用<leader>ig也可以切换
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'go']


":Tlist               调用TagList
let Tlist_Show_One_File        = 1             " 只显示当前文件的tags
let Tlist_Exit_OnlyWindow      = 1             " 如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_Use_Right_Window     = 1             " 在右侧窗口中显示
let Tlist_File_Fold_Auto_Close = 1             " 自动折叠

" }}}

" Plugin {{{
    " CtrlP {{{
        let g:ctrlp_map = '<c-p>'
        let g:ctrlp_cmd = 'CtrlP'
        let g:ctrlp_working_path_mode = 'ra'
        set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.png,*.gif,*.jpeg,.DS_Store  " MacOSX/Linux
        " nnoremap <Leader>t :CtrlP getcwd()<CR>
        " nnoremap <Leader>f :CtrlPClearAllCaches<CR>
        " nnoremap <Leader>bl :CtrlPBuffer<CR>
        " nnoremap <Leader>j :CtrlP ~/<CR>
        nnoremap <c-s-p> :CtrlPBuffer<CR>
        " 下面这句话是说ctrlp自动默认取消探索所有tmp目录下的文件,所以会导致在tmp目录中
        " 不能使用ctrlp,其实我发现在随便一种tmp目录下面,使用vim的 :e path/to/filename
        " 都没有作用,具体原因可能和ctrlp类似
        " default gtrlp_custom_ignore =  '\v[\/]\.(git|hg|svn)$',
        if exists('g:ctrlp_custom_ignore')
            unlet g:ctrlp_custom_ignore
        endif
        let g:ctrlp_custom_ignore = {
                    \'dir': '\.git$\|\.hg$\|\.svn$\|bower_components$\|dist$\|node_modules$\|project_files$\|test$',
                    \'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$\|\.pyo$\|\.rbc$\|\.rbo$\|\.class$\|\.o$\|\~$'
                    \}

        " command! -nargs=* -complete=function Call exec 'call '.<f-args>
        " command! Q q
        " command! -bang Q q<bang>
        " command! Qall qall
        " command! -bang Qall qall<bang>
        " command! W w
        " command! -nargs=1 -complete=file E e <args>
        " command! -bang -nargs=1 -complete=file E e<bang> <args>
        " command! -nargs=1 -complete=tag Tag tag <args>
        "
        " Save a file that requires sudoing even when
        " you opened it as a normal user.
        command! Sw w !sudo tee % > /dev/null
        " Show difference between modified buffer and original file
        command! DiffSaved call s:DiffWithSaved()

        command! Bw call CleanClose(1,0)
        command! Bq call CleanClose(0,0)
        command! -bang Bw call CleanClose(1,1)
        command! -bang Bq call CleanClose(0,1)
    " }}}
    " YCM {{{
        "competeble with UltraSnips
        let g:ycm_key_list_select_completion   = []
        let g:ycm_key_list_previous_completion = []
        let g:ycm_global_ycm_extra_conf        = $VIM . '/rc/ycm_extra_conf.py'
        " 下里的filetype主要是和上面的syntastic对应，用于使用clang编译的情况
        let g:ycm_extra_conf_vim_data          = ['&filetype', 'g:syntastic_c_compiler_options', 'g:syntastic_cpp_compiler_options']
        let g:ycm_filetype_blacklist = {
            \ 'notes' : 1,
            \ 'markdown' : 1,
            \ 'text' : 1,
            \ 'gitcommit': 1,
            \ 'mail': 1,
        \}
        let g:ycm_error_symbol   = '>>'
        let g:ycm_warning_symbol = '>!'
        let g:ycm_collect_identifiers_from_tags_files = 1
        let g:ycm_collect_identifiers_from_comments_and_strings = 1
        " 确保了在你完成操作之后，自动补全窗口不会消失
        let g:ycm_autoclose_preview_window_after_completion=1
        " offer like ctags: declara, define and multi, only support c/cpp
        " nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
        " nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
        nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>

    " }}}
    " Airline {{{
        " 打开airline的扩展tab buffer exploer功能
        " let g:airline#extensions#tabline#enabled = 1
        " determine whether bufferline will overwrite customization variables
        " let g:airline#extensions#bufferline#overwrite_variables = 1
        " AirLine彩色状态栏:badwolf, bubblegum, luna, raven, serene
        " serene需要修改的地方：
        " 白色状态栏: sol
        " ~/.dotfiles/vimrc/vimfiles/bundle/vim-airline/autoload/airline/themes +4
        " 改为235
        " let g:airline_theme = 'serene'                " 设置主题
        " configure the title text for quickfix buffers
        " let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'

        " Open URI under cursor or search.--go brower
        nmap gb <Plug>(openbrowser-smart-search)
        " Open URI selected word or search.
        vmap gb <Plug>(openbrowser-smart-search)
        " Open URI you also can use <leader>gb because of "textbrowser.vim"
    " }}}
    " Goyo:the pure writer {{{
        function! s:goyo_before()
          silent !tmux set status off
          set noshowmode
          set noshowcmd
        endfunction
        function! s:goyo_after()
          silent !tmux set status on
          set showmode
          set showcmd
        endfunction
        let g:goyo_callbacks = [function('s:goyo_before'), function('s:goyo_after')]
        nmap <Leader><Space> :Goyo<CR>
    " }}}
" }}}

" Locals {{{
if ($ENV == 'windows')
elseif ($ENV == 'macmini')
    set background=light
    colorscheme solarized

endif
" }}}

" vim: set ts=4 sw=4 tw=0 et fdm=marker foldlevel=0 foldenable foldlevelstart=99 :
