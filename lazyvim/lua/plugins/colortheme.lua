return {
    {
        "folke/tokyonight.nvim",
        opts = function(_, opts)
            opts.on_colors = function(colors)
                colors.bg_dark = "#323232"
                colors.bg = "#212121"
                colors.bg_highlight = "#323232"
                colors.green = "#87afd7"
                colors.green1 = "#87afd7"
                colors.orange = "#ffc24b"
                colors.purple = "#d78787"
                colors.fg = "#eeeeee"
                colors.fg_dark = "#dadada"
                colors.fg_gutter = "#444444"
                colors.magenta = colors.fg
                colors.dark5 = "#b7b7b7"
                colors.comment = "#666666"
                colors.blue = "#afd787"
                colors.blue1 = "#c9d05c"
                colors.cyan = "#d3b987"
            end
            opts.style = "night"
        end,
    },

    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "tokyonight",
        },
    },
}
