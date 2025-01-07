local wezterm = require("wezterm")
local config = {}
local act = wezterm.action

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Basic configuration
config.default_prog = { "/usr/bin/zsh" }
config.default_cwd = "~"

-- Appearance
config.font = wezterm.font("ComicShannsMono Nerd Font")
config.font_size = 17.0
--config.line_height = 1.5
--config.cell_width = 0.9

-- Color scheme and transparency
-- config.color_scheme = 'Ollie'

config.enable_tab_bar = true
config.window_decorations = "RESIZE"
config.color_scheme = "tokyonight_night"
config.window_background_opacity = 0.98
config.window_background_gradient = {
	orientation = "Vertical",
	colors = {
		"#1a1b26",
		"#1a1b26",
	},
	interpolation = "Linear",
	blend = "Rgb",
}

config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action_callback(function(window, pane)
			local has_selection = window:get_selection_text_for_pane(pane) ~= ""
			if has_selection then
				window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
				window:perform_action(act.ClearSelection, pane)
			else
				window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
			end
		end),
	},
}

-- Keybindings for pane management
config.keys = {
	-- Split panes
	{
		key = "|",
		mods = "SHIFT|ALT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "_",
		mods = "SHIFT|ALT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- Navigate between panes using arrow keys
	{
		key = "LeftArrow",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},

	-- Resize panes using ALT+SHIFT+Arrow keys
	{
		key = "LeftArrow",
		mods = "ALT|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "RightArrow",
		mods = "ALT|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "UpArrow",
		mods = "ALT|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "DownArrow",
		mods = "ALT|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},

	-- Close current pane
	{
		key = "w",
		mods = "ALT",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},

	-- Full Screen
	{
    		key = 'n',
    		mods = 'SHIFT|CTRL',
    		action = wezterm.action.ToggleFullScreen,
  	},

	-- Paste Shift + Ins
	{ 	key = "Insert", 
		mods = "SHIFT", 
		action = act.PasteFrom("Clipboard"),
	},

	-- Show/Hide Window
	{
		key = "`",
		mods = "CTRL",
		action = wezterm.action.Hide,
	},

	{
		key = "`",
		mods = "ALT",
		action = wezterm.action.Show,
	},

	{
		key = "t",
		mods = "ALT",
		action = wezterm.action.SpawnCommandInNewWindow,
	},
}

-- Rest of your existing configuration
config.enable_scroll_bar = false
config.scrollback_lines = 10000
config.colors = {
	scrollbar_thumb = "#666666",
	background = "#000000",
	cursor_bg = "#c0caf5",
	cursor_border = "#c0caf5",
	cursor_fg = "#1a1b26",
	selection_bg = "rgba(128, 128, 128, 0.3)",
	selection_fg = "none",
}

config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 20,
}

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.window_close_confirmation = "NeverPrompt"

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500
config.animation_fps = 60

return config
