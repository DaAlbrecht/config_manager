local git_blame = require('gitblame')

local function harpoon_component()
    local mark_idx = require("harpoon.mark").get_current_index()
    if mark_idx == nil then
        return ""
    end

    return string.format("󱡅 %d", mark_idx)
end


-- This disables showing of the blame text next to the cursor
vim.g.gitblame_display_virtual_text = 0
require('lualine').setup {
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
        lualine_b = { 'branch', 'diff', 'diagnostics', { harpoon_component } },
        lualine_c = { 'filename', { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available } },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
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
    extensions = {}
}
