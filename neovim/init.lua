-- ###############
-- ### Plugins ###
-- ###############

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    -- Colortheme
    'johnnyMudcrab/vim-mudcrab',
    'JohnnyMudcrab/tender.vim',
    'norcalli/nvim-colorizer.lua',

    'sheerun/vim-polyglot',
    { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate | TSInstall c cpp python' },

    -- Statusline
    'vim-airline/vim-airline',
    'vim-airline/vim-airline-themes',

    -- Sidebars
    'majutsushi/tagbar',
    'nvim-tree/nvim-web-devicons',
    'nvim-tree/nvim-tree.lua',

    -- Movement
    'folke/flash.nvim',

    -- Yank, Paste, Search, Replace
    'gbprod/substitute.nvim',
    'gbprod/yanky.nvim',

    -- Fuzzy Finder
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope.nvim',   tag = '0.1.2' },
    { 'junegunn/fzf',                    dir = '~/.fzf',                            run = './install --all' },
    'JohnnyMudcrab/lazygit.nvim',

    -- Git
    'tpope/vim-fugitive', -- alternative?
    'mhinz/vim-signify',  -- alternative?
    'sindrets/diffview.nvim',

    -- Development
    { 'neoclide/coc.nvim', branch = 'release' },
    'dbgx/lldb.nvim',
    'puremourning/vimspector', -- alternative?
    'fannheyward/telescope-coc.nvim',

    -- tmux
    'christoomey/vim-tmux-navigator', -- alternative?

    -- Utils
    'scrooloose/nerdcommenter', -- alternative?
    'Raimondi/delimitMate',     -- alternative?
    'mhinz/vim-startify',       -- alternative?
    'tpope/vim-surround',       -- alternative?
    'tpope/vim-repeat',         -- alternative?

    -- ROS
    'taDachs/ros-nvim',
    --'JohnnyMudcrab/ros2-nvim'
})

-- ################
-- ### Settings ###
-- ################
--
-- check: https://neovim.discourse.group/t/how-to-suppress-warning-undefined-global-vim/1882/3

-- use bash as default shell
vim.opt.shell = "/bin/bash"

-- make system clipboard default (apt-get install xclip required)
vim.opt.clipboard = "unnamedplus"

-- show whitespace. must be inserted before colorsheme command
vim.cmd [[
    autocmd ColorScheme * highlight ExtraWhiteSpace ctermbg=red guibg=red
    au InsertLeave * match ExtraWhitespace /\s\+$/
]]

-- looks
vim.opt.termguicolors = true
vim.cmd("colorscheme tender")

vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.mouse = "a"

-- alway show status bar
vim.opt.laststatus = 2

-- Y-N-C prompt if closing with unsaved changes
vim.opt.confirm = true

-- don't automatically prefix comments
vim.cmd [[ autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]]

-- searching and patterns
vim.opt.hlsearch = true   -- highlight searches by default
-- vim.opt.incsearch = true  -- incrementally search while typing a /regex
vim.opt.ignorecase = true -- default to using case insensitive searches
vim.opt.smartcase = true  -- unless uppercase letters are used in the regex

-- reading/writing
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.autowrite = false    -- never write a file unless I request it
vim.opt.autowriteall = false -- NEVER

-- syntax highlight on
vim.cmd('syntax on')
vim.opt.lazyredraw = true

-- showing line numbers and length
vim.opt.number = true             -- show line numbers
vim.opt.relativenumber = true     -- make them relative
vim.opt.textwidth = 80            -- width of document (used by gd)
vim.opt.wrap = false              -- don't automatically wrap on load
vim.opt.formatoptions:remove("t") -- don't automatically wrap text when typing
-- vim.opt.colorcolumn = "80"  -- show column 80

-- when scrolling, keep cursor x lines away from screen border
-- vim.opt.scrolloff = 1010
vim.opt.scrolloff = 3

-- autocompletion of files and commands behaves like shell
-- (complete only the common part, list the options that match)
-- vim.opt.wildmode = { 'list', 'longest' }
-- vim.opt.completeopt:remove("preview")

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved
vim.opt.signcolumn = 'yes'

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.cmd([[ autocmd BufReadPost,FileReadPost * normal zR ]])

