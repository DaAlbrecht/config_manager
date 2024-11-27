-- Thanks to: https://github.com/tjdevries/config.nvim/tree/master
return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

        "nvim-telescope/telescope-smart-history.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "kkharji/sqlite.lua",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local data = assert(vim.fn.stdpath "data") --[[@as string]]
        require("telescope").setup {
            defaults = {
                --file_ignore_patterns = { "dune.lock" },
            },
            extensions = {
                wrap_results = true,

                fzf = {},
                history = {
                    path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
                    limit = 100,
                },
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {},
                },
            },
        }
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "smart_history")
        pcall(require("telescope").load_extension, "ui-select")

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = '[P]ick [F]ile' })
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = '[P]ick [B]uffer' })
        vim.keymap.set('n', '<leader>ph', function()
            require('telescope.builtin').find_files({
                hidden = true,
            })
        end, { desc = '[P]ick [H]idden' })

        vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
    end,
}
