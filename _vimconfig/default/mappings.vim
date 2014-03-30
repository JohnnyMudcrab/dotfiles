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

" tab navigation
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm
map tt :tabnew
map ts :tab split<CR>

" autocomplete enhancements
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" dont yank replaced text
vnoremap <leader>p "_dP

" remove all unwanted whitespaces
map <leader>dw :%s/\s\+$// <cr>

" neosnippet usage
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
