local hi = vim.api.nvim_set_hl

hi(0, 'Base', {bg='NONE', fg='#234758'})
hi(0, 'Decoration', {bg='NONE', fg='NONE'})
hi(0, 'Filetype', {bg='NONE', fg='#007fb5'})
hi(0, 'Git', {bg='NONE', fg='#005faf'})
hi(0, 'StatusDelimiter', {bg='NONE', fg='#326e8c'})
hi(0, 'StatusLine', {fg=black, bg='NONE'})
hi(0, 'StatusRight', {bg='NONE', fg='#6c7e96'})
hi(0, 'Mode', {bg='NONE', fg='#007fb5'})

N = {}

function N.FancyMode()
    local modes = {}
    local current_mode = api.nvim_get_mode()['mode']
    modes.current_mode = setmetatable({
        ['n'] = 'N',
        ['no'] = 'N·Operator Pending',
        ['v'] = 'V',
        ['V']  = 'V·Line',
        ['^V'] = 'V·Block',
        ['s'] = 'Select',
        ['S'] = 'S·Line',
        ['^S'] = 'S·Block',
        ['i'] = 'I',
        ['ic'] = 'I',
        ['ix'] = 'I',
        ['R'] = 'Replace',
        ['Rv'] = 'V·Replace',
        ['c'] = 'CMD',
        ['cv'] = 'VimEx',
        ['ce'] = 'Ex',
        ['r'] = 'Prompt',
        ['rm'] = 'More',
        ['r?'] = 'Confirm',
        ['!'] = 'Shell',
        ['t'] = 'T'
    }, {
        -- fix weird issues
        __index = function(_, _)
            return 'V·Block'
        end
    })
    return modes.current_mode[current_mode]
end

function N.FizeSize()
    local file = vim.fn.expand('%:p')
    if string.len(file) == 0 then return '' end
    return format_file_size_(file)
end

function NegJobs()
    local n_jobs = 0
    if vim.fn.exists('g:jobs') then
        n_jobs = ' ' .. #vim.api.nvim_get_option('jobs')
    end
    if n_jobs ~= 0 then
        return n_jobs
    else
        return ''
    end
end

local conditions = {
    buffer_not_empty = function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
    hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end
}

function format_file_size_(file)
    local size = vim.fn.getfsize(file)
    if size <= 0 then return '' end
    local sufixes = {'b','k','m','g'}
    local i = 1
    while size > 1024 do
        size = size / 1024
        i = i + 1
    end
    return string.format('%.1f%s', size, sufixes[i])
end

function hex_pos(statusline)
    local line = vim.api.nvim_call_function('line', {"."})
    line = string.format("%X", tostring(line))
    local col = vim.api.nvim_call_function('col', {"."})
    local delimiter = '%#StatusDelimiter# • %#StatusRight#'
    col = delimiter  .. string.format("%X", tostring(col))
    return statusline ..  line .. col
end

function N.StatusLinePWD()
    if vim.fn.exists('b:statusline_pwd') then
        vim.api.nvim_buf_set_var(
            0,
            'statusline_pwd',
            vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
        )
        local statusline_pwd = vim.api.nvim_buf_get_var(0, 'statusline_pwd')
        if statusline_pwd ~= '~/' then
            if #statusline_pwd <= 15 then
                statusline_pwd = vim.fn.pathshorten(statusline_pwd)
            end
            return statusline_pwd
        else
            return ''
        end
    end
    return vim.api.nvim_buf_get_var(0, 'statusline_pwd')
end

function N.CheckMod()
    if vim.api.nvim_buf_get_option(0, 'modified') == true then
        hi(0, 'Modi', {bg='NONE', fg='#8fa7c7'})
        hi(0, 'Filename', {bg='NONE', fg='#8fa7c7'})
        return '  '
    else
        hi(0, 'Modi', {bg='NONE', fg='#6587b3'})
        hi(0, 'Filename', {bg='NONE', fg='#8fa7c7'})
        return ''
    end
end

function N.StatusLineFileName()
    local name = vim.fn.expand('%:~:.')
    name = vim.fn.simplify(name)
    ratio = vim.fn.winwidth(0) / #name
    if ratio <= 2 and ratio > 1 then
        name = vim.fn.pathshorten(name)
    elseif ratio <= 1 then
        name = vim.fn.fnamemodify(name, ':t')
    end
    return name
end

function N.FormatAndEncoding()
    return printf('%s | %s', encoding, format)
end

function N.VisualSelectionSize()
    if vim.fn.mode():byte() == 22 then
        return (vim.fn.abs(vim.fn.line('v') - vim.fn.line('.')) + 1)
            .. 'x'
            .. (vim.fn.abs(vim.fn.virtcol('v') - vim.fn.virtcol('.')) + 1)
            .. ' block '
    elseif vim.fn.mode() == 'V' or (vim.fn.line('v') ~= vim.fn.line('.')) then
        return (vim.fn.abs(vim.fn.line('v') - vim.fn.line('.')) + 1)
            .. ' lines '
    else
        return ''
    end
end

function N.GitBranch(git)
    if git == '' then
        return ''
    else
        return ' ' .. git
    end
end

function N.activeLine()
    local statusline = ""
    statusline = statusline
        .. '%#Base# '
        .. N.VisualSelectionSize()
    local pwd = N.StatusLinePWD()
    if pwd ~= '' then
        statusline = statusline .. '%#Git# %#String#' .. pwd
    end
    filename = N.StatusLineFileName():gsub("/", "%%#Base#/%%#Modi#")
    if filename ~= '' then
        statusline = statusline .. '%#Git# ¦ %#Modi#'
    end
    statusline = statusline .. filename
        .. '%#Modi#' .. N.CheckMod()
    if vim.api.nvim_get_option('readonly') then
        statusline = statusline .. ''
    end
    statusline = statusline
        .. '%#Decoration# %3* %= '
        .. '%#Filetype#'
        .. '%3*'
        .. '%#StatusDelimiter#'
        .. '%#String#' .. N.FizeSize() .. '%#Modi#'
    if vim.api.nvim_get_option('modifiable') then
        if vim.api.nvim_get_option('expandtab') then
            statusline = statusline ..  '  '
        else
            statusline = statusline ..  '   '
        end
    end
    statusline = statusline
        .. vim.api.nvim_buf_get_option(0, 'shiftwidth') .. '%#Git# '
    if vim.b.gitsigns_head then
        statusline = statusline .. N.GitBranch(vim.b.gitsigns_head .. vim.b.gitsigns_status)
    end
    statusline = statusline .. '%1* %#Base#'
    return statusline
end

function N.inActiveLine()
    local statusline = ""
    statusline = statusline .. '%#Statement# '
    local pwd = N.StatusLinePWD()
    if pwd ~= '' then
        statusline = statusline .. '%#String# ' .. pwd
    end
    filename = N.StatusLineFileName()
    if filename ~= '' then
        statusline = statusline .. '%#String# ¦ '
        statusline = statusline .. filename
    end
    statusline = statusline .. '%= %#Statement#'
    return statusline
end

_G.NegStatusline = setmetatable(N, {
    __call = function(statusline, mode)
        if mode == "active" then return N.activeLine() end
        if mode == "inactive" then return N.inActiveLine() end
    end
})

return N
