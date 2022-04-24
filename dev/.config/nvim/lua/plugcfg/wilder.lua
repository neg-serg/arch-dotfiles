local wilder = require('wilder')
wilder.setup(
    { modes = {':'}, },
    { enable_cmdline_enter = 0, }
)

wilder.set_option('use_python_remote_plugin', 0)

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline({
      fuzzy = 2,
    }),
    wilder.python_file_finder_pipeline({
        file_command = {'fd', '-tf'},
        dir_command = {'fd', '-td'},
        filters = {'fuzzy_filter', 'difflib_sorter'},
    }),
    wilder.vim_search_pipeline()
  )
})

vim.cmd[[
call wilder#setup({
      \ 'modes': [':'],
      \ 'next_key': '<C-e>',
      \ 'previous_key': '<S-Tab>',
      \ 'accept_key': '<Tab>',
      \ })
call wilder#set_option('noselect', 0)
]]

-- wilder.set_option('pipeline', {
--   wilder.branch(
--    -- wilder.python_search_pipeline({
--    --   pattern = wilder.python_fuzzy_pattern(),
--    --   sorter = wilder.python_difflib_sorter(),
--    --   -- can be set to 're2' for performance, requires pyre2 to be installed
--    --   -- see :h wilder#python_search() for more details
--    --   engine = 're',
--    -- })
--  ),
-- })
