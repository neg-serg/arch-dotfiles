local api = vim.api

local M = {}

local getColors = function()
  return {
    ['STNormalFlatMD'] = { guifg= '#32374d', guibg='#1b1e2b'},
    ['STNormalFlatInfo'] = { guifg= '#32374d', guibg='#1b1e2b'},

    ['STNormalMD'] = { guifg= '#ffffff', guibg='#292d3e'},
    ['STVisualMD'] = { guibg = '#89bbdd', guifg = '#292d3e' },
    ['STInsertMD'] = { guibg = '#b9a3eb', guifg='#292d3e' },
    ['STReplaceMD'] = { guibg = '#d0e7d0', guifg='#292d3e' },
    ['STTermMD'] = { guibg = '#959dcb', guifg='#292d3e' },

    ['STNormalInfo'] = { guifg= '#ffffff', guibg='#1b1e2b'},
    ['STVisualInfo'] = { guifg = '#89bbdd', guibg='#1b1e2b' },
    ['STInsertInfo'] = { guifg = '#b9a3eb', guibg='#1b1e2b' },
    ['STReplaceInfo'] = { guifg = '#d0e7d0', guibg='#1b1e2b' },
    ['STTermInfo'] = { guifg = '#959dcb', guibg='#1b1e2b' },
  }
end

local getModes = function()
  return {
    ['n']   = { color = '%#STNormalMD#', val = ' NORMAL ' },
    ['no']  = { color = '%#STNormalMD#', val = ' N-Operator Pending ' },

    ['v']   = { color = '%#STVisualMD#', val = ' VISUAL ' },
    ['V']   = { color = '%#STVisualMD#', val = ' V-LINE ' },
    ['\22'] = { color = '%#STVisualMD#', val = ' V-BLOCK ' },

    ['i']   = { color = '%#STInsertMD#', val = ' INSERT ' },
    ['ic']  = { color = '%#STInsertMD#', val = ' INSERT ' },
    ['ix']  = { color = '%#STInsertMD#', val = ' INSERT ' },

    ['R']   = { color = '%#STReplaceMD#', val = ' REPLACE ' },
    ['Rv']  = { color = '%#STReplaceMD#', val = ' V-REPLACE ' },

    ['t']   = { color = '%#STTermMD#', val = ' TERMINAL ' },

    ['s']   = { color = '%#STNormalFlatMD#', val = ' SELECT ' },
    ['S']   = { color = '%#STNormalFlatMD#', val = ' S-LINE ' },
    ['^S']  = { color = '%#STNormalFlatMD#', val = ' S-BLOCK ' },
    ['c']   = { color = '%#STNormalFlatMD#', val = ' COMMAND ' },
    ['cv']  = { color = '%#STNormalFlatMD#', val = ' VIM EX ' },
    ['ce']  = { color = '%#STNormalFlatMD#', val = ' EX ' },
    ['r']   = { color = '%#STNormalFlatMD#', val = ' PROMPT ' },
    ['rm']  = { color = '%#STNormalFlatMD#', val = ' MORE ' },
    ['r?']  = { color = '%#STNormalFlatMD#', val = ' CONFIRM ' },
    ['!']   = { color = '%#STNormalFlatMD#', val = ' SHELL ' },
  }
end

local function get_mode()
  local mode = api.nvim_get_mode().mode
  return getModes()[mode] or { val = 'Unknown mode: ', color = '%#CursorLine#' }
end

local branch = vim.fn.system('git rev-parse --abbrev-ref HEAD'):sub(0, -2)
local is_git = branch:match('fatal') == nil

function M.update_git()
  branch = vim.fn.system('git rev-parse --abbrev-ref HEAD'):sub(0, -2)
  is_git = branch:match('fatal') == nil
end

local function get_git()
  return is_git and branch..' |' or ''
end

local function get_infos(bufnr)
  local ft = api.nvim_buf_get_option(bufnr, 'ft')
  if ft ~= '' then ft = ' '..ft..' |' end

  local _, row, col = unpack(vim.fn.getpos('.'))
  local num_lines = #api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local percent = string.format('%d', row / num_lines * 100) .. '%%'

  return string.format('%s %s:%s | %s | %s ', ft, row, col, percent, num_lines)
end

local function get_filename(bufnr)
  local fname = api.nvim_buf_get_name(bufnr)
  if #fname == 0 then
    return '[NO NAME]'
  end

  return vim.fn.fnamemodify(fname, ':~')
end

function M.clear()
  local width = api.nvim_win_get_width(0)
  local dashes = string.rep('―', width)
  vim.wo.statusline = '%#VertSplit#'..dashes
end

local function format_status(mode, filename, git, infos)
  local left_side = mode.color..mode.val..'%#Normal# '..filename
  local right_side =mode.color:gsub('MD', 'Info')..git..infos..'%#Normal#'
  local total_size = api.nvim_win_get_width(0)

  local padding = ' '
  padding = padding:rep(total_size - (#mode.val + #filename + #git + #infos + 1))

  return left_side..padding..right_side
end

function M.update()
  local bufnr = api.nvim_get_current_buf()
  if api.nvim_buf_get_option(bufnr, 'ft') == 'LuaTree' then return ' ' end

  local mode = get_mode()
  local filename = get_filename(bufnr)
  local git = get_git()
  local infos = get_infos(bufnr)

  local formatted_status = format_status(mode, filename, git, infos)

  return formatted_status
end

function M.setup()
  local func = [[
  function! Status()
    return luaeval("require 'statusline'.update()")
  endfunction

  augroup StatusLine
    au!
    au TabEnter,WinLeave,BufEnter,WinEnter,VimEnter * lua require'statusline'.clear()
    au BufEnter,VimEnter * setlocal statusline=%!Status()
    au DirChanged * lua require'statusline'.update_git()
  augroup END
  ]]
  api.nvim_exec(func, '')

  for name, c in pairs(getColors()) do
    api.nvim_exec('hi def '..name..' gui=NONE guifg='..c.guifg..' guibg='..c.guibg, '')
  end
end

return M
