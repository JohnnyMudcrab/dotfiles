-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Options are automatically loaded before lazy.nvim startup
--
-- Add any additional options here
-- vim.opt.winbar = "%=%m %f"

-- use bash as default shell
vim.opt.shell = "/bin/bash"

-- make system clipboard default (apt-get install xclip required)
vim.opt.clipboard = "unnamedplus"

-- show whitespace. must be inserted before colorsheme command
-- vim.cmd([[
--     autocmd ColorScheme * highlight ExtraWhiteSpace ctermbg=red guibg=red
--     au InsertLeave * match ExtraWhitespace /\s\+$/
-- ]])

-- looks
vim.opt.termguicolors = true

vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.mouse = "a"
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.cinoptions = ""

-- Y-N-C prompt if closing with unsaved changes
vim.opt.confirm = true

-- don't automatically prefix comments
vim.cmd([[ autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]])

-- searching and patterns
vim.opt.hlsearch = true -- highlight searches by default
-- vim.opt.incsearch = true  -- incrementally search while typing a /regex
vim.opt.ignorecase = true -- default to using case insensitive searches
vim.opt.smartcase = true -- unless uppercase letters are used in the regex

-- reading/writing
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.autowrite = false -- never write a file unless I request it
vim.opt.autowriteall = false -- NEVER

-- syntax highlight on
vim.cmd("syntax on")
-- vim.opt.lazyredraw = true

-- showing line numbers and length
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- make them relative
vim.opt.textwidth = 80 -- width of document (used by gd)
vim.opt.wrap = false -- don't automatically wrap on load
vim.opt.formatoptions:remove("t") -- don't automatically wrap text when typing
-- vim.opt.colorcolumn = "80"  -- show column 80

-- when scrolling, keep cursor x lines away from screen border
-- vim.opt.scrolloff = 1010
vim.opt.scrolloff = 4

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 200

-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
