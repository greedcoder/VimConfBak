"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 操作系统判定
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 终端&GUI判定
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windows版gVim默认配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if (g:iswindows && g:isGUI)
    set nocompatible
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin

    set diffexpr=MyDiff()
    function MyDiff()
      let opt = '-a --binary '
      if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
      if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
      let arg1 = v:fname_in
      if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
      let arg2 = v:fname_new
      if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
      let arg3 = v:fname_out
      if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
      if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
          if empty(&shellxquote)
            let l:shxq_sav = ''
            set shellxquote&
          endif
          let cmd = '"' . $VIMRUNTIME . '\diff"'
        else
          let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
      else
        let cmd = $VIMRUNTIME . '\diff'
      endif
      silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
      if exists('l:shxq_sav')
        let &shellxquote=l:shxq_sav
      endif
    endfunction
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Linux版gVim&Vim默认配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if g:islinux
    "TODO
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible "禁用 Vi 兼容模式
filetype off "禁用文件类型侦测

set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
call vundle#begin('$VIM/vimfiles/bundle/')

"插件加载外部独立vim配置文件,方便调试
if filereadable(expand($VIM . "/vimrc.bundle"))
    source $VIM/vimrc.bundle
endif

call vundle#end()
filetype plugin indent on "启用文件类型检测,加载文件类型相关插件,使用该类型文件缩进

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 编码格式配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8                                    		"设置显示编码
set fileencoding=utf-8                                		"设置文件保存编码
set termencoding=utf-8                                      "设置终端编码
set fileencodings=utf-8,ucs-bom,gbk,gb2312,cp936,latin-1    "设置文件打开编码

set fileformat=unix                              	"设置新文件的<EOL>换行符格式
set fileformats=unix,dos,mac                      	"打开文件的<EOL>换行符格式类型

if (g:iswindows && g:isGUI)
	"set langmenu=zh_CN
	"let $LANG = 'zh_CN.UTF-8' 
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "解决consle输出乱码
    language messages zh_CN.utf-8
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 文件编辑配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup "关闭自动备份文件
set noswapfile "关闭交换文件
set noundofile "关闭持久撤销功能
"set undofile "持久撤销功能
"set undodir=$VIM/vimfiles/\_undodir
"set undolevels=1000 "maximum number of changes that can be undone

set autoread " 当文件在外部被修改，自动更新该文件
set autoindent
set smartindent "启用智能对齐方式
set tabstop=4 "设置Tab键的宽度
set shiftwidth=4 "换行时自动缩进4个空格
set softtabstop=4
set noexpandtab
"set expandtab "将Tab键转换为空格
set smarttab "指定按一次backspace就删除shiftwidth宽度的空格

set ignorecase "搜索模式里忽略大小写
set smartcase

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 界面显示配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shortmess=atI "去掉欢迎界面
set number "显示行号，反之set nonumber
set relativenumber "显示相对行号，反之set norelativenumber 
nnoremap <silent> <C-N>    :set nu!<CR> "快捷键开关显示行号
"nnoremap <silent> <C-R>    :set relativenumber!<CR> "快捷键开关显示相对行号 "ctrl-r和撤销回复冲突，暂时取消该快捷键"
set cursorline "突出显示当前行
set nowrap "设置不自动换行,禁止折行
set laststatus=2 "启用状态栏信息
set statusline=%<%f%h%m%r\ [%{&ff}]%=%03.3b\ 0x02.2B\ \ Ln:%l,Col%v\ %P\ [Lines=%L] "状态栏信息格式化,启用vim-powerline插件后无效

"set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
"func! CurDir()
"    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
"    return curdir
"endfunc

set cmdheight=2 "设置命令行的高度为2，默认为1
set wildmenu
set showmatch "高亮显示匹配的括号
set ruler "显示当前行号列号
set showcmd "右下角显示当前敲的命令按键
set history=500

if (g:iswindows && g:isGUI)
    "开启语法高亮功能
    syntax enable
    "允许用指定语法高亮配色方案替换默认方案
    syntax on
	"au GUIEnter * simalt ~x "窗口启动时自动最大化
    winpos 100 10 "指定窗口出现的位置，坐标原点在屏幕左上角
    set lines=40 columns=140 "指定窗口大小，lines为高度，columns为宽度
	set guifont=Consolas:h11:cANSI
    "set noeb "set noerrorbells "错误发生的时候将不会发出 bi 的一声
    set noerrorbells
    set novisualbell
    set vb t_vb= "出错发声就彻底被禁止
    au GuiEnter * set t_vb= "关闭闪屏
endif

" 显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    map <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 通用快捷映射配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"定义<Leader>键
let mapleader=","

