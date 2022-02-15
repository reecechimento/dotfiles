vim.cmd[[set termguicolors]]
require 'settings'
require 'keybinds'

local use = require'packer'.use
require'packer'.startup(function()
    use { 'wbthomason/packer.nvim' } -- Package manager
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'nvim-lua/plenary.nvim' }
    use { 'neovim/nvim-lspconfig' } -- Collection of configurations for the built-in LSP client
    -- SECTION: treesitter modules
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'p00f/nvim-ts-rainbow' }
    use { 'JoosepAlviste/nvim-ts-context-commentstring' }
    use { 'haringsrob/nvim_context_vt' }
    -- SECTION: autocompletion
    use { 'ms-jpq/coq_nvim', branch = 'coq' }
    use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
    use { 'ms-jpq/coq.thirdparty', branch = '3p' }

    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            { 'kyazdani42/nvim-web-devicons' },
        }
    }

    use {
        'kosayoda/nvim-lightbulb',
        requires = { { 'neovim/nvim-lspconfig' } }
    }

    use { 'machakann/vim-sandwich' }
    use { 'machakann/vim-highlightedyank' }
    use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
    use { 'wfxr/minimap.vim', run = ':!cargo install --locked code-minimap' }
    use { 'navarasu/onedark.nvim' }  -- NOTE: Favorite colorscheme
    use { 'nvim-lualine/lualine.nvim', requires = { { 'kyazdani42/nvim-web-devicons', opt = true }, } }
    use { 'chentau/marks.nvim' }
    use { 'norcalli/nvim-colorizer.lua' }
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require 'config.gitsigns'
        end
    }
    use {
        'folke/todo-comments.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            require 'config.todo-comments'
        end
    }

    use {
        'romgrk/nvim-treesitter-context',
        config = function()
            require 'config.treesitter-context'
        end
    }

    use {
        'windwp/nvim-autopairs',
        config = function()
            require 'config.autopairs'
        end
    }

    use { 'habamax/vim-asciidoctor' }

    use { 
        'anuvyklack/pretty-fold.nvim',
        config = function()
            require('pretty-fold').setup{}
            require('pretty-fold.preview').setup()
        end
    }

    use {
        'nacro90/numb.nvim',
        config = function()
            require('numb').setup {
                show_numbers = true,
                show_cursorline = true,
                number_only = false
            }
        end
    } 

    use { 'yamatsum/nvim-cursorline' }
end)

require'nvim-web-devicons'.setup {}


-- NOTE: lualine setup
require'lualine'.setup {
    options = {
        icons_enabled = true,
        theme = 'onedark',
    }
}

-- NOTE: marks setup
require'marks'.setup {}

-- NOTE: colorizer setup
require'colorizer'.setup {}

-- NOTE: wfxr/minimap.vim configuration
vim.g.minimap_width = 10
vim.g.minimap_auto_start = 1
vim.g.minimap_auto_start_win_enter = 1
vim.g.minimap_left = 0
vim.g.minimap_highlight_range = 1
vim.g.minimap_highlight_search = 1
vim.g.minimap_git_colors = 1

-- NOTE: telescope configuration
require'telescope'.setup {}
require'telescope'.load_extension('fzf')

-- NOTE: treesitter configuration
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
        disable = { "rust" },
    },
    indent = {
        enable = false
    },
    rainbow = {
        enable = true,
        -- disable = {},
        extended_mode = true,
        max_file_lines= nil,
        -- colors = {},
        -- termcolors = {},
    },
    context_commentstring = {
        enable = true
    }
}

-- NOTE: COQ and LSP configuration
vim.g.coq_settings = { auto_start = 'shut-up' }

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local nvim_lsp = require "lspconfig"
local coq = require "coq" -- add this

-- lsp.<server>.setup(<stuff...>)                              -- before
-- lsp.<server>.setup(coq.lsp_ensure_capabilities(<stuff...>)) -- after
-- nvim_lsp.pylsp.setup(coq.lsp_ensure_capabilities())

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pylsp', 'vimls', 'bashls' }
for _, lsp in pairs(servers) do
    nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities({
        on_attach = on_attach,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        }
    }))
end


local sumneko_binary_path = vim.fn.exepath('lua-language-server')
local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ':h:h:h')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- SECTION: sumneko lua
nvim_lsp.sumneko_lua.setup(coq.lsp_ensure_capabilities({
    cmd = {sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}))


-- Set colorscheme
require 'theme'

-- NOTE: 'kosayoda/nvim-lightbulb',
vim.cmd[[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
