" Rebind <Leader> key
let mapleader = ","

" make system clipboard default
set clipboard=unnamedplus

" save as sudo
ca w!! w !sudo tee "%"

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" use 256 colors when possible
if &term =~? 'mlterm\|xterm\|xterm-256\|screen-256'
	let &t_Co = 256
    " color
    colorscheme mustang
else
    " color
    colorscheme mustang
endif

" colors for gvim
if has('gui_running')
    colorscheme mustang
    set guioptions-=T
    set guioptions-=l
    set guioptions-=r
    set guioptions-=b
    set guioptions-=L
endif

" moving around/editing
set cursorline              " have a line indicate the cursor location
set tabstop=4               " <tab> inserts 4 spaces
set softtabstop=4           " <BS> over autoindent deletes both spaces
set shiftwidth=4            " indent level is 4 spaces wide
set shiftround              " rounds indent to a multiple of shiftwidth
set expandtab               " use spaces, not tabs, for autoindent/tab key
set mouse=a                 " enable mouse

" tablength exceptions
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType cpp setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType matlab setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType octave setlocal shiftwidth=2 tabstop=2 softtabstop=2

" matlab and octave settings
" augroup filetypedetect
  " au! BufRead,BufNewFile *.m,*.oct set filetype=octave
" augroup END
" if has("autocmd") && exists("+omnifunc")
   " autocmd Filetype octave
   " \	if &omnifunc == "" |
   " \	 setlocal omnifunc=syntaxcomplete#Complete |
   " \	endif
" endif
" au BufNewFile,BufRead *.m     setf octave
" au BufNewFile,BufRead *.m     set syntax=matlab"
autocmd BufEnter *.m    compiler mlint

" always show status bar
set ls=2

" Y-N-C prompt if closing with unsaved changes
set confirm

" searching and patterns
set hlsearch                " Highlight searches by default
set incsearch               " incrementally search while typing a /regex
set ignorecase              " default to using case insensitive searches
set smartcase               " unless uppdace letters are used in the regex
set smarttab                " handle tabs more intelligently

" reading/writing
set nobackup
set nowritebackup
set noswapfile
set noautowrite             " never write a file unless I request it
set noautowriteall          " NEVER

" syntax highlight on
syntax on
set lazyredraw

" showing line numbers and length
set number  		        " show line numbers
set tw=79   		        " width of document (used by gd)
set nowrap  		        " don't automatically wrap on load
set fo-=t   		        " don't automatically wrap text when typing
set colorcolumn=80	        " show column 80
highlight ColorColumn ctermbg=233

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" show syntax informations
nmap <Leader>sI :call <SID>SynStack()<CR>

function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" toogle between number and relativ number
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>


" forward serach with latex
function! SyncTexForward()
     let execstr = "silent !okular --unique %:p:r.pdf\\#src:".line(".")."%:p &"
     exec execstr
     redraw!
     redraw!
endfunction
nnoremap <Leader>f :call SyncTexForward()<CR>
"
"" vim-airline settings
let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_left_sep=""
let g:airline_right_sep=""
let g:airline#extensions#tabline#enabled = 1

" fix some problems with gitgutter
let g:gitgutter_eager = 0
let g:gitgutter_realtime = 0

" Fix to let ESC work as espected with Autoclose plugin
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" autofocus on Tagbar open
let g:tagbar_autofocus = 1

" Don't change working directory
let g:ctrlp_working_path_mode = 0

" Ignore files on fuzzy finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
  \ 'file': '\.pyc$\|\.pyo$',
  \ }

" tell NERDCommenter to put whitespace after delimiter
let g:NERDSpaceDelims = 1


" dont select first item when autoomplete
let g:acp_autoselectFirstCompletion=0
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
" inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><C-y>  neocomplete#close_popup()
" inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 0

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType matlab setlocal omnifunc=syntaxcomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

if !exists('g:neocomplete#force_omni_input_patterns')
          let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.objc =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.objcpp =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:clang_complete_auto = 0
let g:clang_auto_select = 0

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
