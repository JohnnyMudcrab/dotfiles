return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
        opts.window.mappings["o"] = "open"
        opts.default_component_configs["name"] = { use_git_status_colors = false }
        opts.default_component_configs["git_status"] = { symbols = { untracked = "?" } }
    end,
}
