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


--[[ function M.Path()
    if !empty(expand('%:t'))
        let fn = winwidth(0) <# 55
                    \ ? '../'
                    \ : winwidth(0) ># 85
                    \ ? expand('%:~:.:h') . '/'
                    \ : pathshorten(expand('%:~:.:h')) . '/'
    else
        let fn = ''
    end
    return fn
end ]]

--[[ fun! SL_jobs()
    let n_jobs = exists('g:jobs') ? len(g:jobs) : 0
    return winwidth(0) <# 55 ? '' : n_jobs ? ' ' . n_jobs : ''
end

--[[ fun! SL_format_and_encoding()
    let encoding = winwidth(0) <# 55 ? '' : strlen(&fenc) ? &fenc : &enc
    let format = winwidth(0) ># 85 ? &fileformat : winwidth(0) <# 55 ? '' : &fileformat[0]
    return printf('%s[%s]', encoding, format)
endfun

fun! SL_filetype() abort
    return strlen(&filetype) ? &filetype : ''
endfun

fun! SL_column_and_percent() abort
    " The percent part was inspired by vim-line-no-indicator plugin.
    let chars = ['꜒', '꜓', '꜔', '꜕', '꜖',]
    let [c_l, l_l] = [line('.'), line('$')]
    let index = float2nr(ceil((c_l * len(chars) * 1.0) / l_l)) - 1
    let perc = chars[index]
    return winwidth(0) ># 55 ? printf('%s%2d', perc, col('.')) : ''
endfun
]]

--[[
function! s:file_is_modified() abort
  return spaceline#utils#line_is_lean() || spaceline#utils#line_is_plain() ?  ''  :
  \      &modified                                       ?  ' ' :
  \      &modifiable                                     ?  ''  : ' -'
endfunction

function! s:line_percent()
  let byte = line2byte( line( "." ) ) + col( "." ) - 1
  let size = (line2byte( line( "$" ) + 1 ) - 1)
  return (byte * 100) / size .'% '
endfunction

function! spaceline#scrollbar#scrollbar_instance() abort
  " Zero index line number so 1/3 = 0, 2/3 = 0.5, and 3/3 = 1
  let l:current_line = line('.') - 1
  let l:total_lines = line('$') - 1

  if l:current_line == 0
    let l:index = 0
  elseif l:current_line == l:total_lines
    let l:index = -1
  else
    let l:line_no_fraction = floor(l:current_line) / floor(l:total_lines)
    let l:index = float2nr(l:line_no_fraction * len(g:spaceline_scroll_bar_chars))
  endif

  return g:spaceline_scroll_bar_chars[l:index]
endfunction

function! s:file_readonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! s:size(f) abort
    let l:size = getfsize(expand(a:f))
  if l:size == 0 || l:size == -1 || l:size == -2
    return ''
  endif
  if l:size < 1024
    let size = l:size.'b'
  elseif l:size < 1024*1024
    let size = printf('%.1f', l:size/1024.0).'k'
  elseif l:size < 1024*1024*1024
    let size = printf('%.1f', l:size/1024.0/1024.0) . 'm'
  else
    let size = printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'g'
  endif
  return size
endfunction

--]]

function M.activeLine()
  local statusline = ""
  statusline = statusline..'%#Base#   '
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
