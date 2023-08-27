return {
    "cloudsftp/peek.nvim",
    branch = "bundle",
    build = "deno task --quiet build:fast",
    config = function()
        require("peek").setup()
        vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
        vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
}

-- Install Deno Version 1.33.1: https://github.com/denoland/deno/releases/tag/v1.33.1
-- Path ~/.deno/bin/
