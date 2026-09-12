return {
    "ErickKramer/nvim-ros2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    opts = {
        autocmds = true,
        treesitter = true,
        picker = "snacks",
    },
    --stylua: ignore
    keys = {
        { "<leader>ra", function() require("nvim-ros2.pickers").actions() end,     desc = "List ROS Actions" },
        { "<leader>rt", function() require("nvim-ros2.pickers").topics_info() end, desc = "List ROS Topics" },
        { "<leader>ri", function() require("nvim-ros2.pickers").interfaces() end,  desc = "List ROS Interfaces" },
        { "<leader>rn", function() require("nvim-ros2.pickers").nodes() end,       desc = "List ROS Nodes" },
        { "<leader>rs", function() require("nvim-ros2.pickers").services() end,    desc = "List ROS Services" },
        { "<leader>rp", function() require("nvim-ros2.pickers").packages() end,    desc = "List ROS Packages" },
    },
}
