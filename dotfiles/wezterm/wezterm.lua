local wezterm = require("wezterm")
local config = wezterm.config_builder()

local act = wezterm.action

local colors_light = require("lua/rose-pine-dawn").colors()
local window_frame_light = require("lua/rose-pine-dawn").window_frame()

local colors_dark = require("lua/rose-pine-moon").colors()
local window_frame_dark = require("lua/rose-pine-moon").window_frame()

local function isViProcess(pane)
	-- get_foreground_process_name On Linux, macOS and Windows,
	-- the process can be queried to determine this path. Other operating systems
	-- (notably, FreeBSD and other unix systems) are not currently supported
	return pane:get_foreground_process_name():find("n?vim") ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
	if isViProcess(pane) then
		window:perform_action(
			-- This should match the keybinds you set in Neovim.
			act.SendKey({ key = vim_direction, mods = "ALT" }),
			pane
		)
	else
		window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
	end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
	conditionalActivatePane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
	conditionalActivatePane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
	conditionalActivatePane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
	conditionalActivatePane(window, pane, "Down", "j")
end)

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function colors_for_appearance(appearance)
	if appearance:find("Dark") then
		return colors_dark
	else
		return colors_light
	end
end

local function window_frame_for_appearance(appearance)
	if appearance:find("Dark") then
		return window_frame_dark
	else
		return window_frame_light
	end
end

config.front_end = "OpenGL"
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium" })

config.adjust_window_size_when_changing_font_size = false
config.colors = colors_for_appearance(get_appearance())

-- nix flake version for some reason thinks
-- there is always an update
config.check_for_updates = false
config.window_background_opacity = 0.95
config.window_decorations = "RESIZE"
config.scrollback_lines = 9000
config.window_frame = window_frame_for_appearance(get_appearance())
config.keys = {
	{ key = "Enter", mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "Enter", mods = "CMD|CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "Enter", mods = "ALT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "Enter", mods = "SHIFT", action = wezterm.action({ SendString = "\x1b\r" }) },
	{ key = "k", mods = "SUPER", action = act.ClearScrollback("ScrollbackAndViewport") },
	{ key = "h", mods = "CTRL", action = act.EmitEvent("ActivatePaneDirection-left") },
	{ key = "j", mods = "CTRL", action = act.EmitEvent("ActivatePaneDirection-down") },
	{ key = "k", mods = "CTRL", action = act.EmitEvent("ActivatePaneDirection-up") },
	{ key = "l", mods = "CTRL", action = act.EmitEvent("ActivatePaneDirection-right") },
	{ key = "b", mods = "CTRL", action = act.RotatePanes("CounterClockwise") },
	{ key = "n", mods = "CTRL", action = act.RotatePanes("Clockwise") },
}

return config
