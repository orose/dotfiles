set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'ervandew/supertab'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jiangmiao/auto-pairs'
Plugin 'alvan/vim-closetag'

Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter.git'

Plugin 'itchyny/lightline.vim'

Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

Plugin 'prettier/vim-prettier'

Plugin 'micha/vim-colors-solarized'

call vundle#end()
filetype plugin indent on

syntax on
set number
set relativenumber
set hidden
set directory=$HOME/.vim/swap//

let mapleader = ','

" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>
" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

nmap <leader>ne :NERDTree<cr>
nmap <leader>nf :NERDTreeFind<cr>

nnoremap <leader>. :CtrlPTag<cr>

set expandtab
set shiftwidth=2
set softtabstop=2

set hlsearch
set incsearch
set ignorecase
set smartcase

" ===========
" Colorscheme
" ===========
set background=dark
colorscheme Twilight
" colorscheme solarized


" ================================================================================
" Plugins
" ================================================================================


" =========
" Lightline
" =========
set noshowmode
set laststatus=2


" ==========
" Auto-Pairs
" ==========
let g:AutoPairsShortcutFastWrap = ''"


" ======
" Ctrl+P
" ======
let g:ctrlp_custom_ignore = 'node_modules\|bower_components\|vendor\|web/html\|web/css\|web/js'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'


" ========
" Prettier
" ========
let g:prettier#autoformat = 0
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#single_quote = 'false'
let g:prettier#config#trailing_comma = 'none'
autocmd BufWritePre *.js,*.css,*.scss,*.less,*.md,*.vue Prettier
