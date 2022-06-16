set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jiangmiao/auto-pairs'
Plugin 'alvan/vim-closetag'

Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter.git'

Plugin 'itchyny/lightline.vim'

Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'posva/vim-vue'

Plugin 'prettier/vim-prettier'

Plugin 'micha/vim-colors-solarized'

Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plugin 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

call vundle#end()
filetype plugin indent on

syntax on
set number
set relativenumber
set hidden
set directory=$HOME/.vim/swap//

let mapleader = ' '

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

set expandtab
set shiftwidth=2
set softtabstop=2

set scrolloff=5

set hlsearch
set incsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set mouse=a
set ttymouse=xterm2

" ===========
" Colorscheme
" ===========
set background=dark
" colorscheme gruvbox
colorscheme Twilight
" colorscheme everforest
" colorscheme solarized
"
" =======
" Folding
" =======
set foldmethod=syntax "syntax highlighting items specify folds  
" set foldcolumn=1 "defines 1 col at window left, to indicate folding  
let javaScript_fold=1 "activate folding by JS syntax  
set foldlevelstart=99 "start file with all folds opened


" ================================================================================
" Plugins
" ================================================================================


" =========
" Lightline
" =========
set noshowmode
set laststatus=2
let g:lightline = {
  \ 'colorscheme': 'everforest',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead'
  \ },
  \ }


" ==========
" Auto-Pairs
" ==========
let g:AutoPairsShortcutFastWrap = ''"


" =======================
" Fuzzy File Finder (fzf)
" =======================

" Search for files
nnoremap <leader>o :Files<CR>
" Search/grep inside files
nnoremap <leader>f :Rg<CR>
" Search Git Commits
nnoremap <leader>g :Commits<CR>
" Buffers
nnoremap <leader>b :Buffers<CR>


" ========
" Prettier
" ========
let g:prettier#autoformat = 0
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#single_quote = 'false'
let g:prettier#config#trailing_comma = 'none'
autocmd BufWritePre *.js,*.css,*.scss,*.less,*.md,*.vue Prettier

" ===========================
" CoC - Conquer of Completion
" ===========================
" let g:coc_node_path = '/Users/k37597/.nvm/versions/node/v14.18.2/bin/node'
let g:coc_global_extensions = ['coc-css', 'coc-json', 'coc-tsserver', 'coc-html', 'coc-git']

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

" Navigate to next/prev error spotted by CoC
nmap <silent> <Leader>j <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>k <Plug>(coc-diagnostic-next)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
