local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git', 'clone', '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', lazypath})
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader=','
require'lazy'.setup({
    spec={
        -- █▓▒░ Performance / Fixes
        {import='plugins/performance'},
        -- █▓▒░ Generic
        {import='plugins/generic'},
        -- █▓▒░ Completion
        {import='plugins/completion'},
        -- █▓▒░ Dev
        {import='plugins/dev'},
        -- █▓▒░ Debug
        {import='plugins/debug'},
        -- █▓▒░ Text
        {import='plugins/text'},
        -- █▓▒░ Edit
        {import='plugins/edit'},
        -- █▓▒░ Appearance
        {import='plugins/appearance'},
        -- █▓▒░ Filetypes
        {import='plugins/filetypes'},
        -- █▓▒░ DCVS
        {import='plugins/dcvs'},
    }
})
