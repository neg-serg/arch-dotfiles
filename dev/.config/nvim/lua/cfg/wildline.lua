local windline = require('windline')
local helper = require('windline.helpers')
local b_components = require('windline.components.basic')
local cache_utils = require('windline.cache_utils')
local utils = require('windline.utils')
local state = _G.WindLine.state

local lsp_comps = require('windline.components.lsp')
local git_comps = require('windline.components.git')

local fn = vim.fn

local hl_list = {
    Black = {'white', 'black'},
    White = {'black', 'white'},
    Inactive = {'InactiveFg', 'InactiveBg'},
    Active = {'ActiveFg', 'ActiveBg'},
}
local basic = {}

local breakpoint_width = 90
basic.divider = {b_components.divider, ''}
basic.bg = {' ', 'StatusLine'}

local colors_mode = {
    Normal = {'base', 'black'},
    Insert = {'green', 'black'},
    Visual = {'blue', 'black'},
    Replace = {'blue_light', 'black'},
    Command = {'cyan', 'black'},
}

basic.vi_mode = {
    name = 'vi_mode',
    hl_colors = colors_mode,
    text = function()
        return {{' ', state.mode[2]}}
    end,
}

basic.square_mode_left = {
    hl_colors = colors_mode,
    text = function()
        return {{'', state.mode[2]}}
    end,
}

basic.square_mode_right = {
    hl_colors = colors_mode,
    text = function()
        return {{'', state.mode[2]}}
    end,
}

basic.lsp_diagnos = {
    name = 'diagnostic',
    hl_colors = {
        red = {'red', 'black'},
        yellow = {'yellow', 'black'},
        blue = {'blue', 'black'},
    },
    width = breakpoint_width,
    text = function(bufnr)
        if lsp_comps.check_lsp(bufnr) then
            return {
                {lsp_comps.lsp_error({format = '  %s', show_zero = true}), 'red'},
                {lsp_comps.lsp_warning({format = '  %s', show_zero = true}), 'yellow'},
                {lsp_comps.lsp_hint({format = '  %s', show_zero = true}), 'blue'},
            }
        end
        return ''
    end,
}

local function get_buf_name(modify, shorten)
    return function(bufnr)
        local bufname = fn.bufname(bufnr)
        bufname = fn.fnamemodify(bufname, modify)
        if shorten then
            return fn.pathshorten(bufname)
        end
        return bufname
    end
end

local function file_name(default, modify)
    default = default or '[No Name]'
    modify = modify or 'name'
    local fnc_name = get_buf_name(':t')
    if modify == 'unique' then
        fnc_name = utils.get_unique_bufname
    elseif modify == 'full' then
        fnc_name = get_buf_name('%:p', true)
    end
    return function(bufnr)
        local name = fnc_name(bufnr)
        if name == '' then
            name = default
        end
        return name .. ' '
    end
end

local cache_file_name = function(default, modify)
    return cache_utils.cache_on_buffer('BufEnter', 'WL_filename', file_name(default, modify))
end

basic.file = {
    name = 'file',
    hl_colors = {
        default = hl_list.Black,
        white = {'white', 'black'},
        cyan = {'cyan', 'black'},
    },
    text = function(_, _, width)
        if width > breakpoint_width then
            return {
                {' ', ''},
                {cache_file_name(), 'default'},
                {' ', ''},
                {b_components.file_modified(' '), 'cyan'},
                {' ', ''},
                {b_components.cache_file_size(), 'default'},
            }
        else
            return {
                {cache_file_name(), 'default'},
                {' ', ''},
                {b_components.cache_file_size(), 'default'},
                {' ', ''},
                {b_components.file_modified(' '), 'cyan'},
            }
        end
    end,
}

basic.file_right = {
    hl_colors = {
        default = hl_list.Black,
        white = {'white', 'black'},
        cyan = {'cyan', 'black'},
    },
    text = function(_, _, width)
        if width < breakpoint_width then
            return {
                {b_components.progress_lua, ''},
            }
        end
    end,
}

basic.git = {
    name = 'git',
    hl_colors = {
        green = {'green', 'black'},
        red = {'red', 'black'},
        blue = {'blue', 'black'},
   },
    width = breakpoint_width,
    text = function(bufnr)
        if git_comps.is_git(bufnr) then
            return {
                {git_comps.diff_added({format = '  %s', show_zero = true}), 'green'},
                {git_comps.diff_removed({format = '  %s', show_zero = true}), 'red'},
                {git_comps.diff_changed({format = ' 柳%s', show_zero = true}), 'blue'},
           }
        end
        return ''
    end,
}

local quickfix = {
    filetypes = {'qf', 'Trouble'},
    active = {
        {'🚦 Quickfix ', {'white', 'black'}},
        {helper.separators.slant_right, {'black', 'base'}},
        {
            function()
                return vim.fn.getqflist({title = 0}).title
            end,
            {'blue', 'base'},
        },
        {' Total : %L ', {'blue', 'base'}},
        {helper.separators.slant_right, {'base', 'InactiveBg'}},
        {' ', {'InactiveFg', 'InactiveBg'}},
        basic.divider,
        {helper.separators.slant_right, {'InactiveBg', 'black'}},
        {'🧛 ', {'white', 'black'}},
    },

    always_active = true,
    show_last_status = true,
}

local explorer = {
    filetypes = {'fern', 'NvimTree', 'lir'},
    active = {
        {'  ', {'black', 'red'}},
        {helper.separators.slant_right, {'red', 'NormalBg'}},
        {b_components.divider, ''},
        {b_components.file_name(''), {'white', 'NormalBg'}},
    },
    always_active = true,
    show_last_status = true,
}

basic.lsp_name = {
    width = breakpoint_width,
    name = 'lsp_name',
    hl_colors = {
        cyan = {'cyan', 'black'},
    },
    text = function(bufnr)
        if lsp_comps.check_lsp(bufnr) then
            return {{lsp_comps.lsp_name(), 'cyan'}}
        end
        return {
            {b_components.cache_file_type({icon = true}), 'cyan'},
        }
    end,
}

local default = {
    filetypes = {'default'},
    active = {
        basic.square_mode_left,
        basic.file,
        basic.lsp_diagnos,
        basic.divider,
        basic.file_right,
        basic.lsp_name,
        basic.git,
        {git_comps.git_branch(), {'cyan', 'black'}, breakpoint_width},
        {' ', hl_list.Black},
        basic.vi_mode,
        basic.square_mode_right,
    },
    inactive = {
        {b_components.full_file_name, hl_list.Inactive},
        basic.divider,
        {b_components.progress, hl_list.Inactive},
    },
}

local telescope = {
    filetypes = {'TelescopePrompt'},
    active = {
        {'  ', {'white', 'black'} },
    },
    --- for global statusline (laststatus = 3).
    --- by default it skip all floating window on global statusline but you can
    --- change it here
    global_show_float = false
}

windline.setup({
    colors_name = function(colors)
        colors = {
            black = 'NONE',
            black_light = 'NONE',
            white = '#54667a',
            red = '#970d4f',
            green = '#007a51',
            blue = '#005faf',
            yellow = '#c678dd',
            magenta = '#c678dd',
            base = '#234758',
            blue_light = "#517f8d",
            cyan = '#6587b3',

            NormalFg = "#ff0000",
            NormalBg = "#282828",
            InactiveFg = '#c6c6c6',
            InactiveBg = '#3c3836',
            ActiveFg = '#54667a',
            ActiveBg = 'NONE',
            FileName = colors.cyan,
        }

        return colors
    end,
    statuslines = {
        default,
        quickfix,
        explorer,
        telescope,
    },
})
