return {
    {                -- Autocompletion
        'hrsh7th/nvim-cmp',
        version = false, -- last release is way too old
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            "hrsh7th/cmp-buffer",
            'hrsh7th/cmp-path',
        },
        opts = function()
            local cmp = require 'cmp'
            local defaults = require("cmp.config.default")()
            local auto_select = true
            return {
                completion = {
                    completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
                },
                preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
                mapping = cmp.mapping.preset.insert {
                    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ['<Up>'] = cmp.mapping.scroll_docs(-4),
                    ['<Down>'] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm { select = true },
                },
                sources = cmp.config.sources({
                    {
                        name = 'lazydev',
                        -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
                        group_index = 0,
                    },
                    { name = "nvim_lsp" },
                    { name = "path" },
                }, {
                    { name = "buffer" },
                }),
                formatting = {
                    format = function(entry, item)
                        local icons = require("config.init").icons.kinds
                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. item.kind
                        end

                        local widths = {
                            abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
                            menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
                        }

                        for key, width in pairs(widths) do
                            if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
                            end
                        end

                        return item
                    end,
                },
                sorting = defaults.sorting,
            }
        end,
    },
}
