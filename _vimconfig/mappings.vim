" show pending tasks list
map <F2> :TaskList<CR>

" NERDTree (better file browser) toggle
map <F3> :NERDTreeToggle<CR>

" toggle Tagbar display
map <F4> :TagbarToggle<CR>

" tab navigation
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm
map tt :tabnew
map ts :tab split<CR>

" navigate windows with meta+arrows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
imap <c-j> <ESC><c-w>l
imap <c-k> <ESC><c-w>h
imap <c-l> <ESC><c-w>k
imap <c-h> <ESC><c-w>j

" autocomplete enhancements
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

