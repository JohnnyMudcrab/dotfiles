local wezterm = require 'wezterm'

return {
    default_prog = { 'wsl.exe', '--distribution', 'Ubuntu-22.04' },
    font = wezterm.font("Hack Nerd Font Mono"), -- Replace with your preferred font "JetBrains Mono"
	--font = wezterm.font("JetBrains Mono Bold"), -- Replace with your preferred font "JetBrains Mono"
    font_size = 12.0,
	window_decorations = "INTEGRATED_BUTTONS|RESIZE",
	window_close_confirmation = "NeverPrompt",
    enable_tab_bar = false, -- Disable this if you don't want the tab bar
    window_background_opacity = 1.0, -- Optional: Adjust background transparency
	color_scheme = "OneHalfDark", -- Use a predefined scheme
    colors = {
        background = "#212121", -- Override the background
    },
    keys = {
        -- Toggle fullscreen with F11
        {key="F11", mods="NONE", action=wezterm.action.ToggleFullScreen},
		-- {key="R", mods="CTRL|SHIFT", action=wezterm.action.ReloadConfiguration},
    },
	window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 0,
    },
	line_height = 1.0,
	cell_width = 1.0,
	--wezterm.on("format-window-title", function(tab, pane, tabs, config, hover, max)
	--	return ""
	--end),
}