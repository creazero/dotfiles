filetype on
filetype plugin indent on
filetype plugin on
syntax on

" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install.py --all' }

" Completion
Plug 'roxma/nvim-completion-manager'
Plug 'roxma/clang_complete'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'roxma/nvim-cm-racer'

" Hi
Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'itchyny/lightline.vim'
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.local/share/nvim/plugged/gocode/nvim/symlink.sh' }

" Colors
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'beigebrucewayne/Turtles'
Plug 'morhetz/gruvbox'
Plug 'nelstrom/vim-mac-classic-theme'
Plug 'nanotech/jellybeans.vim'

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

let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'gitbranch', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

let g:clang_library_path='/usr/lib64/libclang.so.3.9'

:noremap / :set hlsearch<CR>/

" toggle paste mode
:noremap <F2> :set paste! nopaste?<CR>

" toggle number lines
:noremap <F3> :set nonumber! nonumber?<CR>

" toggle search highlights
:noremap <F4> :set hlsearch! hlsearch?<CR>

colorscheme jellybeans
hi Normal ctermbg=NONE

set hidden
let mapleader=","

nnoremap <leader>bd :bd<cr>
nnoremap <leader>l :bn<cr>
nnoremap <leader>h :bp<cr>
nnoremap <leader>ev :vs $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

inoremap jk <esc>
inoremap <esc> <nop>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

au FileType c,cpp nmap <leader>gd <Plug>(clang_complete_goto_declaration)

augroup CPP
    au!
    au BufEnter,BufNewFile, *.c, *.h, *.cpp, setlocal ts=2 sw=2 sts=2
