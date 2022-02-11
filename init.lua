-- require "plugins"
require "settings"
require 'theme' -- NOTE: this workso
require 'keybinds'

local use = require'packer'.use
require'packer'.startup(function()
    use { 'wbthomason/packer.nvim' }  -- Package manager
    use { 'neovim/nvim-lspconfig' }  -- Collection of configurations for the built-in LSP client
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-lua/plenary.nvim' }
    use { 'ms-jpq/coq_nvim',  branch = 'coq' }
    use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
    use { 'ms-jpq/coq.thirdparty', branch = '3p' }
    use { 'machakann/vim-sandwich' }
    use { 'machakann/vim-highlightedyank' }
    use { 'marko-cerovac/material.nvim' }
    use { 'folke/tokyonight.nvim' }

end)

require'lspconfig'.pylsp.setup{}
require'lspconfig'.vimls.setup{}
