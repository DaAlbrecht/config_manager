vim.g.rustaceanvim = {
    server = {
        on_attach = function(client, bufnr)
            -- you can also put keymaps in here
        end,
        default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
                cargo = {
                    allFeatures = true,
                    loadOutDirsFromCheck = true,
                    buildScripts = {
                        enable = true,
                    },
                },
                check = {
                    enable = true,
                    command = "clippy",
                    extraArgs = {
                        "--",
                        "--no-deps",
                        "-Dclippy::correctness",
                        "-Dclippy::complexity",
                        "-Wclippy::perf",
                        "-Wclippy::pedantic",
                    },
                },
                procMacro = {
                    enable = true,
                    ignored = {
                        ["async-trait"] = { "async_trait" },
                        ["napi-derive"] = { "napi" },
                        ["async-recursion"] = { "async_recursion" },
                    },
                },
            },
        },
    },
    tools = {},
}

require("crates").setup {
    popup = {
        border = "rounded",
    },
}

local crates = require("crates")
vim.keymap.set("n", "<leader>cf", crates.show_features_popup)
vim.keymap.set("n", "<leader>cv", crates.show_versions_popup)
crates.setup(opts)
