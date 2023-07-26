local lsp = require("lsp-zero")
local lspconfig = require("lspconfig")

lsp.preset("recommended")

lsp.nvim_workspace()

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


lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
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

lsp.setup()


vim.diagnostic.config({
    virtual_text = true
})
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

Wso2lsp = function()
    vim.lsp.start({
        name = 'wso2lsp',
        cmd = { "wso2-lsp" },
        root_dir = vim.fs.dirname('didi'),
        detached = false,
        filetypes = { "xml" },
        on_attach = function(client, bufnr)
            print('didi  server is running on buffer ' .. bufnr)
        end,
        autostart = true
    })
end
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.didi.xml",
    callback = function(_)
        vim.b.filetype = "xml"
        Wso2lsp()
    end
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
    end,
})
