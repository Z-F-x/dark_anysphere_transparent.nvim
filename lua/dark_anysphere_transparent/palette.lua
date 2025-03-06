
local M = {}

-- Assume the new palette is provided by VSCodeModernPalette
local palette = require("vscode_modern_palette")
--[[
  VSCodeModernPalette mapping used:

  bg          -> palette.grey_01    -- (#252526)
  fg          -> palette.light_13   -- (#ebebeb)
  gray        -> palette.grey_14    -- (#6e7681)
  blue        -> palette.blue_16    -- (#2aaaff)
  light_blue  -> palette.blue_25    -- (#9cdcfe)
  cyan        -> palette.blue_28    -- (#c3d8e6)
  green       -> palette.green_08   -- (#4ec9b0)
  light_green -> palette.green_13   -- (#b5cea8)
  yellow      -> palette.yellow_08  -- (#e2c08d)
  orange      -> palette.orange_03  -- (#f8c9ab)
  red         -> palette.red_08     -- (#f14c4c)
  magenta     -> palette.magenta_01 -- (#d16d9e)
  purple      -> palette.purple_02  -- (#b180d7)
  dark_purple -> palette.purple_01  -- (#af00db)
  ui_blue     -> palette.blue_14    -- (#264f78)
]]--

function M.setup()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  vim.o.background = "dark"
  vim.o.termguicolors = true
  vim.g.colors_name = "vscode_modern_theme"

  local groups = {
    -- Vim interface
    Normal = { fg = palette.light_13, bg = palette.grey_01 },
    NormalFloat = { fg = palette.light_13, bg = palette.grey_01 },
    Cursor = { fg = palette.grey_01, bg = palette.light_13 },
    CursorLine = { bg = palette.grey_07 }, -- e.g. approximating "#292929"
    CursorColumn = { bg = palette.grey_07 },
    ColorColumn = { bg = palette.grey_07 },
    LineNr = { fg = palette.grey_14 },
    CursorLineNr = { fg = palette.light_13 },
    VertSplit = { fg = palette.grey_09 },
    Folded = { fg = palette.grey_14, bg = palette.grey_07 },
    FoldColumn = { fg = palette.grey_14, bg = palette.grey_01 },
    SignColumn = { bg = palette.grey_01 },
    StatusLine = { fg = palette.light_13, bg = palette.grey_07 },
    StatusLineNC = { fg = palette.grey_14, bg = palette.grey_07 },
    Pmenu = { fg = palette.light_13, bg = palette.grey_07 },
    PmenuSel = { fg = palette.light_13, bg = palette.blue_14 },
    PmenuSbar = { bg = palette.grey_07 },
    PmenuThumb = { bg = palette.grey_14 },
    MatchParen = { fg = palette.yellow_08, bold = true },
    NonText = { fg = palette.grey_07 },
    SpecialKey = { fg = palette.grey_07 },
    Visual = { bg = palette.blue_14 },
    VisualNOS = { bg = palette.blue_14 },
    Search = { fg = palette.grey_01, bg = palette.orange_02 },
    IncSearch = { fg = palette.grey_01, bg = palette.orange_02 },
    QuickFixLine = { bg = palette.blue_14 },
    Terminal = { fg = palette.light_13, bg = palette.dark_02 },

    -- Syntax
    Comment = { fg = palette.grey_14, italic = true },
    Constant = { fg = palette.orange_03 },
    String = { fg = palette.magenta_01 },
    Character = { fg = palette.magenta_01 },
    Number = { fg = palette.yellow_08 },
    Boolean = { fg = palette.blue_16 },
    Float = { fg = palette.yellow_08 },
    Identifier = { fg = palette.blue_16 },
    Function = { fg = palette.yellow_08 },
    Statement = { fg = palette.blue_16 },
    Conditional = { fg = palette.blue_16 },
    Repeat = { fg = palette.blue_16 },
    Label = { fg = palette.blue_16 },
    Operator = { fg = palette.light_13 },
    Keyword = { fg = palette.blue_16 },
    Exception = { fg = palette.blue_16 },
    PreProc = { fg = palette.blue_16 },
    Include = { fg = palette.blue_16 },
    Define = { fg = palette.blue_16 },
    Macro = { fg = palette.blue_16 },
    PreCondit = { fg = palette.blue_16 },
    Type = { fg = palette.orange_03 },
    StorageClass = { fg = palette.blue_16 },
    Structure = { fg = palette.blue_16 },
    Typedef = { fg = palette.blue_16 },
    Special = { fg = palette.yellow_08 },
    SpecialChar = { fg = palette.yellow_08 },
    Tag = { fg = palette.orange_03 },
    Delimiter = { fg = palette.light_13 },
    SpecialComment = { fg = palette.grey_14 },
    Debug = { fg = palette.orange_03 },
    Underlined = { underline = true },
    Ignore = { fg = palette.grey_14 },
    Error = { fg = palette.red_08 },
    Todo = { fg = palette.magenta_01, bold = true },

    -- Treesitter
    ["@punctuation.delimiter"] = { fg = palette.light_13 },
    ["@punctuation.bracket"] = { fg = palette.light_13 },
    ["@punctuation.special"] = { fg = palette.blue_16 },
    ["@constant"] = { fg = palette.orange_03 },
    ["@constant.builtin"] = { fg = palette.orange_03 },
    ["@constant.macro"] = { fg = palette.orange_03 },
    ["@string.regex"] = { fg = palette.red_08 },
    ["@string"] = { fg = palette.magenta_01 },
    ["@character"] = { fg = palette.magenta_01 },
    ["@number"] = { fg = palette.yellow_08 },
    ["@boolean"] = { fg = palette.blue_16 },
    ["@float"] = { fg = palette.yellow_08 },
    ["@annotation"] = { fg = palette.yellow_08 },
    ["@attribute"] = { fg = palette.blue_16 },
    ["@namespace"] = { fg = palette.orange_03 },
    ["@function.builtin"] = { fg = palette.blue_16 },
    ["@function"] = { fg = palette.yellow_08 },
    ["@function.macro"] = { fg = palette.yellow_08 },
    ["@parameter"] = { fg = palette.light_13 },
    ["@parameter.reference"] = { fg = palette.light_13 },
    ["@method"] = { fg = palette.yellow_08 },
    ["@field"] = { fg = palette.purple_02 },
    ["@property"] = { fg = palette.purple_02 },
    ["@constructor"] = { fg = palette.blue_16 },
    ["@conditional"] = { fg = palette.blue_16 },
    ["@repeat"] = { fg = palette.blue_16 },
    ["@label"] = { fg = palette.blue_16 },
    ["@keyword"] = { fg = palette.blue_16 },
    ["@keyword.function"] = { fg = palette.blue_16 },
    ["@keyword.operator"] = { fg = palette.blue_16 },
    ["@operator"] = { fg = palette.light_13 },
    ["@exception"] = { fg = palette.blue_16 },
    ["@type"] = { fg = palette.orange_03 },
    ["@type.builtin"] = { fg = palette.orange_03 },
    ["@structure"] = { fg = palette.orange_03 },
    ["@include"] = { fg = palette.blue_16 },
    ["@variable"] = { fg = palette.blue_25 },
    ["@variable.builtin"] = { fg = palette.orange_03 },

    -- LSP
    DiagnosticError = { fg = palette.red_08 },
    DiagnosticWarn = { fg = palette.yellow_08 },
    DiagnosticInfo = { fg = palette.blue_16 },
    DiagnosticHint = { fg = palette.blue_16 },
    LspReferenceText = { bg = palette.grey_07 },
    LspReferenceRead = { bg = palette.grey_07 },
    LspReferenceWrite = { bg = palette.grey_07 },

    -- Plugins
    TelescopeNormal = { fg = palette.light_13, bg = palette.grey_01 },
    TelescopeBorder = { fg = palette.grey_09, bg = palette.grey_01 },
    TelescopePromptNormal = { fg = palette.light_13, bg = palette.grey_07 },
    TelescopePromptBorder = { fg = palette.grey_09, bg = palette.grey_07 },
    TelescopePromptTitle = { fg = palette.light_13, bg = palette.blue_14 },
    TelescopePreviewTitle = { fg = palette.light_13, bg = palette.blue_14 },
    TelescopeResultsTitle = { fg = palette.light_13, bg = palette.blue_14 },

    GitSignsAdd = { fg = palette.green_08 },
    GitSignsChange = { fg = palette.blue_16 },
    GitSignsDelete = { fg = palette.red_08 },

    BufferLineFill = { bg = palette.grey_07 },
    BufferLineBackground = { fg = palette.grey_14, bg = palette.grey_07 },
    BufferLineBufferVisible = { fg = palette.light_13, bg = palette.grey_07 },
    BufferLineBufferSelected = { fg = palette.light_13, bg = palette.grey_01, bold = true },

    IndentBlanklineChar = { fg = palette.grey_07 },
    IndentBlanklineContextChar = { fg = palette.purple_02 },
  }

  for group, styles in pairs(groups) do
    vim.api.nvim_set_hl(0, group, styles)
  end
end

return M
