" introduce
" author: yantze
" date:2014-08-14

" Environment {

    " Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win16') || has('win32') || has('win64'))
        endfunction
    " }

    " Basics {
        set nocompatible        " Must be first line
    " }

    " Windows Compatible {
        if WINDOWS()
            let g:isWIN = 1
            " set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        else
            " 兼容windows的环境变量$VIM
            let $VIM = $HOME."/.vim"
            set shell=/bin/sh
            let g:isWIN = 0
        endif
    " }

    " 判断是否处于GUI界面
    if has("gui_running")
        let g:isGUI = 1
    else
        let g:isGUI = 0
    endif

" }





" 添加vundle插件管理
set nocompatible               " 设置不与之前版本兼容 be iMproved
filetype off                   " 检测文件类型 required!
" set rtp+=$VIM/bundle/Vundle.vim  "添加vendle环境变量
if filereadable(expand("$VIM/_vimrc.bundles"))
   set rtp+=$VIM/vimfiles/bundle/Vundle.vim  "添加vendle环境变量
   source $VIM/_vimrc.bundles
endif
"you can put it in tmpfs:/dev/shm/.dotfiles/vimrc/vimfiles/bundle/Vundle.vim
" 安装新的插件 :PluginInstall
" 在命令行运行 vim +PluginInstall +qall
" 更新插件:PluginUpdate
" 清除不再使用的插件:PluginClean,
" 列出所有插件:PluginList
" 查找插件:PluginSearch


syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype plugin indent on    " 启用自动补全
set ic                       "忽略大小写查找
set visualbell t_vb=         "关闭visual bell/声音
au GuiEnter * set t_vb=      "关闭beep/屏闪

" file
" 设定换行符
set fileformats=unix
" 设定文件浏览器目录为当前目录
set bsdir=buffer
" 设置编码
set enc=utf-8
" 设置文件编码
set fenc=utf-8
" 设置文件编码检测类型及支持格式
set fencs=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936




" 设置着色模式和字体
" 使用GUI界面时的设置
if g:isWIN
    if g:isGUI
        "启动gvim时窗口的大小
        "set lines=42 columns=170
        " 启动时自动最大化窗口
        au GUIEnter * simalt ~x

        "winpos 20 20             " 指定窗口出现的位置，坐标原点在屏幕左上角
        "set lines=20 columns=90  " 指定窗口大小，lines为高度，columns为宽度
        set guioptions+=c        " 使用字符提示框
        set guioptions-=m        " 隐藏菜单栏
        set guioptions-=T        " 隐藏工具栏
        "set guioptions-=L        " 隐藏左侧滚动条
        "set guioptions-=r        " 隐藏右侧滚动条
        "set guioptions-=b        " 隐藏底部滚动条
        "set showtabline=1        " 隐藏Tab栏

        set cursorline            " 突出显示当前行

        "set colortheme molokai autumn blackboard asu1dark busybee tomorrow
        colorscheme solarized

        "set font
        "set guifont=Consolas:h12
        "set guifont=Monaco:h15
        "set guifont=Source\ Code\ Pro\ Regular:h15
        set guifont=Source\ Code\ Pro\:h13
    else
        colorscheme ir_black
        " 兼容windows下cmd的gb2312
        set enc=cp936

    endif
else
    if g:isGUI
        set guifont=Monaco\ 11
    else
        " colorscheme ir_black
        " colorscheme grb256
        colorscheme vt_tmux
        "
        " set background=dark
        " let g:solarized_termtrans =0
        " let g:solarized_termcolors=256
        " colorscheme solarized
        " colorscheme BusyBee
        " set guifont=Monaco\ 11
    endif
endif

if v:version > 703
    " 开启相对行号
    set relativenumber

    " 替换原来的查找，可以同时显示多个查找关键字
    map  / <Plug>(easymotion-sn)
    omap / <Plug>(easymotion-tn)

    " These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
    " Without these mappings, `n` & `N` works fine. (These mappings just provide
    " different highlight method and have some other features )
    " map  n <Plug>(easymotion-next)
    " map  N <Plug>(easymotion-prev)
endif





"set my leader
let mapleader=","
let g:mapleader=","
"set : to ;
map ; :



" kk 返回Normal模式，不执行保存
" imap kk <ESC>l

" Win paste
" imap <C-V> <C-r>+

"switch window
" :map <leader>w <C-W>w

" 把 CTRL-S 映射为 保存
" imap <C-S> <C-C>:w<CR>

" =========
" Functions
" =========

" 用两个<CR>可以隐藏执行命令后出现的提示信息，原创哦."
" map F :call FormatCode() <CR><CR>
" map <silent>F 也可以隐藏

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

