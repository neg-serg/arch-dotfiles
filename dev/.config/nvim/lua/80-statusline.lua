-- extension for scoll bar
function scrollbar_instance(scroll_bar_chars)
    local current_line = vim.fn.line('.')
    local total_lines = vim.fn.line('$')
    local default_chars = {'__', '▁▁', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██'}
    local chars = scroll_bar_chars or default_chars
    local index = 1

    if current_line == 1 then
        index = 1
    elseif current_line == total_lines then
        index = #chars
    else
        local line_no_fraction = vim.fn.floor(current_line) / vim.fn.floor(total_lines)
        index = vim.fn.float2nr(line_no_fraction * #chars)
        if index == 0 then
            index = 1
        end
    end
    return chars[index]
end
