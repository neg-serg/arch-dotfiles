local surroundings = {
    { '{', '}' },
    { '[', ']' },
    { '(', ')' },
    '"',
    '\'',
    '`',
    '´'
}

local function left(a)
    for _,i in pairs(surroundings) do
        if type(i) == 'table' then
            if i[1] == a then
                return a
            elseif i[2] == a then
                return i[1]
            end
        else
            if i == a then return a end
        end
    end
end

local function right(a)
    for _,i in pairs(surroundings) do
        if type(i) == 'table' then
            if i[1] == a then
                return i[2]
            elseif i[2] == a then
                return a
            end
        else
            if i == a then return a end
        end
    end
end

-- escape all magic characters with a '%'
local function esc(str)
    if not str then return "" end
    return (str:gsub('%%', '%%%%')
        :gsub('^%^', '%%^')
        :gsub('%$$', '%%$')
        :gsub('%(', '%%(')
        :gsub('%)', '%%)')
        :gsub('%.', '%%.')
        :gsub('%[', '%%[')
        :gsub('%]', '%%]')
        :gsub('%*', '%%*')
        :gsub('%+', '%%+')
        :gsub('%-', '%%-')
        :gsub('%?', '%%?'))
end

local function find_surrounding(file, pos, left, right)
    local left_data = file:content(0, pos)
    local right_data = file:content(pos+1, file.size)
    local left_idx = left_data:match('^.*()'..esc(left))
    local right_idx = right_data:match('^[^'..esc(right)..']*()')
    if left_idx and right_idx then
        return (left_idx - 1), (pos + right_idx)
    else
        return nil
    end
end

local function find_surrounding_tags(file, pos, tag)
    local left_data = file:content(0, pos)
    local right_data = file:content(pos+1, file.size)
    local l1, l2 = left_data:match('^.*()<'..esc(tag)..'>()')
    local r1, r2 = right_data:match('()</'..esc(tag)..'>()')
    if l1 then l1 = l1-1 end
    if l2 then l2 = l2-1 end
    if r1 then r1 = pos+r1-1 end
    if r2 then r2 = pos+r2-1 end
    return l1, l2, r1, r2
end

local function change_surrounding(keys)
    if #keys < 2 then
        return -1
    elseif #keys == 2 then -- change single character surrounding
        local k1, k2 = keys:sub(1,1), keys:sub(2,2)
        if k1 == '<' or k1 == '>' or k2 == '<' or k2 == '>' then
            return -1
        end
        local left_old, right_old = left(k1), right(k1)
        local left_new, right_new = left(k2), right(k2)
        if not (left_old and right_old and left_new and right_new) then
            return 2
        end
        local win = vis.win
        local file = win.file
        local pos = win.selection.pos
        local l, r = find_surrounding(file, pos, left_old, right_old)
        if not l or not r then return end
        file:delete(l, 1)
        file:insert(l, left_new)
        file:delete(r, 1)
        file:insert(r, right_new)
        win.selection.pos = pos
        return 2
    else -- xml tags
        local tag_old, tag_new = keys:match("<([^<>]*)><([^<>]*)>")
        if not (tag_old and tag_new) then
            return -1
        end
        local win = vis.win
        local file = win.file
        local pos = win.selection.pos
        local l1, l2, r1, r2 = find_surrounding_tags(file, pos, tag_old)
        if not (l1 and l2 and r1 and r2) then
            return #keys
        end
        file:delete(l1, l2-l1)
        file:insert(l1, '<'..tag_new..'>')
        file:delete(r1 + #tag_new - #tag_old + 1, r2-r1)
        file:insert(r1 + #tag_new - #tag_old + 1, '</'..tag_new..'>')
        win.selection.pos = pos + #tag_new - #tag_old
        return #keys
    end
end

local function delete_surrounding(keys)
    if #keys < 1 then
        return -1
    elseif #keys == 1 then -- single character surrounding
        if keys:sub(1,1) == '<' then
            return -1
        end
        local left = left(keys)
        local right = right(keys)
        if not (left and right) then return 1 end
        local win = vis.win
        local file = win.file
        local pos = win.selection.pos

        local l, r = find_surrounding(file, pos, left, right)
        if not l or not r then return 1 end

        win.file:delete(l, 1)
        win.file:delete(r-1, 1)
        win.selection.pos = pos-1
        return 1
    else -- xml tags
        local tag = keys:match("<([^<>]*)>")
        if not tag then
            return -1
        end
        local win = vis.win
        local file = win.file
        local pos = win.selection.pos
        local l1, l2, r1, r2 = find_surrounding_tags(file, pos, tag)
        if not (l1 and l2 and r1 and r2) then
            return #keys
        end
        win.file:delete(l1, l2-l1)
        win.file:delete(r1 - #tag - 1, r2-r1)
        win.selection.pos = pos - #tag - 2
        return #keys
    end
end

vis:map(vis.modes.NORMAL, "cs", change_surrounding, "Change surroundings")
vis:map(vis.modes.NORMAL, "ds", delete_surrounding, "Delete surroundings")

