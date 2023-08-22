return {
    {
        "norcalli/nvim-colorizer.lua",
    },
    {
        "nvim-treesitter/playground",
    },
    {
        "folke/tokyonight.nvim",
        opts = function(_, opts)
            opts.on_colors = function(colors)
                colors.bg_dark = "#282828"
                colors.bg = "#212121"
                colors.bg_highlight = "#323232"
                -- colors.green = "#bababa"
                colors.green0 = "#87afd7"
                colors.green1 = "#87afd7"
                colors.green2 = "#85a366"
                colors.orange = "#ffc24b"
                colors.purple = "#d78787"
                colors.fg = "#eeeeee"
                colors.fg_dark = "#dadada"
                colors.fg_gutter = "#444444"
                colors.magenta = colors.fg
                colors.dark5 = "#b7b7b7"
                colors.comment = "#666666"
                -- colors.blue = "#9d83d0"
                colors.blue = "#afd787"
                colors.blue1 = "#c9d05c"
                colors.cyan = "#d3b987"
                colors.teal = "#f9c13e"
                colors.bg_sidebar = colors.bg_dark
                colors.fg_sidebar = colors.fg_dark
                colors.bg_statusline = colors.bg_dark
                colors.fg_statusline = colors.fg_dark
                colors.bg_float = "#1b1b1b"
                colors.fg_float = colors.fg_dark
                colors.info = colors.dark5
                colors.gitSigns = {
                    add = colors.blue1,
                    -- change = "#536c9e",
                    change = colors.orange,
                    -- delete = "#b2555b",
                    delete = colors.purple,
                }
            end
            opts.on_highlights = function(hl, c)
                hl.NeoTreeGitModified = { fg = c.orange }
                hl.NeoTreeDirectoryName = { fg = c.fg_dark }
                hl.NeoTreeRootName = { fg = c.purple }

                hl.AlphaShortcut = { fg = c.purple }
                hl.AlphaHeader = { fg = c.blue1 }
                hl.AlphaHeaderLabel = { fg = c.orange }
                hl.AlphaFooter = { fg = c.green }
                hl.AlphaButtons = { fg = c.fg_dark }
            end
            opts.style = "storm"
            opts.transparent = false
        end,
    },

    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "tokyonight",
        },
    },

    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            opts.theme = "tokyonight"
        end,
    },
}