-- ################
-- ### Mappings ###
-- ################

vim.g.mapleader = " "

-- NERDCommenter
vim.api.nvim_set_keymap('', '<leader>c', '<plug>NERDCommenterToggle', {})

-- remove search highlights
vim.api.nvim_set_keymap('', '<Leader><Space>', ':noh<CR>', {})

-- remove unwanted whitespaces
vim.api.nvim_set_keymap('n', '<leader>w', ':%s/\\s\\+$//<CR>', {})

-- Git
vim.api.nvim_set_keymap('n', '<leader>gs', ':Git<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gp', ':Git push<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>go', ':DiffviewOpen<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gq', ':DiffviewClose<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gf', ':DiffviewFileHistory %<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gg', ':LazyGitCurrentFile<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>gr', ':LazyGit ~/ros2_ws/rcb_testing/src/rcb_testing_area<CR>', { silent = true })

-- open location list
vim.api.nvim_set_keymap('n', '<leader>l', ':lopen<CR>', {})

-- show full path
vim.api.nvim_set_keymap('n', '<leader>p', ':echo expand("%:p")<CR>', {})

-- open nvim tree
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<CR>', {})

-- quickly open init.lua
vim.api.nvim_set_keymap('n', '<leader>e', ':e ~/github/dotfiles/neovim/init.lua<CR>', {})

-- quickly source init.lua
vim.api.nvim_set_keymap('n', '<leader>s', ':source ~/.config/nvim/init.lua<CR>', {})

-- Telescope magic
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fu', '<cmd>Telescope find_files cwd=~/<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fc', '<cmd>Telescope command_history<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>Telescope coc document_symbols<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fe', '<cmd>Telescope coc diagnostics<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fd', '<cmd>Telescope coc diagnostics<cr>', {})

-- toogle tagbar
vim.api.nvim_set_keymap('n', '<leader>t', ':TagbarToggle<CR>', {})

-- open quickfix list
-- vim.api.nvim_set_keymap('n', '<leader>q', ':copen<CR>', {})

-- substitute
-- vim.api.nvim_set_keymap('n', 's', '<plug>(SubversiveSubstitute)', {})
-- vim.api.nvim_set_keymap('n', 'ss', '<plug>(SubversiveSubstituteLine)', {})
-- vim.api.nvim_set_keymap('n', 'S', '<plug>(SubversiveSubstituteToEndOfLine)', {})
-- vim.api.nvim_set_keymap('n', '<leader>s', '<plug>(SubversiveSubstituteRange)', {})
-- vim.api.nvim_set_keymap('x', '<leader>s', '<plug>(SubversiveSubstituteRange)', {})

-- yoink
-- vim.api.nvim_set_keymap('n', '<c-n>', '<plug>(YoinkPostPasteSwapBack)', {})
-- vim.api.nvim_set_keymap('n', '<c-p>', '<plug>(YoinkPostPasteSwapForward)', {})
-- vim.api.nvim_set_keymap('n', '[y', '<plug>(YoinkRotateBack)', {})
-- vim.api.nvim_set_keymap('n', ']y', '<plug>(YoinkRotateForward)', {})
-- vim.api.nvim_set_keymap('n', 'p', '<plug>(YoinkPaste_p)', {})
-- vim.api.nvim_set_keymap('n', 'P', '<plug>(YoinkPaste_P)', {})

-- sneak
-- vim.api.nvim_set_keymap('n', '(', '<Plug>Sneak_s', {})
-- vim.api.nvim_set_keymap('n', ')', '<Plug>Sneak_S', {})
-- vim.api.nvim_set_keymap('x', '(', '<Plug>Sneak_s', {})
-- vim.api.nvim_set_keymap('x', ')', '<Plug>Sneak_S', {})
-- vim.api.nvim_set_keymap('n', ',', '<Plug>Sneak_;', {})
-- vim.api.nvim_set_keymap('n', ';', '<Plug>Sneak_,', {})
-- vim.api.nvim_set_keymap('x', ',', '<Plug>Sneak_;', {})
-- vim.api.nvim_set_keymap('x', ';', '<Plug>Sneak_,', {})