" 设置环境保存项
set sessionoptions="blank,buffers,folds,globals,help,localoptions,options,resize,sesdir,slash,tabpages,unix,winpos,winsize"
" 保存 undo 历史
"set undodir=~/.undo_history/
"set undofile   
" 保存快捷键
map <leader>ss :mksession! mysession.vim<cr> :wviminfo! my.viminfo<cr>
" 恢复快捷键
map <leader>rs :source mysession.vim<cr> :rviminfo my.viminfo<cr>

if (g:iswindows && g:isGUI)
	unmap  <C-Y>
	iunmap  <C-Y>
endif

" Ctrl + K 插入模式下光标向上移动
imap <c-k> <Up>
" Ctrl + J 插入模式下光标向下移动
imap <c-j> <Down>
" Ctrl + H 插入模式下光标向左移动
imap <c-h> <Left>
" Ctrl + L 插入模式下光标向右移动
imap <c-l> <Right>

"用<C-k,j,h,l>切换到上下左右的窗口中去
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" 常规模式下输入 cS 清除行尾空格
nmap cS :%s/\s\+$//g<CR>:noh<CR>

" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<CR>:noh<CR>

imap <Leader>ymd   <C-R>=strftime("%y%m%d")<CR>
imap <Leader>mdy   <C-R>=strftime("%m/%d/%y")<CR>
imap <Leader>ndy   <C-R>=strftime("%b %d, %Y")<CR>
imap <Leader>hms   <C-R>=strftime("%T")<CR>
imap <Leader>ynd   <C-R>=strftime("%Y %b %d")<CR>
com! YMD :norm! i<C-R>=strftime("%y%m%d")<CR>
com! MDY :norm! i<C-R>=strftime("%m/%d/%y")<CR>
com! NDY :norm! i<C-R>=strftime("%b %d, %Y")<CR>
com! HMS :norm! i<C-R>=strftime("%T")<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 其他配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"a.vim
"用于切换C/C++头文件
":A     ---切换头文件并独占整个窗口
":AV    ---切换头文件并垂直分割窗口
":AS    ---切换头文件并水平分割窗口

"bufexplorer
" 快速轻松的在缓存中切换（相当于另一种多个文件间的切换方式）
" <Leader>be 在当前窗口显示缓存列表并打开选定文件
" <Leader>bs 水平分割窗口显示缓存列表，并在缓存列表窗口中打开选定文件
" <Leader>bv 垂直分割窗口显示缓存列表，并在缓存列表窗口中打开选定文件

"nerdtree
noremap <C-F2> :NERDTreeMirror<CR>
noremap <C-F2> :NERDTreeToggle<CR> "打开/关闭nerdtree

"taglist.vim
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
noremap <C-F3> :TlistToggle<CR> "打开/关闭taglist

"tagbar
noremap <C-F4> :TagbarToggle<CR> "打开/关闭tagbar

"minibufexpl.vim
let g:miniBufExplMapCTabSwitchBufs=1
noremap <C-F5> :MBEToggle<CR> "打开/关闭minibufexpl
noremap <C-Tab> :MBEbn<CR>
noremap <C-S-Tab> :MBEbp<CR>

"vim-colors-solarized
if g:isGUI
"GUI配色方案
    syntax enable
    set background=dark
    "set background=light
    colorscheme solarized
else
"终端配色方案
    "colorscheme Tomorrow-Night-Eighties
endif

"vim-powerline
"状态栏插件，更好的状态栏效果
"let g:Powerline_symbols = 'fancy'

"auto-pairs
"用于括号与引号自动补全

"ctrlp.vim
" 一个全路径模糊文件，缓冲区，最近最多使用，... 检索插件；详细帮助见 :h ctrlp
" 常规模式下输入：Ctrl + p 调用插件

"nerdcommenter
"用于C/C++代码注释(其它的也行)
" 以下为插件默认快捷键，其中的说明是以C/C++为例的，其它语言类似
" <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
" <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
" <Leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
" <Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
" <Leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
" <Leader>cA 行尾注释
let g:NERDSpaceDelims = 1                     "在左注释符之后，右注释符之前留有空格

"vim-cpp-enhanced-highlight
"加强版c++语法高亮
"let g:cpp_class_scope_highlight = 1

"ainbow_parentheses.vim
":RainbowParenthesesToggle       " Toggle it on/off
":RainbowParenthesesLoadRound    " (), the default when toggling
":RainbowParenthesesLoadSquare   " []
":RainbowParenthesesLoadBraces   " {}
":RainbowParenthesesLoadChevrons " <>
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
"Always On
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"ultisnips
"代码片段模板补全,未自带预定义的代码模板
"vim-snippets
"各类语言丰富的代码模板
"Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"indentLine
"用于显示对齐线
nmap <leader>il :IndentLinesToggle<CR> " 开启/关闭对齐线
" 设置Gvim的对齐线样式
if g:isGUI
    let g:indentLine_char = "┊"
    let g:indentLine_first_char = "┊"
