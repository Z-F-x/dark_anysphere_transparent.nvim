print(vim.o.lines)

-- Example configuration for dark_anysphere_transparent.nvim
-- This should be added to your Neovim config (e.g., in init.lua or a separate file)

-- Using lazy.nvim
return {
  "username/dark_anysphere_transparent.nvim",
  lazy = false,
  priority = 1000,  -- Load the colorscheme before other plugins
  config = function()
    require("dark_anysphere_transparent").setup({
      -- The transparent_background option is always true in this theme
      -- and cannot be overridden
      
      -- Other options
      cursorline = true,       -- Enable cursorline highlighting
      undercurl = true,        -- Enable undercurls for diagnostics
      italic_keyword = true,   -- Enable italics for keywords
      nvim_tree_darker = true, -- Use darker background for NvimTree
    })
    
    -- Set the colorscheme
    vim.cmd("colorscheme dark_anysphere_transparent")
    
    -- Optional: You can still apply additional transparency settings
    -- if needed, although the theme already handles this
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  end,
}

-- Alternative configuration with packer.nvim:
--[[
use {
  'username/dark_anysphere_transparent.nvim',
  config = function()
    require('dark_anysphere_transparent').setup({
      cursorline = true,
      undercurl = true,
      italic_keyword = true,
      nvim_tree_darker = true,
    })
    vim.cmd('colorscheme dark_anysphere_transparent')
  end
}
--]]
