-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp",
    callback = function()
        -- Set the commentstring for C++ files
        vim.bo.commentstring = "// %s"
    end,
})

vim.filetype.add({
    extension = {
        urdf = "xml",
        xacro = "xml", -- falls du auch xacro-Dateien verwendest
    },
})

-- LazyVim switches spell checking on for markdown, with an english dictionary.
-- On german prose that underlines most of the words. Toggle it per buffer with
-- <leader>us when proof reading is actually wanted.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.spell = false
    end,
})

-- lazy.nvim creates filetype scoped keymaps only when a FileType event fires
-- after its handlers are attached. For the file given on the command line that
-- has already happened, so those keymaps are missing (<leader>cp for markdown,
-- for example). Fire the event once more.
vim.schedule(function()
    vim.cmd("do FileType")
end)
