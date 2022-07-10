local present, impatient = pcall(require, "impatient")
if present then
    impatient.enable_profile()
end

-- local async_load_plugin = nil
-- async_load_plugin = vim.loop.new_async(vim.schedule_wrap(function()
--     require("commands")
--     async_load_plugin:close()
-- end))
-- async_load_plugin:send()
