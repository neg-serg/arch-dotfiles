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
--
function loadrequire(module)
    local function requiref(module)
        require(module)
    end
    res = pcall(requiref,module)
end

loadrequire 'impatient'
loadrequire 'nvim_utils'
loadrequire '00-helpers'
loadrequire '00-settings'
loadrequire 'packer/packer_compiled'
loadrequire '01-plugins'
loadrequire '02-bindings'
loadrequire '04-aucmds'
loadrequire '08-cmds'
loadrequire '14-abbr'
loadrequire '21-lang'
loadrequire '31-statusline'
loadrequire '62-sort-operator'
