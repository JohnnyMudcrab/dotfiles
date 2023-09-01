return {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
        opts.indent.disable = { "cpp" }
        opts.highlight = {
            enable = true,
        }
    end,
}
