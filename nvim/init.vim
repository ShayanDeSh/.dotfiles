" 
" author: Shayan Shafaghi
" github: https://github.com/NothingRealm
" mail  : shafaghi1378@gmail.com
"

" visit the folowing site for installing Plug and learning how to work with it
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'liuchengxu/space-vim-dark'
Plug 'chriskempson/base16-vim'

Plug 'vim-scripts/c.vim'
Plug '907th/vim-auto-save'
Plug 'majutsushi/tagbar'
Plug 'xolox/vim-misc'
Plug 'yggdroot/indentline'
Plug 'sudar/vim-arduino-syntax'
Plug 'justinmk/vim-sneak'
Plug 'whatyouhide/vim-gotham'
Plug 'rust-lang/rust.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'morhetz/gruvbox'
Plug 'tikhomirov/vim-glsl'
Plug 'willchao612/vim-diagon'
Plug 'puremourning/vimspector'
Plug 'zbirenbaum/copilot.lua'
" Plug 'lervag/vimtex'
"
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

Plug 'jose-elias-alvarez/null-ls.nvim'

" LSP
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" For completely activating ycm see it's repo on github
" Plug 'ycm-core/YouCompleteMe' " execute 'rustup component add rls rust-analysis rust-src' for rust support
Plug 'nvim-lua/plenary.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'

" nvim-cmp requirements
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-telescope/telescope.nvim'

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
"if exists('$BASE16_THEME')
"      \ && (!exists('g:colors_name') || g:colors_name != 'base16-$BASE16_THEME')
"    let base16colorspace=256
"    colorscheme base16-$BASE16_THEME
"endif

" colorscheme base16-classic-dark
"color base16-classic-dark
"


" hi LineNr ctermbg=NONE
" hi Comment ctermfg=59


" Open .ino files as cpp
au BufRead,BufNewFile *.ino,*.pde set filetype=cpp

let g:airline#extensions#tabline#enabled = 1 
let g:airline_powerline_fonts = 1
"let g:airline_theme='base16_classic_dark'

let g:SimpylFold_docstring_preview=1
" let g:ycm_show_diagnostics_ui = 0

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
set termbidi

" coc

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" 
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" 
" nnoremap <silent> K :call <SID>show_documentation()<CR>
" 
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction


" Vimspector
let g:vimspector_base_dir='/home/shayan/.vim/plugged/vimspector'
nnoremap <Leader>db :call vimspector#Launch()<CR>
nnoremap <Leader>dq :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>oo <Plug>VimspectorStepOut
nmap <Leader>nn <Plug>VimspectorStepInto
nmap <Leader>jj <Plug>VimspectorStepOver

nmap <Leader>ds <Plug>VimspectorBreakpoints

set completeopt=menu,menuone,noselect
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>ft <cmd>Telescope treesitter<cr>
nno <leader>fd <cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>

"markdown-preview
let g:mkdp_refresh_slow = 1
let g:mkdp_theme = 'light'

lua <<EOF
    require("config")
EOF


colorscheme catppuccin-mocha

