vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
    use {'Vigemus/iron.nvim'}
    use 'wbthomason/packer.nvim'
    use 'simrat39/rust-tools.nvim'
    -- Debugging
    use 'nvim-lua/plenary.nvim'
    use 'mfussenegger/nvim-dap'
end)
