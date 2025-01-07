return {
    "akinsho/toggleterm.nvim",
    version = "*",
    --stylua: ignore
    keys = {
        { "<leader>rb", function() _build_ros() end , desc = "ROS Build"},
    },
    lazy = false,
    opts = {},
    config = function()
        local Terminal = require("toggleterm.terminal").Terminal
        local build_ros = Terminal:new({
            cmd = 'colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_CXX_FLAGS="-isystem /opt/ros/humble/include" --symlink-install',
            -- function to run on opening the terminal
            on_open = function(term)
                vim.notify("Started RCB Build")
                vim.fn.setqflist({}, "r")
            end,
            -- function to run on closing the terminal
            on_stdout = function(term, job, data, name)
                local quickfix_list = {}
                local capture = false
                local current_package = nil

                for _, line in ipairs(data) do
                    line =
                        line:gsub("\27%[[0-9;]*m", ""):gsub("\27%[[0-9;]*K", ""):gsub("\27%]8;;.-\7", ""):gsub("\r", "") -- Remove ANSI codes

                    local time = line:match("^%[(%d+%.%d+s)%]")
                    if time then
                        -- vim.notify(time, "info", {
                        --     title = "plugin",
                        --     timeout = 3000,
                        --     on_close = function()
                        --         vim.notify("Problem solved", nil, { title = "plugin" })
                        --         vim.notify("Error code 0x0395AF", 1, { title = "plugin" })
                        --     end,
                        -- })
                    end

                    -- Check for start and end markers with leading whitespace
                    if line:match("^%s*--- stderr: (%S+)") then
                        current_package = line:match("^%s*--- stderr: (%S+)")
                        capture = true
                    elseif line:match("^%s*---") then
                        capture = false
                    end

                    if capture then
                        -- Try to match a pattern with file, line number, column, type, and message
                        local file, lnum, col, err_type, msg = line:match("(%S+):(%d+):(%d+): (%a+): (.+)")
                        if not file then
                            -- If no match, try a pattern without the column number and type
                            file, lnum, msg = line:match("(%S+):(%d+): (.+)")
                            err_type = nil
                            col = nil
                        end

                        if file and lnum and msg then
                            local type = nil
                            if err_type == "error" then
                                type = "E"
                            elseif err_type == "warning" then
                                type = "W"
                            end
                            table.insert(quickfix_list, {
                                filename = file,
                                lnum = tonumber(lnum),
                                col = col and tonumber(col),
                                type = type,
                                text = "[" .. (current_package or "unknown") .. "] " .. msg,
                            })
                        end
                    end
                end
                vim.fn.setqflist(quickfix_list, "a")
            end,
            on_exit = function(term, job, data, name)
                if data == 0 then
                    vim.notify("RCB Build finished without errors")
                else
                    vim.notify("RCB Build finished with errors", "error")
                    vim.cmd("Trouble quickfix")
                end
            end,
        })

        function _build_ros()
            vim.cmd("Trouble quickfix close")
            build_ros:toggle()
        end
    end,
}

-- -- Require the notify module
-- local notify = require("notify")
--
-- -- Function to start the build process and show initial notification
-- local build_start = function()
--     -- Store the notification in a variable
--     local notification = notify("Build started...", "info", {
--         title = "Building Project",
--         timeout = false  -- Keeps the notification open
--     })
--
--     -- Return the notification object for future updates
--     return notification
-- end
--
-- -- Function to update the notification with the current build time
-- local update_build_time = function(notification, build_time)
--     -- Update the notification
--     notify("Current build time: " .. build_time, "info", {
--         replace = notification,  -- Replace the existing notification
--         title = "Building Project"
--     })
-- end
--
-- -- Example usage
-- local my_notification = build_start()
-- -- Simulate updating build time after some time
-- vim.defer_fn(function()
--     update_build_time(my_notification, "0.65s")
-- end, 2000)  -- Update after 2 seconds
