require("dapui").setup()
local dap = require("dap")
local dapui = require("dapui")
local widgets = require("dap.ui.widgets")

local function opt(msg)
  return { desc = "DAP: " .. msg }
end

-- stylua: ignore start
vim.keymap.set("n", "<leader>db",  function() dap.toggle_breakpoint() end, opt("breakpoint"))
vim.keymap.set("n", "<F2>",        function() dap.continue()          end, opt("continue"))
vim.keymap.set("n", "<F3>",        function() dap.step_into()         end, opt("step into"))
vim.keymap.set("n", "<F4>",        function() dap.step_over()         end, opt("step over"))
vim.keymap.set("n", "<F5>",        function() dap.step_out()          end, opt("step out"))
vim.keymap.set("n", "<leader>dui", function() dapui.toggle()          end, opt("toggle ui"))
vim.keymap.set("n", "<leader>duh", function() widgets.hover()         end, opt("hover"))
vim.keymap.set("n", "<leader>duf", function() widgets.centered_float(widgets.scopes) end, opt("float view"))
-- stylua: ignore end

vim.keymap.set("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, opt("contitional breakpoint"))
vim.keymap.set("n", "<leader>dl", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, opt("log point message"))

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.after.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.after.event_exited["dapui_config"] = function()
  dapui.close()
end

dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance",
    host = function()
      local value = vim.fn.input("Host [127.0.0.1]: ")
      if value ~= "" then
        return value
      end
      return "127.0.0.1"
    end,
    port = function()
      local val = tonumber(vim.fn.input("Port: "))
      assert(val, "Please provide a port number")
      return val
    end,
  },
}

require("nvim-dap-virtual-text").setup()

-- vim: fdm=marker
