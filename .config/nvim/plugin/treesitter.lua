local ensure_installed = {
    'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'json', 'rust'
}

require('nvim-treesitter').install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
    desc = "Ensure tree-sitter is started",
    group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
    callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
    end,
})
