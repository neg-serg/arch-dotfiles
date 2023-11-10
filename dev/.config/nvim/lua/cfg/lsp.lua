-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ neovim/nvim-lspconfig                                                        │
-- └───────────────────────────────────────────────────────────────────────────────────┘
vim.diagnostic.config({
    virtual_text=true,
    signs=true,
    underline=true,
    update_in_insert=false,
    severity_sort=false,
})

local signs={Error="", Warn="", Hint="", Info=""}
for type, icon in pairs(signs) do
    local hl="DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text=icon, texthl=hl, numhl=hl})
end

local mason=require'mason'
local mason_lspconfig=require'mason-lspconfig'
local mason_null_ls=require'mason-null-ls'
mason.setup()
mason_lspconfig.setup({ensure_installed={
    'bashls',
    'clangd',
    'dockerls',
    'hls',
    'jsonls',
    'pyright',
    'remark_ls',
    'rust_analyzer',
    'salt_ls',
    'taplo',
    'yamlls',
}})
mason_null_ls.setup({
    ensure_installed = {},
    automatic_installation = true,
    automatic_setup = true
})
