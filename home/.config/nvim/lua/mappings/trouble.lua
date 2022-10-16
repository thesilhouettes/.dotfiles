vim.api.nvim_set_keymap(
  "n",
  "<M-d>",
  "<cmd>TroubleToggle<cr>",
  { silent = true, noremap = true }
)

-- these are really unnecessary, I just keep it in case I need it.
vim.api.nvim_set_keymap(
  "n",
  "<M-w>",
  "<cmd>Trouble workspace_diagnostics<cr>",
  { silent = true, noremap = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<M-D>",
  "<cmd>Trouble document_diagnostics<cr>",
  { silent = true, noremap = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<M-o>",
  "<cmd>Trouble loclist<cr>",
  { silent = true, noremap = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<M-q>",
  "<cmd>Trouble quickfix<cr>",
  { silent = true, noremap = true }
)
vim.api.nvim_set_keymap(
  "n",
  "gR",
  "<cmd>Trouble lsp_references<cr>",
  { silent = true, noremap = true }
)
