vim.api.nvim_set_keymap(
  "n",
  "<M-t>",
  '<Cmd>exe v:count1 . "ToggleTerm"<CR>',
  { silent = true, noremap = true }
)

vim.api.nvim_set_keymap(
  "i",
  "<M-t>",
  '<Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>',
  { silent = true, noremap = true }
)

-- exit the terminal with the same key binding
vim.api.nvim_set_keymap(
  "t",
  "<M-t>",
  '<Cmd>exe v:count1 . "ToggleTerm"<CR>',
  { silent = true, noremap = true }
)
