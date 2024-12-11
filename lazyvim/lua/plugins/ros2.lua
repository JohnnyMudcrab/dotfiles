return {
    "ErickKramer/nvim-ros2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        -- Add any custom options here
        autocmds = true,
        telescope = true,
        treesitter = true,
    },
    keys = {
        { "<leader>ra", "<cmd>Telescope ros2 actions<CR>", desc = "List ROS Actions" },
        { "<leader>rt", "<cmd>Telescope ros2 topics<CR>", desc = "List ROS topics" },
        { "<leader>ri", "<cmd>Telescope ros2 interfaces<CR>", desc = "List ROS Interfaces" },
        { "<leader>rn", "<cmd>Telescope ros2 nodes<CR>", desc = "List ROS Nodes" },
        { "<leader>rs", "<cmd>Telescope ros2 services<CR>", desc = "List ROS services" },
    },
}
