vim.cmd[[set termguicolors]]

-- NOTE: :s:\v(\{|\})::g

local use = require'packer'.use
require'packer'.startup(function()

  -- II: Dependencies
  use 'wbthomason/packer.nvim'  -- Package manager
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'ryanoasis/vim-devicons'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use 'neovim/nvim-lspconfig'

  -- II: treesitter modules
  use 'p00f/nvim-ts-rainbow'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  -- use  'haringsrob/nvim_context_vt'

  -- II: autocompletion
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

  use 'machakann/vim-sandwich'
  use 'machakann/vim-highlightedyank'
  use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
  use { 'wfxr/minimap.vim', run = ':!cargo install --locked code-minimap' }

  -- Colorscheme
  use 'navarasu/onedark.nvim'   -- II: Favorite colorscheme
  use 'tiagovla/tokyodark.nvim'
  use 'yashguptaz/calvera-dark.nvim'

  use { 'nvim-lualine/lualine.nvim', requires = { { 'kyazdani42/nvim-web-devicons', opt = true }, } }
  use  'chentau/marks.nvim'
  use  'norcalli/nvim-colorizer.lua'
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

  use 'habamax/vim-asciidoctor'

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

  use 'yamatsum/nvim-cursorline'

  -- UI
  use 'stevearc/dressing.nvim'
  use {
    'rmagatti/goto-preview',
    config = function()
      require'goto-preview'.setup {}
    end
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
  }

    use 'tmhedberg/SimpylFold'

    use 'preservim/vim-markdown'

end)

require'nvim-web-devicons'.setup {}



-- II: marks setup
require'marks'.setup {}

-- II: colorizer setup
require'colorizer'.setup {}

-- II: wfxr/minimap.vim configuration
vim.g.minimap_width = 20
vim.g.minimap_auto_start = 0
vim.g.minimap_auto_start_win_enter = 0
vim.g.minimap_left = 0
vim.g.minimap_highlight_range = 1
vim.g.minimap_highlight_search = 1
vim.g.minimap_git_colors = 1

-- NOTE: telescope configuration
require'telescope'.setup {}
require'telescope'.load_extension('fzf')

-- II: treesitter configuration
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
    enable = true,
  },
}

-- II: COQ and LSP configuration
vim.g.coq_settings = { auto_start = 'shut-up' }

-- SECTION: coq.thirdparty sources
require('coq_3p') {
    { src = "nvimlua", short_name = "nLUA" },
    { src = "vimtex", short_name = "vTEX" },
    { src = "copilot", short_name = "COP", accept_key = "<c-f>" },
    {
        src = "repl",
        sh = "zsh",
        shell = { p = "perl", n = "node", ... },
        max_lines = 99,
        deadline = 500,
        unsafe = { "rm", "poweroff", "mv", ... },
    },
    -- Evaluates `...`
    -- Where <ctrl chars> can be a combination of zero or more of:
    -- # :: comment output
    -- - :: prevent indent
}

local nvim_lsp = require "lspconfig"
local coq = require "coq" -- add this

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
local servers = { 'pylsp', 'vimls', 'bashls', 'ccls', 'jsonls', 'yamlls', 'dockerls', 'html' }
for _, lsp in pairs(servers) do
  nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
  }))
end

-- II: sumneko lua
nvim_lsp.sumneko_lua.setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    cmd = {"/home/rchimento/tools/lua-language-server/bin/lua-language-server"},
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                -- path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            -- workspace = {
                -- Make the server aware of Neovim runtime files
                -- library = vim.api.nvim_get_runtime_file("", true),
                -- },
                -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}))



-- II: 'kosayoda/nvim-lightbulb'
vim.cmd[[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

require 'settings'
require 'keybinds'
require 'config.simpylfold'

-- Set colorscheme
require'theme'.onedark()

-- II: lualine setup
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
  }
}


