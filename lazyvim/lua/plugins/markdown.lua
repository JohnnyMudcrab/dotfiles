return {
    -- nvim-lint pipes the buffer into markdownlint-cli2, which then has no file
    -- path to resolve a config from. Hand it one explicitly.
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = {
            linters = {
                ["markdownlint-cli2"] = {
                    prepend_args = { "--config", vim.fn.stdpath("config") .. "/.markdownlint.yaml" },
                },
            },
        },
    },

    -- While WSL interop is broken nvim cannot start a windows browser, so keep
    -- the port stable and print the url to open by hand.
    {
        "iamcco/markdown-preview.nvim",
        optional = true,
        init = function()
            vim.g.mkdp_port = "8765"
            vim.g.mkdp_echo_preview_url = 1
        end,
    },
}
