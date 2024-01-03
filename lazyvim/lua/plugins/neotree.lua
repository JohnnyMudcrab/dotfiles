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
}
