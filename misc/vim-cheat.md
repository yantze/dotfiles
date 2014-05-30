POS
    - h,j,k,l,H,M,L
    - gg,1G : top
    - G     : bottom
    - nG    : n line, n%G
    - <C-G> : show current pos
    - 0     : home
    - ^     : home not null
    - $     : end
    
    - gi    : go&edit last edit pos
	- g; g,	: go older/newer change
	- :changes : change list
    
    - <C-F\B> : next, prev page
    
    - w,W   : next word(not null chars)
    - b,B   : back word
    - e,E   : next word end, ge/gE back

    - f,F,t,T   : find/until char
    
    - (,)   : next,prev string
    
    - H,M,L : viewport top/middle/buttom
    - zt/z/b: scroll to cursor at top/middle/buttom

    - gd    : go var's defined pos
    - %     : match code block
    - ms    : mark [s]
    - `s    : go mark [s]
    - `.    : last edit pos

    - <C-o/l>   : prev/next cursor pos
	
	- zz h j: scroll center/left... 

EDIT
    - a,A,i,I,o,O
    - u     : undo
    - <C-r> : redo
    
    - r,R   : replace(ever)
    - d,D   : delete(after) //dd del line
    - c,C   : change ?/line
    - y,Y   : copy(line) //Y=yy
    - p,P,[p : paste after/forward (with auto index)
    - x,X,s : del char
    
    - J     : join next line
    - .     : repeat

    
	
	=====Insert Mode======
    - <C-o> : temporary normal mode
	- <C-r>n: paste "n clip
	- <C-t>	: indent
	- <C-d>	: undent
    - <C-w> : window control h,j,k,l, o
	
OBJECT
    - w     : word
    - e     : word !space
    
    - f,F,t,T x : find/until x //df[e]
    - ;     : refind
    
    - i*    : inner m // w[('"<(..) //di", diw delete surround word
    - a*    : all, include [] or space
    
SEARCH, REPLACE
    - /String, ?String :search String
    - *, #  : search current word next/prev
    - n, N  : next, prev Search
    
    - #,# s/old/new/g : # line to # line
    
    - q/,q? : search history

SECTION
    - v, V, <C-V> : char, line, block selection
    - u, U, ~ : lower, upper, reverse
    
    - <C-V>G$A : line end edit
    
CLIP
    - "k    : use [k] clip //"xyy = V"xy, "xp paste
    - "+    : system clip
    
MACRO
    - qx    : record
    - @x    : use record
    
OTHER
    - <C-P/N> : auto complete
	- <C-a/x> : increase/decrease number
    - <C-G>   : show info?
    - Q       : ex mode
    - q:      : command history
	
	- ga/g8   : show char code hex/unicode
    
PLUGS
    - matchit.vim 



COMMANDS
    - ls    : show buffers
    - bn    : go buffer [n]
    - bdn   : delete buffer [n]
    
    - q:    : command history
    
    - vimgrep string *  : find file in *
    - copen             : show find file list
    - cn, cp            : show n/p finded file

    - reg   : view clips

NERDTREE
    - o
    - t,T

    
    
    
    
    
    
===============
SCRIPT
    - let @"="value" :modify " clip //""p -> value //expand("%:p"):file name
    - autocmd eventName *.js :action
    - command! -nargs=n -complete=types Cname echo 1 : custom command
