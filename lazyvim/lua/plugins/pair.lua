return {
    "echasnovski/mini.pairs",
    opts = function(_, opts)
        opts.mappings = {
            ["("] = { action = "open", pair = "()", neigh_pattern = ".[%s]" },
            ["["] = { action = "open", pair = "[]", neigh_pattern = ".[%s]" },
            ["{"] = { action = "open", pair = "{}", neigh_pattern = ".[%s]" },

            [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
            ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
            ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

            ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
            ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
            ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
        }
    end,
}
