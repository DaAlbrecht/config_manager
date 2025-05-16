return {
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = 'luvit-meta/library', words = { 'vim%.uv' } },
            },
        },
    },
    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim',    event = "VeryLazy", opts = {} },
    { 'Bilal2453/luvit-meta', lazy = true },
    {
        -- Main LSP Configuration
        'neovim/nvim-lspconfig',
        events = { "BufReadPost", "BufNewFile", "BufWritePre" },
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            { 'mason-org/mason.nvim',           config = true }, -- NOTE: Must be loaded before dependants
            'mason-org/mason-lspconfig.nvim',
            { 'mason-org/mason-lspconfig.nvim', opts = {} },
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            { "folke/neoconf.nvim" },
        },
        config = function()
            require("neoconf").setup({
                rust_analyzer = {}
            })
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    map('K', vim.lsp.buf.hover, 'Show [H]over')
                    map('gl', vim.diagnostic.open_float, 'Show [L]ine diagnostics')
                    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
                    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
                    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
                    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
                    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                    map('[d', vim.diagnostic.goto_next, 'Go to next diagnostic')
                    map(']d', vim.diagnostic.goto_prev, 'Go to previous diagnostic')
                    map('C-q', vim.lsp.buf.signature_help, 'Show signature help', 'i')


                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    -- The following code creates a keymap to toggle inlay hints in your
                    -- code, if the language server you are using supports them
                    --
                    -- This may be unwanted, since they displace some of your code
                    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                        map('<leader>th', function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                        end, '[T]oggle Inlay [H]ints')
                    end
                end,
            })

            if vim.g.have_nerd_font then
                local icons = require("config.init").icons
                local diagnostic_signs = {}
                for type, icon in pairs(icons) do
                    diagnostic_signs[vim.diagnostic.severity[type]] = icon
                end
                vim.diagnostic.config { signs = { text = diagnostic_signs } }
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

            -- Enable the following language servers
            --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = 'Replace',
                            },
                        },
                    },
                },
                bashls = {},
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            -- used for bevy_lint development until neoconf supports the new lsp settings
                            rustc = {
                                source = "discover"
                            },
                            workspace = {
                                symbol = {
                                    search = {
                                        scope = "workspace_and_dependencies"
                                    }
                                }
                            },
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
            }
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                'stylua', -- Used to format Lua code
            })
            require('mason-tool-installer').setup { ensure_installed = ensure_installed }
            for server_name, config in pairs(servers) do
                vim.lsp.config(server_name, config)
            end
        end,
    }
}
