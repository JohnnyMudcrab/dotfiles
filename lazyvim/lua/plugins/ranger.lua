return {
    {
        "kelly-lin/ranger.nvim",
        keys = {
            {
                "<leader>r",
                function()
                    require("ranger-nvim").open(true)
                end,
                desc = "Ranger",
            },
        },
        config = function()
            require("ranger-nvim").setup({ replace_netrw = true })
        end,
    },
}
-- need to install ranger
