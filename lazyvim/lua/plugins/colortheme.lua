return {
    {
        "norcalli/nvim-colorizer.lua",
    },
    {
        "nvim-treesitter/playground",
    },
    {
        "folke/tokyonight.nvim",
        -- M.default = {
        -- none = "NONE",
        -- bg_dark = "#1f2335",
        -- bg = "#24283b",
        -- bg_highlight = "#292e42",
        -- terminal_black = "#414868",
        -- fg = "#c0caf5",
        -- fg_dark = "#a9b1d6",
        -- fg_gutter = "#3b4261",
        -- dark3 = "#545c7e",
        -- comment = "#565f89",
        -- dark5 = "#737aa2",
        -- blue0 = "#3d59a1",
        -- blue = "#7aa2f7",
        -- cyan = "#7dcfff",
        -- blue1 = "#2ac3de",
        -- blue2 = "#0db9d7",
        -- blue5 = "#89ddff",
        -- blue6 = "#b4f9f8",
        -- blue7 = "#394b70",
        -- magenta = "#bb9af7",
        -- magenta2 = "#ff007c",
        -- purple = "#9d7cd8",
        -- orange = "#ff9e64",
        -- yellow = "#e0af68",
        -- green = "#9ece6a",
        -- green1 = "#73daca",
        -- green2 = "#41a6b5",
        -- teal = "#1abc9c",
        -- red = "#f7768e",
        -- red1 = "#db4b4b",
        -- git = { change = "#6183bb", add = "#449dab", delete = "#914c54" },
        -- gitSigns = {
        --     add = "#266d6a",
        --     change = "#536c9e",
        --     delete = "#b2555b",
        -- },
        -- }
        -- TODO: change color of autocompletion
        opts = function(_, opts)
            opts.on_colors = function(colors)
                colors.none = "NONE"
                colors.bg_dark = "#282828"
                colors.bg = "#212121"
                colors.bg_highlight = "#323232"
                colors.fg = "#eeeeee"
                colors.fg_dark = "#dadada"
                colors.fg_darker = "#cbcbcb"
                colors.fg_gutter = "#444444"
                colors.dark3 = "#545c7e"
                colors.dark5 = "#a7a7a7" --"#b7b7b7"
                colors.blue0 = "#3d59a1"
                colors.blue1 = "#87afd7"
                colors.blue = "#b1dbec"
                colors.blue2 = "#8aacba"
                colors.blue5 = "#647c86"
                colors.blue6 = "#3d4c53"
                colors.blue7 = "#394b70"
                colors.cyan = "#7dcfff"
                colors.comment = "#666666"
                colors.magenta = "#d78787" -- "#ff007c" --colors.fg
                colors.magenta2 = "#ff007c"
                colors.purple = "#a074c4" --"#b7bdf8"
                colors.orange = "#ffc24b"
                colors.yellow = "#d3b987"
                colors.green = "#afd787"
                colors.green1 = "#cfffa0"
                colors.green2 = "#85a366"
                colors.teal = "#f9c13e"
                colors.red = "#f7768e"
                colors.red1 = "#db4b4b"
                colors.git = { change = colors.orange, add = colors.green, delete = colors.magenta }
                colors.gitSigns = {
                    add = colors.green,
                    change = colors.orange,
                    delete = colors.magenta,
                }
                colors.bg_sidebar = colors.bg_dark
                colors.fg_sidebar = colors.fg_dark
                colors.bg_statusline = colors.bg_dark
                colors.fg_statusline = colors.fg_dark
                colors.bg_float = "#1b1b1b"
                colors.fg_float = colors.fg_dark
                colors.info = colors.green1 --colors.dark5
                colors.white = "#ffffff"
            end
            opts.on_highlights = function(hl, c)
                hl.NeoTreeGitModified = { fg = c.orange }
                hl.NeoTreeDirectoryName = { fg = c.yellow }
                hl.NeoTreeRootName = { fg = c.magenta }
                hl.NeoTreeTitleBar = { fg = c.magenta }
                hl.NeoTreeGitUntracked = { fg = c.red1 }

                -- hl.FlashCurrent = { bg = c.green }
                -- hl.FlashMatch = { bg = c.purple }
                -- hl.FlashLabel = { bg = c.green }
                -- hl.FlashBackdrop = { bg = c.comment }

                -- hl.IlluminatedWordWrite = { bg = c.magenta }

                hl.AlphaShortcut = { fg = c.magenta }
                hl.AlphaHeader = { fg = c.blue1 }
                hl.AlphaHeaderLabel = { fg = c.orange }
                hl.AlphaFooter = { fg = c.green }
                hl.AlphaButtons = { fg = c.fg_dark }

                -- hl.CmpItemKind = { bg = c.fg }

                hl.MiniIndentscopeSymbol = { fg = c.green1 }

                hl.WhichKeyDesc = { fg = c.fg }
                -- hl.WhichKey = { fg = c.white }
                hl.WhichKeyGroup = { fg = c.yellow }

                hl.Constant = { fg = c.orange }
                hl.cppNumber = { fg = c.fg }
                hl.Directory = { fg = c.blue1 }
                hl.DiagnosticUnnecessary = { fg = c.comment, underline = true }
                hl.Function = { fg = c.green }
                hl.Pmenu = { bg = c.bg_highlight }
                hl.PmenuSbar = { bg = c.bg }
                hl.PreProc = { fg = c.dark5 }
                hl.String = { fg = c.fg }
                hl.Statement = { fg = c.magenta }
                hl.Title = { fg = c.magenta }
                hl.Type = { fg = c.blue }

                hl["@operator"] = { fg = c.magenta }
                hl["@keyword"] = { fg = c.magenta }

                hl["@lsp.type.variable.cpp"] = { fg = c.fg }
                hl["@lsp.type.class.cpp"] = { fg = c.blue1 }
                hl["@lsp.typemod.class.defaultLibrary.cpp"] = hl["@lsp.type.class"]
                hl["@lsp.typemod.type.defaultLibrary.cpp"] = hl.Type
                hl["@lsp.typemod.function.defaultLibrary.cpp"] = hl.Function
                hl["@lsp.typemod.variable.readonly.cpp"] = hl.Constant
                hl["@lsp.type.property.cpp"] = { fg = c.yellow } --hl["@lsp.type.variable"]
                hl["@lsp.type.namespace"] = { fg = c.magenta }
                hl["@lsp.type.unknown.cpp"] = { fg = c.fg_darker, underline = true }

                hl.BufferLineTabSelected = { fg = c.magenta }
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
