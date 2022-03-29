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
  use  'haringsrob/nvim_context_vt'

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

  -- use {
  --   'anuvyklack/pretty-fold.nvim',
  --   config = function()
  --     require('pretty-fold').setup{}
  --     require('pretty-fold.preview').setup()
  --   end
  -- }

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
  -- use {
  --   'kyazdani42/nvim-tree.lua',
  --   requires = {
  --     'kyazdani42/nvim-web-devicons', -- optional, for file icon
  --   },
  --   config = function() require'nvim-tree'.setup {} end
  -- }

use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = { 
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim" 
    },
    config = function ()
      -- Unless you are still migrating, remove the deprecated commands from v1.x
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define("DiagnosticSignError",
        {text = " ", texthl = "DiagnosticSignError"})
      vim.fn.sign_define("DiagnosticSignWarn",
        {text = " ", texthl = "DiagnosticSignWarn"})
      vim.fn.sign_define("DiagnosticSignInfo",
        {text = " ", texthl = "DiagnosticSignInfo"})
      vim.fn.sign_define("DiagnosticSignHint",
        {text = "", texthl = "DiagnosticSignHint"})
      -- NOTE: this is changed from v1.x, which used the old style of highlight groups
      -- in the form "LspDiagnosticsSignWarning"

      require("neo-tree").setup({
        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        default_component_configs = {
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "ﰊ",
            default = "*",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
          },
          git_status = {
            symbols = {
              -- Change type
              added     = "✚",
              deleted   = "✖",
              modified  = "",
              renamed   = "",
              -- Status type
              untracked = "",
              ignored   = "",
              unstaged  = "",
              staged    = "",
              conflict  = "",
            }
          },
        },
        window = {
          position = "left",
          width = 40,
          mappings = {
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["C"] = "close_node",
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["H"] = "toggle_hidden",
            ["R"] = "refresh",
            ["/"] = "fuzzy_finder",
            ["f"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
            ["a"] = "add",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination
            ["m"] = "move", -- takes text input for destination
            ["q"] = "close_window",
          }
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_by_name = {
              ".DS_Store",
              "thumbs.db"
              --"node_modules"
            },
            never_show = { -- remains hidden even if visible is toggled to true
              --".DS_Store",
              --"thumbs.db"
            },
          },
          follow_current_file = true, -- This will find and focus the file in the active buffer every
                                       -- time the current file is changed while the tree is open.
          hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                                  -- in whatever position is specified in window.position
                                -- "open_current",  -- netrw disabled, opening a directory opens within the
                                                  -- window like netrw would, regardless of window.position
                                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                                          -- instead of relying on nvim autocmd events.
        },
        buffers = {
          show_unloaded = true,
          window = {
            mappings = {
              ["bd"] = "buffer_delete",
            }
          },
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["A"]  = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
            }
          }
        }
      })
      vim.cmd([[nnoremap <c-n> :Neotree toggle<cr>]])
    end
}

    use 'tmhedberg/SimpylFold'

    use 'preservim/vim-markdown'

    use 'chrisbra/csv.vim'

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
  -- rainbow = {
    -- enable = true,
    -- disable = {},
    -- extended_mode = true,
    -- max_file_lines= nil,
    -- colors = {},
    -- termcolors = {},
  -- },
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
                path = runtime_path,
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
-- vim.cmd[[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

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


