-- require "plugins"
require "settings"


vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.updatetime = 1000
vim.opt.matchtime = 1000

local use = require'packer'.use
require'packer'.startup(function()
use 'wbthomason/packer.nvim'  -- Package manager
use 'neovim/nvim-lspconfig'  -- Collection of configurations for the built-in LSP client
use { 'ms-jpq/coq_nvim',  branch = 'coq' }
use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
use { 'ms-jpq/coq.thirdparty', branch = '3p' }
use 'machakann/vim-sandwich'
use 'machakann/vim-highlightedyank'
end)


require'lspconfig'.pylsp.setup{}
--    cmd = { "pylsp" },
--    filetypes = { "python" },
--    root_dir = function(fname)
--        local root_files = {
--            'pyproject.toml',
--            'setup.py',
--            'setup.cfg',
--            'requirements.txt',
--            'Pipfile',
--        },
--        return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
--    end,
--    single_file_support = true



vim.cmd[[nnoremap <leader>ev :vs ~/.config/nvim/init.lua<CR>]]
vim.cmd[[nnoremap [h :nohl<CR>]]
vim.cmd[[set hlsearch]]
vim.cmd[[set incsearch]]
vim.cmd[[set tabstop=4]]
vim.cmd[[set shiftwidth=4]]
vim.cmd[[set expandtab]]


