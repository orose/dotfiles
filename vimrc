execute pathogen#infect()
syntax on
filetype plugin indent on

let mapleader = ','
nmap <leader>ne :NERDTree<cr>
nmap <leader>nf :NERDTreeFind<cr>

set laststatus=2
set visualbell
set number
set foldmethod=manual
set modeline
set directory=$HOME/.vim/swap//


" Colorscheme
" ===========
set background=light
colorscheme solarized


" Real programmers don't use TABs but spaces
" ==========================================
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set smarttab


" Search tweaks
" =============
set hlsearch
set incsearch
set ignorecase
set smartcase


" Ctrl+P
" ======
let g:ctrlp_custom_ignore = 'node_modules\|bower_components'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'


" Minimal number of screen lines to keep above and below the cursor
set scrolloff=3

map <c-t> :tabnew<cr>

" set list
set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\

" Allow cursor keys to wrap around lines
set whichwrap=<,>,[,]

" Better labels on tabs
set guitablabel=%N/\ %t\ %M

" reload file when entering buffer or gained focus
au FocusGained,BufEnter * :silent! !

if has("autocmd")
  filetype indent on
endif
