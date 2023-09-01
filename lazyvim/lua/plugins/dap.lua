return {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
        opts.ensure_installed = { "cpptools" }
    end,
}
