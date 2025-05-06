local M = {}

-- Anysphere colorscheme palette
M.grey_01 = '#141414'     -- darkest background/sidebar
M.grey_02 = '#1a1a1a'     -- editor background
M.grey_03 = '#292929'     -- line highlight
M.grey_04 = '#2A2A2A'     -- dropdown border
M.grey_05 = '#404040'     -- selection background
M.grey_06 = '#505050'     -- inactive line number
M.grey_07 = '#CCCCCC'     -- main text/foreground
M.grey_08 = '#D8DEE9'     -- editor foreground
M.grey_09 = '#FFFFFF'     -- active line number

-- Accent colors from Anysphere theme
M.blue_01 = '#88C0D0'     -- activity badge background
M.blue_02 = '#4c9df3'     -- button background
M.blue_03 = '#66aefa'     -- button hover
M.blue_04 = '#2472c8'     -- blue accent
M.blue_05 = '#81A1C1'     -- terminal blue
M.blue_06 = '#264f78'     -- selection highlight

M.red_01 = '#BF616A'      -- error foreground
M.red_02 = '#f14c4c'      -- minimap error highlight

M.green_01 = '#A3BE8C'    -- git added
M.green_02 = '#15ac91'    -- minimap added

M.yellow_01 = '#EBCB8B'   -- warning foreground
M.yellow_02 = '#e5b95c'   -- minimap modified
M.yellow_03 = '#ea7620'   -- minimap warning

-- Transparency - use NONE instead of hex codes with alpha
M.none = 'NONE'
M.none_1 = 'NONE' -- Changed from #00000000 to NONE

-- Semantic token colors from Anysphere theme
M.semantic = {
    purple = '#AA9BF5',    -- variable.other.property
    orange = '#efb080',    -- function.declaration
    cyan = '#82d2ce',      -- class.typeHint
    func = '#ebc88d',      -- function
    string = '#e394dc',    -- string
    parameter = '#d6d6dd', -- parameter function
    comment = '#6d6d6d',   -- comments
    decorator = '#a8cc7c', -- python decorator
    class = '#87c3ff',     -- class
    selfParam = '#cc7c8a'  -- selfParameter
}

