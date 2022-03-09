-- Theme style

-- colorscheme nvcode
-- vim.g.nvcode_termcolors=256
-- vim.o.syntax = 'on'
-- vim.cmd[[colorscheme nvcode]]

local M = {}

M.onedark = function()
    vim.o.syntax = 'on'
    -- Lua
    require('onedark').setup  {
        -- Main options --
        style = 'warmer', -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = false,  -- Show/hide background
        term_colors = true, -- Change terminal color as per the selected theme style
        ending_tildes = true, -- Show the end-of-buffer tildes. By default they are hidden
        -- toggle theme style ---
        toggle_style_key = '<leader>ts', -- Default keybinding to toggle
        toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'}, -- List of styles to toggle between

        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
        code_style = {
            comments = 'italic',
            keywords = 'bold',
            functions = 'italic,bold',
            strings = 'none',
            variables = 'italic'
        },

        -- Custom Highlights --
        -- colors = {}, -- Override default colors
        -- highlights = {}, -- Override highlight groups

        -- Plugins Config --
        diagnostics = {
            darker = true, -- darker colors for diagnostic
            undercurl = false,   -- use undercurl instead of underline for diagnostics
            background = true,    -- use background color for virtual text
        },
    }
    require('onedark').load()
end

M.tokyodark = function()
    -- tokyodark
    vim.g.tokyodark_transparent_background = false
    vim.g.tokyodark_enable_italic_comment = true
    vim.g.tokyodark_enable_italic = true
    vim.g.tokyodark_color_gamma = "1.0"
    vim.cmd("colorscheme tokyodark")
end

M.calvera = function()
    -- calvera-dark
    vim.g.calvera_italic_comments = true
    vim.g.calvera_italic_keywords = true
    vim.g.calvera_italic_functions = true
    vim.g.calvera_italic_variables = false
    vim.g.calvera_contrast = true
    vim.g.calvera_borders = false
    vim.g.calvera_disable_background = false
    vim.g.transparent_bg = true
    vim.g.calvera_custom_colors = { black = "#000000", bg = "#0F111A" }
    require('calvera').set()
end

return M

