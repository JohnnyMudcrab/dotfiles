return {
    {
        "SmiteshP/nvim-navbuddy",
        keys = {
            {
                "<leader>j",
                function()
                    require("nvim-navbuddy").open()
                end,
                desc = "Navbuddy",
            },
        },
        opts = {
            lsp = {
                auto_attach = true,
            },
        },
    },
}