-- splits
vim.api.nvim_set_keymap('n', '<leader>|', ':vsplit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>-', ':split<CR>', { noremap = true, silent = true })

-- resize horizontal split window
vim.api.nvim_set_keymap('n', '<C-Up>', '<C-W>-<C-W>-', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Down>', '<C-W>+<C-W>+', { noremap = true, silent = true })

-- resize vertical split window
vim.api.nvim_set_keymap('n', '<C-Right>', '<C-W>><C-W>>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Left>', '<C-W><<C-W><', { noremap = true, silent = true })

-- tab navigation
vim.api.nvim_set_keymap('n', 'tn', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'tp', ':bprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'tt', ':enew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'tq', ':bd<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'tl', ':ls<CR>', { noremap = true, silent = true })

-- switch between header and implementation (commented out)
-- vim.api.nvim_set_keymap('n', '<F4>', [[:e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>]], { noremap = true, silent = true })

-- make breakpoint (commented out)
-- vim.api.nvim_set_keymap('n', '<F5>', ':LL continue<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<F6>', '<Plug>LLBreakSwitch', {})
-- vim.api.nvim_set_keymap('n', '<F10>', ':LL next<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<F11>', ':LL step<CR>', { noremap = true, silent = true })


-- COC
local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
keyset("n", "gr", "<Plug>(coc-references)", { silent = true })
keyset("n", "gh", "CocCommand clangd.switchSourceHeader", { silent = true })


-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })


-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })


-- Formatting selected code
keyset("x", "<leader>fo", "<Plug>(coc-format-selected)", { silent = true })
keyset("n", "<leader>fo", "<Plug>(coc-format-selected)", { silent = true })


-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = { silent = true, nowait = true }
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply source code actions for current file.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
--keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
--keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
--keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
--keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
--keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
--keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
--keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
--keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
--keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
--keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
--keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
--keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = { silent = true, nowait = true, expr = true }
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
    'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
    'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
keyset("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
keyset("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })


-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
--vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
--local opts = { silent = true, nowait = true }
--Show all diagnostics
--keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
--Manage extensions
--keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
--Show commands
--keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
--Find symbol of current document
--keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
--Search workspace symbols
--keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
--Do default action for next item
--keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
--Do default action for previous item
--keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
--Resume latest coc list
--keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)


-- ######################
-- ### Plugin Setting ###
-- ######################


-- Startify
vim.g.startify_change_to_dir = 0

-- NERDCommenter
vim.g.NERDCreateDefaultMappings = 0

-- VimSpector
vim.g.vimspector_install_gadgets = { 'vscode-cpptools' }
vim.g.vimspector_enable_mappings = 'HUMAN'

-- SmartQ (commented out)
-- vim.g.smartq_auto_close_splits = 0

-- vim-airline
vim.g.airline_powerline_fonts = 0
vim.g.airline_theme = 'bubblegum'
-- vim.g.airline_theme = 'tender' -- commented out
vim.g["airline#extensions#whitespace#enabled"] = 0
vim.g.airline_left_sep = ""
vim.g.airline_right_sep = ""
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#fnamemod"] = ':t'
vim.g.airline_section_y = ''
-- vim.g.airline_section_z = ... -- requires the airline#section#create function to be wrapped or implemented in Lua

-- These autocommands involve Vimscript functions that should ideally be wrapped in a Lua function
-- Or you can use a hybrid approach of Vimscript within Lua for complex cases like this
vim.cmd [[
  au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['%3p%% %L:%3v'])
  "au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['windowswap', 'obsession', '%3p%%', 'maxlinenr', ' :%3v']) -- commented out
]]

-- tabbar
vim.g.tagbar_autofocus = 1

-- Coc
vim.g.coc_global_extensions = { 'coc-clangd', 'coc-pyright', 'coc-snippets', 'coc-json', 'coc-clangd' }

