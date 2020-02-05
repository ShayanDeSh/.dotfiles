set number
set incsearch
set backspace=indent,eol,start
set autoindent
set history=50
set showcmd
set ruler
set splitbelow
set splitright
set encoding=utf-8
set mouse=a
set nocompatible
set noswapfile
filetype off
colorscheme elflord 
nnoremap <space> za
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-S-L> :bn<cr>
nnoremap <C-S-K> :bp<cr>
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
