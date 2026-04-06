require("squishy")

vim.pack.add({
    "https://github.com/stevearc/oil.nvim.git",
    "https://github.com/nvim-tree/nvim-web-devicons.git",
    "https://github.com/rebelot/kanagawa.nvim.git",
    "https://github.com/tpope/vim-fugitive.git",
    {
        src = "https://github.com/mrcjkb/rustaceanvim",
        version = vim.version.range("^9"),
    },
    -- read .vscode/settings.json file
    "https://github.com/mrjones2014/codesettings.nvim.git",
    -- LSP
    { src = "https://github.com/neovim/nvim-lspconfig" },
    "https://github.com/mason-org/mason.nvim.git",
    "https://github.com/mason-org/mason-lspconfig.nvim.git",
    -- completion
    { src = "https://github.com/saghen/blink.cmp.git", version = vim.version.range("^1") },
    --
    "https://github.com/ibhagwan/fzf-lua.git",
})
