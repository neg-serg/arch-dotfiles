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

vim.cmd "silent! command PackerClean lua require 'plugins' require('packer').clean()"
vim.cmd "silent! command PackerCompile lua require 'plugins' require('packer').compile()"
vim.cmd "silent! command PackerInstall lua require 'plugins' require('packer').install()"
vim.cmd "silent! command PackerStatus lua require 'plugins' require('packer').status()"
vim.cmd "silent! command PackerSync lua require 'plugins' require('packer').sync()"
vim.cmd "silent! command PackerUpdate lua require 'plugins' require('packer').update()"

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
