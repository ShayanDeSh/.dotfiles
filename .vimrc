set nocompatible

set clipboard=unnamedplus

set number

set incsearch

set backspace=indent,eol,start

set autoindent

set history=50

set ruler

set splitbelow

set splitright

set encoding=utf-8

set noswapfile

set textwidth=80

set wrap

set autoread

set showcmd

set expandtab

set tabstop=4

set shiftwidth=4

set cursorline

highlight CursorLineNr ctermbg=0 ctermfg=6

filetype off

colorscheme elflord

nnoremap <space> za

nnoremap <C-S-L> :bn<cr>
nnoremap <C-S-K> :bp<cr>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
vnoremap <Tab> >gv
vnoremap <S-tab> <gv

if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'

filetype plugin indent on


