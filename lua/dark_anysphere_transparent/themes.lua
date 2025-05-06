-- Function to ensure all background values are properly handled for transparency
local function ensure_valid_colors(obj)
    if type(obj) ~= "table" then
        return obj
    end
    
    for k, v in pairs(obj) do
        if type(v) == "table" then
            obj[k] = ensure_valid_colors(v)
        elseif k == "bg" and (v == "#00000000" or v:match("^#%x%x%x%x%x%x$")) then
            obj[k] = "NONE"
        end
    end
    
    return obj
end

return {
    --- @param palette AnysphereModernModernPalette
    --- @param config AnysphereModernModernConfig
    --- @return AnysphereModernThemeDark
    dark = function(palette, config)
        -- Always use NONE for background in transparent theme
        local background = 'NONE'
        local statusline_bg = 'NONE'

        if
            config.custom_dark_background ~= nil
            and type(config.custom_dark_background) == 'string'
            and not config.transparent_background
        then
            background = config.custom_dark_background
        end

        if
            config.custom_statusline_dark_background ~= nil
            and type(config.custom_statusline_dark_background) == 'string'
            and not config.transparent_background
        then
            statusline_bg = config.custom_statusline_dark_background
        end

        --- @class AnysphereModernThemeDark
        local theme = {
            palette = palette,
            ui = {
                bg = background,
                bg_darker_01 = background,
                fg = palette.grey_07,
                cursor = {
                    bg = palette.grey_09,
                    fg = palette.grey_01,
                    term = {
                        bg = palette.grey_07,
                        fg = palette.grey_01,
                    },
                    line = {
                        bg = palette.grey_03,
                        nr = {
                            bg = background,
                            fg = palette.grey_09,
                        },
                    },
                },
                context = {
                    bg = background,
                },
                directory = {
                    fg = palette.yellow_01,
                },
                float = {
                    bg = background,
                    border = {
                        bg = background,
                        fg = palette.grey_04,
                    },
                },
                line_nr = {
                    bg = background,
                    fg = palette.grey_06,
                },
                match_paren = {
                    bg = palette.grey_05,
                },
                non_text = {
                    bg = background,
                    fg = palette.grey_06,
                },
                status_line = {
                    bg = background,
                    fg = palette.grey_07,
                    medium = {
                        bg = background,
                        fg = palette.grey_07,
                    },
                    mode = {
                        bg = palette.blue_02,
                        fg = palette.grey_09,
                    },
                    icon = {
                        branch = {
                            fg = palette.yellow_01,
                        },
                        lsp = {
                            active = {
                                fg = palette.green_01,
                            },
                        },
                    },
                },
                search = {
                    bg = palette.blue_06,
                },
                sign_column = {
                    bg = background,
                },
                visual = {
                    bg = palette.blue_06,
                },
                whitespace = {
                    bg = background,
                    fg = palette.grey_06,
                },
                win_separator = {
                    fg = palette.grey_06,
                },
                pmenu = {
                    bg = background,
                    fg = palette.grey_07,
                    sbar = {
                        bg = background,
                    },
                    sel = {
                        bg = palette.blue_06,
                        fg = palette.grey_09,
                    },
                    thumb = {
                        bg = palette.grey_06,
                    },
                },
                indent_guide = {
                    fg = palette.grey_06,
                    active = {
                        fg = palette.grey_07,
                    },
                },
                folded = {
                    bg = background,
                },
                title = {
                    bg = palette.blue_02,
                    fg = palette.grey_09,
                },
                telescope = {
                    matching = {
                        fg = palette.blue_02,
                    },
                    preview = {
                        bg = background,
                        border = {
                            bg = background,
                            fg = palette.grey_04,
                        },
                        title = {
                            bg = palette.blue_02,
                            fg = palette.grey_09,
                        },
                    },
                    prompt = {
                        bg = background,
                        fg = palette.grey_09,
                        border = {
                            bg = background,
                            fg = palette.grey_04,
                        },
                        counter = {
                            fg = palette.grey_09,
                        },
                        title = {
                            bg = palette.blue_02,
                            fg = palette.grey_09,
                        },
                    },
                    results = {
                        bg = background,
                        border = {
                            bg = background,
                            fg = palette.grey_04,
                        },
                        title = {
                            bg = palette.blue_02,
                            fg = palette.grey_09,
                        },
                    },
                    selection = {
                        bg = palette.blue_06,
                        fg = palette.grey_09,
                    },
                },
            },
            sintax = {
                comment = palette.semantic.comment,
                variable = palette.semantic.purple,
                constant = palette.semantic.cyan,
                string = palette.semantic.string,
                character = palette.semantic.string,
                number = palette.semantic.func,
                boolean = palette.blue_04,
                identifier = palette.grey_07,
                punctuation = palette.grey_07,
                function_name = palette.semantic.func,
                operator = palette.grey_07,
                keyword = palette.blue_04,
                keyword_control_flow = palette.blue_04,
                macro = palette.semantic.decorator,
                type = palette.semantic.class,
                namespace = palette.semantic.class,
                special_char = palette.yellow_01,
                xml_tag = palette.blue_04,
                xml_delimiter = palette.grey_07,
                todo = palette.semantic.string,
            },
            git = {
                signs = {
                    add = palette.green_01,
                    delete = palette.red_01,
                    change = palette.blue_01,
                },
                status = {
                    ignored = palette.grey_06,
                    untracked = palette.blue_01,
                    staged = palette.green_01,
                    deleted = palette.red_01,
                    modified = palette.yellow_01,
                },
                diff = {
                    add = palette.green_01,
                    change = palette.blue_01,
                    delete = palette.red_01,
                    text = palette.green_01,
                },
            },
            lsp = {
                diagnostics = {
                    error = palette.red_01,
                    warn = palette.yellow_01,
                    info = palette.blue_01,
                    hint = palette.blue_01,
                    unnecessary = palette.grey_06,
                },
                references = {
                    write = palette.blue_06,
                    read = palette.grey_05,
                    text = palette.grey_05,
                },
                inlay_hint = {
                    bg = background,
                    fg = palette.grey_06,
                },
            },
            neotest = {
                ui = {
                    file = palette.blue_05,
                    namespace = palette.yellow_01,
                    dir = palette.blue_05,
                    adapter = palette.red_01,
                    indent = palette.yellow_01,
                    marker = palette.yellow_01,
                    select = palette.yellow_01,
                    test = palette.semantic.func,
                },
                process = {
                    error = palette.red_01,
                    success = palette.green_01,
                    run = palette.yellow_01,
                    skip = palette.blue_05,
                    focus = palette.semantic.string,
                },
            },
        }

        -- Process the theme to ensure all transparent values are properly handled
        return ensure_valid_colors(theme)
    end,

    --- @param palette AnysphereModernModernPalette
    --- @param config AnysphereModernModernConfig
    --- @return AnysphereModernModernThemeLight
    light = function(palette, config)
        -- Always use NONE for background in transparent theme
        local background = 'NONE'

        if
            config.custom_light_background ~= nil
            and type(config.custom_light_background) == 'string'
            and not config.transparent_background
        then
            background = config.custom_light_background
        end

        --- @class AnysphereModernModernThemeLight
        local theme = {
            palette = palette,
            ui = {
                bg = background,
                bg_darker_01 = background,
                bg_darker_02 = background,
                fg = palette.grey_06,
                cursor = {
                    bg = palette.grey_01,
                    fg = palette.grey_09,
                    term = {
                        bg = palette.blue_03,
                        fg = palette.grey_09,
                    },
                    line = {
                        bg = palette.grey_07,
                        nr = {
                            bg = background,
                            fg = palette.blue_04,
                        },
                    },
                },
                context = {
                    bg = background,
                },
                directory = {
                    fg = palette.yellow_01,
                },
                float = {
                    bg = background,
                    border = {
                        bg = background,
                        fg = palette.grey_06,
                    },
                },
                line_nr = {
                    bg = background,
                    fg = palette.grey_06,
                },
                match_paren = {
                    bg = palette.grey_07,
                },
                non_text = {
                    bg = background,
                    fg = palette.grey_07,
                },
                status_line = {
                    bg = background,
                    fg = palette.grey_06,
                    medium = {
                        bg = background,
                        fg = palette.grey_06,
                    },
                    mode = {
                        bg = palette.blue_02,
                        fg = palette.grey_09,
                    },
                    icon = {
                        branch = {
                            fg = palette.yellow_01,
                        },
                        lsp = {
                            active = {
                                fg = palette.green_01,
                            },
                        },
                    },
                },
                search = {
                    bg = palette.yellow_01,
                },
                sign_column = {
                    bg = background,
                },
                visual = {
                    bg = palette.blue_06,
                },
                whitespace = {
                    bg = background,
                    fg = palette.grey_07,
                },
                win_separator = {
                    fg = palette.grey_07,
                },
                pmenu = {
                    bg = background,
                    fg = palette.grey_06,
                    sbar = {
                        bg = background,
                    },
                    sel = {
                        bg = palette.grey_07,
                        fg = palette.grey_01,
                    },
                    thumb = {
                        bg = palette.grey_07,
                    },
                },
                indent_guide = {
                    fg = palette.grey_07,
                    active = {
                        fg = palette.grey_06,
                    },
                },
                folded = {
                    bg = background,
                },
                title = {
                    bg = palette.blue_02,
                    fg = palette.grey_09,
                },
                telescope = {
                    matching = {
                        fg = palette.blue_02,
                    },
                    preview = {
                        bg = background,
                        border = {
                            bg = background,
                            fg = palette.grey_07,
                        },
                        title = {
                            bg = palette.blue_02,
                            fg = palette.grey_07,
                        },
                    },
                    prompt = {
                        bg = background,
                        fg = palette.grey_06,
                        border = {
                            bg = background,
                            fg = palette.grey_07,
                        },
                        counter = {
                            fg = palette.grey_06,
                        },
                        title = {
                            bg = palette.blue_02,
                            fg = palette.grey_07,
                        },
                    },
                    results = {
                        bg = background,
                        border = {
                            bg = background,
                            fg = palette.grey_07,
                        },
                        title = {
                            bg = palette.blue_02,
                            fg = palette.grey_07,
                        },
                    },
                    selection = {
                        bg = palette.grey_07,
                        fg = palette.grey_01,
                    },
                },
            },
            sintax = {
                comment = palette.semantic.comment,
                variable = palette.semantic.purple,
                constant = palette.blue_05,
                string = palette.semantic.string,
                character = palette.red_01,
                number = palette.semantic.func,
                identifier = palette.grey_06,
                punctuation = palette.grey_06,
                function_name = palette.semantic.func,
                operator = palette.grey_01,
                keyword = palette.blue_04,
                keyword_control_flow = palette.blue_04,
                macro = palette.blue_04,
                type = palette.semantic.class,
                namespace = palette.semantic.class,
                special_char = palette.red_01,
                xml_tag = palette.blue_04,
                xml_delimiter = palette.blue_04,
                todo = palette.semantic.string,
            },
            git = {
                signs = {
                    add = palette.green_01,
                    delete = palette.red_01,
                    change = palette.blue_03,
                },
                status = {
                    ignored = palette.grey_06,
                    untracked = palette.green_01,
                    staged = palette.green_01,
                    deleted = palette.red_01,
                    modified = palette.yellow_01,
                },
                diff = {
                    add = palette.green_01,
                    change = palette.green_01,
                    delete = palette.red_01,
                    text = palette.green_01,
                },
            },
            lsp = {
                diagnostics = {
                    error = palette.red_01,
                    warn = palette.yellow_01,
                    info = palette.blue_04,
                    hint = palette.blue_04,
                    unnecessary = palette.blue_04,
                },
                references = {
                    write = palette.blue_06,
                    read = palette.grey_07,
                    text = palette.grey_07,
                },
                inlay_hint = {
                    bg = background,
                    fg = palette.grey_06,
                },
            },
            neotest = {
                ui = {
                    file = palette.blue_05,
                    namespace = palette.yellow_01,
                    dir = palette.blue_05,
                    adapter = palette.red_01,
                    indent = palette.yellow_01,
                    marker = palette.yellow_01,
                    select = palette.yellow_01,
                    test = palette.grey_07,
                },
                process = {
                    error = palette.red_01,
                    success = palette.green_01,
                    run = palette.yellow_01,
                    skip = palette.blue_05,
                    focus = palette.semantic.string,
                },
            },
        }

        -- Process the theme to ensure all transparent values are properly handled
        return ensure_valid_colors(theme)
    end,
}
