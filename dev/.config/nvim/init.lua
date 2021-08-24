--              *
--         *                *
--         _..._      *
--       .'     '.      _
--   *  /    .-""-\   _/ \
--    .-|   /:.   |  |   |
--    |  \  |:.   /.-'-./
--    | .-'-;:__.'    =/
--    .'=  *=|NVIM _.='
--   /   _.  |    ;
--  ;-.-'|    \   |     *
--  |  | \    _\  _\
--  |_/'._;.  ==' ==\     *
--          \    \   |
--          /    /   / *
--    *     /-._/-._/
--        * \   `\  \
--           `-._/._/
require '00-helpers'
require '00-settings'
require '01-plugins'
_, nvim_utils = pcall(require, "nvim_utils")
require '02-bindings'
require '04-aucmds'
require '08-cmds'
require '14-abbr'
require '21-lang'
require '31-statusline'
require '62-sort-operator'
require('auto-session').setup({
    log_level = 'error',
    auto_session_enable_last_session = true,
    auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
    auto_session_enabled = true,
    auto_save_enabled = nil,
    auto_restore_enabled = nil,
    auto_session_suppress_dirs = nil
})
