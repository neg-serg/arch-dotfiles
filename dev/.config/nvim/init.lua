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
local present, impatient = pcall(require, "impatient")
if present then
   impatient.enable_profile()
end
