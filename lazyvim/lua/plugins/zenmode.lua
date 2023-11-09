return {
    "folke/zen-mode.nvim",
    --stylua: ignore
    keys = function()
        return {
            { "<leader>z", mode = { "n", "x", "o" }, function() require("zen-mode").toggle({}) end, desc = "Flash"},
        }
    end,

    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
}
