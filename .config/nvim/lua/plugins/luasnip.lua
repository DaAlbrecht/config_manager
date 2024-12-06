return {
    -- add luasnip
    {
        "L3MON4D3/LuaSnip",
        lazy = true,
        build = "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
            or nil,
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
    },
    -- nvim-cmp integration
    {
        "nvim-cmp",
        optional = true,
        dependencies = { "saadparwaiz1/cmp_luasnip" },
        opts = function(_, opts)
            opts.snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            }
            table.insert(opts.sources, { name = "luasnip" })
        end,
        -- stylua: ignore
        keys = {
            { "<C-l>", function() require("luasnip").jump(1) end,  mode = { "i", "s" } },
            { "<C-h>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
    },
}
