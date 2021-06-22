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

--[[
scriptencoding utf-8
if exists('g:loaded_spaceline') || v:version < 700
  finish
endif

let g:loaded_spaceline = 1

let g:symbol = get(g:, 'spaceline_line_symbol', 0)
let g:seperate_style = get(g:, 'spaceline_seperate_style', 'arrow')
let g:spaceline_colorscheme = get(g:, 'spaceline_colorscheme', 'space')
let g:spaceline_shortline_filetype = ['defx','coc-explorer','dbui','vista','vista_markdown','Mundo','MundoDiff']
let g:spaceline_scroll_bar_chars = get(g:,'spaceline_scroll_bar_chars', [
  \  '▁', '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█'
  \  ])
let g:spaceline_lsp = get(g:,'spaceline_lsp_executive','coc')
let g:spaceline_git = get(g:,'spaceline_git_tool','coc')

let g:spaceline_errorsign = get(g:,'spaceline_diagnostic_errorsign', '●')
let g:spaceline_warnsign = get(g:,'spaceline_diagnostic_warnsign', '●')
let g:spaceline_oksign = get(g:,'spaceline_diagnostic_oksign', '')

let g:sep= {}
let g:sep = spaceline#seperator#spacelineStyle(g:seperate_style)


augroup spaceline
  autocmd!
  autocmd FileType,WinEnter,BufWinEnter,BufReadPost,BufWritePost * call spaceline#spacelinetoggle()
  autocmd Colorscheme * call spaceline#colorscheme_init()
  autocmd VimResized * call spaceline#spacelinetoggle()
  autocmd WinLeave * call spaceline#setInActiveStatusLine()
  autocmd User CocStatusChange,CocGitStatusChange,ClapOnExit call spaceline#spacelinetoggle()
  autocmd User CocDiagnosticChange call spaceline#spacelinetoggle()
augroup END "}}}

--]]
