local languages = require "configs.translate.languages";
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local conf = require('telescope.config').values

return function()

  -- This active_buf and active selection because telescope clears everything (i think)
  local active_buf = vim.api.nvim_get_current_buf();
  local mode = vim.api.nvim_get_mode().mode;
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'x!', true)
  local start_mark = vim.api.nvim_buf_get_mark(active_buf, "<")
  local end_mark = vim.api.nvim_buf_get_mark(active_buf, ">")

  pickers
      .new({}, {
        prompt_title = 'Translate',
        finder = finders.new_table {
          results = languages,
          entry_maker = function(entry)
            return {
              value = entry[2],
              ordinal = entry[1] .. " " .. entry[2],
              display = entry[3] .. entry[1],
            }
          end,
        },
        sorter = conf.generic_sorter {},
        attach_mappings = function(prompt_bufnr)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)

            local selection = action_state.get_selected_entry()

            vim.api.nvim_set_current_buf(active_buf)

            vim.api.nvim_win_set_cursor(0, start_mark);
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(mode, true, false, true), 'x!', true)
            vim.api.nvim_win_set_cursor(0, end_mark);

            local timer = vim.loop.new_timer()
            timer:start(500, 0, vim.schedule_wrap(function()
              if mode == "v" or mode == "V" then
                vim.cmd("'<,'>Translate " .. selection.value)
              else
                vim.cmd("Translate " .. selection.value)
              end
            end))
          end)
          return true
        end,
        previewer = nil
      })
      :find()

end
