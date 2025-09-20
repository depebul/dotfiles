local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

local is_darwin = wezterm.target_triple:match('darwin') ~= nil

-- Theme (Tokyo Night built-in)
config.color_scheme = 'Tokyo Night'

-- Font setup with broader fallbacks
config.font = wezterm.font_with_fallback {
  'Menlo',
  'Meslo LG S for Powerline',
  'Menlo Nerd Font',
  'JetBrainsMono Nerd Font',
  'FiraCode Nerd Font',
}
config.font_size = 13.0

config.initial_cols = 127
config.initial_rows = 45

-- Transparency everywhere, blur when available
config.window_background_opacity = 0.9
if is_darwin then
  config.macos_window_background_blur = 40
end

-- Padding
config.window_padding = {
  left = 10,
  right = 10,
  top = 0,
  bottom = 10,
}

-- Shared keybindings
config.keys = {
  { key = 'LeftArrow', mods = 'OPT', action = wezterm.action.SendString '\x1bb' },
  { key = 'LeftArrow', mods = 'ALT', action = wezterm.action.SendString '\x1bb' },
  { key = 'RightArrow', mods = 'OPT', action = wezterm.action.SendString '\x1bf' },
  { key = 'RightArrow', mods = 'ALT', action = wezterm.action.SendString '\x1bf' },
}

local function add_platform_keys(mod)
  table.insert(config.keys, { key = 'LeftArrow', mods = mod, action = wezterm.action.SendString '\x01' })
  table.insert(config.keys, { key = 'RightArrow', mods = mod, action = wezterm.action.SendString '\x05' })
  table.insert(config.keys, { key = 'Backspace', mods = mod, action = wezterm.action.SendString '\x15' })
  table.insert(config.keys, { key = 'UpArrow', mods = mod, action = wezterm.action.SendString '\x10' })
  table.insert(config.keys, { key = 'DownArrow', mods = mod, action = wezterm.action.SendString '\x0e' })
end

if is_darwin then
  add_platform_keys('CMD')
else
  add_platform_keys('SUPER')
end

return config
