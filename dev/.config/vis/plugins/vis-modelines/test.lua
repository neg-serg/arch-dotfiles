require 'busted.runner'()
local m = require("vis-modelines")

local function file_to_table(fname)
    local lines = {}
    local f = io.open(fname, "r")
    for line in f:lines() do
        if line then lines[#lines + 1] = line end
    end
    f:close()
    return lines
end

describe("Modeline parser", function()
    local files = {
        {
            "tests/file1.in",
            nil,
            nil,
            { }
        },
        {
            "tests/file2.in",
            "# vi:noai:sw=3 ts=6",
            { "noai", { "sw", "3" }, { "ts", "6" } },
            { "set ai off", "set tw 3" }
        },
        {
            "tests/file3.in",
            "-- vim: tw=77",
            { { "tw", "77" } },
            { }
        },
        {
            "tests/file4.in",
            "/* vim: set ai tw=75: */",
            { "ai", { "tw", "75" } },
            { "set ai on" }
        },
        {
            "tests/file5.in",
            "/* Vim: set ai tw=75 */",
            { "ai", { "tw", "75" } },
            { "set ai on" }
        },
        {
            "tests/file6.in",
            "/* vim700: set foldmethod=marker */",
            { { "foldmethod", "marker" } },
            { }
        },
        {
            "tests/file7.in",
            "/* vim>702: set cole=2: */",
            { { "cole", "2" } },
            { }
        },
        {
            "tests/file8.in",
            "// vim: noai:sw=8:ts=4",
            { "noai", { "sw", "8" }, { "ts", "4" } },
            { "set ai off", "set tw 8" }
        },
        {
            "tests/file9.in",
            "-- Vim: ft=lua",
            { { "ft", "lua" } },
            { "set syntax lua" }
        },
        {
            "tests/file10.in",
            "\" vim:ft=vim:fdm=marker",
            { { "ft", "vim"}, {"fdm", "marker"} },
            { "set syntax vim" }
        }
    }

    it("should correctly detect modelines in files", function()
        for i = 1, #files do
            assert.is_true(m.find_modeline(file_to_table(files[i][1])) == files[i][2])
        end
    end)

    it("should parse modelines correctly", function()
        local function parse(i)
            local ml = m.find_modeline(file_to_table(files[i][1]))
            if not ml then return nil end
            return m.parse_modeline(ml)
        end
        for i = 1, #files do
            assert.are.same(parse(i), files[i][3])
        end
    end)

    it("should map the right options for vis", function()
        local function map(i)
            local ml = m.find_modeline(file_to_table(files[i][1]))
            if not ml then return { } end
            return m.map_options(ml)
        end
        for i = 1, #files do
            assert.are.same(map(i), files[i][4])
        end
    end)
end)