" 这个函数是我用来整理loveacc博客的资料
func! RemoveSong()
    :%s/　//g
    :%s/\[.*//g
    :%s/...EP//g
    :%s/...Single//g
    :%s/\s–\s/\r/g
endfunc
map <leader>rs <ESC>:call RemoveSong()<CR>

" =======
" 自定义快捷键
" =======

" Ctrl + H            光标移当前行行首
imap <c-h> <ESC>I

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
imap <leader>rb <ESC>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nmap <leader>rb <ESC>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
vmap <leader>rb <ESC>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" \rt                 一键替换全部Tab为空格
imap <leader>rt <ESC>:call RemoveTabs()<CR>
nmap <leader>rt :call RemoveTabs()<CR>
vmap <leader>rt <ESC>:call RemoveTabs()<CR>

" \th                 一键生成与当前编辑文件同名的HTML文件 [不输出行号]
imap <leader>th <ESC>:set nonumber<CR>:set norelativenumber<CR><ESC>:TOhtml<CR><ESC>:w %:r.html<CR><ESC>:q<CR>:set number<CR>:set relativenumber<CR>
nmap <leader>th <ESC>:set nonumber<CR>:set norelativenumber<CR><ESC>:TOhtml<CR><ESC>:w %:r.html<CR><ESC>:q<CR>:set number<CR>:set relativenumber<CR>
vmap <leader>th <ESC>:set nonumber<CR>:set norelativenumber<CR><ESC>:TOhtml<CR><ESC>:w %:r.html<CR><ESC>:q<CR>:set number<CR>:set relativenumber<CR>

" 格式化输出
map F :%s/{/{\r/g <CR> :%s/}/}\r/g <CR>  :%s/;/;\r/g <CR> gg=G

" move lines up or down (command - D)
nmap <D-j> mz:m+<cr>`z
nmap <D-k> mz:m-2<cr>`z
vmap <D-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <D-k> :m'<-2<cr>`>my`<mzgv`yo`z

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

:nmap <leader>n :bn<CR>
:map <leader>n :bn<CR>
imap <leader>n <Esc>:bp<CR>i

:nmap <leader>p :bp<CR>
:map <leader>p :bp<CR>
imap <leader>p <Esc>:bp<CR>i


"auto completed
"RUBY
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

"RUBY plugin
autocmd FileType ruby compiler ruby

" auto start nerdtree
" autocmd VimEnter * NERDTree
" if not file start too
" autocmd vimenter * if !argc() | NERDTree | endif
" when no file colse nerdtree
 autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set backspace=2              " 设置退格键可用
set autoindent               " 自动对齐
set smartindent              " 智能自动缩进
set nu!                      " 显示行号
" set mouse=a                  " 启用鼠标
set ruler                    " 右下角显示光标位置的状态行
set incsearch                " 开启实时搜索功能
set hlsearch                 " 开启高亮显示结果
set nowrapscan               " 搜索到文件两端时不重新搜索
" set nocompatible             " 关闭兼容模式
set hidden                   " 允许在有未保存的修改时切换缓冲区
set autochdir                " 设定文件浏览器目录为当前目录
set foldmethod=syntax        " 选择代码折叠类型
set foldlevel=100            " 禁止自动折叠
set laststatus=2             " 开启状态栏信息
set cmdheight=2              " 命令行的高度，默认为1，这里设为2
set writebackup              " 设置无备份文件
set autoread                 " 当文件在外部被修改时自动更新该文件
set nobackup                 " 不生成备份文件
set noswapfile               " 不生成交换文件
set wildmenu                 " 在命令行下显示匹配的字段到状态栏里面
set list                     " 显示特殊字符，其中Tab使用高亮竖线代替，尾部空白使用高亮点号代替
set listchars=tab:\|\ ,trail:.

" Tab
set tabstop=4
set cindent shiftwidth=4
"set autoindent shiftwidth=4
"set ts=4 sw=4 et  "ts=tabstop=4 sw=shiftwidth=4 et=expandtab
set smarttab                 "在行首按TAB将加入sw个空格，否则加入ts个空格;按Backspace可以删除4个空格
" set ambiwidth=double  "如果全角字符不能识别一般用这个
set ai!                      " 设置自动缩进
set expandtab                " 将Tab自动转化成空格 [需要输入真正的Tab键时，使用 Ctrl+V + Tab]
" 详细的tab设置：http://blog.chinaunix.net/uid-24774106-id-3396220.html
"set showmatch               " 显示括号配对情况
"set nowrap                  " 设置不自动换行
"

" set tw=78     "超过80个字符就折行
set lbr       "不在单词中间断行
set fo+=mB    "打开断行模块对亚洲语言支持
" set lsp=0     "设置行间距
"


" set 折叠
set foldmethod=indent
" 打开文件默认不折叠
set foldlevelstart=99

let g:vim_markdown_folding_disabled = 0


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

" =======
" Plugins
" =======

" NERD_commenter      注释处理插件
"let loaded_nerd_tree = 1
let NERDSpaceDelims = 1                        " 自动添加前置空格
let NERDTreeQuitOnOpen = 1
let NERDChristmasTree=1
let g:NERDTreeWinSize = 18
map <leader>f :NERDTreeToggle<CR>



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

"ctags
set tags+=~/gitdb/rails/tags

"auto completed
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0


" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete


"set powerline
set laststatus=2
"set guifont=Powerline
"set font=Source\ Code\ Pro\:h15
set nocompatible
set t_Co=256
let g:Powerline_cache_enabled = 1

"minitest
set completefunc=syntaxcomplete#Complete

"process past
set pastetoggle=<F3>
nnoremap <F3> :set invpaste paste?<CR>
imap <F3> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F3>

" RSpec.vim mappings
" map <Leader>t :call RunCurrentSpecFile()<CR>
" map <Leader>s :call RunNearestSpec()<CR>
" map <Leader>l :call RunLastSpec()<CR>
" map <Leader>a :call RunAllSpecs()<CR>

" 切换窗口光标，兼容tmux的快捷键
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Goyo writer faver
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

" 打开airline的扩展tab buffer exploer功能
let g:airline#extensions#tabline#enabled = 1

" determine whether bufferline will overwrite customization variables
let g:airline#extensions#bufferline#overwrite_variables = 1

" AirLine彩色状态栏
let g:airline_theme = 'badwolf'                " 设置主题

" configure the title text for quickfix buffers
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'

" Open URI under cursor or search.--go brower
nmap gb <Plug>(openbrowser-smart-search)
" Open URI selected word or search.
vmap gb <Plug>(openbrowser-smart-search)

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
au BufNewFile,BufRead *.phtml set filetype=php

":Tlist              调用TagList
let Tlist_Show_One_File        = 1             " 只显示当前文件的tags
let Tlist_Exit_OnlyWindow      = 1             " 如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_Use_Right_Window     = 1             " 在右侧窗口中显示
let Tlist_File_Fold_Auto_Close = 1             " 自动折叠

" Indent_guides       显示对齐线
let g:indent_guides_enable_on_vim_startup = 1  " 默认关闭
let g:indent_guides_guide_size            = 1  " 指定对齐线的尺寸



" <leader>a 排列归类
" <leader>ci 注释+// 可toggle
" <leader>cm 注释+/**/
"bn/bp 切换buffer
"tabn/tabp 切换tab
"tn 创建新窗口
"gb 打开或者搜索光标下的内容 这个好像有时候会失效
" <leader>g/f 搜索和查找
":retab 对当前文档重新替换tab为空格
"用Ctrl+v Tab也可以产生原生的Tab
"f  查找当前行的字符
"Ctrl+p 打开文件列表Ctrl+jk来选择文件
" <leader>be打开当前所有buffer的列表<leader>bs,<leader>bv
" <leader>Space 打开Goyo编写环境
" gf 如果是路径可以打开这个文件
" gd 找到定义
" :e $m<tab> 自动扩展到:e $MYVIMRC 然后打开_vimrc
" <c-y>,  扩展htmlcss的文件
"
"少用
"ga 转换光标下的内容为多进制
":e $MYVIMRC 快速打开配置文件,$MYGVIMRC
"inoremap  <c-]> <c-x><c-]> "ctags 补全快捷键
" :set notextmode  去掉^M这个符号
" :set paste  这个可以解决在linux下面有些字母会被执行
" :set nopaster
" :set pastetoggle
" 如果碰到输入不了*号键，可以先按Ctrl+v，再输入想要输入的特殊符号
" gCtrl+g 统计字数
" Ctrl+x, Ctrl+f 补全当前要输入的路径
"
"
" manpageview phpfunctionname
" 可以使用快捷键K查询
"
"
" =========
" PHP
" =========
"只有在是PHP文件时，才启用PHP补全
" au FileType php call AddPHPFuncList()
" function AddPHPFuncList()
    " set dictionary-=/home/feiyan/tools/vim/funclist.txt dictionary+=/home/feiyan/tools/vim/funclist.txt
    " set complete-=k complete+=k
" endfunction

autocmd FileType php setlocal dict+=$VIM/vimfiles/resource/php.dict

" ==============
" Syntastic: php
" ==============
let g:syntastic_check_on_open=0

" ===php===
" 要让vim支持php/js的错误查询，先安装syntastic插件
" 然后用php对应的版本pear install PHP_CodeSniffer-2.0.0a2
" shell测试：phpcs index.php
"在打开文件的时候检查
"phpcs，tab 4个空格，编码参考使用CodeIgniter风格
" let g:syntastic_phpcs_conf = "--tab-width=3 --standard=Zend"
" let g:syntastic_phpcs_conf = "--tab-width=4 --standard=CodeIgniter"
" 也可以在cli中执行下面的命令
" phpcs --config-set default_standard Zend
" 如果怕被phpcs提示的错误吓倒，可以把Zend改成none,这样就只会提示一些常见的错误
"
let g:phpqa_messdetector_ruleset = ''
let g:phpqa_messdetector_cmd = '/usr/bin/phpmd'
let g:phpqa_messdetector_autorun = 0
"
" ===js===
" 需要用nodejs下的包安装工具npm安装npm install -g jshint
" shell测试：jshint -version
"

" ==============
" web : html css
" ==============
" 只能在特定的文件里面才载入，默认是全局
let g:user_emmet_install_global = 0
autocmd FileType html,css,phtml,tpl EmmetInstall

" 这个主要用来对txt文档也可以用taglist列表
au BufEnter *.txt,*.log,*.ini setlocal ft=txt

" 配置vim-expand-region
" map <leader>K <Plug>(expand_region_shrink)
" map K <Plug>(expand_region_expand)


autocmd BufReadPre * if getfsize(expand("%")) > 10000000 | syntax off | endif

"let g:snippets_dir="$VIM/vimfiles/resource/vim-snippets/" "代码片段的
"
autocmd BufRead,BufNewFile *.js set filetype=javascript syntax=jquery


" TODO
"
"
"vim 插件调试
"检测插件加载时间
"vim filename --startuptime 'time.txt'
"下面代码可以检测加载插件总用时
"awk '{print $2}' time.txt | sed '/[0-9].*:/d' | awk '{sum+=$1} END {print sum}'
"检测vim在干什么 vim filename -V > savefilename
"
"


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

" c/c++环境开发IDE
" c开发介绍：http://blog.csdn.net/bokee/article/details/6633193
" generate ctags
nmap <silent><leader>gt :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q <cr><cr>:echo 'generate ctags done'<cr>
" ctags的使用
" 用ctrl+]和Ctrl+t跳转定义和放回
" 生成cscope
nmap <leader>gc :!cscope -Rbq -f cscope/cs.out <CR><CR>:echo 'generate cscope done'<cr>
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

" PHP 环境开发
" CTRL+P给函数做注释
"
"
"
"

" tips
" 从vim暂时的切换到Console
" 暂停vim方式:Ctrl+z, jobs, fg
" 使用vim的sh命令启动新console :sh
" 使用!bash启动一个console
" 直接执行!命令

" For Mac
"
" noremap <silent> <M-up> <C-W>+
" noremap <silent> <M-down> <C-W>-
"
" fix some unexpectly bugs
"
" http://vim.1045645.n5.nabble.com/Mapping-meta-key-within-tmux-td5716437.html
" Fix screen's key bindings.
   " if &term == "screen"
       " These work from my HP keyboard in PuTTY on Windows XP.
       " map <Esc>[D   <S-Left>
       " map <Esc>[C   <S-Right>
       " map <Esc>[11~ <F1>
       " map <Esc>[12~ <F2>
       " map <Esc>[13~ <F3>
       " map <Esc>[14~ <F4>
       " map <Esc>[15~ <F5>
       " map <Esc>[16~ <F6>
       " map <Esc>[17~ <F7>
       " map <Esc>[18~ <F8>
       " map <Esc>[19~ <F9>
       " map <Esc>[21~ <F10
       " map <Esc>[23~ <F11>
       " map <Esc>[24~ <F12>
   " endif

" deploy python
" source $VIM/rc/py

if WINDOWS()
    let g:hexoProjectPath="D:\\Work\\GitHub\\hexo"
else
    let g:hexoProjectPath="~/hexo/"
endif
fun! OpenHexoProjPath()
    execute "cd " . g:hexoProjectPath
endfun
function! OpenHexoPost(...)
    call OpenHexoProjPath()

    let filename = "source/_posts/" . a:1 . ".md"
    execute "e " . filename
endfunction
function! NewHexoPost(...)
    call OpenHexoProjPath()

    let filename = a:1
    execute "!hexo new " . filename

    call OpenHexoPost(a:1)
endfunction
command -nargs=+ HexoOpen :call OpenHexoPost("<args>")
command -nargs=+ HexoNew :call NewHexoPost("<args>")
" :HexoNew artical-name
" :HexoOpen artical-name

" map <leader>ag :Ag
" cnoreabbrev ag Ag
" cabbrev ag Ag
" there use special tech
cabbrev ag <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Ag' : 'ag')<CR>
