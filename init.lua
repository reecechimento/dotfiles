require 'settings'
require 'keybinds'

local use = require'packer'.use
require'packer'.startup(function()
    use { 'wbthomason/packer.nvim' } -- Package manager
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'nvim-lua/plenary.nvim' }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'neovim/nvim-lspconfig' } -- Collection of configurations for the built-in LSP client

    use { 'ms-jpq/coq_nvim', branch = 'coq' }
    use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
    use { 'ms-jpq/coq.thirdparty', branch = '3p' }

    -- use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
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
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            { 'kyazdani42/nvim-web-devicons', opt = true },
        }
    }
    use { 'chentau/marks.nvim' }
    use { 'norcalli/nvim-colorizer.lua' }

    use {
        'folke/todo-comments.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
        },
        config = function()
            require'todo-comments'.setup {
                signs = true, -- show icons in the signs column
                sign_priority = 8, -- sign priority
                -- keywords recognized as todo comments
                keywords = {
                    FIX = {
                        icon = " ", -- icon used for the sign, and in search results
                        color = "error", -- can be a hex color, or a named color (see below)
                        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                        -- signs = false, -- configure signs for some keywords individually
                    },
                    TODO = { icon = " ", color = "info" },
                    HACK = { icon = " ", color = "warning" },
                    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                },
                merge_keywords = true, -- when true, custom keywords will be merged with the defaults
                -- highlighting of the line containing the todo comment
                -- * before: highlights before the keyword (typically comment characters)
                -- * keyword: highlights of the keyword
                -- * after: highlights after the keyword (todo text)
                highlight = {
                    before = "", -- "fg" or "bg" or empty
                    keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
                    after = "fg", -- "fg" or "bg" or empty
                    pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
                    comments_only = true, -- uses treesitter to match keywords in comments only
                    max_line_len = 400, -- ignore lines longer than this
                    exclude = {}, -- list of file types to exclude highlighting
                },
                -- list of named colors where we try to extract the guifg from the
                -- list of hilight groups or use the hex color if hl not found as a fallback
                colors = {
                    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                    warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
                    info = { "DiagnosticInfo", "#2563EB" },
                    hint = { "DiagnosticHint", "#10B981" },
                    default = { "Identifier", "#7C3AED" },
                },
                search = {
                    command = "rg",
                    args = {
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                    },
                    -- regex that will be used to match keywords.
                    -- don't replace the (KEYWORDS) placeholder
                    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
                    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
                },
            } 
        end
    }
end)

require'nvim-web-devicons'.setup {}

-- NOTE: 'kosayoda/nvim-lightbulb',
vim.cmd[[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

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
}

-- NOTE: COQ and LSP configuration
vim.g.coq_settings = { auto_start = 'shut-up' }

local nvim_lsp = require "lspconfig"
local coq = require "coq" -- add this

-- lsp.<server>.setup(<stuff...>)                              -- before
-- lsp.<server>.setup(coq.lsp_ensure_capabilities(<stuff...>)) -- after
nvim_lsp.pylsp.setup(coq.lsp_ensure_capabilities())

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

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pylsp', 'vimls', 'bashls' }
for _, lsp in pairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        }
    }
end


local sumneko_binary_path = vim.fn.exepath('lua-language-server')
local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ':h:h:h')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
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
}

-- Set colorscheme
require 'theme'
