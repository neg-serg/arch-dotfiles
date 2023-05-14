-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ neovim/nvim-lspconfig                                                        │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local nvim_lsp=require('lspconfig')
local util=require 'lspconfig/util'
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach=function(_, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    local opts={noremap=true, silent=true}
    buf_set_keymap('n', '<C-K>', '<Cmd>lua require"lsp_signature".signature()<CR>', opts)
    buf_set_keymap('n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua require"telescope.builtin".lsp_definitions()<CR>', opts)
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'ge', '<Cmd>lua vim.diagnostic.open_float(0, { scope="line", })<CR>', opts)
    buf_set_keymap('n', 'gi', '<Cmd>lua require"telescope.builtin".lsp_implementations()<CR>', opts)
    buf_set_keymap('n', 'gr', '<Cmd>lua require"telescope.builtin".lsp_references()<CR>', opts)
    buf_set_keymap('n', 'gt', '<Cmd>lua require"telescope.builtin".lsp_type_definitions()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<leader>A', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<leader>ge', '<Cmd>lua require"telescope.builtin".diagnostics()<CR>', opts)
    buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
    buf_set_keymap('n', '<leader>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

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
    'hls',
    'jsonls',
    'pyright',
    'remark_ls',
    'rust_analyzer',
    'salt_ls',
    'taplo',
    'terraformls',
    'yamlls',
}})

require'mason'.setup()
require'mason-null-ls'.setup({
    ensure_installed = {},
    automatic_installation = false,
    automatic_setup = true
})

nvim_lsp.pyright.setup {
    on_attach=on_attach,
    root_dir=function(fname)
        return util.root_pattern('.git','setup.py','setup.cfg','pyproject.toml','requirements.txt','Pipfile','pyrightconfig.json')(fname) or
            util.path.dirname(fname)
    end,
    cmd={'pyright-langserver','--stdio'},
    filetypes={'python'},
    flags={debounce_text_changes=150},
    settings={
        python={
            analysis={
                autoImportCompletions=true,
                autoSearchPaths=true,
                diagnosticMode="openFilesOnly", -- or "workspace"
                stubPath="typings", --or ""
                typeshedPaths={},
                useLibraryCodeForTypes=true,
            },
            linting={enabled=false},
        }
    },
    single_file_support=true
}
nvim_lsp.bashls.setup{on_attach=on_attach}
nvim_lsp.dockerls.setup{on_attach=on_attach}
nvim_lsp.tsserver.setup{on_attach=on_attach}
nvim_lsp.vimls.setup{on_attach=on_attach}
nvim_lsp.yamlls.setup{on_attach=on_attach}
