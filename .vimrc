call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'liuchengxu/space-vim-dark'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

filetype plugin indent on

set clipboard=unnamedplus

filetype off

let mapleader = ","

set nocompatible

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
set softtabstop=4

set foldmethod=indent
set foldlevel=79
set cursorline

if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif
nnoremap <space> za

map <leader>k :bn<cr>
map <leader>j :bp<cr>
map <leader>d :bd<cr>
map <leader>h :set nohlsearch<cr>

nnoremap <cr> o<Esc>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
vnoremap <Tab> >gv
vnoremap <S-tab> <gv

" colorscheme Tomorrow-Night 

colorscheme space-vim-dark
let g:space_vim_dark_background = 233
color space-vim-dark
hi LineNr ctermbg=NONE guibg=NONE
hi Comment guifg=#5C6370 ctermfg=59

let g:airline#extensions#tabline#enabled = 1 
let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'
let g:SimpylFold_docstring_preview=1
