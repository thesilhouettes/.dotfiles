local opts = {
  noremap = true,
  silent = true,
}

vim.api.nvim_set_keymap(
  "n",
  "dk",
  "<cmd>lua vim.diagnostic.goto_prev()<CR>",
  opts
)
vim.api.nvim_set_keymap(
  "n",
  "dj",
  "<cmd>lua vim.diagnostic.goto_next()<CR>",
  opts
)
-- what does this do?
vim.api.nvim_set_keymap(
  "n",
  "<space>q",
  "<cmd>lua vim.diagnostic.setloclist()<CR>",
  opts
)

-- floating diagnostics
vim.api.nvim_set_keymap(
  "n",
  "<C-d>",
  "<cmd>lua vim.diagnostic.open_float()<CR>",
  opts
)
