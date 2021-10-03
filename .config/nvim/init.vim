set number
set autoindent
set smarttab
set hlsearch
set incsearch
set ignorecase
set smartcase
set scrolloff=5
set ruler
set tabstop=4
set shiftwidth=4

filetype indent on
syntax on

call plug#begin(stdpath('data') . '/plugged')

" Plugins start
Plug 'alaviss/nim.nvim'
" Plugings end

call plug#end()
