require "plugins"
require "settings"

local config = {}

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.updatetime = 1000
vim.opt.matchtime = 1000

local use = require('packer').use
require('packer').startup(function()
	use 'wbthomason/packer.nvim'  -- Package manager
	use 'neovim/nvim-lspconfig'  -- Collection of configurations for the built-in LSP client
	
	use 'machakann/vim-sandwich'
	use 'machakann/vim-highlightedyank'
end)
