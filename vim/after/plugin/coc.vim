" ===========================
" CoC - Conquer of Completion
" ===========================
" let g:coc_node_path = '/Users/k37597/.nvm/versions/node/v14.18.2/bin/node'
let g:coc_global_extensions = ['coc-css', 'coc-json', 'coc-tsserver', 'coc-html', 'coc-git', 'coc-lists']

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

" gh - get hint on whatever's under the cursor
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>

" List errors
nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<cr>

" manage extensions
nnoremap <silent> <leader>cx  :<C-u>CocList extensions<cr>
