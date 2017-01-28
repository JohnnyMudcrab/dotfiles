" source colorscheme
map <leader>c :source ~/github/vim-mudcrab/colors/mudcrab.vim<CR>

" quickly source vimrc
map <leader>s :source ~/.vimrc<CR>

" NERDTree (better file browser) toggle
map <leader>n :NERDTreeTabsToggle<CR>

" toggle Tagbar display
map <leader>t :TagbarToggle<CR>

" show syntax informations
nmap <Leader>sI :call <SID>SynStack()<CR>

" turn of highlighting
nmap <Leader>ho :noh<CR>

" begin and end of line
noremap H ^
noremap L $
vnoremap L g_

" tab navigation
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm
map tt :tabnew
map ts :tab split<CR>

" buffer navigation
map <leader>bn :bn<cr>
map <leader>bp :bp<cr>
map <leader>bd :bd<cr>

" autocomplete enhancements
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" dont yank replaced text
vnoremap <leader>p "_dP

" remove all unwanted whitespaces
map <leader>dw :%s/\s\+$// <cr>

" vimux
nnoremap <leader>mm :call VimuxRunCommand("make")<cr>
nnoremap <leader>mr :call VimuxRunCommand("make run")<cr>
nnoremap <leader>mc :call VimuxRunCommand("make clean")<cr>

" goto
nnoremap <leader>gg :YcmCompleter GoTo<CR>

" neosnippet usage
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)

" Fugitive
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gp :Gpush<cr>
