return {
    "folke/todo-comments.nvim",
    --stylua: ignore
    keys = function()
        return {
            { "<leader>xt", "<cmd>TodoTrouble cwd=vim.fn.expand('%:p')<cr>", desc = "Todo (Trouble)" },
        }
    end,
}
