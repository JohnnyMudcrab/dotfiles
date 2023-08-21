return {
    {
        "SmiteshP/nvim-navbuddy",
        keys = {
            {
                "<leader>n",
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
