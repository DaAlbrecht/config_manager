vim.o.laststatus = vim.g.lualine_laststatus
-- This disables showing of the blame text next to the cursor
vim.g.gitblame_display_virtual_text = 0

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename',
            {
                function() return require("gitblame").get_current_blame_text() end,
                cond = function()
                    return package.loaded["gitblame"] and
                        require("gitblame").is_blame_text_available()
                end,
            },
        },
        lualine_x = {
            {
                "diff",
                symbols = {
                    added = diagnostics_config.icons.git.added,
                    modified = diagnostics_config.icons.git.modified,
                    removed = diagnostics_config.icons.git.removed,
                },
            },
            'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = { 'fugitive', 'fzf', 'oil', 'mason' }
})
