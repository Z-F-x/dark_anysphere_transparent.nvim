# Dark Anysphere Transparent

A Neovim colorscheme based on the Anysphere VSCode theme with transparency support. This theme is designed to be used with terminals that support transparency and blur effects.

![Dark Anysphere Transparent Theme](screenshots/screenshot.png)

## Features

- Dark theme with **always-on transparency** support
- Matches the Anysphere VSCode theme colors
- Perfect for transparent terminal emulators with blur effects
- Semantic highlighting support
- Italic support for comments and keywords
- LSP diagnostics and Treesitter support

## Requirements

- Neovim 0.7.0+
- Terminal with true color and transparency support
- A window manager/compositor that supports transparency and blur

## Installation

### Using Lazy.nvim

```lua
{
  "username/dark_anysphere_transparent.nvim",
  lazy = false, -- load during startup
  priority = 1000, -- load this before other plugins
  config = function()
    require("dark_anysphere_transparent").setup({
      -- All backgrounds are transparent by default
      -- transparent_background is always true in this theme
      cursorline = true,         -- Enable cursorline highlighting
      italic_keyword = true,     -- Enable italic for keywords
    })
    vim.cmd([[colorscheme dark_anysphere_transparent]])
  end,
}
```

### Using Packer.nvim

```lua
use({
  "username/dark_anysphere_transparent.nvim",
  config = function()
    require("dark_anysphere_transparent").setup({
      cursorline = true,
      italic_keyword = true,
    })
    vim.cmd([[colorscheme dark_anysphere_transparent]])
  end
})
```

## Configuration

```lua
require("dark_anysphere_transparent").setup({
  -- Transparency is always enabled in this theme and cannot be disabled
  
  -- Enable/disable cursorline highlighting
  cursorline = true,
  
  -- Enable/disable italics for keywords
  italic_keyword = true,
  
  -- NvimTree darker background (although still transparent)
  nvim_tree_darker = true,
  
  -- Enable/disable undercurls for diagnostics
  undercurl = true,
})
```

## Terminal Setup for Best Results

For the best experience, configure your terminal with:

1. **Transparency**: Set your terminal's background opacity between 80-90%
2. **Blur effect**: Enable background blur for best readability
3. **True color support**: Ensure your terminal supports 24-bit colors

### Recommended Terminal Settings

#### Konsole
- Go to Settings → Edit Current Profile → Appearance
- Set background transparency to around 20%
- Enable blur effect

#### Kitty
```
background_opacity 0.85
background_blur 1
```

#### Alacritty
```yaml
window:
  opacity: 0.9
```

#### Windows Terminal
```json
"profiles": {
  "defaults": {
    "useAcrylic": true,
    "acrylicOpacity": 0.85
  }
}
```

## Troubleshooting Transparency

If you're experiencing issues with transparency:

1. Make sure your terminal supports transparency
2. Ensure your window manager/compositor supports transparency and blur
3. Try recompiling the theme with:
   ```lua
   :DarkAnysphereTransparentCompile
   ```
4. Manually force transparency by adding to your config:
   ```lua
   vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
   vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
   ```

## Screenshots

![Code Screenshot](screenshots/code.png)
![UI Elements](screenshots/ui.png)

## Credits

- Based on the Anysphere VSCode theme
- Transparency implementation inspired by [Z-F-x/vim_default_modern.nvim](https://github.com/Z-F-x/vim_default_modern.nvim)