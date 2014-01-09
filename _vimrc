" no vi-compatible
set nocompatible

" load vundle config
so ~/.vimconfig/vundle.vim

" load mappings
so ~/.vimconfig/mappings.vim

" load plugin config
so ~/.vimconfig/plugins.vim

" load autocompletion setup
so ~/.vimconfig/complete.vim

" load projects
so ~/.vimconfig/project.vim

" Rebind <Leader> key
let mapleader = ","

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

" forward serach with latex
function! SyncTexForward()
     let execstr = "silent !okular --unique %:p:r.pdf\\#src:".line(".")."%:p &"
     exec execstr
     redraw!
endfunction
nnoremap <Leader>f :call SyncTexForward()<CR>
