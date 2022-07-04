local lualine=require('lualine')

local clr={
    base='#234758',
    bg='NONE',
    blue='#005faf',
    fg='#54667a',
    filename='#6587b3',
    green='#007a51',
    magenta='#c678dd',
    rasberry='#970d4f',
}

local conditions={
    buffer_not_empty=function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
    hide_in_width=function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace=function()
        local filepath=vim.fn.expand('%:p:h')
        local gitdir=vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

-- Config
local config={
    options={
        -- Disable sections and component separators
        component_separators='',
        section_separators='',
        theme={
            -- We are going to use lualine_c an lualine_x as left and
            -- right section. Both are highlighted by c theme .  So we
            -- are just setting default looks o statusline
            normal={c={fg=clr.fg, bg=clr.bg}},
            inactive={c={fg=clr.fg, bg=clr.bg}},
       },
   },
    sections={
        -- these are to remove the defaults
        lualine_a={},
        lualine_b={},
        lualine_y={},
        lualine_z={},
        -- These will be filled later
        lualine_c={},
        lualine_x={},
   },
    inactive_sections={
        -- these are to remove the defaults
        lualine_a={},
        lualine_b={},
        lualine_y={},
        lualine_z={},
        lualine_c={},
        lualine_x={},
   },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

ins_left {
    function() return '' end,
    color={fg=clr.base}, -- Sets highlighting of component
    padding={left=0, right=0}, -- We don't need space before this
}

ins_left {
    function() return '' end,
    color={fg=clr.blue}, -- Sets highlighting of component
    padding={left=1, right=0}, -- We don't need space before this
    cond=conditions.buffer_not_empty,
}

ins_left {
    function() return vim.fn.fnamemodify(vim.fn.getcwd(), ':~') end,
    cond=conditions.buffer_not_empty,
}

ins_left {
    function() return '¦' end,
    color={fg=clr.blue}, -- Sets highlighting of component
    padding={left=0, right=0}, -- We don't need space before this
    cond=conditions.buffer_not_empty,
}

ins_left {
    'filename',
    file_status=true,
    path=1,
    shorting_target=40,
    cond=conditions.buffer_not_empty,
    color={fg=clr.filename},
}

ins_left {
    'diagnostics',
    sources={'nvim_diagnostic'},
    symbols={error=' ', warn=' ', info=' '},
    diagnostics_color={
        color_error={fg=clr.rasberry},
        color_warn={fg=clr.fg},
        color_info={fg=clr.blue},
   },
}

ins_left {function() return '%=' end,}

ins_left {
    -- Lsp server name .
    function()
        local msg=''
        local buf_ft=vim.api.nvim_buf_get_option(0, 'filetype')
        local clients=vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes=client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon='',
    color={fg=clr.fg},
}

ins_right {
    'filesize', cond=conditions.buffer_not_empty,
    padding={right=0, left=0}
}

-- Add components to right sections
ins_right {
    function()
        if vim.o.encoding ~= 'utf-8' then
            return vim.o.encoding
        else
            return ''
        end
    end,
    fmt=string.upper, -- I'm not sure why it's upper case either ;)
    cond=function() return conditions.hide_in_width() and conditions.buffer_not_empty() end,
    color={fg=clr.green},
    padding={right=0, left=0}
}

ins_right {
    'fileformat',
    fmt=string.upper,
    icons_enabled=true,
    cond=function() return conditions.hide_in_width() and conditions.buffer_not_empty() end,
    color={fg=clr.green},
}

ins_right {'filetype', padding={left=0, right=1}, color={fg=clr.fg},}

ins_right {'branch', icon='', color={fg=clr.blue},}

ins_right {
    'diff',
    -- Is it me or the symbol for modified us really weird
    symbols={added=' ', modified='柳', removed=' '},
    diff_color={
        added={fg=clr.green},
        modified={fg=clr.fg},
        removed={fg=clr.rasberry},
   },
    cond=conditions.hide_in_width,
}

ins_right {
    'location', padding={left=0, right=1}, color={fg=clr.fg},
    cond=conditions.buffer_not_empty,
}

ins_right {
    function() return '' end,
    color=function()
        -- auto change color according to neovims mode
        local mode_color={
            n=clr.fg,
            i=clr.green,
            v=clr.blue,
            ['']=clr.blue,
            V=clr.blue,
            c=clr.magenta,
            no=clr.rasberry,
            s=clr.fg,
            S=clr.fg,
            ['']=clr.fg,
            ic=clr.fg,
            R=clr.blue,
            Rv=clr.blue,
            cv=clr.rasberry,
            ce=clr.rasberry,
            r=clr.blue,
            rm=clr.blue,
            ['r?']=clr.blue,
            ['!']=clr.rasberry,
            t=clr.rasberry,
        }
        return {fg=mode_color[vim.fn.mode()]}
    end,
    padding={right=0, left=0},
}

ins_right {
    function() return '' end,
    color={fg=clr.base}, -- Sets highlighting of component
    padding={left=1},
}

-- Now don't forget to initialize lualine
lualine.setup(config)
