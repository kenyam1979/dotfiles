-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
-- or, changing the font size and color scheme.
config.font_size = 13
config.font = wezterm.font("HackGen Console NF")

config.color_scheme = "AdventureTime"
config.window_background_opacity = 0.85

-- Key binding
config.keys = {

	-- Open a new tab (Ctrl+Shift+T)
	{ key = "t", mods = "CTRL|SHIFT", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	--  Transit tabs (Ctrl+Tab)
	{ key = "Tab", mods = "CTRL", action = wezterm.action({ ActivateTabRelative = 1 }) },
	-- Close a tab (Ctrl+Shift+W)
	{ key = "w", mods = "CTRL|SHIFT", action = wezterm.action({ CloseCurrentPane = { confirm = false } }) },
	-- Split a pane vertically (Alt+Shift++)
	{ key = "+", mods = "ALT|SHIFT", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	-- Split a pane horizontally (Alt+Shift+-)
	{ key = "=", mods = "ALT|SHIFT", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	-- Command pallet (Ctrl+Shift+P)
	{ key = "p", mods = "CTRL|SHIFT", action = "ActivateCommandPalette" },
	-- Transit panes
	{ key = "LeftArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
	-- Adjust pane size
	{ key = "LeftArrow", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
	{ key = "UpArrow", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "DownArrow", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
}

-- Tab title
-- config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
local title_cache = {}

wezterm.on("update-status", function(window, pane)
	local pane_id = pane:pane_id()
	local process_info = pane:get_foreground_process_info()
	if process_info then
		local cwd = process_info.cwd
		local cwd_str = tostring(cwd)
		local folder_name = cwd_str:match("([^/]+)$")
		title_cache[pane_id] = folder_name
	end
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local pane = tab.active_pane
	local pane_id = pane.pane_id

	if title_cache[pane_id] then
		return {
			{ Text = " 📂 " .. title_cache[pane_id] .. " " },
		}
	end

	return {
		{ Text = " " .. tab.tab_title .. " " },
	}
end)

-- Finally, return the configuration to wezterm:
return config
