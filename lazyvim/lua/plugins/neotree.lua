return {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
        { "<leader>E", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
        { "<leader>e", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
    },
    opts = function(_, opts)
        opts.window.mappings["o"] = "open"
        opts.default_component_configs["name"] = { use_git_status_colors = false }
        opts.default_component_configs["git_status"] = { symbols = { untracked = "?" } }
        opts.filesystem["filtered_items"] = { hide_dotfiles = false, hide_gitignored = false }
        opts.filesystem["follow_current_file"] = { leave_dirs_open = true }
    end,
    requires = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        {
            "s1n7ax/nvim-window-picker",
            version = "2.*",
            config = function()
                require("window-picker").setup({
                    filter_rules = {
                        include_current_win = false,
                        autoselect_one = true,
                        -- filter using buffer options
                        bo = {
                            -- if the file type is one of following, the window will be ignored
                            filetype = { "neo-tree", "neo-tree-popup", "notify" },
                            -- if the buffer type is one of following, the window will be ignored
                            buftype = { "terminal", "quickfix" },
                        },
                    },
                })
            end,
        },
    },
}
