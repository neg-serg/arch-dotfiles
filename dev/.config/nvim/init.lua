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

local present, impatient = pcall(require, "impatient")
if present then
   impatient.enable_profile()
end

loadrequire 'nvim_utils'
loadrequire '00-helpers'
loadrequire '00-settings'
loadrequire 'packer_compiled'
loadrequire '01-plugins'
loadrequire '02-bindings'
loadrequire '04-aucmds'
loadrequire '08-cmds'
loadrequire '14-abbr'
loadrequire '21-lang'
loadrequire '31-statusline'
loadrequire '62-sort-operator'
