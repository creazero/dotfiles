set laststatus=2
set noshowmode

set showcmd
set ignorecase
set smartcase
set expandtab
set smarttab
set hlsearch
set number
set noswapfile
set autoindent

set shiftwidth=4
set softtabstop=4
set scrolloff=8
set sidescrolloff=10

set timeoutlen=1000
set ttimeoutlen=0

" for cross-terminal clipboard support
set clipboard=unnamed
set clipboard^=unnamedplus

:noremap / :set hlsearch<CR>/

" toggle paste mode
:noremap <F2> :set paste! nopaste?<CR>

" toggle number lines
:noremap <F3> :set nonumber! nonumber?<CR>

" toggle search highlights
:noremap <F4> :set hlsearch! hlsearch?<CR>

set background=dark
syntax on

set hidden
let mapleader=" "
"hi StatusLine   ctermbg=NONE   ctermfg=231 cterm=NONE
"hi StatusLineNC ctermfg=231 ctermbg=234 cterm=NONE
"hi CursorLine   ctermfg=NONE   ctermbg=8   cterm=NONE
"hi CursorLineNr ctermfg=NONE   ctermbg=8   cterm=NONE

nnoremap <leader>bd :bd<cr>
nnoremap <leader>l :bn<cr>
nnoremap <leader>h :bp<cr>
nnoremap <leader>ev :vs $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>; :Buffers<cr>
nnoremap <leader>t :Files<cr>

let g:ackprg = 'ag --nogroup --nocolor --column'

inoremap jk <esc>
inoremap <esc> <nop>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

