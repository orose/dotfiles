set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'ervandew/supertab'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter.git'

Plugin 'vim-airline/vim-airline'

call vundle#end()
filetype plugin indent on

syntax on
set number
set relativenumber
set hidden

let mapleader = ','

" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>
" Show all open buffers and their status
nmap <leader>bl :ls<CR>

nmap <leader>ne :NERDTree<cr>
nmap <leader>nf :NERDTreeFind<cr>

set expandtab
set shiftwidth=2
set softtabstop=2

set hlsearch
set incsearch
set ignorecase
set smartcase

" Ctrl+P
" ======
let g:ctrlp_custom_ignore = 'node_modules\|bower_components\|vendor\|web/html\|web/css\|web/js'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Airline
" =======
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'


" Colorscheme
" ===========
set background=dark
colorscheme Twilight

