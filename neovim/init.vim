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
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

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
"Plug 'critiqjo/lldb.nvim'
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --clangd-completer'}
Plug 'thibthib18/ros-nvim', {'branch': 'ros2'}
"Plug 'ervandew/supertab'
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
"Plug 'powerman/vim-plugin-viewdoc'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'


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

" ################
" ### Mappings ###
" ################

" remap goto
"nmap gd <C-]>

map <leader>cc <plug>NERDCommenterToggle

" remove search highlights
map <Leader><Space> :noh<CR>

" remove all unwanted whitespaces
nmap <leader>w :%s/\s\+$//<CR>

" Autocompletion
"nmap <leader>gt :YcmCompleter GoTo<CR>

" Git
nmap <leader>gs :Git<CR>
nmap <leader>gp :Git push<CR>
nmap <leader>gc :Git commit<CR>

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
nnoremap <leader>fr <cmd>Telescope find_files cwd=/opt/ros/humble/<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope command_history<cr>

" toggle tagbar display
nmap <leader>t :TagbarToggle<CR>

" open quickfix list
"nmap <leader>q :copen<CR>

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
map tq :bd<CR>
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
"nnoremap <leader>rtl <cmd>lua require('ros-nvim.telescope.pickers').topic_picker()<cr>
"" Nodes list & info
"nnoremap <leader>rnl <cmd>lua require('ros-nvim.telescope.pickers').node_picker()<cr>
"" Services list & info
"nnoremap <leader>rsl <cmd>lua require('ros-nvim.telescope.pickers').service_picker()<cr>
"" Service definitions list & info
"nnoremap <leader>rds <cmd>lua require('ros-nvim.telescope.pickers').srv_picker()<cr>
"" Message definitions list & info
"nnoremap <leader>rdm <cmd>lua require('ros-nvim.telescope.pickers').msg_picker()<cr>
"" Params list & values
"nnoremap <leader>rpl <cmd>lua require('ros-nvim.telescope.pickers').param_picker()<cr>


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

" NERDCommenter
let g:NERDCreateDefaultMappings = 0

"NERDTREE
"let g:NERDTreeQuitOnOpen = 1
"let g:NERDTreeFileExtensionHighlightFullName = 0
"let g:NERDTreeHighlightCursorline = 1

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

" youcompleteme
"let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_auto_trigger = 1
"let g:ycm_global_ycm_extra_conf = '~/ros2_ws/.ycm_extra_conf.py'
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_warning_symbol = ">"
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_invoke_completion = '<C-k>'
let g:ycm_clangd_args=['--query-driver=/usr/bin/c++']
let g:ycm_always_populate_location_list = 1
let g:YcmShowDetailedDiagnostic = 1
let g:ycm_show_detailed_diag_in_popup=1
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

lua << EOF
local vim_utils = require "ros-nvim.vim-utils"
require 'ros-nvim'.setup {
    catkin_ws_path = "~/ros2_ws",
    catkin_program = "colcon",
    -- vim_utils.open_new_buffer or custom function
    open_terminal_method = function()
        vim_utils.open_split()
    end,
    terminal_height = 8, -- only for split terminal
    -- Picker mappings
    node_picker_mappings = function(map)
        map("n", "<c-k>", vim_utils.open_terminal_with_format_cmd_entry("rosnode kill %s"))
        map("i", "<c-k>", vim_utils.open_terminal_with_format_cmd_entry("rosnode kill %s"))
    end,
    topic_picker_mappings = function(map)
        local cycle_previewers = function(prompt_bufnr)
            local picker = action_state.get_current_picker(prompt_bufnr)
            picker:cycle_previewers(1)
        end
        map("n", "<c-b>", vim_utils.open_terminal_with_format_cmd_entry("rostopic pub %s"))
        map("i", "<c-b>", vim_utils.open_terminal_with_format_cmd_entry("rostopic pub %s"))
        map("n", "<c-e>", cycle_previewers)
        map("i", "<c-e>", cycle_previewers)
    end,
    service_picker_mappings = function(map)
        map("n", "<c-e>", vim_utils.open_terminal_with_format_cmd_entry("rosservice call %s"))
        map("i", "<c-e>", vim_utils.open_terminal_with_format_cmd_entry("rosservice call %s"))
    end,
    param_picker_mappings = function(map)
        map("n", "<c-e>", vim_utils.open_terminal_with_format_cmd_entry("rosparam set %s"))
        map("i", "<c-e>", vim_utils.open_terminal_with_format_cmd_entry("rosparam set %s"))
    end
}
EOF

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

"lua << EOS
"require'nvim-treesitter.configs'.setup {
  "-- A list of parser names, or "all" (the four listed parsers should always be installed)
  "ensure_installed = { "c", "lua", "vim", "help" },

  "-- Install parsers synchronously (only applied to `ensure_installed`)
  "sync_install = false,

  "-- Automatically install missing parsers when entering buffer
  "-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  "auto_install = true,

  "-- List of parsers to ignore installing (for "all")
  "ignore_install = { "javascript" },

  "---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  "-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  "highlight = {
    "enable = true,

    "-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    "-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    "-- the name of the parser)
    "-- list of language that will be disabled
    "disable = { "c", "rust" },
    "-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    "disable = function(lang, buf)
        "local max_filesize = 100 * 1024 -- 100 KB
        "local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        "if ok and stats and stats.size > max_filesize then
            "return true
        "end
    "end,

    "-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    "-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    "-- Using this option may slow down your editor, and you may see some duplicate highlights.
    "-- Instead of true it can also be a list of languages
    "additional_vim_regex_highlighting = false,
  "},
"}
"EOS

"lua << EOS
"local nightfox = require('nightfox')

"nightfox.setup({
    "fox = 'nordfox', -- change the colorscheme
    "styles = {
        "comments = 'italic',
        "functions = 'italic',
    "},
"})

"-- load the configurations
"nightfox.load()
"EOS

"lua << EOS
"require('onenord').setup({
  "theme = nil, -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
  "borders = true, -- Split window borders
  "fade_nc = false, -- Fade non-current windows, making them more distinguishable
  "-- Style that is applied to various groups: see `highlight-args` for options
  "styles = {
    "comments = "NONE",
    "strings = "NONE",
    "keywords = "NONE",
    "functions = "NONE",
    "variables = "NONE",
    "diagnostics = "underline",
  "},
  "disable = {
    "background = true, -- Disable setting the background color
    "cursorline = false, -- Disable the cursorline
    "eob_lines = true, -- Hide the end-of-buffer lines
  "},
  "-- Inverse highlight for different groups
  "inverse = {
    "match_paren = false,
  "},
  "custom_highlights = {}, -- Overwrite default highlight groups
  "custom_colors = {}, -- Overwrite default colors
"})
"EOS
