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
set relativenumber
set directory=$HOME/.vim/swap//
" Minimal number of screen lines to keep above and below the cursor
set scrolloff=3



" Colorscheme
" ===========
set background=dark
let g:solarized_termcolors=256
" colorscheme solarized
colorscheme Twilight
" colorscheme PaperColor
" colorscheme pencil


" Real programmers don't use TABs but spaces
" ==========================================
set tabstop=4
set softtabstop=4
set shiftwidth=4
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
let g:ctrlp_custom_ignore = 'node_modules\|bower_components\|vendor\|web/html\|web/css\|web/js'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'


" Auto-Pairs
" ==========
let g:AutoPairsShortcutFastWrap = ''


" Airline
" =======
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Open new tab
map <c-t> :tabnew<cr>

" Strip all trailing whitespace in current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" set list
set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\

" Allow cursor keys to wrap around lines
set whichwrap=<,>,[,]

" Better labels on tabs
set guitablabel=%N/\ %t\ %M

" reload file when entering buffer or gained focus
au FocusGained,BufEnter * :silent! !


" Buffers
" ====
" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Toggle nerdtree
nnoremap <F4> :NERDTreeToggle<CR>

if has("autocmd")
  filetype indent on
endif
