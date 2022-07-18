-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ neovim/nvim-lspconfig                                                        │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local nvim_lsp = require('lspconfig')
local util = require 'lspconfig/util'
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    local opts = {noremap=true, silent=true}
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', '<C-K>', '<Cmd>lua require"lsp_signature".signature()<cr>', opts)
    buf_set_keymap('n', ']g', '<Cmd>lua vim.diagnostic.goto_next()<cr>', opts)
    buf_set_keymap('n', '[g', '<Cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua require"telescope.builtin".lsp_definitions()<cr>', opts)
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    buf_set_keymap('n', 'ge', '<Cmd>lua vim.diagnostic.open_float(0, { scope = "line", })<cr>', opts)
    buf_set_keymap('n', 'gi', '<Cmd>lua require"telescope.builtin".lsp_implementations()<cr>', opts)
    buf_set_keymap('n', 'gr', '<Cmd>lua require"telescope.builtin".lsp_references()<cr>', opts)
    buf_set_keymap('n', 'gt', '<Cmd>lua require"telescope.builtin".lsp_type_definitions()<cr>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<cr>', opts)
    buf_set_keymap('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<leader>ga', '<Cmd>lua require"telescope.builtin".lsp_code_actions()<cr>', opts)
    buf_set_keymap('n', '<leader>ge', '<Cmd>lua require"telescope.builtin".lsp_document_diagnostics()<cr>', opts)
    buf_set_keymap('n', '<leader>gf', '<Cmd>lua vim.lsp.buf.formatting()<cr>', opts)
    buf_set_keymap('n', '<leader>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('v', '<leader>ga', '<Cmd>lua require"telescope.builtin".lsp_range_code_actions()<cr>', opts)
end

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
})

-- local signs_fancy = { Error = "🔥", Warn = "💩", Info = "💬", Hint = "💡", }
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text=icon, texthl=hl, numhl=hl})
end

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.setup()

nvim_lsp.pyright.setup {
    on_attach=on_attach,
    root_dir = function(fname)
        local root_files = {'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json'}
        return util.root_pattern(table.unpack(root_files))(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
    end,
    cmd={"pyright-langserver", "--stdio"},
    filetypes={"python"},
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
nvim_lsp.bashls.setup {on_attach=on_attach}
nvim_lsp.dockerls.setup {on_attach=on_attach}
nvim_lsp.sumneko_lua.setup {settings={Lua={diagnostics={
    globals={'vim','use','require','rocks','use_rocks'}}}}, on_attach=on_attach}
nvim_lsp.tsserver.setup {on_attach=on_attach}
nvim_lsp.vimls.setup {on_attach=on_attach}
nvim_lsp.yamlls.setup {on_attach=on_attach}
nvim_lsp.rust_analyzer.setup {
    on_attach=on_attach,
    settings={
        ["rust-analyzer"]={
            assist={importMergeBehavior="last", importPrefix="by_self"},
            diagnostics={disabled={"unresolved-import"}},
            cargo={loadOutDirsFromCheck=true},
            procMacro={enable=true},
            checkOnSave={command="clippy"},
        }},
    capabilities=require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}
