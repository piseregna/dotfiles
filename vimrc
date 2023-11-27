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

call plug#begin('~/vimfiles/plugged')

"Plug 'preservim/nerdtree'
"Plug 'mileszs/ack.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular'

Plug 'NLKNguyen/papercolor-theme'
Plug 'nathanaelkane/vim-indent-guides'

"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-session'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"Plug 'thaerkh/vim-workspace'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'

call plug#end()


"=====================================================
"" General settings
"=====================================================

"""""""""""""""" Powerline Settings """"""""""""""""""

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline 
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
"
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
set ignorecase
set smartcase
set hlsearch
set hlsearch
set incsearch
filetype plugin indent on
set hidden

"set clipboard=unnamedplus                   " utilizzo la clipboard dell'OS

set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use


set cursorline

set nobackup 	                              " no backup files
set nowritebackup                           " only in case you don't want a backup file while editing
set noswapfile 	                            " no swap files

set splitbelow                              " di degault la finestra splittata sta di sotto
set splitright                              " di degault la finestra splittata sta di a destra

"set list
"set listchars+=tab:┊\ 
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" Better Netrw
let g:netrw_banner = 0 
let g:netrw_browse_split = 4 
let g:netrw_altv = 1 
let g:netrw_liststyle = 3 

if &columns < 90
  let g:netrw_winsize = 50 " If the screen is small, occupy half
else
  let g:netrw_winsize = 30 " else take 30%
endif

let g:netrw_keepdir = 0 " Sync current directory and browsing directory. This solves the problem with the 'move' command
"
"=====================================================
"" Keyboard Shortcut
"=====================================================
" Apre Netrw
map <leader>d :Lexplore<CR>

" Modifica i registri in blocco, carattere e linea 
map <A-b> :call setreg('*',@*,'b')<CR>
map <A-c> :call setreg('*',@*,'c')<CR>
map <A-l> :call setreg('*',@*,'l')<CR>

" Copia e incolla dalla clipboard
nnoremap gp "*p
nnoremap gP "*P
vnoremap gy "*y
vnoremap gY "*Y

" Incolla senza perdere quanto incollato dal registro
nnoremap <leader>p "_p
nnoremap <leader>P "_P

" Seleziona tutto
nnoremap <leader>a ggVG

" Muoversi tra le finestre
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l 

" Resize delle finestre splittate
noremap <silent> <C-S-Left> :vertical resize +5<CR>
noremap <silent> <C-S-Right> :vertical resize -5<CR>

" Usa il selezionato come primo termine per la sostituzione
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left> 

" Muoversi tra i buffer
nnoremap <tab> :bn<CR>
nnoremap <S-tab> :bp<CR>


"=====================================================
" Functions
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
  set lines=42 columns=240
endif


"=====================================================
"" Da fare
"=====================================================
"Scroll orizzontale


