"""""""""""""""""" vim 通用配置 """""""""""""""""""""

" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" 关闭兼容模式
set nocompatible
" vim 自身命令行模式智能补全
set wildmenu

" 配色方案
set background=dark
colorscheme ron
"colorscheme molokai or  desert 

" 禁止光标闪烁
"set gcr=a:block-blinkon0
" 禁止显示滚动条
"set guioptions-=l
"set guioptions-=L
"set guioptions-=r
"set guioptions-=R
" 禁止显示菜单和工具条
"set guioptions-=m
"set guioptions-=T

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 高亮显示搜索结果
set hlsearch

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

" 自适应不同语言的智能缩进
filetype indent on
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

" <<<< 函数标签跳转 >>>>
" 正向遍历同名标签
nmap <Leader>tn :tnext<CR>
" 反向遍历同名标签
nmap <Leader>tp :tprevious<CR>

""""vim ctags 自动更新"""""
noremap <F6> <ESC>:!ctags -R *<CR>:set tags=./tags,./TAGS,tags,TAG<CR>

"""""""""""""""""" vim 通用配置 end """""""""""""""""""""


""""""""""""""""""""""' vim plug 插件配置 """"""""""""""""""""""""""""""
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes


" On-demand loading， nerdtree 文件夹视图
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

"  这个好像是个搜索插件，可以快速的找到文件
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'majutsushi/tagbar'

"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

"Plug 'valloric/youcompleteme'  -- failed  需要联网，在离线环境不好配置

" 括号带颜色
Plug 'luochen1990/rainbow-3.3.1'

Plug 'vim-airline/vim-airline' "主题插件，可以使得状态栏的颜色更加丰富"
Plug 'vim-airline/vim-airline-themes'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()

""""""""""""""""""""""' vim plug 插件配置 end """""""""""""""""""""""""""""


"""""""""" 具体插件定制 """"""""""""

""""""""""""vim-airline-themes""""""""""""""
"其中 vim-airline-themes 是主题插件，可以使得状态栏的颜色更加丰富""""""""'
set laststatus=2  								" 永远显示状态栏
let g:airline_powerline_fonts = 1  				" 支持 powerline 字体
let g:airline#extensions#tabline#enabled = 1 	" 显示窗口tab和buffer
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#whitespace#enabled = 0
"let g:airline_theme='moloai'  					" murmur配色不错
let g:airline_theme = 'dark'
if &background == "light"
    let g:airline_theme = 'light'
endif

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'

" <<  <leader>+ number, buffet 跳转 >>
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9	


" << Buffers 切换 tab  and  shift + tab >>
nmap <S-Tab> :bprev<Return>
nmap <Tab> :bnext<Return>

""  << plug: rainbow >>
let g:rainbow_active = 1


""""""""""""" 文件树设置 NERDTreeToggle """"""""""""""""""""
" 通过F3键来开启和关闭NERDTree
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>

" 启动vim时自动打开NERDTree，并将光标放在Tree的Tag
"autocmd VimEnter * NERDTree

" 启动vim时自动打开NERDTree，并将光标放在vim打开的文件
"autocmd VimEnter * NERDTree | wincmd p

" 如果退出vim后只剩Tree的Tag的话，则自动退出Tree的Tag
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" 当打开文件时，如果 NERDTree 是唯一的窗口，则关闭它
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"当打开vim且没有文件时自动打开NERDTree
"autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"""""""""""""" NERDTreeToggle end """"""""""""""""""""


"""""""""" Taglist (ctags)""""""""""""""""
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1  "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1  "如果taglist窗口是最后一个窗口，则退出vim

let Tlist_Auto_Open=1    "在启动VIM后，自动打开taglist窗口

"let Tlist_Use_SingleClick= 1    " 缺省情况下，在双击一个tag时，才会跳到该tag定义的位置

"let Tlist_Process_File_Always=1  "taglist始终解析文件中的tag，不管taglist窗口有没有打开

"let Tlist_File_Fold_Auto_Close=1 "同时显示多个文件中的tag时，可使taglist只显示当前文件tag，其它文件的tag都被折叠起来
"""""""""""""""""""end """""""""""""""""""""""""""

"""""""""""""" cscope 配置 """"""""""""""""""""""""""""
" todo

""""""""""""" fzf """""""""""""""""'''
" <<< fzf 配置： 就可以使用 Ctrl + p 来快速打开文件了。 >>>
nnoremap <C-p> :Files<CR>
" <<< fzf 配置： 实现查找工程中特定字符的工具，这样ctrl + f 就可以进行全局的字符串搜索了
" ubuntu 需要安装 : sudo apt-get install ripgrep
nnoremap <C-f> :Rg<CR>  

"""""""""" 具体插件定制 end """"""""""""

