-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
-- or, changing the font size and color scheme.
config.font_size = 11
config.color_scheme = "AdventureTime"
config.window_background_opacity = 0.85

-- Key binding
config.keys = {

  -- Open a new tab (Ctrl+Shift+T)
  { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action{SpawnTab='CurrentPaneDomain'} },
  --  Transit tabs (Ctrl+Tab)
  { key = 'Tab', mods = 'CTRL', action = wezterm.action{ActivateTabRelative=1} },
  -- Close a tab (Ctrl+Shift+W)
  { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action{CloseCurrentPane={confirm=false}} },
  -- Split a pane vertically (Alt+Shift++)
  { key = '+', mods = 'ALT|SHIFT', action = wezterm.action{SplitHorizontal={domain='CurrentPaneDomain'}} },
  -- Split a pane horizontally (Alt+Shift+-)
  { key = '=', mods = 'ALT|SHIFT', action = wezterm.action{SplitVertical={domain='CurrentPaneDomain'}} },
  -- Command pallet (Ctrl+Shift+P)
  { key = 'p', mods = 'CTRL|SHIFT', action = 'ActivateCommandPalette' },
  -- Transit panes
  { key = 'LeftArrow',  mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Down' },
  -- Adjust pane size
  { key = 'LeftArrow',  mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize { 'Left', 5 } },
  { key = 'RightArrow', mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize { 'Right', 5 } },
  { key = 'UpArrow',    mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
  { key = 'DownArrow',  mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize { 'Down', 5 } },

}



-- Finally, return the configuration to wezterm:
return config
