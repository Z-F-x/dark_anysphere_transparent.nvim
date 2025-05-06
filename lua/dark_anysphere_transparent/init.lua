local M = {}

--- @class VSCodeModernConfig
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
    transparent_background = true, -- Set this to true
    nvim_tree_darker = false,
    undercurl = true,
    italic_keyword = true,
    custom_dark_background = '#141414',
    custom_light_background = nil,
    custom_statusline_dark_background = nil,
    cache_path = vim.fn.stdpath 'cache' .. '/dark_anysphere_transparent/cache',
}

--- @overload fun(config?: VSCodeModernConfig)
function M.setup(config)
    M.config = vim.tbl_deep_extend('force', M.config, config or {})
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
    
    -- Set the global transparency flag
    vim.g.transparent_background = M.config.transparent_background
    
    compile_if_not_exist()

    local f = loadfile(M.config.cache_path)
    if f ~= nil then
        f()
        
        -- Apply transparency directly if enabled
        if M.config.transparent_background then
            local transparent_groups = {
                "Normal", "NormalFloat", "SignColumn", "NormalNC", 
                "LineNr", "CursorLineNr", "Folded", "EndOfBuffer",
                "VertSplit", "StatusLine", "StatusLineNC",
                "Pmenu", "PmenuSbar", "PmenuThumb",
                "TabLine", "TabLineFill", "TabLineSel"
            }
            
            for _, group in ipairs(transparent_groups) do
                vim.api.nvim_set_hl(0, group, { bg = "NONE" })
            end
        end
    else
        vim.notify(
            '[dark_anysphere_transparent.nvim] error trying to load cache file',
            vim.log.levels.ERROR
        )
    end
end

--- @param config VSCodeModernConfig
--- @param theme_dark VSCodeModernThemeDark
--- @param theme_light VSCodeModernThemeLight
function M.compile(config, theme_dark, theme_light)
    local lines = {
        string.format [[return string.dump(function()
vim.cmd.highlight('clear')
vim.g.colors_name="dark_anysphere_transparent"
local h=vim.api.nvim_set_hl
vim.opt.termguicolors=true]],
    }

    table.insert(lines, 'if vim.o.background == \'dark\' then')
    local hgs_dark = require('dark_anysphere_transparent.hlgroups').get(config, theme_dark)
    for group, color in pairs(hgs_dark) do
        -- Replace any #00000000 values with NONE
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
    for group, color in pairs(hgs_light) do
        -- Replace any #00000000 values with NONE
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

    -- Add transparency overrides if enabled
    if config.transparent_background then
        table.insert(lines, [[
-- Apply transparency
if vim.g.transparent_background then
    h(0, "Normal", { bg = "NONE" })
    h(0, "NormalFloat", { bg = "NONE" })
    h(0, "SignColumn", { bg = "NONE" })
    h(0, "NormalNC", { bg = "NONE" })
    h(0, "LineNr", { bg = "NONE" })
    h(0, "CursorLineNr", { bg = "NONE" })
    h(0, "Folded", { bg = "NONE" })
    h(0, "EndOfBuffer", { bg = "NONE" })
    h(0, "VertSplit", { bg = "NONE" })
    h(0, "StatusLine", { bg = "NONE" })
    h(0, "StatusLineNC", { bg = "NONE" })
    h(0, "Pmenu", { bg = "NONE" })
    h(0, "PmenuSbar", { bg = "NONE" })
    h(0, "PmenuThumb", { bg = "NONE" })
    h(0, "TabLine", { bg = "NONE" })
    h(0, "TabLineFill", { bg = "NONE" })
    h(0, "TabLineSel", { bg = "NONE" })
end]])
    end

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
