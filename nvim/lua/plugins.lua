vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
    use { "catppuccin/nvim", as = "catppuccin" }
    use {'Vigemus/iron.nvim'}
    use 'wbthomason/packer.nvim'
    use 'simrat39/rust-tools.nvim'
    -- Debugging
    use 'nvim-lua/plenary.nvim'
    use 'mfussenegger/nvim-dap'
    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }
    use 'nvim-tree/nvim-web-devicons'
end)
