local wezterm = require 'wezterm'

return {
  -- Theme (Tokyo Night built-in)
  color_scheme = "Tokyo Night",

  -- Font setup4
  font = wezterm.font_with_fallback {
    "Menlo",
    "Menlo Nerd Font",
  },
  font_size = 13.0,

  initial_cols = 127,
  initial_rows = 45,

  -- Transparency & blur (macOS only)
  window_background_opacity = 0.9,
  macos_window_background_blur = 10,


  -- Padding
  window_padding = {
    left = 10,
    right = 10,
    top = 0,
    bottom = 10,
  },
   -- Keybindings
  keys = {
    -- Cmd+Left = Ctrl-A (beginning of line)
    { key = "LeftArrow", mods = "CMD", action = wezterm.action.SendString "\x01" },
    -- Cmd+Right = Ctrl-E (end of line)
    { key = "RightArrow", mods = "CMD", action = wezterm.action.SendString "\x05" },
    -- Cmd+Backspace = Ctrl-U (delete to start of line)
    { key = "Backspace", mods = "CMD", action = wezterm.action.SendString "\x15" },
    -- Cmd+Up = Ctrl-P (previous line in history)
    { key = "UpArrow", mods = "CMD", action = wezterm.action.SendString "\x10" },
    -- Cmd+Down = Ctrl-N (next line in history)
    { key = "DownArrow", mods = "CMD", action = wezterm.action.SendString "\x0e" },

    -- Option/Alt+Left = ESC-b (backward word)
    { key = "LeftArrow", mods = "OPT", action = wezterm.action.SendString "\x1bb" },
    -- Option/Alt+Right = ESC-f (forward word)
    { key = "RightArrow", mods = "OPT", action = wezterm.action.SendString "\x1bf" },
  },

}