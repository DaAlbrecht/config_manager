require("fzf-lua").setup({
    lsp = {
        code_actions = {
            previewer = "codeaction_native",
            pager = [[delta --width=$COLUMNS --hunk-header-style="omit" --file-style="omit"]],
        },
    },
})

vim.keymap.set("n", "<leader>pf", function()
    FzfLua.files()
end)

vim.keymap.set("n", "<C-p>", function()
    FzfLua.git_files()
end)

vim.keymap.set("n", "<leader>pb", function()
    FzfLua.buffers()
end, { desc = "[P]oject [B]uffers" })

vim.keymap.set("n", "<leader>sh", function()
    FzfLua.helptags()
end, { desc = "[S]earch [H]elp" })

vim.keymap.set("n", "<leader>sw", function()
    FzfLua.grep_cword()
end, { desc = "[S]earch [W]ord" })

vim.keymap.set("n", "<leader>sg", function()
    FzfLua.live_grep_native()
end, { desc = "[S]earch by [G]rep" })

vim.keymap.set("n", "<leader>sd", function()
    FzfLua.diagnostics_workspace()
end, { desc = "[S]earch by [D]iagnostics" })

vim.keymap.set("n", "<leader>sc", function()
    FzfLua.command_history()
end, { desc = "[S]earch command history" })

vim.keymap.set("n", "z=", function()
    FzfLua.spell_suggest()
end, { noremap = true, silent = true })

-- lsp fzf pickers
vim.keymap.set("n", "gd", function()
    FzfLua.lsp_definitions()
end, { desc = "[G]oto [D]efinition" })

vim.keymap.set("n", "gr", function()
    FzfLua.lsp_references()
end, { desc = "[G]oto [R]eferences" })

vim.keymap.set("n", "gI", function()
    FzfLua.lsp_implementations()
end, { desc = "[G]oto [I]mplementation" })

vim.keymap.set("n", "<leader>D", function()
    FzfLua.lsp_typedefs()
end, { desc = "Type [D]efinitions" })

vim.keymap.set("n", "<leader>ds", function()
    FzfLua.lsp_document_symbols()
end, { desc = "[D]ocument [S]ymbols" })

vim.keymap.set("n", "<leader>ws", function()
    FzfLua.lsp_workspace_symbols()
end, { desc = "[W]orkspace [S]ymbols" })

vim.keymap.set("n", "<leader>ca", function()
    FzfLua.lsp_code_actions()
end, { desc = "[C]ode [A]actions" })
