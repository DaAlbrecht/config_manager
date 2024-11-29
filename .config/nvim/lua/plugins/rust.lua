return {
    {
        'saecki/crates.nvim',
        event = { "BufRead Cargo.toml" },
        opts = {
            popup = {
                border = "rounded",
            },
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        },
        config = function(_, opts)
            local crates = require("crates")
            vim.keymap.set("n", "<leader>cf", crates.show_features_popup)
            vim.keymap.set("n", "<leader>cv", crates.show_versions_popup)
            crates.setup(opts)
        end,
    },
}
