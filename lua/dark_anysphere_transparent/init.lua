local M = {}

-- Helper function to clean hex colors
local function clean_hex_color(color)
    if type(color) ~= "string" then
        return color
    end
    
    -- Check for 8-digit hex colors (with alpha) and remove alpha component
    if color:match("^#%x%x%x%x%x%x%x%x$") then
        return color:sub(1, 7)
    end
    
    -- Handle special transparent values
    if color == "#00000000" then
        return "NONE"
    end
    
    return color
end

--- @class AnysphereModernModernConfig
--- @field cursorline? boolean
--- @field transparent_background? boolean
--- @field nvim_tree_darker? boolean
--- @field undercurl? boolean
--- @field italic_keyword? boolean
--- @field custom_dark_background? string
--- @field custom_light_background? string
--- @field custom_statusline_dark_background? string
--- @field cache_path? string
M.config = {
    cursorline = false,
    transparent_background = true, -- Always true for this theme
    nvim_tree_darker = false,
    undercurl = true,
    italic_keyword = true,
    custom_dark_background = '#141414',
    custom_light_background = nil,
    custom_statusline_dark_background = nil,
    cache_path = vim.fn.stdpath 'cache' .. '/dark_anysphere_transparent/cache',
}

--- @overload fun(config?: AnysphereModernModernConfig)
function M.setup(config)
    -- Ensure transparency is always enabled
    config = config or {}
    config.transparent_background = true
    
    M.config = vim.tbl_deep_extend('force', M.config, config)
end

-- Force recompilation by deleting the cache
local function force_recompile()
    -- Delete the cache if it exists
    if vim.fn.filereadable(M.config.cache_path) == 1 then
        vim.fn.delete(M.config.cache_path)
    end
end

local function compile_if_not_exist()
    if vim.fn.filereadable(M.config.cache_path) == 0 then
        local palette = require 'dark_anysphere_transparent.palette'

        local theme_dark =
            require('dark_anysphere_transparent.themes').dark(palette, M.config)
        local theme_light =
            require('dark_anysphere_transparent.themes').light(palette, M.config)

        M.compile(M.config, theme_dark, theme_light)
    end
end

function M.load()
    -- Force recompilation to ensure updated settings
    force_recompile()
    
    -- Always set transparency to true
    M.config.transparent_background = true
    vim.g.transparent_background = true
    
    compile_if_not_exist()

    local f = loadfile(M.config.cache_path)
    if f ~= nil then
        f()
        
        -- Apply transparency directly to all relevant highlight groups
        local transparent_groups = {
            "Normal", "NormalFloat", "SignColumn", "NormalNC", 
            "LineNr", "CursorLineNr", "Folded", "EndOfBuffer",
            "VertSplit", "StatusLine", "StatusLineNC",
            "Pmenu", "PmenuSbar", "PmenuThumb",
            "TabLine", "TabLineFill", "TabLineSel",
            "FoldColumn", "ColorColumn", "Conceal",
            "WinBar", "WinBarNC", "WinSeparator",
            "StatusLineTerm", "StatusLineTermNC"
        }
        
        for _, group in ipairs(transparent_groups) do
            -- Preserve foreground color but set background to NONE
            local current = vim.api.nvim_get_hl(0, {name = group})
            if current then
                current.bg = nil
                
                -- Clean any color values
                if current.fg then
                    current.fg = clean_hex_color(current.fg)
                end
                
                -- Safely apply highlight
                pcall(vim.api.nvim_set_hl, 0, group, current)
            end
        end
        
        -- Ensure background is properly cleared
        pcall(vim.api.nvim_set_hl, 0, "Normal", { bg = "NONE" })
    else
        vim.notify(
            '[dark_anysphere_transparent.nvim] error trying to load cache file',
            vim.log.levels.ERROR
        )
    end
end

