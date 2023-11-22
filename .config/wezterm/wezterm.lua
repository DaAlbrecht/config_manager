-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux

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
    'Hack FC Ligatured CCG',
    'Hack Nerd Font Mono',
}

config.font_size = 12.0
config.window_background_opacity = 0.9

-- For example, changing the color scheme:
config.color_scheme = 'Kanagawa (Gogh)'

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
        { key = "[",          mods = "CMD",       action = wezterm.action { CopyTo = "Clipboard" } },

        -- Paste
        { key = "]",          mods = "CMD",       action = wezterm.action { PasteFrom = "Clipboard" } },

        --jump words
        { key = "LeftArrow",  mods = "OPT",       action = wezterm.action { SendString = "\x1bb" } },
        -- Make Option-Right equivalent to Alt-f; forward-word
        { key = "RightArrow", mods = "OPT",       action = wezterm.action { SendString = "\x1bf" } },

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
        { key = "t",          mods = "ALT|SHIFT|CTRL", action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },

        -- Pane Navigation
        { key = "h",          mods = "ALT|SHIFT|CTRL", action = wezterm.action { ActivatePaneDirection = "Prev" } },
        { key = "j",          mods = "ALT|SHIFT|CTRL", action = wezterm.action { ActivatePaneDirection = "Down" } },
        { key = "k",          mods = "ALT|SHIFT|CTRL", action = wezterm.action { ActivatePaneDirection = "Up" } },
        { key = "l",          mods = "ALT|SHIFT|CTRL", action = wezterm.action { ActivatePaneDirection = "Next" } },

        -- Resize Panes
        { key = "h",          mods = "ALT|SHIFT",      action = wezterm.action { AdjustPaneSize = { "Left", 5 } } },
        { key = "j",          mods = "ALT|SHIFT",      action = wezterm.action { AdjustPaneSize = { "Down", 5 } } },
        { key = "k",          mods = "ALT|SHIFT",      action = wezterm.action { AdjustPaneSize = { "Up", 5 } } },
        { key = "l",          mods = "ALT|SHIFT",      action = wezterm.action { AdjustPaneSize = { "Right", 5 } } },

        -- Close Pane
        { key = "w",          mods = "ALT|SHIFT|CTRL", action = wezterm.action { CloseCurrentPane = { confirm = true } } },

        -- Copy Mode
        { key = "[",          mods = "ALT|SHIFT|CTRL", action = wezterm.action { CopyTo = "Clipboard" } },

        -- Paste
        { key = "]",          mods = "ALT|SHIFT|CTRL", action = wezterm.action { PasteFrom = "Clipboard" } },

        --jump words
        { key = "LeftArrow",  mods = "OPT",            action = wezterm.action { SendString = "\x1bb" } },
        -- Make Option-Right equivalent to Alt-f; forward-word
        { key = "RightArrow", mods = "OPT",            action = wezterm.action { SendString = "\x1bf" } },

    }
end

-- and finally, return the configuration to wezterm
return config
