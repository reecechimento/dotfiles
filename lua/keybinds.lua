vim.cmd[[nnoremap <leader>ev :vs ~/.config/nvim/init.lua<CR>]]
vim.cmd[[nnoremap <leader>sv :PackerSync<CR>]]

vim.cmd[[nnoremap [h :nohl<CR>]]

vim.cmd[[nnoremap gc I-- <ESC>]]

-- Using La functions
vim.cmd[[nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>]]
vim.cmd[[nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>]]
vim.cmd[[nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>]]
vim.cmd[[nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>]]


vim.cmd[[nnoremap <C-n> :NvimTreeToggle<CR>]]
vim.cmd[[nnoremap <leader>r :NvimTreeRefresh<CR>]]
vim.cmd[[nnoremap <F5> :w \| !python3 %<CR>]]
vim.cmd[[nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>]]
vim.cmd[[nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>]]
vim.cmd[[nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>]]
-- Only set if you have telescope installed
vim.cmd[[nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>]]
