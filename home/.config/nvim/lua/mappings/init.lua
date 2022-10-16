vim.g.mapleader = "-"
vim.g.localleader = "\\"

vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", "<C-s>", ":w<cr>")
vim.keymap.set("t", "<M-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<M-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<M-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<M-l>", "<C-\\><C-n><C-w>l")
vim.keymap.set("n", "<M-h>", "<C-w>h")
vim.keymap.set("n", "<M-j>", "<C-w>j")
vim.keymap.set("n", "<M-k>", "<C-w>k")
vim.keymap.set("n", "<M-l>", "<C-w>l")
vim.keymap.set("n", "<M-=>", "<C-w>+")
vim.keymap.set("n", "<M-->", "<C-w>-")
vim.keymap.set("n", "<M-.>", "<C-w><lt>")
vim.keymap.set("n", "<M-,>", "<C-w>>")
vim.keymap.set("t", "jk", "<C-\\><C-n>")

vim.keymap.set("n", "<leader>ev", ":edit $MYVIMRC<cr>")
vim.keymap.set("n", "<leader>sv", ":so $MYVIMRC<cr>")

vim.keymap.set("n", "Z", "ZZ")
vim.keymap.set("n", "Q", "ZQ")

vim.keymap.set(
  "n",
  "<leader>w",
  ":edit " .. os.getenv "HOME" .. "/Documents/vimwiki/index.md<cr>"
)

local started = false

vim.keymap.set("n", "<leader>ew", function()
  if started then
    vim.cmd "!eww close bar"
  else
    vim.cmd "!eww open bar"
  end
end)

vim.keymap.set("n", "<leader>ct", ":!ctest --test-dir build")

vim.keymap.set("n", "<leader>cm", ":!cmake --build build")

require "mappings/buffer"
require "mappings/telescope"
require "mappings/lspconfig"
require "mappings/nvim-tree"
require "mappings/glow"
require "mappings/trouble"
require "mappings/dap"
