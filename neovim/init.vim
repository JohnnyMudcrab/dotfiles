"###############
"### Plugins ###
"###############

call plug#begin('~/.config/nvim/plugged')

Plug 'johnnyMudcrab/vim-mudcrab'
Plug 'neomake/neomake'
Plug 'majutsushi/tagbar'
Plug 'restore_view.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'justinmk/vim-sneak'
Plug 'critiqjo/lldb.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Raimondi/delimitMate'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer'}
Plug 'roxma/vim-tmux-clipboard'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'dag/vim-fish'
Plug 'ap/vim-css-color'
Plug 'powerman/vim-plugin-viewdoc'
"Plug 'shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
"Plug 'zchee/deoplete-clang'

call plug#end()


"########################
"### Default Settings ###
"########################

" use bash as default shell
"set shell=/bin/zsh

" make system clipboard default (apt-get install xclip required)
set clipboard=unnamedplus

" show whitespaces
" must be inserted befor colorsheme command
autocmd ColorScheme * highlight ExtraWhiteSpace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

colorscheme mudcrab

set cursorline		" have a line indicate the cursor location
set tabstop=4		" <tab> inserts 4 spaces
set softtabstop=4	" <BS> over autoindent deletes both spaces
set shiftwidth=4	" indent level is 4 spaces wide
set shiftround		" rounds indent to a multiple of shiftwidth
set expandtab		" use spaces, not tabs, for autoindent/tab key
set mouse=a

" always show status bar
set ls=2

" Y-N-C prompt if closing with unsaved changes
set confirm

" don't automatically prefix comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" searching and patterns
set hlsearch        " highlight searches by default
set incsearch       " incrementally search while typing a /regex
set ignorecase      " default to using case insensitive searches
set smartcase       " unless uppercase latters are used in the regex

" reading/writting
set nobackup
set nowritebackup
set noswapfile
set noautowrite     " never write a file unless I request it
set noautowriteall  " NEVER

" syntax highlight on
syntax on
set lazyredraw

" showing line numbers and length
set number          " show line numbers
set relativenumber  " make them relative
set tw=80           " width of document (used by gd)
set nowrap          " don't automatically wrap on load
set fo-=t           " don't automatically wrap text when typing
set colorcolumn=80  " show column 80

" when scrolling, keep cursor x lines away from screen border
set scrolloff=1010

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest
set completeopt-=preview

" ################
" ### Mappings ###
" ################

" remove all unwanred whitespaces
map <leader>dw :%s/\s\+$//<CR>

" goto
map <leader>g :YcmCompleter GoTo<CR>

" open location list
map <leader>l :lopen<CR>

" make
map <leader>m :Neomake<CR>

" don't yank replaced text
vnoremap <leader>p "_dP

" quickly open init.vim
map <leader>e :e ~/.config/nvim/init.vim<CR>

" quickly source init.vim
map <leader>s :source ~/.config/nvim/init.vim<CR>

map <leader>f :Files ~/projects<CR>

" toggle tagbar display
map <leader>t :TagbarToggle<CR>

" open quickfix list
map <leader>q :copen<CR>

" tab navigation
map tn :tabn<CR>
map tp :tabp<CR>
map tt :tabnew<CR>

" make breakpoint
nnoremap <F5> :LL continue<CR>
nmap <F6> <Plug>LLBreakSwitch
nnoremap <F10> :LL next<CR>
nnoremap <F11> :LL step<CR>


" ######################
" ### Plugin Setting ###
" ######################

" vim-airline
let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_left_sep=""
let g:airline_right_sep=""
let g:airline#extensions#tabline#enabled=1

" tabbar
let g:tagbar_autofocus = 1

" deoplete
"let g:deoplete#enable_at_startup=1
"let g:deoplete#enable_ignore_case=1
"let g:deoplete#enable_smart_case=1
"let g:deoplete#enable_camel_case=1
"let g:deoplete#sources#clang#libclang_path='/usr/lib/llvm-3.4/lib/libclang.so.1'
"let g:deoplete#sources#clang#clang_header='/usr/lib/llvm-3.4/lib/clang'

" youcompleteme
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_auto_trigger = 1
let g:ycm_global_ycm_extra_conf = '~/.vimconfig/.ycm_extra_conf.py'
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_warning_symbol = ">"
let g:ycm_confirm_extra_conf = 0

" supertab
let g:SuperTabDefaultCompletionType = '<C-n>'

" ultisnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

