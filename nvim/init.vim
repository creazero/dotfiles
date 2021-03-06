filetype on
filetype plugin indent on
filetype plugin on
syntax on

" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree'
Plug 'roxma/nvim-completion-manager'
Plug 'roxma/ncm-clang'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Completion
Plug 'rust-lang/rust.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'cespare/vim-toml'

Plug 'airblade/vim-gitgutter'

" Hi
Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'

Plug 'morhetz/gruvbox'
Plug 'rakr/vim-two-firewatch'
Plug 'arcticicestudio/nord-vim'

call plug#end()

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
set cursorline
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
colorscheme gruvbox
hi Normal ctermbg=NONE
hi StatusLine ctermbg=7 ctermfg=0

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

let g:ycm_rust_src_path="/home/creazero/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/"
