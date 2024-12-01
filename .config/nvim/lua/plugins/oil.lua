-- https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/oil.lua
CustomOilBar = function()
    local path = vim.fn.expand "%"
    path = path:gsub("oil://", "")

    return "  " .. vim.fn.fnamemodify(path, ":.")
end

return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        win_options = {
            winbar = "%{v:lua.CustomOilBar()}",
        },
        view_options = {
            show_hidden = true,
            is_always_hidden = function(name, _)
                local folder_skip = { ".DS_Store", ".vscode", ".github", ".cargo" }
                return vim.tbl_contains(folder_skip, name)
            end,
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
