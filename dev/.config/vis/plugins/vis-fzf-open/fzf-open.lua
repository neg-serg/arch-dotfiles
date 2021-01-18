-- Copyright (C) 2017  Guillaume Chérel
-- 
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as
-- published by the Free Software Foundation, either version 3 of the
-- License, or (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details.
-- 
-- You should have received a copy of the GNU Affero General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

module = {}
module.fzf_path = "fzf"
module.fzf_args = ""

vis:command_register("fzf", function(argv, force, win, selection, range)
    local command = module.fzf_path .. " " .. module.fzf_args .. " " .. table.concat(argv, " ")

    local file = io.popen(command)
    local output = file:read()
    local success, msg, status = file:close()

    if status == 0 then 
        -- vis:command(string.format("e '%s'", output))
        vis:feedkeys(string.format(":e '%s'", output))
    elseif status == 1 then
        vis:info(string.format("fzf-open: No match. Command %s exited with return value %i." , command, status))
    elseif status == 2 then
        vis:info(string.format("fzf-open: Error. Command %s exited with return value %i." , command, status))
    elseif status == 130 then
        vis:info(string.format("fzf-open: Interrupted. Command %s exited with return value %i" , command, status))
    else
        vis:info(string.format("fzf-open: Unknown exit status %i. command %s exited with return value %i" , status, command, status, status))
    end

    vis:feedkeys("<vis-redraw>")

    return true;
end)

return module
