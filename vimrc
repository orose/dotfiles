execute pathogen#infect()
syntax on
filetype plugin indent on

let mapleader = ','
nmap <leader>ne :NERDTree<cr>
nmap <leader>nf :NERDTreeFind<cr>

set laststatus=2
set ignorecase
set smartcase
set tabstop=2
set shiftwidth=2
set visualbell
set background=dark
set number
set expandtab
set smartindent
set foldmethod=manual
set modeline
set directory=$HOME/.vim/swap//

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=3

" config for ctrlp plugin
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

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