--- @param config AnysphereModernModernConfig
--- @param theme_dark AnysphereModernThemeDark
--- @param theme_light AnysphereModernModernThemeLight
function M.compile(config, theme_dark, theme_light)
    -- Function to sanitize color values before compilation
    local function sanitize_colors(color_table)
        if type(color_table) ~= "table" then
            return color_table
        end
        
        local sanitized = vim.deepcopy(color_table)
        
        for k, v in pairs(sanitized) do
            if type(v) == "table" then
                sanitized[k] = sanitize_colors(v)
            elseif type(v) == "string" then
                sanitized[k] = clean_hex_color(v)
            end
        end
        
        return sanitized
    end

    local lines = {
        string.format [[return string.dump(function()
vim.cmd.highlight('clear')
vim.g.colors_name="dark_anysphere_transparent"
local h=vim.api.nvim_set_hl
vim.opt.termguicolors=true]],
    }

    table.insert(lines, 'if vim.o.background == \'dark\' then')
    local hgs_dark = require('dark_anysphere_transparent.hlgroups').get(config, theme_dark)
    
    -- Sanitize colors before compilation
    hgs_dark = sanitize_colors(hgs_dark)
    
    for group, color in pairs(hgs_dark) do
        -- Double-check that there are no problematic colors
        if color.bg == "#00000000" then
            color.bg = "NONE"
        end
        
        table.insert(
            lines,
            string.format(
                [[h(0,"%s",%s)]],
                group,
                vim.inspect(color, { newline = '', indent = '' })
            )
        )
    end

    table.insert(lines, 'else')

    local hgs_light = require('dark_anysphere_transparent.hlgroups').get(config, theme_light)
    
    -- Sanitize colors before compilation
    hgs_light = sanitize_colors(hgs_light)
    
    for group, color in pairs(hgs_light) do
        -- Double-check that there are no problematic colors
        if color.bg == "#00000000" then
            color.bg = "NONE"
        end
        
        table.insert(
            lines,
            string.format(
                [[h(0,"%s",%s)]],
                group,
                vim.inspect(color, { newline = '', indent = '' })
            )
        )
    end
    table.insert(lines, 'end')

    -- Ensure transparency is always applied
    table.insert(lines, [[
-- Apply transparency for all relevant highlight groups
local transparent_groups = {
    "Normal", "NormalFloat", "SignColumn", "NormalNC", 
    "LineNr", "CursorLineNr", "Folded", "EndOfBuffer",
    "VertSplit", "StatusLine", "StatusLineNC",
    "Pmenu", "PmenuSbar", "PmenuThumb",
    "TabLine", "TabLineFill", "TabLineSel",
    "FoldColumn", "ColorColumn", "Conceal",
    "WinBar", "WinBarNC", "WinSeparator",
    "StatusLineTerm", "StatusLineTermNC"
}

for _, group in ipairs(transparent_groups) do
    local current = vim.api.nvim_get_hl(0, {name = group})
    if current then
        current.bg = nil
        h(0, group, current)
    end
end

-- Final override to ensure Normal has no background
h(0, "Normal", { bg = "NONE" })
]])

    table.insert(lines, 'end,true)')

    local cache_dir = vim.fn.stdpath 'cache' .. '/dark_anysphere_transparent/'

    if vim.fn.isdirectory(cache_dir) == 0 then
        vim.fn.mkdir(cache_dir, 'p')
    end

    local f = loadstring(table.concat(lines, '\n'))
    if not f then
        local path_debug_file = vim.fn.stdpath 'state'
            .. '/dark_anysphere_transparent-debug.lua'

        local msg = string.format(
            '[dark_anysphere_transparent.nvim] error, open %s for debugging',
            path_debug_file
        )
        vim.notify(msg, vim.log.levels.ERROR)

        local debug_file = io.open(path_debug_file, 'wb')
        if debug_file then
            debug_file:write(table.concat(lines, '\n'))
            debug_file:close()
        end
        return
    end

    local file = io.open(cache_dir .. '/cache', 'wb')
    if file then
        file:write(f())
        file:close()
    else
        vim.notify(
            '[dark_anysphere_transparent.nvim] error trying to open cache file',
            vim.log.levels.ERROR
        )
    end
end

vim.api.nvim_create_user_command('DarkAnysphereTransparentCompile', function()
    local palette = require 'dark_anysphere_transparent.palette'

    local theme_dark = require('dark_anysphere_transparent.themes').dark(palette, M.config)
    local theme_light = require('dark_anysphere_transparent.themes').light(palette, M.config)

    M.compile(M.config, theme_dark, theme_light)

    vim.notify '[dark_anysphere_transparent.nvim] colorscheme compiled'
    vim.cmd.colorscheme 'dark_anysphere_transparent'
end, {})

return M
