# Dark Anysphere Transparent

A Neovim colorscheme based on the Anysphere VSCode theme with proper transparency support.

## Features

- Dark theme with transparency support
- Matches the Anysphere VSCode theme
- Terminal integration (Alacritty, Foot, Windows Terminal)
- Semantic highlighting support
- Italic support for keywords

## Requirements

- Neovim 0.7.0+
- Terminal with true color and transparency support

## Installation

### Using Lazy.nvim

```lua
{
  "anysphere/dark_anysphere_transparent.nvim",
  lazy = false, -- load during startup
  priority = 1000, -- load this before other plugins
  config = function()
    require("dark_anysphere_transparent").setup({
      transparent_background = true, -- Enable transparency
      italic_keyword = true,         -- Enable italic for keywords
    })
    vim.cmd([[colorscheme dark_anysphere_transparent]])
  end,
}
```

### Using Packer.nvim

```lua
use({
  "anysphere/dark_anysphere_transparent.nvim",
  config = function()
    require("dark_anysphere_transparent").setup({
      transparent_background = true,
      italic_keyword = true,
    })
    vim.cmd([[colorscheme dark_anysphere_transparent]])
  end
})
```

## Configuration

```lua
require("dark_anysphere_transparent").setup({
  -- Enable/disable transparency
  transparent_background = true,
  
  -- Enable/disable cursorline
  cursorline = false,
  
  -- Enable/disable italics for keywords
  italic_keyword = true,
  
  -- NvimTree darker background
  nvim_tree_darker = false,
  
  -- Enable/disable undercurls
  undercurl = true,
})
```

## Terminal Configuration

The theme includes configuration files for:
- Alacritty: `extras/alacritty_dark_anysphere_transparent.yaml`
- Foot: `extras/foot_dark_anysphere_transparent.ini`
- Windows Terminal: `extras/windows_terminal_dark_anysphere_transparent.json`

## Troubleshooting Transparency

If you're experiencing issues with transparency:

1. Make sure your terminal supports transparency
2. Ensure your window manager/compositor supports transparency 
3. Try recompiling the theme with:
   ```lua
   :DarkAnysphereTransparentCompile
   ```

## Credits

- Based on the Anysphere VSCode theme
- Inspired by VSCode Modern theme structure