vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", { clear = true }),
    callback = function(args)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
                vim.lsp.buf.format { async = false, id = args.data.client_id }
            end,
        })
    end
})

vim.api.nvim_create_augroup("UmlautMappings", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
    group = "UmlautMappings",
    callback = function()
        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }
        map("i", "<C-A>", "ä", opts)
        map("i", "<C-O>", "ö", opts)
        map("i", "<C-U>", "ü", opts)
    end,
})
