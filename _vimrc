" no vi-compatible
set nocompatible

" load vundle config
so ~/.vimconfig/vundle.vim

" load mappings
so ~/.vimconfig/mappings.vim

" load plugin config
so ~/.vimconfig/plugins.vim

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
    colorscheme delek
endif

" colors for gvim
if has('gui_running')
    colorscheme wombat
endif

" moving around/editing
set cursorline              " have a line indicate the cursor location
set tabstop=4               " <tab> inserts 4 spaces
set softtabstop=4           " <BS> over autoindent deletes both spaces
set shiftwidth=4            " indent level is 4 spaces wide
set shiftround              " rounds indent to a multiple of shiftwidth
set expandtab               " use spaces, not tabs, for autoindent/tab key

" tablength exceptions
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType cpp setlocal shiftwidth=2 tabstop=2 softtabstop=2

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
