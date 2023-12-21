local lsp = require("lsp-zero")

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

local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})


cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", '<leader>rn', vim.lsp.buf.rename, opts)

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", 'gr', require('telescope.builtin').lsp_references, opts)

    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("i", "C-q", function() vim.lsp.buf.signature_help() end, opts)

    vim.keymap.set("n", '<leader>ds', require('telescope.builtin').lsp_document_symbols, opts)
    vim.keymap.set("n", '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, opts)
end)

require('lspconfig').typst_lsp.setup {
    settings = {
        exportPdf = "never" -- Choose onType, onSave or never.
        -- serverPath = "" -- Normally, there is no need to uncomment it.
    }
}

require("lspconfig").clangd.setup {
    on_attach = on_attach,
    capabilities = cmp,
    cmd = {
        "clangd",
        "--offset-encoding=utf-16",
    },
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


Wso2lsp = function()
    vim.lsp.start({
        name = 'apache-synapse-lsp',
        cmd = { "synapse-analyzer" },
        root_dir = vim.loop.cwd(),
        detached = false,
        filetypes = { "foo" },
        on_attach = function(client, bufnr)
            print('apache-synapse-lsp server is running on buffer ' .. bufnr)
        end,
        autostart = true
    })
    vim.lsp.set_log_level 'debug'
    if vim.fn.has 'nvim-0.5.1' == 1 then
        require('vim.lsp.log').set_format_func(vim.inspect)
    end
end
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*apache.foo",
    callback = function(_)
        vim.b.filetype = "foo"
        Wso2lsp()
    end
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
    end,
})
