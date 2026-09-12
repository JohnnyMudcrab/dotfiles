return {
    -- blink highlights completion labels with treesitter itself since 1.x,
    -- which is what colorful-menu.nvim used to be here for.
    "saghen/blink.cmp",
    opts = {
        completion = {
            menu = {
                draw = {
                    treesitter = { "lsp" },
                },
            },
        },
    },
}
