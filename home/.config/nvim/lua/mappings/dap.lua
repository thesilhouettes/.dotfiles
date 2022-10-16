vim.keymap.set("n", "<leader>b", ':lua require("dap").toggle_breakpoint()<CR>')
vim.keymap.set("n", "<F5>", ':lua require("dap").continue()<CR>')
vim.keymap.set("n", "<F4>", ':lua require("dap").close()<CR>')
vim.keymap.set("n", "<F3>", ':lua require("dapui").close()<CR>')
-- treat functions like blackbox
vim.keymap.set("n", "<F10>", ':lua require("dap").step_over()<CR>')
-- step into a function
vim.keymap.set("n", "<F11>", ':lua require("dap").step_into()<CR>')
-- step out when inside function
vim.keymap.set("n", "<F12>", ':lua require("dap").step_out()<CR>')

-- something specific to python
vim.keymap.set(
  "n",
  "<leader>dm",
  ':lua require("dap-python").test_method()<CR>'
)
vim.keymap.set("n", "<leader>dc", ':lua require("dap-python").test_class()<CR>')
vim.keymap.set(
  "n",
  "<leader>ds",
  '<ESC>:lua require("dap-python").debug_selection()<CR>'
)