endif
" 设置终端对齐线颜色，如果不喜欢可以将其注释掉采用默认颜色
let g:indentLine_color_term = 239
" 设置 GUI 对齐线颜色，如果不喜欢可以将其注释掉采用默认颜色
" let g:indentLine_color_gui = '#A4E57E'

"vim-javascript
let g:javascript_plugin_jsdoc = 1 "Enables syntax highlighting for JSDocs.
let g:javascript_plugin_ngdoc = 1 "Enables some additional syntax highlighting for NGDocs. Requires JSDoc plugin to be enabled as well.
let g:javascript_plugin_flow = 1 "Enables syntax highlighting for Flow.

"cscope_maps
"cs add F:\zzz\lighttpd-1.4.38\src\cscope.out
"查找C语言符号，即查找函数名、宏、枚举值等出现的地方
"   's'   symbol: find all references to the token under cursor
"查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
"   'g'   global: find global definition(s) of the token under cursor
"查找调用本函数的函数
"   'c'   calls:  find all calls to the function name under cursor
"查找指定的字符串
"   't'   text:   find all instances of the text under cursor
"查找egrep模式，相当于egrep功能，但查找速度快多了
"   'e'   egrep:  egrep search for the word under cursor
"查找并打开文件，类似vim的find功能
"   'f'   file:   open the filename under cursor
"查找包含本文件的文
"   'i'   includes: find files that include the filename under cursor
"查找本函数调用的函数
"   'd'   called: find functions that function under cursor calls
if has("cscope")
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    nnoremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nnoremap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

"pydiction
"let g:pydiction_location = $VIM . '\vimfiles\bundle\pydiction\complete-dict'
"let g:pydiction_menu_height = 3

"DrawIt
"ASCII art 风格
"net say:常用操作就两个，:Distart，开始绘制，可用方向键绘制线条，空格键绘制或擦除字符；:Distop，停止绘制。
"offical say:
"\di to start DrawIt and
"\ds to stop  DrawIt.
"But actully \ is <leader> key!!!

"vimtweak.dll
if (g:iswindows && g:isGUI)
    let g:Current_Alpha = 255
    let g:Top_Most = 0
    func! Alpha_add()
        let g:Current_Alpha = g:Current_Alpha + 5
        if g:Current_Alpha > 255
            let g:Current_Alpha = 255
        endif
        call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Alpha_sub()
        let g:Current_Alpha = g:Current_Alpha - 5
        if g:Current_Alpha < 155
            let g:Current_Alpha = 155
        endif
        call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Top_window()
        if  g:Top_Most == 0
            call libcallnr("vimtweak.dll","EnableTopMost",1)
            let g:Top_Most = 1
        else
            call libcallnr("vimtweak.dll","EnableTopMost",0)
            let g:Top_Most = 0
        endif
    endfunc
    "快捷键设置
    nnoremap <c-up> :call Alpha_add()<CR>
    nnoremap <c-down> :call Alpha_sub()<CR>
    nnoremap <leader>t :call Top_window()<CR>
endif

"YouCompleteMe
let g:ycm_global_ycm_extra_conf = $VIM . '\.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
"补全功能在注释中同样有效 
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1 " Completion in string
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
"从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion = 1
" 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_tags_files=1
"禁止缓存匹配项，每次都重新生成匹配项  
let g:ycm_cache_omnifunc = 0
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax = 1
"补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview
" 修改对C函数的补全快捷键，默认是CTRL + space，修改为ALT + ,  
let g:ycm_key_invoke_completion = '<M-,>'
"回车即选中当前项
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
"设置转到定义处的快捷键为ALT + G，这个功能非常赞
nmap <M-g> :YcmCompleter GoToDefinitionElseDeclaration <C-R>=expand("<cword>")<CR><CR>


"使用autocmd根据当前缓冲的文件的类型或者语法的类型添加不同的map命令
"autocmd FileType sometype nnoremap <buffer> <F5> :w<CR>:!somecompiler % <CR>
"<F5>可以改成其他你想映射的键位，如<leader>r。"
autocmd FileType python nnoremap <buffer> <leader>r :w<CR>:!python % <CR>
" -----------------------------------------------------------------------------
"  < 单文件编译、连接、运行配置 >
" -----------------------------------------------------------------------------
" F9 一键保存、编译、连接存并运行
map <F9> :call Run()<CR>
imap <F9> <ESC>:call Run()<CR>

