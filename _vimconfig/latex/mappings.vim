" perform forward search for latex files
nnoremap <Leader>f :call SyncTexForward()<CR>

" change leave enviroment short cut
imap <c-l> <Plug>IMAP_JumpForward

" change insert item
imap <c-k> <Plug>Tex_InsertItemOnThisLine

" no smart qoutes
let g:Tex_SmartKeyQuote=0

nmap <Leader>lc :!texcount -inc -total main.tex<CR>
