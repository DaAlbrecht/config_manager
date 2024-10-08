-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'


    use "rebelot/kanagawa.nvim"
    use { "ellisonleao/gruvbox.nvim" }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })
    use {
        "ray-x/lsp_signature.nvim",
    }

    use("theprimeagen/harpoon")
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use("f-person/git-blame.nvim")
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    )
    use("nvim-treesitter/nvim-treesitter-context")
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
    use("github/copilot.vim")
    use('mfussenegger/nvim-dap')
    -- Java
    use { "mfussenegger/nvim-jdtls", ft = { "java" } }

    --typst
    use { 'kaarmu/typst.vim', ft = { 'typst' } }
    use {
        'chomosuke/typst-preview.nvim',
        tag = 'v0.3.*',
        run = function() require 'typst-preview'.update() end,
    }

    use 'nvim-tree/nvim-web-devicons'
    use 'onsails/lspkind-nvim'
    use({
        "stevearc/oil.nvim",
    })
    use 'Civitasv/cmake-tools.nvim'
    -- install without yarn or npm
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
end)
