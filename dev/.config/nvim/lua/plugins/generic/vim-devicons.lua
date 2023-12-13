-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ kyazdani42/nvim-web-devicons                                                 │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {
    'nvim-tree/nvim-web-devicons', -- better icons
    config=function()
        vim.g.DevIconsEnableFoldersOpenClose=1
        vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols={}
        vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["html"]=""
        vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["js"]=""
        vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["json"]=""
        vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["jsx"]="ﰆ"
        vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["md"]=""
        vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["vim"]=""
        vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["yaml"]=""
        vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["yml"]=""
        vim.g.WebDevIconsUnicodeDecorateFileNodesPatternSymbols={}
        vim.g.WebDevIconsUnicodeDecorateFileNodesPatternSymbols[".*vimrc.*"]=""
        vim.g.WebDevIconsUnicodeDecorateFileNodesPatternSymbols[".gitignore"]=""
        vim.g.WebDevIconsUnicodeDecorateFileNodesPatternSymbols["package.json"]=""
        vim.g.WebDevIconsUnicodeDecorateFileNodesPatternSymbols["package.lock.json"]=""
        vim.g.WebDevIconsUnicodeDecorateFileNodesPatternSymbols["node_modules"]=""
        vim.g.WebDevIconsUnicodeDecorateFileNodesPatternSymbols["webpack."]="ﰩ"
    end
}
