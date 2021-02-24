------------------------------------------------------------------------
--                        Mode Prompts                                --
------------------------------------------------------------------------
local M = {}
-- Mode Prompt Table
M.current_mode = setmetatable({
      ['n'] = 'N',
      ['no'] = 'N·Operator Pending',
      ['v'] = 'V',
      ['V'] = 'V',
      ['^V'] = 'V',
      ['s'] = 'Select',
      ['S'] = 'S·Line',
      ['^S'] = 'S·Block',
      ['i'] = 'I',
      ['ic'] = 'I',
      ['ix'] = 'I',
      ['R'] = 'Replace',
      ['Rv'] = 'V·Replace',
      ['c'] = 'C',
      ['cv'] = 'Vim Ex',
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
return M