-- Functions
local function syn_stack()
    if not vim.fn.exists("*synstack") then
        return
    end
    local syn_stack_output = vim.fn.map(vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.')),
        'vim.fn.synIDattr(v:val, "name")')
    print(table.concat(syn_stack_output, ", "))
end

-- Set keymap for the function
vim.api.nvim_set_keymap('n', '<leader>h', ':lua syn_stack()<CR>', { noremap = true, silent = true })



-- LUA stuff

-- This is Lua
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', '<leader>d', api.tree.change_root_to_node, opts('CD'))
    vim.keymap.set('n', 'u', api.node.navigate.parent, opts('Parent Directory'))
end

-- pass to setup along with your other options
require("nvim-tree").setup {
    ---
    on_attach = my_on_attach,
    ---
}

require("nvim-tree").setup({
    on_attach = my_on_attach,
    actions = {
        change_dir = {
            global = false
        },
        open_file = {
            quit_on_open = false
        }
    },
    sort_by = "case_sensitive",
    view = {
        width = 50,
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


require("yanky").setup({
})
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

require("substitute").setup({
    on_substitute = require("yanky.integration").substitute(),
})

vim.keymap.set("n", "s", require('substitute').operator, { noremap = true })
vim.keymap.set("n", "ss", require('substitute').line, { noremap = true })
vim.keymap.set("n", "S", require('substitute').eol, { noremap = true })
vim.keymap.set("x", "s", require('substitute').visual, { noremap = true })

vim.keymap.set("n", "sx", require('substitute.exchange').operator, { noremap = true })
vim.keymap.set("n", "sxx", require('substitute.exchange').line, { noremap = true })
vim.keymap.set("x", "X", require('substitute.exchange').visual, { noremap = true })
vim.keymap.set("n", "sxc", require('substitute.exchange').cancel, { noremap = true })


vim.keymap.set({ 'n', 'x', 'o' }, '(', function() require("flash").jump() end)
vim.keymap.set({ 'n', 'x', 'o' }, ')', function() require("flash").treesitter() end)

require("ros-nvim").setup({ only_workspace = true })
-- telescope finder
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope ros ros<cr>', { noremap = true })

-- follow links in launch files
vim.keymap.set('n', '<leader>rl', function() require("ros-nvim.ros").open_launch_include() end,
    { silent = true, noremap = true })

-- show definition for interfaces (messages/services) in floating window
vim.keymap.set('n', '<leader>ri', function() require("ros-nvim.ros").show_interface_definition() end,
    { silent = true, noremap = true })

require("telescope").setup({
    extensions = {
        coc = {
            theme = 'ivy',
            prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
        }
    },
})
require('telescope').load_extension('coc')

--local vim_utils = require "ros2-nvim.vim-utils"
--require 'ros2-nvim'.setup {
---- path to your catkin workspace
--catkin_ws_path = "~/catkin_ws",

---- make program (e.g. "catkin_make" or "catkin build" )
--catkin_program = "catkin_make",

----method for opening terminal for e.g. catkin_make: utils.open_new_buffer or custom function
--}

-- ROS Introspection
local map_opts = { noremap = true, silent = true }

-- Topics list & info
vim.api.nvim_set_keymap('n', '<leader>rt', '<cmd>lua require("ros2-nvim.telescope.pickers").topic_picker()<CR>', map_opts)
-- Nodes list & info
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua require("ros2-nvim.telescope.pickers").node_picker()<CR>', map_opts)
-- Services list & info
vim.api.nvim_set_keymap('n', '<leader>rs', '<cmd>lua require("ros2-nvim.telescope.pickers").service_picker()<CR>',
    map_opts)
-- Service definitions list & info
vim.api.nvim_set_keymap('n', '<leader>rds', '<cmd>lua require("ros2-nvim.telescope.pickers").srv_picker()<CR>', map_opts)
-- Message definitions list & info
vim.api.nvim_set_keymap('n', '<leader>rm', '<cmd>lua require("ros2-nvim.telescope.pickers").msg_picker()<CR>', map_opts)
-- Params list & values
vim.api.nvim_set_keymap('n', '<leader>rp', '<cmd>lua require("ros2-nvim.telescope.pickers").param_picker()<CR>', map_opts)
