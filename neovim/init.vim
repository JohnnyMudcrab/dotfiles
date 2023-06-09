"###############
"### Plugins ###
"###############

call plug#begin('~/.config/nvim/plugged')

"# Colortheme
Plug 'lifepillar/vim-colortemplate'
Plug 'lifepillar/vim-wwdc16-theme'
Plug 'johnnyMudcrab/vim-mudcrab'
Plug 'mhinz/vim-janah'
Plug 'danilo-augusto/vim-afterglow'
Plug 'JohnnyMudcrab/tender.vim'
Plug 'rainglow/vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }

Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate \| TSInstall c cpp python'}

"# Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"# Sidebars
Plug 'majutsushi/tagbar'
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'

"# Movement
Plug 'justinmk/vim-sneak'

" #  Yank Paste Search Replace
Plug 'svermeulen/vim-subversive'
Plug 'svermeulen/vim-yoink'

"# Fuzzy Finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'aaronhallaert/advanced-git-search.nvim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

"# Git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'sindrets/diffview.nvim'

"# Development
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dbgx/lldb.nvim'

"# Snippets
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

"# tmux
Plug 'christoomey/vim-tmux-navigator'
"Plug 'roxma/vim-tmux-clipboard'

" utils
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'


call plug#end()


"########################
"### Default Settings ###
"########################

" use bash as default shell
set shell=/bin/bash

" make system clipboard default (apt-get install xclip required)
set clipboard=unnamedplus

" show whitespaces
" must be inserted befor colorsheme command
autocmd ColorScheme * highlight ExtraWhiteSpace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" looks
set termguicolors
colorscheme tender

set cursorline		" have a line indicate the cursor location
set tabstop=2		" <tab> inserts 4 spaces
set softtabstop=2	" <BS> over autoindent deletes both spaces
set shiftwidth=2	" indent level is 4 spaces wide
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
"set incsearch       " incrementally search while typing a /regex
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
"set colorcolumn=80  " show column 80

" when scrolling, keep cursor x lines away from screen border
"set scrolloff=1010
set scrolloff=1

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
"set wildmode=list:longest
"set completeopt-=preview

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
autocmd BufReadPost,FileReadPost * normal zR

" ################
" ### Mappings ###
" ################

map <leader>cc <plug>NERDCommenterToggle

" remove search highlights
map <Leader><Space> :noh<CR>

" remove all unwanted whitespaces
nmap <leader>w :%s/\s\+$//<CR>

" Git
nmap <leader>gs :Git<CR>
nmap <leader>gp :Git push<CR>
nmap <leader>gc :Git commit<CR>
nmap <leader>go :DiffviewOpen<CR>
nmap <leader>gq :DiffviewClose<CR>
nmap <leader>gf :DiffviewFileHistory %<CR>

" open location list
nmap <leader>l :lopen<CR>

" show full path
nmap <leader>p :echo expand('%:p')

" open nerdtree
nmap <leader>n :NvimTreeToggle<CR>

" quickly open init.vim
nmap <leader>e :e ~/github/dotfiles/neovim/init.vim<CR>

" quickly source init.vim
nmap <leader>s :source ~/.config/nvim/init.vim<CR>

" Telescope magic
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fu <cmd>Telescope find_files cwd=~/<cr>
nnoremap <leader>fr <cmd>Telescope find_files cwd=/opt/ros/humble/<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope command_history<cr>

" toggle tagbar display
nmap <leader>t :TagbarToggle<CR>

" open quickfix list
"nmap <leader>q :copen<CR>

" substitute
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

" yoink
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
let g:yoinkChangeTickThreshold = 1

" vim-smartq
"let g:smartq_default_mappings = 0
"nmap tq       :bd<CR> <bar> :bp<CR>
"nmap <C-q>    <Plug>(smartq_this_force)

" splits
nmap <leader><bar> :vsplit<CR>
nmap <leader>- :split<CR>
" resize horzontal split window
nmap <C-Up> <C-W>-<C-W>-
nmap <C-Down> <C-W>+<C-W>+
" resize vertical split window
nmap <C-Right> <C-W>><C-W>>
nmap <C-Left> <C-W><<C-W><

" tab navigation
map tn :bnext<CR>
map tp :bprevious<CR>
map tt :enew<CR>
"map tq :bd<CR>
map tl :ls<CR>

" switch between header and implementation
"map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
map <F4> :CocCommand clangd.switchSourceHeader<CR>

" make breakpoint
nnoremap <F5> :LL continue<CR>
nmap <F6> <Plug>LLBreakSwitch
nnoremap <F10> :LL next<CR>
nnoremap <F11> :LL step<CR>

" COC
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>fo  <Plug>(coc-format-selected)
nmap <leader>fo  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  "autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" ######################
" ### Plugin Setting ###
" ######################

" Startify
let g:startify_change_to_dir = 0

" NERDCommenter
let g:NERDCreateDefaultMappings = 0

" SmartQ
"let g:smartq_auto_close_splits = 0


" vim-airline
let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
"let g:airline_theme = 'tender'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_left_sep=""
let g:airline_right_sep=""
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'
"let g:airline_section_z = airline#section#create(['windowswap', 'obsession', '%3p%%'.g:airline_symbols.space, 'linenr', 'maxlinenr', g:airline_symbols.space.':%3V'])
let g:airline_section_y = ''
"let g:airline_section_z = airline#section#create(['windowswap','%3p%%'])
au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['%3p%% %L:%3v'])
"au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['windowswap', 'obsession', '%3p%%', 'maxlinenr', ' :%3v'])

" tabbar
let g:tagbar_autofocus = 1

" Coc
let g:coc_global_extensions = ['coc-clangd', 'coc-pyright', 'coc-snippets', 'coc-json', ]


" #################
" ### Functions ###
" #################

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap <leader>h :call SynStack()<CR>


lua << EOS
-- This is Lua
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup({
  actions = {
    change_dir = {
      global = false
      },
    open_file = {
      quit_on_open = false
  }},
  sort_by = "case_sensitive",
  view = {
    width = 50,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
        { key = "<leader>d", action = "cd" },
      },
    },
  },
  renderer = {
    group_empty = true,
    icons = {
        git_placement = "after",
        }
  },
  filters = {
    dotfiles = true,
  },
})
EOS
