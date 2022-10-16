local dap = require "dap"
local dapui = require "dapui"
local dapv = require "nvim-dap-virtual-text"

dapui.setup {}
dapv.setup {}

-- stolen from lua users
local function split(str, pat)
  local t = {}
  local fpat = "(.-)" .. pat
  local last_end = 1
  local s, e, cap = str:find(fpat, 1)
  while s do
    if s ~= 1 or cap ~= "" then
      table.insert(t, cap)
    end
    last_end = e + 1
    s, e, cap = str:find(fpat, last_end)
  end
  if last_end <= #str then
    cap = str:sub(last_end)
    table.insert(t, cap)
  end
  return t
end

local function get_last(li)
  return li[#li]
end

local workspace = vim.fn.getcwd()
-- if a path looks like /a/b/c/dd/ then this will output dd
local folder_name = get_last(split(workspace, "[\\/]+"))
local venv_folder = os.getenv "HOME"
  .. "/.local/python-env/"
  .. folder_name
  .. "/bin/python"

-- require("dap-python").setup(venv_folder)

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  --  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  -- dapui.close()
end

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input(
        "Path to executable: ",
        vim.fn.getcwd() .. "/build/",
        "file"
      )
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}

-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
