return {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
        opts.options.offsets = {
            {
                filetype = "snacks_layout_box",
                text = "Explorer",
                highlight = "@property",
                text_align = "left",
            },
        }
    end,
}
