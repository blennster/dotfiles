local wezterm = require 'wezterm';

return {
  -- Environment
  term = "xterm-256color",

  -- color_scheme = "Tomorrow Night Bright (Gogh)",
  color_scheme = 'Tomorrow (dark) (terminal.sexy)',

  -- Window settings
  window_background_opacity = 1.0,
  window_decorations = "RESIZE",
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  automatically_reload_config = true,
  freetype_load_target = "Light",
  front_end = 'WebGpu',
  window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
  },

  -- Keybindings
  keys = {
    {
      key = 'r',
      mods = 'CMD|SHIFT',
      action = wezterm.action.ReloadConfiguration,
    },
    {
      key = 'O',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.QuickSelectArgs {
        label = 'open url',
        patterns = {
          'https?://\\S+',
        },
        -- skip_action_on_paste = true,
        action = wezterm.action_callback(function(window, pane)
          local url = window:get_selection_text_for_pane(pane)
          wezterm.log_info('opening: ' .. url)
          wezterm.open_with(url)
        end),
      },
    }
  },

  -- Font settings
  font = wezterm.font("IosevkaTerm Nerd Font"),
  font_size = 14,

  -- Option as Alt (macOS specific, assuming you need "OnlyLeft" as left ALT):
  -- keys = {
  --   { key = 'Left', mods = 'OPT', action = wezterm.action.SendKey { key = 'Alt' } },
  -- },

  -- Padding (assuming dynamic padding means adjusting it based on window size):
  adjust_window_size_when_changing_font_size = true,

}
