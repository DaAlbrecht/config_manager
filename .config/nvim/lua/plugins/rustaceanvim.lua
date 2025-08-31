return {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false,   -- This plugin is already lazy
    dependencies = {
        {
            'Joakker/lua-json5',
            build = './install.sh',
            config = function()
                -- Support JSON5 syntax in .vscode/settings.json
                ---@diagnostic disable-next-line: duplicate-set-field
                vim.json.decode = function(str, _) return require('json5').parse(str) end
            end,
        },
    },
    config = function()
        vim.g.rustaceanvim = {
            server = {
                on_attach = function(client, bufnr)
                    -- you can also put keymaps in here
                end,
                default_settings = {
                    -- rust-analyzer language server configuration
                    ['rust-analyzer'] = {
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
            tools = {
            },
        }
    end,
}
