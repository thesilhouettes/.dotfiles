local nvimtree = require "nvim-tree"
local nvimtree_view = require "nvim-tree.view"

function set_nvimtree_when_open_term(terminal)
  if nvimtree_view.is_visible() and terminal.direction == "horizontal" then
    local nvimtree_width = vim.fn.winwidth(nvimtree_view.get_winnr())
    nvimtree.toggle()
    nvimtree_view.View.width = nvimtree_width
    nvimtree.toggle(false, true)
  end
end

require("toggleterm").setup {
  direction = "horizontal",
  insert_mappings = true,
  persist_size = true,
  start_in_insert = true,
  float_opts = {
    border = "single",
    width = 120,
    height = 50,
    winblend = 3,
  },
  on_open = set_nvimtree_when_open_term,
}
