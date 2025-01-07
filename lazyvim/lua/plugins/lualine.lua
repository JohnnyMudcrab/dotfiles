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
            light_grey = "#676767",
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
        vim.api.nvim_set_hl(0, "LualineSeparatorOrange", { fg = colors.light_grey, bg = colors.grey })

        -- Reusable separator formatting functions
        local function add_sep_left(str)
            if str and str ~= "" then
                return str .. " %#LualineSeparatorOrange#╲"
            end
            return str
        end

        local function add_sep_right(str)
            if str and str ~= "" then
                return str .. " %#LualineSeparatorOrange#╱"
            end
            return str
        end


        -- custom_theme.normal.x = { bg = "#444444" }
        opts.options.theme = custom_theme
        opts.options.section_separators = { left = "", right = "" }
        opts.sections = process_sections({
            lualine_a = { "mode" },
            lualine_b = { "branch" },
            lualine_c = {
                --LazyVim.lualine.root_dir(),
                {
                    "diagnostics",
                    symbols = {
                        error = icons.diagnostics.Error,
                        warn = icons.diagnostics.Warn,
                        info = icons.diagnostics.Info,
                        hint = icons.diagnostics.Hint,
                    },
                    fmt = add_sep_left,
                    padding = { left = 1, right = 0 },
                },
                { "filetype", icon_only = false, padding = { left = 1, right = 0 }, fmt = add_sep_left },
                -- { LazyVim.lualine.pretty_path() },
                { "filename", path = 1, padding = { left = 1, right = 0 } },
            },
            lualine_x = {
                Snacks.profiler.status(),
                -- stylua: ignore
                {
                    function() return require("noice").api.status.command.get() end,
                    cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                    color = function() return { fg = Snacks.util.color("Statement") } end,
                    fmt = add_sep_right,
                    padding = { left = 0, right = 1 }
                },
                -- stylua: ignore
                {
                    function() return require("noice").api.status.mode.get() end,
                    cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                    color = function() return { fg = Snacks.util.color("Constant") } end,
                    fmt = add_sep_right,
                    padding = { left = 0, right = 1 }
                },
                -- stylua: ignore
                {
                    function() return "  " .. require("dap").status() end,
                    cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                    color = function() return { fg = Snacks.util.color("Debug") } end,
                    fmt = add_sep_right,
                    padding = { left = 0, right = 1 }
                },
                -- stylua: ignore
                {
                    require("lazy.status").updates,
                    cond = require("lazy.status").has_updates,
                    color = function() return { fg = Snacks.util.color("Special") } end,
                    fmt = add_sep_right,
                    padding = { left = 0, right = 1 }
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
                    padding = { left = 0, right = 1 },
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
