local api = vim.api
local cmd = api.nvim_command
local call = vim.call
local func = api.nvim_call_function

local bufmod = require 'sections.bufmodified'
local bufname = require 'sections.bufname'
local buficon = require 'sections.buficon'
local editable = require 'sections.bufeditable'
local filesize = require 'sections.filesize'

cmd('hi Base guibg=NONE guifg=#234758')
cmd('hi Decoration guibg=NONE guifg=NONE')
cmd('hi Filetype guibg=NONE guifg=#007fb5')
cmd('hi Git guibg=NONE guifg=#005faf')
cmd('hi StatusDelimiter guibg=NONE guifg=#326e8c')
cmd('hi StatusLine guifg=black guibg=NONE')
cmd('hi StatusLineNC guifg=black guibg=cyan')
cmd('hi StatusRight guibg=NONE guifg=#6c7e96')
cmd('hi Mode guibg=NONE guifg=#007fb5')
cmd('set noruler') --disable line numbers in bottom right for our custom indicator as above

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
      }
  )
  return modes.current_mode[current_mode]
end

function N.FizeSize()
  local file = vim.fn.expand('%:p')
  if string.len(file) == 0 then return '' end
  return format_file_size_(file)
end

_G.NegStatusline = setmetatable(N, {
  __call = function(statusline, mode)
    if mode == "active" then return N.activeLine() end
    if mode == "inactive" then return N.inActiveLine() end
  end
})

function N.StatusErrors()
    if not vim.fn.exists(':ALE*') then
        return ''
    end
    local s = ''
    local ale = vim.fn['ale#statusline#Count'](vim.fn.bufnr('%'))
    if ale['error'] > 0 then
        s = s .. '●' .. ale['error']
    end
    if ale['warning'] > 0 then
        s = s .. '' .. ale['error']
    end
    if not (s == nil or s == '') then
        return s
    end
    return ''
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
  local line = api.nvim_call_function('line', {"."})
  line = string.format("%X", tostring(line))
  local col = api.nvim_call_function('col', {"."})
  local delimiter = '%#StatusDelimiter#•%#StatusRight#'
  col = delimiter  .. string.format("%X", tostring(col))
  return statusline ..  line .. col
end

function N.StatusLinePWD()
    if vim.fn.exists('b:statusline_pwd') then
        vim.api.nvim_buf_set_var(0, 'statusline_pwd', vim.fn.fnamemodify(vim.fn.getcwd(), ':~'))
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

function N.CheckMod(modi)
    if modi == 1 then
        cmd('hi Modi guifg=#8fa7c7 guibg=NONE')
        cmd('hi Filename guifg=#8fa7c7 guibg=NONE')
        return N.StatusLineFileName() .. '  '
    else
        cmd('hi Modi guifg=#6587b3 guibg=NONE')
        cmd('hi Filename guifg=#8fa7c7 guibg=NONE')
        return N.StatusLineFileName()
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

function N.CocStatus()
  if vim.fn.exists('g:coc_status') == 0 then
    return ''
  end
  local status = vim.api.nvim_get_var('coc_status')
  local words = {}
  words[1], words[2] = status:match("(%w+)(.+)")
  local first_word = words[1]
  -- Replace the long strings by some fancy characters
  if first_word == 'Python' then
    return ''
  elseif first_word == 'TSC' then
    return ''
  end
  return status
end

function N.ReadPercent()
    -- The percent part was inspired by vim-line-no-indicator plugin.
    local chars = {'▁', '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█'}
    local c_l = vim.fn.line('.')
    local l_l = vim.fn.line('$')
    local index = math.floor(math.ceil((c_l * #chars * 1.0) / l_l)) - 1
    return chars[index]
end

function N.VisualSelectionSize()
  if vim.fn.mode():byte() == 22 then
      return (vim.fn.abs(vim.fn.line('v') - vim.fn.line('.')) + 1) .. 'x' .. (vim.fn.abs(vim.fn.virtcol('v') - vim.fn.virtcol('.')) + 1) .. ' block'
  elseif vim.fn.mode() == 'V' or (vim.fn.line('v') ~= vim.fn.line('.')) then
      return (vim.fn.abs(vim.fn.line('v') - vim.fn.line('.')) + 1) .. ' lines'
  else
    return ''
  end
end

function N.GitBranch(git)
    if git == '' then
        return ''
    else
        return ' ' .. git .. ' '
    end
end

function N.activeLine()
  local statusline = ""
  statusline = statusline
    .. '%#Base#   '
    .. '%{v:lua.N.VisualSelectionSize()}'
    .. '%#StatusDelimiter#❯>'
    .. '%#Modi# %{v:lua.N.CheckMod(&modified)} %{v:lua.N.FizeSize()}'
    .. "%#Modi# %{&readonly?' ':''}"
    .. '%(%{v:lua.N.StatusErrors()}%)%*'
    .. "%#Git# %{get(g:,'coc_git_status','')}"
    .. '%#Decoration# '
    .. '%3* '
    .. '%= '
    .. '%#Decoration# '
    .. '%#StatusRight#  %{v:lua.N.StatusLinePWD()}'
    .. '%3*'
    .. '%#StatusDelimiter#'
    .. "%{&modifiable?(&expandtab?'   ':'    ').&shiftwidth:''}"
    .. '%(%{v:lua.N.CocStatus()}%)'
    .. '%1*'
    .. '%#StatusDelimiter# '
    .. '%#Mode#%{v:lua.N.FancyMode()}'
    .. ' %#StatusRight#%2p%%'
  return statusline
end

function N.inActiveLine()
  return '%#Base# %#Filename# %.20%F'
end

return N
