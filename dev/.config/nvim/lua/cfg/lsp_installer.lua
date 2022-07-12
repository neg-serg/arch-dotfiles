local lsp_installer = require("nvim-lsp-installer")

-- -- Register a handler that will be called for all installed servers.
-- -- Alternatively, you may also register handlers on specific server instances instead (see example below).
-- lsp_installer.on_server_ready(function(server)
--     local opts = {}
--     server:setup(opts)
-- end)

lsp_installer.setup({
  ensure_installed = {
    "bashls",
    "clangd",
    "dockerls",
    "gopls",
    "html",
    "jedi_language_server",
    "jsonls",
    "sqls",
    "sumneko_lua",
    "tsserver",
    "vimls",
    "yamlls",
  },
  install_root_dir = vim.env.HOME .. "/.cache/lsp-servers",
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
})
