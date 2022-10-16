local os = require "os"

local path = os.getenv "VIRTUAL_ENV"

local function get_python3()
  local handle = io.popen("which python3", "r")
  if not handle then
    return "none"
  end
  local res = handle:read "a"
  local stripped = string.gsub(res, "%s+", "")
  return stripped
end

-- if virtual env is actiavted, then virtual env is populated
if path then
  vim.g.python3_host_prog = get_python3()
end
