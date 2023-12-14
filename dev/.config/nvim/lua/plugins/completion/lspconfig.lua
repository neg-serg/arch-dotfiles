-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ neovim/nvim-lspconfig                                                        │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {'neovim/nvim-lspconfig', -- lsp config
    config=function()
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
        mason.setup()
        mason_lspconfig.setup({ensure_installed={
            'bashls',
            'clangd',
            'dockerls',
            'jsonls',
            'pyright',
            'rust_analyzer',
            'salt_ls',
        }})
    end,
    dependencies={
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim'
    }, event={'InsertEnter'}
}
