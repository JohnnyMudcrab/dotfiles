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
}
