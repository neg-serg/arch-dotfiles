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

local M = {}
function M.FancyMode()
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

local conditions = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
  hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end
}

local function format_file_size(file)
  local size = vim.fn.getfsize(file)
  if size <= 0 then return '' end
  local sufixes = {'b', 'k', 'm', 'g'}
  local i = 1
  while size > 1024 do
    size = size / 1024
    i = i + 1
  end
  return string.format('%.1f%s', size, sufixes[i])
  --local file = vim.fn.expand('%:p')
  --if string.len(file) == 0 then return '' end
  --return format_file_size(file)
end

function M.activeLine()
  local statusline = ""
  statusline = statusline .. '%#Base#   '
  statusline = statusline .. '%{VisualSelectionSize()}'
  statusline = statusline .. '%#StatusDelimiter#❯>'
  statusline = statusline .. '%#Modi# %{CheckMod(&modified)}'
  statusline = statusline .. "%#Modi# %{&readonly?' ':''}"
  statusline = statusline .. '%(%{StatusErrors()}%)%*'
  statusline = statusline .. "%#Git# %{get(g:,'coc_git_status','')}"
  statusline = statusline .. '%#Decoration# '
  statusline = statusline .. '%3* '
  statusline = statusline .. '%= '
  statusline = statusline .. '%#Decoration# '
  statusline = statusline .. '%#StatusRight#  %{StatusLinePWD()}'
  statusline = statusline .. '%3*'
  statusline = statusline .. '%#StatusDelimiter#'
  statusline = statusline .. "%{&modifiable?(&expandtab?'   ':'    ').&shiftwidth:''}"
  statusline = statusline .. '%(%{NegJobs()}%)'
  statusline = statusline .. '%(%{CocStatus()}%)'
  statusline = statusline .. "%#StatusDelimiter# "
  statusline = statusline .. '%1*'
  statusline = statusline .. '%#StatusRight#%02l%#StatusDelimiter#/%#StatusRight#%02v'
  statusline = statusline .. '%#StatusDelimiter# '
  statusline = statusline .. '%#Mode#%{FancyMode()}'
  statusline = statusline .. ' %#StatusRight#%2p%%'
  return statusline
end

function M.inActiveLine()
  return '%#Base# %#Filename# %.20%F'
end
return M