function M.setup()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  vim.o.background = "dark"
  vim.o.termguicolors = true
  vim.g.colors_name = "AnysphereModern_modern_theme"

  local groups = {
    -- Vim interface
    Normal = { fg = M.grey_07, bg = M.grey_01 },
    NormalFloat = { fg = M.grey_07, bg = M.grey_01 },
    Cursor = { fg = M.grey_01, bg = M.grey_07 },
    CursorLine = { bg = M.grey_07 }, -- e.g. approximating "#292929"
    CursorColumn = { bg = M.grey_07 },
    ColorColumn = { bg = M.grey_07 },
    LineNr = { fg = M.grey_08 },
    CursorLineNr = { fg = M.grey_07 },
    VertSplit = { fg = M.grey_09 },
    Folded = { fg = M.grey_08, bg = M.grey_07 },
    FoldColumn = { fg = M.grey_08, bg = M.grey_01 },
    SignColumn = { bg = M.grey_01 },
    StatusLine = { fg = M.grey_07, bg = M.grey_07 },
    StatusLineNC = { fg = M.grey_08, bg = M.grey_07 },
    Pmenu = { fg = M.grey_07, bg = M.grey_07 },
    PmenuSel = { fg = M.grey_07, bg = M.blue_04 },
    PmenuSbar = { bg = M.grey_07 },
    PmenuThumb = { bg = M.grey_08 },
    MatchParen = { fg = M.yellow_01, bold = true },
    NonText = { fg = M.grey_07 },
    SpecialKey = { fg = M.grey_07 },
    Visual = { bg = M.blue_04 },
    VisualNOS = { bg = M.blue_04 },
    Search = { fg = M.grey_01, bg = M.yellow_02 },
    IncSearch = { fg = M.grey_01, bg = M.yellow_02 },
    QuickFixLine = { bg = M.blue_04 },
    Terminal = { fg = M.grey_07, bg = M.grey_02 },

    -- Syntax
    Comment = { fg = M.grey_08, italic = true },
    Constant = { fg = M.yellow_01 },
    String = { fg = M.purple },
    Character = { fg = M.purple },
    Number = { fg = M.yellow_01 },
    Boolean = { fg = M.blue_04 },
    Float = { fg = M.yellow_01 },
    Identifier = { fg = M.blue_04 },
    Function = { fg = M.yellow_01 },
    Statement = { fg = M.blue_04 },
    Conditional = { fg = M.blue_04 },
    Repeat = { fg = M.blue_04 },
    Label = { fg = M.blue_04 },
    Operator = { fg = M.grey_07 },
    Keyword = { fg = M.blue_04 },
    Exception = { fg = M.blue_04 },
    PreProc = { fg = M.blue_04 },
    Include = { fg = M.blue_04 },
    Define = { fg = M.blue_04 },
    Macro = { fg = M.blue_04 },
    PreCondit = { fg = M.blue_04 },
    Type = { fg = M.yellow_01 },
    StorageClass = { fg = M.blue_04 },
    Structure = { fg = M.blue_04 },
    Typedef = { fg = M.blue_04 },
    Special = { fg = M.yellow_01 },
    SpecialChar = { fg = M.yellow_01 },
    Tag = { fg = M.yellow_01 },
    Delimiter = { fg = M.grey_07 },
    SpecialComment = { fg = M.grey_08 },
    Debug = { fg = M.yellow_01 },
    Underlined = { underline = true },
    Ignore = { fg = M.grey_08 },
    Error = { fg = M.red_01 },
    Todo = { fg = M.purple, bold = true },

    -- Treesitter
    ["@punctuation.delimiter"] = { fg = M.grey_07 },
    ["@punctuation.bracket"] = { fg = M.grey_07 },
    ["@punctuation.special"] = { fg = M.blue_04 },
    ["@constant"] = { fg = M.yellow_01 },
    ["@constant.builtin"] = { fg = M.yellow_01 },
    ["@constant.macro"] = { fg = M.yellow_01 },
    ["@string.regex"] = { fg = M.red_01 },
    ["@string"] = { fg = M.purple },
    ["@character"] = { fg = M.purple },
    ["@number"] = { fg = M.yellow_01 },
    ["@boolean"] = { fg = M.blue_04 },
    ["@float"] = { fg = M.yellow_01 },
    ["@annotation"] = { fg = M.yellow_01 },
    ["@attribute"] = { fg = M.blue_04 },
    ["@namespace"] = { fg = M.yellow_01 },
    ["@function.builtin"] = { fg = M.blue_04 },
    ["@function"] = { fg = M.yellow_01 },
    ["@function.macro"] = { fg = M.yellow_01 },
    ["@parameter"] = { fg = M.grey_07 },
    ["@parameter.reference"] = { fg = M.grey_07 },
    ["@method"] = { fg = M.yellow_01 },
    ["@field"] = { fg = M.purple },
    ["@property"] = { fg = M.purple },
    ["@constructor"] = { fg = M.blue_04 },
    ["@conditional"] = { fg = M.blue_04 },
    ["@repeat"] = { fg = M.blue_04 },
    ["@label"] = { fg = M.blue_04 },
    ["@keyword"] = { fg = M.blue_04 },
    ["@keyword.function"] = { fg = M.blue_04 },
    ["@keyword.operator"] = { fg = M.blue_04 },
    ["@operator"] = { fg = M.grey_07 },
    ["@exception"] = { fg = M.blue_04 },
    ["@type"] = { fg = M.yellow_01 },
    ["@type.builtin"] = { fg = M.yellow_01 },
    ["@structure"] = { fg = M.yellow_01 },
    ["@include"] = { fg = M.blue_04 },
    ["@variable"] = { fg = M.blue_05 },
    ["@variable.builtin"] = { fg = M.yellow_01 },

    -- LSP
    DiagnosticError = { fg = M.red_01 },
    DiagnosticWarn = { fg = M.yellow_01 },
    DiagnosticInfo = { fg = M.blue_04 },
    DiagnosticHint = { fg = M.blue_04 },
    LspReferenceText = { bg = M.grey_07 },
    LspReferenceRead = { bg = M.grey_07 },
    LspReferenceWrite = { bg = M.grey_07 },

    -- Plugins
    TelescopeNormal = { fg = M.grey_07, bg = M.grey_01 },
    TelescopeBorder = { fg = M.grey_09, bg = M.grey_01 },
    TelescopePromptNormal = { fg = M.grey_07, bg = M.grey_07 },
    TelescopePromptBorder = { fg = M.grey_09, bg = M.grey_07 },
    TelescopePromptTitle = { fg = M.grey_07, bg = M.blue_04 },
    TelescopePreviewTitle = { fg = M.grey_07, bg = M.blue_04 },
    TelescopeResultsTitle = { fg = M.grey_07, bg = M.blue_04 },

    GitSignsAdd = { fg = M.green_01 },
    GitSignsChange = { fg = M.blue_04 },
    GitSignsDelete = { fg = M.red_01 },

    BufferLineFill = { bg = M.grey_07 },
    BufferLineBackground = { fg = M.grey_08, bg = M.grey_07 },
    BufferLineBufferVisible = { fg = M.grey_07, bg = M.grey_07 },
    BufferLineBufferSelected = { fg = M.grey_07, bg = M.grey_01, bold = true },

    IndentBlanklineChar = { fg = M.grey_07 },
    IndentBlanklineContextChar = { fg = M.purple },
  }

  for group, styles in pairs(groups) do
    vim.api.nvim_set_hl(0, group, styles)
  end
end

return M
