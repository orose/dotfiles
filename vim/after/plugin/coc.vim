" ===========================
" CoC - Conquer of Completion
" ===========================
" let g:coc_node_path = '/Users/k37597/.nvm/versions/node/v14.18.2/bin/node'
let g:coc_global_extensions = ['coc-css', 'coc-json', 'coc-tsserver', 'coc-html', 'coc-git', 'coc-lists', 'coc-java']

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

" Navigate to next/prev error spotted by CoC
nmap <silent> <Leader>j <Plug>(coc-diagnostic-next)
nmap <silent> <Leader>k <Plug>(coc-diagnostic-prev)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" gh - get hint on whatever's under the cursor
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> gh :call <SID>show_documentation()<CR>


" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>

" List errors
nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<cr>

" List diagnostics
nnoremap <silent> <leader>cd  :<C-u>CocList diagnostics<cr>

" Perform code actions
nmap <leader>ca <Plug>(coc-codeaction)

" manage extensions
nnoremap <silent> <leader>cx  :<C-u>CocList extensions<cr>

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

" hi CocSearch ctermfg=12 guifg=#18A3FF
" hi CocMenuSel ctermbg=109 guibg=#13354A

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
