-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux

local opacity_levels = { 1.0, 0.7 }
local current_opacity_index = 1

wezterm.on("toggle-opacity", function(window, pane)
    current_opacity_index = 3 - current_opacity_index -- Toggle between 1 and 2
    window:set_config_overrides({
        window_background_opacity = opacity_levels[current_opacity_index],
    })
end)

-- This table will hold the configuration.
local config = {
}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end


-- This is where you actually apply your config choices
config.font = wezterm.font_with_fallback {
    'Berkeley Mono',
    'CaskaydiaCove Nerd Font',
}

config.font_size = 12.0
config.window_background_opacity = 1

-- For example, changing the color scheme:
config.color_scheme = 'Kanagawa (Gogh)'
--config.color_scheme = 'Gruvbox Light'

config.enable_scroll_bar = false
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

-- config.tab_bar_at_bottom = true
-- try at the top, could use the dead space of the notch

--keybindings
if wezterm.target_triple == 'aarch64-apple-darwin' then
    -- start wezterm in fullscreen for macos
    wezterm.on("gui-startup", function()
        local tab, pane, window = mux.spawn_window(cmd or {})
        window:gui_window():toggle_fullscreen()
    end)

    config.keys = {
        -- Split Panes
        {
            key = "d",
            mods = "CMD",
            action = wezterm.action { SplitHorizontal = {
                domain = "CurrentPaneDomain" } }
        },
        {
            key = "d",
            mods = "CMD|SHIFT",
            action = wezterm.action { SplitVertical = {
                domain = "CurrentPaneDomain" } }
        },

        -- Pane Navigation
        { key = "h",          mods = "CMD",       action = wezterm.action { ActivatePaneDirection = "Prev" } },
        { key = "j",          mods = "CMD",       action = wezterm.action { ActivatePaneDirection = "Down" } },
        { key = "k",          mods = "CMD",       action = wezterm.action { ActivatePaneDirection = "Up" } },
        { key = "l",          mods = "CMD",       action = wezterm.action { ActivatePaneDirection = "Next" } },

        -- Resize Panes
        { key = "h",          mods = "CMD|SHIFT", action = wezterm.action { AdjustPaneSize = { "Left", 5 } } },
        { key = "j",          mods = "CMD|SHIFT", action = wezterm.action { AdjustPaneSize = { "Down", 5 } } },
        { key = "k",          mods = "CMD|SHIFT", action = wezterm.action { AdjustPaneSize = { "Up", 5 } } },
        { key = "l",          mods = "CMD|SHIFT", action = wezterm.action { AdjustPaneSize = { "Right", 5 } } },

        -- Close Pane
        { key = "w",          mods = "CMD",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },

        -- Copy Mode
        { key = "v",          mods = "CMD|SHIFT", action = wezterm.action.ActivateCopyMode },

        --jump words
        { key = "LeftArrow",  mods = "OPT",       action = wezterm.action { SendString = "\x1bb" } },
        -- Make Option-Right equivalent to Alt-f; forward-word
        { key = "RightArrow", mods = "OPT",       action = wezterm.action { SendString = "\x1bf" } },
        {
            key = "Enter", -- Change this to your preferred key
            mods = "CMD",  -- Change this to your preferred modifier
            action = wezterm.action.EmitEvent("toggle-opacity"),
        },
    }
else
    config.keys = {
        -- Split Panes
        {
            key = "d",
            mods = "ALT|SHIFT|CTRL",
            action = wezterm.action { SplitHorizontal = {
                domain = "CurrentPaneDomain" } }
        },
        {
            key = "d",
            mods = "CMD|SHIFT",
            action = wezterm.action { SplitVertical = {
                domain = "CurrentPaneDomain" } }
        },

        -- new tab
        { key = "t",          mods = "ALT|SHIFT|CTRL",                 action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },

        -- Pane Navigation
        { key = "h",          mods = "ALT|SHIFT|CTRL",                 action = wezterm.action { ActivatePaneDirection = "Prev" } },
        { key = "j",          mods = "ALT|SHIFT|CTRL",                 action = wezterm.action { ActivatePaneDirection = "Down" } },
        { key = "k",          mods = "ALT|SHIFT|CTRL",                 action = wezterm.action { ActivatePaneDirection = "Up" } },
        { key = "l",          mods = "ALT|SHIFT|CTRL",                 action = wezterm.action { ActivatePaneDirection = "Next" } },

        -- Resize Panes
        { key = "h",          mods = "ALT|SHIFT",                      action = wezterm.action { AdjustPaneSize = { "Left", 5 } } },
        { key = "j",          mods = "ALT|SHIFT",                      action = wezterm.action { AdjustPaneSize = { "Down", 5 } } },
        { key = "k",          mods = "ALT|SHIFT",                      action = wezterm.action { AdjustPaneSize = { "Up", 5 } } },
        { key = "l",          mods = "ALT|SHIFT",                      action = wezterm.action { AdjustPaneSize = { "Right", 5 } } },

        -- Close Pane
        { key = "w",          mods = "ALT|SHIFT|CTRL",                 action = wezterm.action { CloseCurrentPane = { confirm = true } } },

        -- Copy Mode
        { key = "v",          mods = "ALT|SHIFT|CTRL",                 action = wezterm.action.ActivateCopyMode },

        -- Paste
        { key = "]",          mods = "ALT|SHIFT|CTRL",                 action = wezterm.action { PasteFrom = "Clipboard" } },

        --jump words
        { key = "LeftArrow",  mods = "OPT",                            action = wezterm.action { SendString = "\x1bb" } },
        -- Make Option-Right equivalent to Alt-f; forward-word
        { key = "RightArrow", mods = "OPT",                            action = wezterm.action { SendString = "\x1bf" } },

        { key = "F9",         action = wezterm.action.ShowTabNavigator },

    }
end

-- and finally, return the configuration to wezterm
return config
