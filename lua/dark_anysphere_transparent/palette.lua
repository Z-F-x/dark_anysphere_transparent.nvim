local M = {}

-- Anysphere colorscheme palette
M.grey_01 = '#141414'     -- darkest background/sidebar
M.grey_02 = '#1a1a1a'     -- editor background
M.grey_03 = '#292929'     -- line highlight
M.grey_04 = '#2A2A2A'     -- dropdown border
M.grey_05 = '#404040'     -- selection background
M.grey_06 = '#505050'     -- inactive line number
M.grey_07 = '#CCCCCC'     -- main text/foreground (removed alpha value that was causing error)
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
M.none_1 = 'NONE'

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
  vim.g.colors_name = "dark_anysphere_transparent"

  local groups = {
    -- Vim interface - all backgrounds set to NONE for transparency
    Normal = { fg = M.grey_07, bg = M.none },
    NormalFloat = { fg = M.grey_07, bg = M.none },
    Cursor = { fg = M.grey_01, bg = M.grey_07 },
    CursorLine = { bg = M.grey_03 },
    CursorColumn = { bg = M.grey_03 },
    ColorColumn = { bg = M.grey_03 },
    LineNr = { fg = M.grey_06, bg = M.none },
    CursorLineNr = { fg = M.grey_09, bg = M.none },
    VertSplit = { fg = M.grey_04, bg = M.none },
    Folded = { fg = M.grey_08, bg = M.none },
    FoldColumn = { fg = M.grey_08, bg = M.none },
    SignColumn = { bg = M.none },
    StatusLine = { fg = M.grey_07, bg = M.none },
    StatusLineNC = { fg = M.grey_08, bg = M.none },
    Pmenu = { fg = M.grey_07, bg = M.none },
    PmenuSel = { fg = M.grey_09, bg = M.blue_04 },
    PmenuSbar = { bg = M.none },
    PmenuThumb = { bg = M.grey_06 },
    MatchParen = { fg = M.yellow_01, bold = true },
    NonText = { fg = M.grey_06, bg = M.none },
    SpecialKey = { fg = M.grey_06, bg = M.none },
    Visual = { bg = M.blue_06 },
    VisualNOS = { bg = M.blue_06 },
    Search = { fg = M.grey_01, bg = M.yellow_02 },
    IncSearch = { fg = M.grey_01, bg = M.yellow_02 },
    QuickFixLine = { bg = M.blue_04 },
    Terminal = { fg = M.grey_07, bg = M.none },

    -- Syntax
    Comment = { fg = M.semantic.comment, italic = true },
    Constant = { fg = M.yellow_01 },
    String = { fg = M.semantic.string },
    Character = { fg = M.semantic.string },
    Number = { fg = M.semantic.func },
    Boolean = { fg = M.blue_04 },
    Float = { fg = M.semantic.func },
    Identifier = { fg = M.blue_04 },
    Function = { fg = M.semantic.func },
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
    Type = { fg = M.semantic.class },
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
    Todo = { fg = M.semantic.string, bold = true },

    -- Treesitter
    ["@punctuation.delimiter"] = { fg = M.grey_07 },
    ["@punctuation.bracket"] = { fg = M.grey_07 },
    ["@punctuation.special"] = { fg = M.blue_04 },
    ["@constant"] = { fg = M.yellow_01 },
    ["@constant.builtin"] = { fg = M.yellow_01 },
    ["@constant.macro"] = { fg = M.yellow_01 },
    ["@string.regex"] = { fg = M.red_01 },
    ["@string"] = { fg = M.semantic.string },
    ["@character"] = { fg = M.semantic.string },
    ["@number"] = { fg = M.semantic.func },
    ["@boolean"] = { fg = M.blue_04 },
    ["@float"] = { fg = M.semantic.func },
    ["@annotation"] = { fg = M.yellow_01 },
    ["@attribute"] = { fg = M.blue_04 },
    ["@namespace"] = { fg = M.semantic.class },
    ["@function.builtin"] = { fg = M.semantic.cyan },
    ["@function"] = { fg = M.semantic.func },
    ["@function.macro"] = { fg = M.semantic.decorator },
    ["@parameter"] = { fg = M.semantic.parameter },
    ["@parameter.reference"] = { fg = M.semantic.parameter },
    ["@method"] = { fg = M.semantic.func },
    ["@field"] = { fg = M.semantic.purple },
    ["@property"] = { fg = M.semantic.purple },
    ["@constructor"] = { fg = M.blue_04 },
    ["@conditional"] = { fg = M.blue_04 },
    ["@repeat"] = { fg = M.blue_04 },
    ["@label"] = { fg = M.blue_04 },
    ["@keyword"] = { fg = M.blue_04 },
    ["@keyword.function"] = { fg = M.blue_04 },
    ["@keyword.operator"] = { fg = M.blue_04 },
    ["@operator"] = { fg = M.grey_07 },
    ["@exception"] = { fg = M.blue_04 },
    ["@type"] = { fg = M.semantic.class },
    ["@type.builtin"] = { fg = M.semantic.cyan },
    ["@structure"] = { fg = M.semantic.class },
    ["@include"] = { fg = M.blue_04 },
    ["@variable"] = { fg = M.semantic.parameter },
    ["@variable.builtin"] = { fg = M.semantic.cyan },

    -- LSP
    DiagnosticError = { fg = M.red_01 },
    DiagnosticWarn = { fg = M.yellow_01 },
    DiagnosticInfo = { fg = M.blue_01 },
    DiagnosticHint = { fg = M.blue_01 },
    LspReferenceText = { bg = M.grey_05 },
    LspReferenceRead = { bg = M.grey_05 },
    LspReferenceWrite = { bg = M.grey_05 },

    -- Plugins
    TelescopeNormal = { fg = M.grey_07, bg = M.none },
    TelescopeBorder = { fg = M.grey_04, bg = M.none },
    TelescopePromptNormal = { fg = M.grey_07, bg = M.none },
    TelescopePromptBorder = { fg = M.grey_04, bg = M.none },
    TelescopePromptTitle = { fg = M.grey_09, bg = M.blue_02 },
    TelescopePreviewTitle = { fg = M.grey_09, bg = M.blue_02 },
    TelescopeResultsTitle = { fg = M.grey_09, bg = M.blue_02 },

    GitSignsAdd = { fg = M.green_01 },
    GitSignsChange = { fg = M.yellow_01 },
    GitSignsDelete = { fg = M.red_01 },

    BufferLineFill = { bg = M.none },
    BufferLineBackground = { fg = M.grey_06, bg = M.none },
    BufferLineBufferVisible = { fg = M.grey_07, bg = M.none },
    BufferLineBufferSelected = { fg = M.grey_09, bg = M.none, bold = true },

    IndentBlanklineChar = { fg = M.grey_04 },
    IndentBlanklineContextChar = { fg = M.semantic.purple },
  }

  for group, styles in pairs(groups) do
    vim.api.nvim_set_hl(0, group, styles)
  end
end

return M
