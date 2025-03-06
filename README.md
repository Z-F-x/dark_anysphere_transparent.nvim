# Please see [gmr458] (https://github.com/gmr458/vscode_modern_theme.nvim) for original repo! 

## Also you need to run this in nvim with lazyvim + in a terminal emulator that is set to transparent, transluscent and blur. Screnshots are taken while running config in konsole.



# Installation

[lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
  {
    "Z-F-x/dark_anyshpere_transparent.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    lazy = false,
    priority = 1000,
    config = function()
      require("dark_anysphere_transparent").setup({
        cursorline = true,
        transparent_background = true,
        nvim_tree_darker = true,
      })
      vim.cmd([[colorscheme vscode_modern]])

      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
      vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
    end,
  },

```
