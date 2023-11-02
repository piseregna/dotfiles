"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
"                                                                              "
"                       __   _ _ _ __ ___  _ __ ___                            "
"                       \ \ / / | '_ ` _ \| '__/ __|                           "
"                        \ V /| | | | | | | | | (__                            "
"                         \_/ |_|_| |_| |_|_|  \___|                           "
"                                                                              "
"                                                                              "
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

"=====================================================
"" Plug settings
"=====================================================

call plug#begin('~/.vim/plugged')
    Plug 'preservim/nerdtree'
    Plug 'frazrepo/vim-rainbow'
    Plug 'tpope/vim-surround'
    Plug 'nathanaelkane/vim-indent-guides'



    Plug 'morhetz/gruvbox'
    Plug 'nordtheme/vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    
"    Plug 'ctrlpvim/ctrlp.vim '
    
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
call plug#end()

"=====================================================
"" General settings
"=====================================================

"""""""""""""""" Powerline Settings """"""""""""""""""

"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
"set term=xterm-256color
set termencoding=utf-8

""""""""""""""""" Airline Settings """""""""""""""""""

let g:airline_theme='gruvbox'														"badwolf|PaperColor
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1

""""""""""""""""" Raimbow Brackets """""""""""""""""""
let g:rainbow_active = 1


"""""""""""""""" Remove GUI bar """"""""""""""""""""""

:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

set background=dark    " Setting dark mode
autocmd vimenter * ++nested colorscheme gruvbox
colorscheme gruvbox

set scrolloff=3
set sidescrolloff=3

set ruler
set wildmenu

"""""""""""""""""""""" Others """"""""""""""""""""""""

set history=1000
syntax enable
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set backspace=indent,eol,start " Bring backspace to life
set number relativenumber
set nocompatible
set laststatus=2
set noshowmode
set ruler
set ignorecase
set hlsearch
set incsearch
"filetype plugin indent on
"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use


set cursorline

set nobackup 	                              " no backup files
set nowritebackup                           " only in case you don't want a backup file while editing
set noswapfile 	                            " no swap files

"set list
"set listchars+=tab:┊\ 
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
"=====================================================
"" Keyboard Shortcut
"=====================================================

map <C-d> :NERDTreeToggle<CR>
map <A-b> :call setreg('*',@*,'b')<CR>
map <A-c> :call setreg('*',@*,'c')<CR>
map <A-l> :call setreg('*',@*,'l')<CR>

nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>y "+y
vnoremap <leader>Y "+Y
"=====================================================
"" Functions
"=====================================================
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

"=====================================================
"" Aliasses
"=====================================================
command Rmblank g/^$/d
command! Trim call TrimWhitespace()

"=====================================================
"" Inital window size
"=====================================================
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window (for an alternative on Windows, see simalt below).
  set lines=32 columns=120
endif

"=====================================================
"" Da fare
"=====================================================
"Scroll orizzontale
"Mouversi tra i buffer <--Proprio da capire


"=====================================================
"" CtrlP con Ag
"=====================================================
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