" Ctrl + F9 一键保存并编译
map <c-F9> :call Compile()<CR>
imap <c-F9> <ESC>:call Compile()<CR>

" Ctrl + F10 一键保存并连接
map <c-F10> :call Link()<CR>
imap <c-F10> <ESC>:call Link()<CR>

let s:LastShellReturn_C = 0
let s:LastShellReturn_L = 0
let s:ShowWarning = 1
let s:Obj_Extension = '.o'
let s:Exe_Extension = '.exe'
let s:Sou_Error = 0

let s:windows_CFlags = 'gcc\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CFlags = 'gcc\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

let s:windows_CPPFlags = 'g++\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CPPFlags = 'g++\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

func! Compile()
    exe ":ccl"
    exe ":update"
    let s:Sou_Error = 0
    let s:LastShellReturn_C = 0
    let Sou = expand("%:p")
    let v:statusmsg = ''
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Obj = expand("%:p:r").s:Obj_Extension
        let Obj_Name = expand("%:p:t:r").s:Obj_Extension
        if !filereadable(Obj) || (filereadable(Obj) && (getftime(Obj) < getftime(Sou)))
            redraw!
            if expand("%:e") == "c"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CFlags
                else
                    exe ":setlocal makeprg=".s:linux_CFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CPPFlags
                else
                    exe ":setlocal makeprg=".s:linux_CPPFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            endif
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_C = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_C != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " compilation failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " compilation successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " compilation successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""Obj_Name"is up to date"
        endif
    else
        let s:Sou_Error = 1
        echohl WarningMsg | echo " please choose the correct source file"
    endif
    exe ":setlocal makeprg=make"
endfunc

func! Link()
    call Compile()
    if s:Sou_Error || s:LastShellReturn_C != 0
        return
    endif
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let s:LastShellReturn_L = 0
        let Sou = expand("%:p")
        let Obj = expand("%:p:r").s:Obj_Extension
        if g:iswindows
            let Exe = expand("%:p:r").s:Exe_Extension
            let Exe_Name = expand("%:p:t:r").s:Exe_Extension
        else
            let Exe = expand("%:p:r")
            let Exe_Name = expand("%:p:t:r")
        endif
        let v:statusmsg = ''
        if filereadable(Obj) && (getftime(Obj) >= getftime(Sou))
            redraw!
            if !executable(Exe) || (executable(Exe) && getftime(Exe) < getftime(Obj))
                if expand("%:e") == "c"
                    setlocal makeprg=gcc\ -o\ %<\ %<.o
                    echohl WarningMsg | echo " linking..."
                    silent make
                elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                    setlocal makeprg=g++\ -o\ %<\ %<.o
                    echohl WarningMsg | echo " linking..."
                    silent make
                endif
                redraw!
                if v:shell_error != 0
                    let s:LastShellReturn_L = v:shell_error
                endif
                if g:iswindows
                    if s:LastShellReturn_L != 0
                        exe ":bo cope"
                        echohl WarningMsg | echo " linking failed"
                    else
                        if s:ShowWarning
                            exe ":bo cw"
                        endif
                        echohl WarningMsg | echo " linking successful"
                    endif
                else
                    if empty(v:statusmsg)
                        echohl WarningMsg | echo " linking successful"
                    else
                        exe ":bo cope"
                    endif
                endif
            else
                echohl WarningMsg | echo ""Exe_Name"is up to date"
            endif
        endif
        setlocal makeprg=make
    endif
endfunc

func! Run()
    let s:ShowWarning = 0
    call Link()
    let s:ShowWarning = 1
    if s:Sou_Error || s:LastShellReturn_C != 0 || s:LastShellReturn_L != 0
        return
    endif
    let Sou = expand("%:p")
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Obj = expand("%:p:r").s:Obj_Extension
        if g:iswindows
            let Exe = expand("%:p:r").s:Exe_Extension
        else
            let Exe = expand("%:p:r")
        endif
        if executable(Exe) && getftime(Exe) >= getftime(Obj) && getftime(Obj) >= getftime(Sou)
            redraw!
            echohl WarningMsg | echo " running..."
            if g:iswindows
                exe ":!%<.exe"
            else
                if g:isGUI
                    exe ":!gnome-terminal -x bash -c './%<; echo; echo 请按 Enter 键继续; read'"
                else
                    exe ":!clear; ./%<"
                endif
            endif
            redraw!
            echohl WarningMsg | echo " running finish"
        endif
    endif
endfunc


"cd D:\allwork\mt3_20160525_r47321\mt3\server\server\gate_server\gate\
cd D:\repo4git\nginx-release-1.11.2\src