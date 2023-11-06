return {
    "folke/flash.nvim",
    --stylua: ignore
    keys = function()
        return {
            { "(", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { ")", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        }
    end,
    opts = function(_, opts)
        opts["modes"] = {
            char = {
                enabled = true,
                multi_line = false,
                highlight = {
                    backdrop = false,
                },
                jump = { nohlsearch = true },
            },
            search = {
                enabled = false,
            },
        }
        opts["highlight"] = {
            backdrop = false,
        }
        opts["labels"] = "asdfghjklwertyuiopxcvbnm([{"
        opts["jump"] = {
            pos = "start",
        }
    end,
}
