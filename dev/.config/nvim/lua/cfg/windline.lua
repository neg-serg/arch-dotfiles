local status, windline = pcall(require, 'windline')
if (not status) then return end
local helper=require('windline.helpers')
local b_components=require('windline.components.basic')
local cache_utils=require('windline.cache_utils')
local state=_G.WindLine.state
local lsp_comps=require('windline.components.lsp')
local git_comps=require('windline.components.git')

local hl_list={
    Black={'white', 'black'},
    White={'black', 'white'},
    Inactive={'InactiveFg', 'InactiveBg'},
    Active={'ActiveFg', 'ActiveBg'},
}
local basic={}

local breakpoint_width=90
basic.divider={b_components.divider, ''}
basic.bg={' ', 'StatusLine'}

local colors_mode={
    Normal={'base', 'black'},
    Insert={'green', 'black'},
    Visual={'blue', 'black'},
    Replace={'blue_light', 'black'},
    Command={'cyan', 'black'},
}

basic.mode_indicator={
    name='mode_indicator',
    hl_colors=colors_mode,
    text=function() return {{'', state.mode[2]}} end,
}

basic.lsp_diagnos={
    name='diagnostic',
    hl_colors={
        red={'red','black'},
        yellow={'yellow','black'},
        blue={'blue','black'},
    },
    width=breakpoint_width,
    text=function(bufnr)
        if lsp_comps.check_lsp(bufnr) then
            return {
                {lsp_comps.lsp_error({format='  %s', show_zero=false}), 'red'},
                {lsp_comps.lsp_warning({format='  %s', show_zero=false}), 'yellow'},
                {lsp_comps.lsp_hint({format='  %s', show_zero=false}), 'blue'},
            }
        end
        return ''
    end,
}

local function dir_name(default, modify)
    default = default or ''
    modify = modify or 'name'
    return function()
        local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
        if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
            return dir
        else
            return default
        end
    end
end

local function delimiter()
    return function()
        if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
            return ' ¦'
        else
            return ''
        end
    end
end

local function dir_symbol()
    return function()
        if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
            return ''
        else
            return ''
        end
    end
end

local cache_dir_name = function(default, modify)
    return cache_utils.cache_on_buffer('BufEnter', 'WL_filename', dir_name(default, modify))
end
local cache_delimiter = function()
    return cache_utils.cache_on_buffer('BufEnter', 'delimiter', delimiter())
end
local cache_dir_symbol = function()
    return cache_utils.cache_on_buffer('BufEnter', 'dir_symbol', dir_symbol())
end

basic.file = {
    name = 'file',
    hl_colors = {
        default = hl_list.Black,
        white = {'white', 'black'},
        cyan = {'cyan', 'black'},
        blue = {'blue', 'black'},
    },
    text = function(_, _, width)
        if width > breakpoint_width then
            return {
                {cache_dir_symbol(), 'blue'},
                {' ', ''},
                {cache_dir_name(), 'default'},
                {cache_delimiter(), 'blue'},
                {' ', ''},
                {b_components.file_name(''), 'cyan'},
                {b_components.file_modified(' '), 'blue'},
            }
        else
            return {
                {cache_dir_name(), 'cyan'},
                {b_components.cache_file_size(), 'default'},
                {' ', ''},
                {b_components.file_modified(' '), 'blue'},
            }
        end
    end,
}

basic.file_right={
    hl_colors={
        default=hl_list.Black,
        white={'white', 'black'},
        cyan={'cyan', 'black'},
    },
    text=function(_, _, width)
        if width < breakpoint_width then
            return {{b_components.progress_lua, ''}}
        end
    end,
}

basic.git = {
    name='git',
    hl_colors={
        green={'green', 'black'},
        red={'red', 'black'},
        white={'white', 'black'},
        blue={'blue', 'black'},
    },
    width = breakpoint_width,
    text = function(bufnr)
        if git_comps.is_git(bufnr) then
            return {
                {git_comps.diff_added({format='  %s', show_zero=false}), 'green'},
                {git_comps.diff_changed({format=' 柳%s', show_zero=false}), 'white'},
                {git_comps.diff_removed({format='  %s', show_zero=false}), 'red'},
            }
        end
        return ''
    end,
}

local quickfix={
    filetypes={'qf','Trouble'},
    active={
        {'Quickfix ',{'white','black'}},
        {function() return vim.fn.getqflist({title=0}).title end,{'blue','base'}},
        {' Total:%L ',{'base','black'}},
        {' ',{'InactiveFg','black'}},
        {'',{'black','black'}},
    },
    always_active=true,
    show_last_status=true,
}

local explorer={
    filetypes={'fern', 'NvimTree', 'lir'},
    active={
        {'  ', {'black', 'red'}},
        {helper.separators.slant_right, {'red', 'NormalBg'}},
        {b_components.divider, ''},
        {b_components.file_name(''), {'white', 'NormalBg'}},
    },
    always_active=true,
    show_last_status=true,
}

basic.lsp_name={
    width=breakpoint_width,
    name='lsp_name',
    hl_colors={cyan={'cyan', 'black'}},
    text=function(bufnr)
        if lsp_comps.check_lsp(bufnr) then
            return {{lsp_comps.lsp_name(), 'cyan'}}
        end
        return {
            {b_components.cache_file_type({icon=true}), 'cyan'},
        }
    end,
}

local default={
    filetypes={'default'},
    active={
        basic.file,
        basic.lsp_diagnos,
        basic.divider,
        {b_components.cache_file_size(), {'white','black'}},
        {' ', hl_list.Black},
        basic.file_right,
        basic.lsp_name,
        basic.git,
        {git_comps.git_branch({icon='  '}), {'blue', 'black'}, breakpoint_width},
        {' ', hl_list.Black},
        basic.mode_indicator,
    },
    inactive={
        {b_components.full_file_name, hl_list.Inactive},
        basic.divider,
        {b_components.progress, hl_list.Inactive},
    },
}

local telescope={
    filetypes={'TelescopePrompt'},
    active={{'  ',{'white','black'}}},
}

windline.setup({
    colors_name=function(colors)
        colors={
            black='NONE',
            black_light='NONE',
            white='#54667a',
            red='#970d4f',
            green='#007a51',
            blue='#005faf',
            yellow='#c678dd',
            magenta='#c678dd',
            base='#234758',
            blue_light="#517f8d",
            cyan='#6587b3',

            NormalFg="#ff0000",
            NormalBg="#282828",
            InactiveFg='#c6c6c6',
            InactiveBg='#3c3836',
            ActiveFg='#54667a',
            ActiveBg='NONE',
            FileName=colors.cyan,
        }
        return colors
    end,
    statuslines={
        default,
        quickfix,
        explorer,
        telescope,
    },
})
