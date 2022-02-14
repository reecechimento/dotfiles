vim.cmd[[nnoremap <leader>ev :vs ~/.config/nvim/init.lua<CR>]]
vim.cmd[[nnoremap <leader>sv :PackerSync<CR>]]

vim.cmd[[nnoremap [h :nohl<CR>]]

vim.cmd[[nnoremap gc I-- <ESC>]]

-- Using La functions
vim.cmd[[nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>]]
vim.cmd[[nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>]]
vim.cmd[[nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>]]
vim.cmd[[nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>]]
