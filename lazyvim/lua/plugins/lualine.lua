return {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
        local Util = require("lazyvim.util")
        local icons = require("lazyvim.config").icons
        -- Put proper separators and gaps between components in sections
        local colors = {
            red = "#ca1243",
            grey = "#323232",
            dark_grey = "#282828",
            black = "#383a42",
            white = "#f3f3f3",
            light_green = "#83a598",
            orange = "#fe8019",
            green = "#8ec07c",
        }
        local empty = require("lualine.component"):extend()
        function empty:draw(default_highlight)
            self.status = ""
            self.applied_separator = ""
            self:apply_highlights(default_highlight)
            self:apply_section_separators()
            return self.status
        end
        local function process_sections(sections)
            for name, section in pairs(sections) do
                local left = name:sub(9, 10) < "x"
                for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
                    table.insert(section, pos * 2, { empty, color = { fg = colors.grey, bg = colors.grey } })
                end
                for id, comp in ipairs(section) do
                    if type(comp) ~= "table" then
                        comp = { comp }
                        section[id] = comp
                    end
                    comp.separator = left and { right = "" } or { left = "" }
                end
            end
            return sections
        end
        -- Get the auto-generated theme
        local custom_theme = require("lualine.themes.auto")
        -- Override just the normal section c background color
        custom_theme.normal.c.bg = colors.grey
        -- custom_theme.normal.x = { bg = "#444444" }
        opts.options.theme = custom_theme
        opts.options.section_separators = { left = "", right = "" }
        opts.sections = process_sections({
            lualine_a = { "mode" },
            lualine_b = { "branch" },

            lualine_c = {
                LazyVim.lualine.root_dir(),
                {
                    "diagnostics",
                    symbols = {
                        error = icons.diagnostics.Error,
                        warn = icons.diagnostics.Warn,
                        info = icons.diagnostics.Info,
                        hint = icons.diagnostics.Hint,
                    },
                },
                { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                -- { LazyVim.lualine.pretty_path() },
                { "filename", path = 1 },
            },
            lualine_x = {
                Snacks.profiler.status(),
                -- stylua: ignore
                {
                    function() return require("noice").api.status.command.get() end,
                    cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                    color = function() return { fg = Snacks.util.color("Statement") } end,
                },
                -- stylua: ignore
                {
                    function() return require("noice").api.status.mode.get() end,
                    cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                    color = function() return { fg = Snacks.util.color("Constant") } end,
                },
                -- stylua: ignore
                {
                    function() return "  " .. require("dap").status() end,
                    cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                    color = function() return { fg = Snacks.util.color("Debug") } end,
                },
                -- stylua: ignore
                {
                    require("lazy.status").updates,
                    cond = require("lazy.status").has_updates,
                    color = function() return { fg = Snacks.util.color("Special") } end,
                },
                {
                    "diff",
                    symbols = {
                        added = icons.git.added,
                        modified = icons.git.modified,
                        removed = icons.git.removed,
                    },
                    source = function()
                        local gitsigns = vim.b.gitsigns_status_dict
                        if gitsigns then
                            return {
                                added = gitsigns.added,
                                modified = gitsigns.changed,
                                removed = gitsigns.removed,
                            }
                        end
                    end,
                },
            },
            lualine_y = {
                { "progress", separator = " ", padding = { left = 1, right = 1 } },
                { "location", padding = { left = 1, right = 1 } },
            },
            lualine_z = {
                function()
                    return " " .. os.date("%R")
                end,
            },
        })
    end,
}
