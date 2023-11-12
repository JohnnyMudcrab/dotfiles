return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
        vim.opt.laststatus = 3
        vim.opt.splitkeep = "screen"
    end,
    opts = {
        animate = { enabled = false },
        bottom = {
            -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
            {
                ft = "toggleterm",
                size = { height = 0.3 },
                -- exclude floating windows
                filter = function(buf)
                    return vim.b[buf].toggle_number == 2
                end,
            },
            {
                ft = "lazyterm",
                title = "LazyTerm",
                size = { height = 0.3 },
                filter = function(buf)
                    return not vim.b[buf].lazyterm_cmd
                end,
            },
            {
                ft = "Trouble",
                title = "FixMe",
                size = { height = 0.3 },
            },
            {
                ft = "qf",
                title = "QuickFix",
            },
            {
                ft = "help",
                size = { height = 0.3 },
                -- only show help buffers
                filter = function(buf)
                    return vim.bo[buf].buftype == "help"
                end,
            },
            {
                ft = "spectre_panel",
                size = { height = 0.4 },
            },
        },
        left = {},
    },
}
