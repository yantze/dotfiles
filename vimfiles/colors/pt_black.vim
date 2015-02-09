" author : yantze@126.com
" full name : putty_tmux_black

" Based on
runtime colors/ir_black.vim
" runtime globpath(&rtp, 'colors\ir_black.vim')
" and base-cn on grb256
" From https://github.com/garybernhardt/destroy-all-software-extras/blob/master/das-0030-some-vim-tips/grb256.vim

let g:colors_name = "pt_black"

hi pythonSpaceError ctermbg=red

hi StatusLine       ctermbg=darkgrey  ctermfg=white
hi StatusLineNC     ctermbg=black     ctermfg=lightgrey
hi VertSplit        ctermbg=black     ctermfg=lightgrey
hi LineNr           ctermfg=darkgray

hi Comment          ctermbg=none        ctermfg=grey
hi CursorLine       ctermfg=NONE        ctermbg=0
hi Function         ctermfg=yellow      ctermbg=NONE   cterm=NONE
hi Visual           ctermfg=NONE        ctermbg=32     cterm=NONE

hi Error            ctermfg=16       ctermbg=red     cterm=NONE     guisp=#FF6C60 " undercurl color
hi ErrorMsg         ctermfg=16       ctermbg=red     cterm=NONE
hi WarningMsg       ctermfg=16       ctermbg=red     cterm=NONE
hi SpellBad         ctermfg=16       ctermbg=160     cterm=NONE

" ir_black doesn't highlight operators for some reason
hi Operator         ctermfg=lightblue   ctermbg=NONE        cterm=NONE

hi DiffAdd    term=reverse cterm=bold ctermbg=lightgreen ctermfg=16
hi DiffChange term=reverse cterm=bold ctermbg=lightblue  ctermfg=16
hi DiffText   term=reverse cterm=bold ctermbg=lightgray  ctermfg=16
hi DiffDelete term=reverse cterm=bold ctermbg=lightred   ctermfg=16

hi PmenuSel ctermfg=16 ctermbg=156

