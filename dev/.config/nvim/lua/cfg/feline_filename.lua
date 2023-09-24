-- ~/.config/nvim/lua/cfg/feline_filename.lua
-- Get unique file name

local M = {}

local function reverse(tbl)
    for i = 1, math.floor(#tbl/2) do
        local j = #tbl - i + 1
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
end

function M.get_tail(filename)
    return vim.fn.fnamemodify(filename, ":t")
end

function M.split_filename(filename)
    local nodes = {}
    for parent in string.gmatch(filename, "[^/]+/") do
        table.insert(nodes, parent)
    end
    table.insert(nodes, M.get_tail(filename))
    return nodes
end

function M.reverse_filename(filename)
    local parents = M.split_filename(filename)
    reverse(parents)
    return parents
end

local function same_until(first, second)
    for i = 1, #first do
        if first[i] ~= second[i] then
            return i
        end
    end
    return 1
end

function M.get_unique_filename(filename, other_filenames)
    local rv = ''

    local others_reversed = vim.tbl_map(M.reverse_filename, other_filenames)
    local filename_reversed = M.reverse_filename(filename)
    local same_until_map = vim.tbl_map(function(second) return same_until(filename_reversed, second) end, others_reversed)

    local max = 0
    for _, v in ipairs(same_until_map) do
        if v > max then max = v end
    end
    for i = max, 1, -1 do
        rv = rv .. filename_reversed[i]
    end

    return rv
end

function M.get_current_ufn()
    local buffers = vim.fn.getbufinfo()
    local listed = vim.tbl_filter(function(buffer) return buffer.listed == 1 end, buffers)
    local names = vim.tbl_map(function(buffer) return buffer.name end, listed)
    local current_name = vim.fn.expand("%")
    return M.get_unique_filename(current_name, names)
end

return M
