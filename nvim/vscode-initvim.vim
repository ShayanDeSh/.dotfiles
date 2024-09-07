" 
" author: Shayan Shafaghi
" github: https://github.com/NothingRealm
" mail  : shafaghi1378@gmail.com
"

" visit the folowing site for installing Plug and learning how to work with it
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'justinmk/vim-sneak'
call plug#end()

filetype plugin indent on

set clipboard=unnamedplus

nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <C-c> <nop>

" Left and right can switch buffers
nnoremap <up> :bn<CR>
nnoremap <down> :bp<CR>
nnoremap <right> gt
nnoremap <left> gT
nmap <leader>td :tabclose<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

filetype off
" In normal mode every char after ',' will be read as command
let mapleader = ","

set nocompatible
" Press : and then type some incomplete command you shall see the effect
set wildmenu
" Numbering line
set number
" Incremental search
set incsearch
set backspace=indent,eol,start
set autoindent
" set history to 50 :)
set history=50
" tell you where the hell you are
set ruler
" split command will split on below
set splitbelow
" vsplit command will split on right
set splitright

set encoding=utf-8
" get rid of swap files
set noswapfile
set autoread
" shows the command you entered
set showcmd

set mouse=

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

au BufNewFile,BufRead *.py  
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal expandtab |
    \ setlocal autoindent |
    \ setlocal fileformat=unix

au BufNewFile,BufRead *.yaml,*.yml
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal shiftwidth=2 |
    \ setlocal expandtab |
    \ setlocal autoindent |
    \ setlocal fileformat=unix

set cindent
au BufRead,BufNewFile *.c,*.h
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal autoindent |
    \ setlocal expandtab |
    \ setlocal fileformat=unix

set cursorline

if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif
nnoremap <space> za

" list buffers
map <leader>bl :buffers<cr>

" goto buffer
map <leader>bg :call <SID>gotobuffer()<cr>
function! s:gotobuffer()
    execute ":buffers"
    try
        execute ":buffer ". input('buffer number: ')
    catch /.*/
        redraw
        echo "Buffer doesn't exsists"
    endtry
endfunction

" In normal mode use ,nn to go to next buffer
map <leader>bn :bn<cr>
" In normal mode use ,p to go to previous buffer
map <leader>bp :bp<cr>
" In normal mode use ,bd to delete buffer
map <leader>bd :bd<cr>
" In normal mode use ,nh to hide search highlighting 
map <leader>nh :noh<cr>
" In normal mode use ,h to show search highlighting 
map <leader>h :set hlsearch<cr>
" In normal mode use ,d to go to delete line
map <leader>d "_dd

" In normal mode use enter to add new line without gooing to insert mode
nnoremap <cr> o<Esc>

" Moving around float buffer window
" nnoremap <silent><nowait><expr> <C-J> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-F>"
" nnoremap <silent><nowait><expr> <C-K> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-B>"
" nnoremap <C-H> <C-W><C-W>

" In normal mode you can use tab to indent line
nnoremap <Tab> >>_
" In normal mode you can use Shift tab to unindent line
nnoremap <S-Tab> <<_
" Also in visual mode
vnoremap <Tab> >gv
vnoremap <S-tab> <gv

" Some shorcut for YCM
" nnoremap <silent> <leader>gr :YcmCompleter GoToReferences<CR>
" nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
"let python_highlight_all=1
"
if exists('$BASE16_THEME')
      \ && (!exists('g:colors_name') || g:colors_name != 'base16-$BASE16_THEME')
    let base16colorspace=256
    colorscheme base16-$BASE16_THEME
endif

"colorscheme base16-classic-dark
"color base16-classic-dark
"
"colorscheme space-vim-dark
"let g:space_vim_dark_background = 233
"color space-vim-dark

hi LineNr ctermbg=NONE
hi Comment ctermfg=59
