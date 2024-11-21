local lsp = require("lsp-zero")

require("neoconf").setup({
    -- override any of the default settings here
})


lsp.preset("recommended")

lsp.nvim_workspace()

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = " ",
        warn = " ",
        hint = " ",
        info = " ",
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local luasnip = require 'luasnip'
luasnip.config.setup {}

local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Up>'] = cmp.mapping.scroll_docs(-4),
    ['<Down>'] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ['<C-l>'] = cmp.mapping(function()
        if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
        end
    end, { 'i', 's' }),
    ['<C-h>'] = cmp.mapping(function()
        if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
        end
    end, { 'i', 's' }),
})


cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})


vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local opts = { buffer = args.buf, remap = false }
        vim.keymap.set("n", '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", '<leader>rn', vim.lsp.buf.rename, opts)

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", 'gr', require('telescope.builtin').lsp_references, opts)

        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("i", "C-q", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.formatting() end, opts)

        vim.keymap.set("n", '<leader>ds', require('telescope.builtin').lsp_document_symbols, opts)
        vim.keymap.set("n", '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, opts)
    end,
})

require('lspconfig').typst_lsp.setup {
    settings = {
        exportPdf = "never", -- Choose onType, onSave or never.
        experimentalFormatterMode = "on",
    }
}


lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

local lspkind = require('lspkind')

cmp.setup({
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',  -- show only symbol annotations
            maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            menu = {},
        })
    }
})
