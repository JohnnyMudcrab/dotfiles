-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    ---@cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({ lhs, mode = mode }).id] then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        if opts.remap and not vim.g.vscode then
            opts.remap = nil
        end
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

local wk = require("which-key")
wk.register({
    r = {
        name = "ROS", -- optional group name
    },
}, { prefix = "<leader>" })

map("n", "<leader>a", "<cmd>e ~/.config/nvim/init.lua<cr>", { desc = "Edit Config" })
map("t", "<esc>", "<C-\\><C-n>", { desc = "Exit to Normal in Terminal" })

map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigate Down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigate Up" })
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigate Left" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigate Right" })

-- center after jump
map("n", "<C-o>", "<C-o>zz", { desc = "Jump back and center" })
map("n", "<C-i>", "<C-i>zz", { desc = "Jump forward and center" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
map("n", "<leader>.", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map(
    "n",
    "<leader>fs",
    "<cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.getcwd() .. '/src' })<CR>",
    { desc = "Find Files in src directory" }
)
