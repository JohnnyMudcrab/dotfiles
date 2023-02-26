"###############
"### Plugins ###
"###############

call plug#begin('~/.config/nvim/plugged')

"# Colortheme
Plug 'johnnyMudcrab/vim-mudcrab'
Plug 'mhinz/vim-janah'
Plug 'danilo-augusto/vim-afterglow'
Plug 'chriskempson/base16-vim'
Plug 'shaunsingh/nord.nvim'

"# Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"# Sidebars
Plug 'majutsushi/tagbar'
"Plug 'scrooloose/nerdtree'
"Plug 'ryanoasis/vim-devicons'
"Plug 'johnstef99/vim-nerdtree-syntax-highlight'
"Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'

"# Movement
Plug 'justinmk/vim-sneak'

"# Fuzzy Finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'

"# Git
Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'

"# Development
"Plug 'neomake/neomake'
Plug 'critiqjo/lldb.nvim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer'}
Plug 'thibthib18/ros-nvim', {'branch': 'ros2'}
"Plug 'ervandew/supertab'

"# Snippets
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

"# tmux
Plug 'christoomey/vim-tmux-navigator'
"Plug 'roxma/vim-tmux-clipboard'

" utils
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
Plug 'powerman/vim-plugin-viewdoc'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'norcalli/nvim-colorizer.lua'


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

" looks
set termguicolors
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
"set colorcolumn=80  " show column 80

" when scrolling, keep cursor x lines away from screen border
"set scrolloff=1010
set scrolloff=1

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
"set wildmode=list:longest
"set completeopt-=preview

" ################
" ### Mappings ###
" ################

" remap goto
nmap gd <C-]>

map <leader>c <plug>NERDCommenterToggle

" remove search highlights
map <Leader><Space> :noh<CR>

" remove all unwanted whitespaces
nmap <leader>dw :%s/\s\+$//<CR>

" Autocompletion
nmap <leader>gt :YcmCompleter GoTo<CR>

" Git
nmap <leader>gs :Git<CR>
nmap <leader>gp :Git push<CR>
nmap <leader>gc :Git push<CR>

" open location list
nmap <leader>l :lopen<CR>

" make
"nmap <leader>m :Neomake<CR>

" open nerdtree
nmap <leader>n :NvimTreeToggle<CR>

" don't yank replaced text
vnoremap <leader>p "_dP

" quickly open init.vim
nmap <leader>e :e ~/.config/nvim/init.vim<CR>

" quickly source init.vim
nmap <leader>s :source ~/.config/nvim/init.vim<CR>

" Telescope magic
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fu <cmd>Telescope find_files cwd=~/<cr>
nnoremap <leader>fr <cmd>Telescope find_files cwd=/<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope command_history<cr>

" toggle tagbar display
nmap <leader>t :TagbarToggle<CR>

" open quickfix list
nmap <leader>q :copen<CR>

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
map tc :bd<CR>
map tl :ls<CR>

" switch between header and implementation
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" make breakpoint
nnoremap <F5> :LL continue<CR>
nmap <F6> <Plug>LLBreakSwitch
nnoremap <F10> :LL next<CR>
nnoremap <F11> :LL step<CR>

" ros-nvim
" #### ROS Introspection ####
" Topics list & info
nnoremap <leader>rtl <cmd>lua require('ros-nvim.telescope.pickers').topic_picker()<cr>
" Nodes list & info
nnoremap <leader>rnl <cmd>lua require('ros-nvim.telescope.pickers').node_picker()<cr>
" Services list & info
nnoremap <leader>rsl <cmd>lua require('ros-nvim.telescope.pickers').service_picker()<cr>
" Service definitions list & info
nnoremap <leader>rds <cmd>lua require('ros-nvim.telescope.pickers').srv_picker()<cr>
" Message definitions list & info
nnoremap <leader>rdm <cmd>lua require('ros-nvim.telescope.pickers').msg_picker()<cr>
" Params list & values
nnoremap <leader>rpl <cmd>lua require('ros-nvim.telescope.pickers').param_picker()<cr>


" ######################
" ### Plugin Setting ###
" ######################

" NERDCommenter
let g:NERDCreateDefaultMappings = 0

"NERDTREE
"let g:NERDTreeQuitOnOpen = 1
"let g:NERDTreeFileExtensionHighlightFullName = 0
"let g:NERDTreeHighlightCursorline = 1

" vim-airline
let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_left_sep=""
let g:airline_right_sep=""
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'
"let g:airline_section_z = airline#section#create(['windowswap', 'obsession', '%3p%%'.g:airline_symbols.space, 'linenr', 'maxlinenr', g:airline_symbols.space.':%3V'])
let g:airline_section_y = ''
let g:airline_section_z = airline#section#create(['windowswap', '%3p%%'])

" tabbar
let g:tagbar_autofocus = 1

" youcompleteme
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_auto_trigger = 1
"let g:ycm_global_ycm_extra_conf = '~/.vimconfig/.ycm_extra_conf.py'
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_warning_symbol = ">"
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_invoke_completion = '<C-k>'

" supertab
"let g:SuperTabDefaultCompletionType = '<C-n>'

" ultisnips
"let g:UltiSnipsExpandTrigger = "<C-k>"
"let g:UltiSnipsJumpForwardTrigger = "<C-k>"
"let g:UltiSnipsJumpBackwardTrigger = "<C-j>"

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

"lua require'colorizer'.setup()

"lua << EOF
"local vim_utils = require "ros-nvim.vim-utils"
"require 'ros-nvim'.setup {
  "-- path to your catkin workspace
  "catkin_ws_path = "~/catkin_ws",

  "-- make program (e.g. "catkin_make" or "catkin build" )
  "catkin_program = "catkin_make"

  "--method for opening terminal for e.g. catkin_make: utils.open_new_buffer or custom function
  "open_terminal_method = function()
      "require vim-utils.open_split()
  "end,

  "-- terminal height for build / test, only valid with `open_terminal_method=open_split()`
  "terminal_height = 8

  "-- Picker mappings
  "node_picker_mappings = function(map)
      "map("n", "<c-k>", vim_utils.open_terminal_with_format_cmd_entry("rosnode kill %s"))
      "map("i", "<c-k>", vim_utils.open_terminal_with_format_cmd_entry("rosnode kill %s"))
  "end,
  "topic_picker_mappings = function(map)
      "local cycle_previewers = function(prompt_bufnr)
          "local picker = action_state.get_current_picker(prompt_bufnr)
          "picker:cycle_previewers(1)
      "end
      "map("n", "<c-b>", vim_utils.open_terminal_with_format_cmd_entry("rostopic pub %s"))
      "map("i", "<c-b>", vim_utils.open_terminal_with_format_cmd_entry("rostopic pub %s"))
      "map("n", "<c-e>", cycle_previewers)
      "map("i", "<c-e>", cycle_previewers)
  "end,
  "service_picker_mappings = function(map)
      "map("n", "<c-e>", vim_utils.open_terminal_with_format_cmd_entry("rosservice call %s"))
      "map("i", "<c-e>", vim_utils.open_terminal_with_format_cmd_entry("rosservice call %s"))
  "end,
  "param_picker_mappings = function(map)
      "map("n", "<c-e>", vim_utils.open_terminal_with_format_cmd_entry("rosparam set %s"))
      "map("i", "<c-e>", vim_utils.open_terminal_with_format_cmd_entry("rosparam set %s"))
  "end
"}
"EOF

lua << EOS
-- This is Lua
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup({
  actions = {
    open_file = {
      quit_on_open = true
  }},
  sort_by = "case_sensitive",
  view = {
    width = 40,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
EOS

