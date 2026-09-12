return {
    { "nvchad/volt", lazy = true },
    -- the default menu's color picker entry calls minty.huefy
    { "nvchad/minty", lazy = true },
    {
        "nvchad/menu",
        lazy = false,
        opts = {},
        config = function()
            vim.keymap.set("n", "<C-t>", function()
                require("menu").open("default")
            end, { desc = "Context menu" })

            vim.keymap.set("n", "<RightMouse>", function()
                vim.cmd.exec('"normal! \\<RightMouse>"')
                require("menu").open("default", { mouse = true })
            end, { desc = "Context menu (mouse)" })
        end,
    },
}
