-- Usage:
--
--     sa DELIMITER
--     sc DELIMITER1 DELIMITER2
--     sd DELIMITER

require('vis')
local vis = vis

local M

local builtins = {
	["["] = { "[" , "]" , id =  7 },  -- +/VIS_TEXTOBJECT_OUTER_SQUARE_BRACKET vis.h
	["{"] = { "{" , "}" , id =  9 },  -- +/VIS_TEXTOBJECT_OUTER_CURLY_BRACKET vis.h
	["<"] = { "<" , ">" , id = 11 },  -- +/VIS_TEXTOBJECT_OUTER_ANGLE_BRACKET vis.h
	["("] = { "(" , ")" , id = 13 },  -- +/VIS_TEXTOBJECT_OUTER_PARENTHESIS vis.h
	['"'] = { '"' , '"' , id = 15 },  -- +/VIS_TEXTOBJECT_OUTER_QUOTE vis.h
	["'"] = { "'" , "'" , id = 17 },  -- +/VIS_TEXTOBJECT_OUTER_SINGLE_QUOTE vis.h
	["`"] = { "`" , "`" , id = 19 },  -- +/VIS_TEXTOBJECT_OUTER_BACKTICK vis.h
}

local aliases = {}
for _, data in pairs(builtins) do aliases[data[2]] = data[1] ~= data[2] and data or nil end
for key, data in pairs(aliases) do builtins[key] = data end

for key, data in pairs( {
	["{"] = "B",
	["("] = "b",
} ) do builtins[data] = builtins[key] end

local function get_pair(key) return builtins[key] end

local function add(file, range, pos)
	local d = get_pair(M.key[1])
	-- XXX: How do I tell apart non-existing textobjects from empty ones, like inner <>
	if not (d and range.finish > range.start) then return pos end
	file:insert(range.finish, d[2])
	file:insert(range.start, d[1])
	return pos + #d[1]
end

local function change(file, range, pos)
	local o = get_pair(M.key[1])
	local n = get_pair(M.key[2])
	if not (o and n
		and range.finish > range.start
		and file:content(range.start, #o[1]):find(o[1], 1, true)
		and file:content(range.finish - #o[2], #o[2]):find(o[2], 1, true)) then
		return pos
	end
	file:delete(range.finish - #o[2], #o[2])
	file:insert(range.finish - #o[2], n[2])
	file:delete(range.start, #o[1])
	file:insert(range.start, n[1])
	return pos - #o[1] + #n[1]
end

local function delete(file, range, pos)
	local d = get_pair(M.key[1])
	if not (d
		and range.finish > range.start
		and file:content(range.start, #d[1]):find(d[1], 1, true)
		and file:content(range.finish - #d[2], #d[2]):find(d[2], 1, true)) then
		return pos
	end
	file:delete(range.finish - #d[2], #d[2])
	file:delete(range.start, #d[1])
	return pos - #d[1]
end

local function outer(key) return builtins[key].id end

local function va_call(handler, nargs, execute_textobject)
	return function(keys)
		if #keys < nargs then return -1 end
		if #keys == nargs then
			M.key = {}
			for key in keys:gmatch(".") do table.insert(M.key, key) end
			vis:operator(handler)
			if execute_textobject then
				vis:textobject(outer(M.key[1]))
			end
		end
		return #keys
	end
end

local function operator_new(key, operator, nargs, help)
	local id = vis:operator_register(operator)
	if id < 0 then
		return false
	end
	if key then
		local execute_textobject = operator == change or operator == delete
		vis:map(vis.modes.NORMAL, key, va_call(id, nargs, execute_textobject), help)
		vis:map(vis.modes.VISUAL, key, va_call(id, nargs), help)
	end
	return id
end

vis.events.subscribe(vis.events.INIT, function()
	M.operator = {
		add = operator_new(M.map.add, add, 1, "Add delimiters at range boundaries"),
		change = operator_new(M.map.change, change, 2, "Change delimiters at range boundaries"),
		delete = operator_new(M.map.delete, delete, 1, "Delete delimiters at range boundaries"),
	}
	if vis:module_exist('textobject-surround') then
		local t = require('textobject-surround')
		get_pair = t.get_pair
		outer = function(key) t.key = key return t.textobject.outer end
	end
end)

M = {
	map = {add = "sa", change = "sc", delete = "sd"},
}

return M
