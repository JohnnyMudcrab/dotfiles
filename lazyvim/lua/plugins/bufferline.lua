return {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
        opts.options.offsets = {
            {
                filetype = "neo-tree",
                text = "Neo-tree",
                highlight = "@property",
                text_align = "left",
            },
        }
    end,
}
