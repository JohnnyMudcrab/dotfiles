return {
    -- The mason build of oxfmt is broken here (missing native binding), and
    -- lspconfig lets it attach to markdown. Formatting runs through conform
    -- anyway, so the server stays off. LazyVim only disables it in its oxc
    -- extra, which is not enabled here.
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            oxfmt = { enabled = false },
        },
    },
}
