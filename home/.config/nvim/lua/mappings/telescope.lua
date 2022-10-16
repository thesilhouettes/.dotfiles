-- file prompt
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>")

-- grep
vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep")

-- kepmap cheatsheet
vim.keymap.set("n", "<leader>?", "<cmd>Telescope keymaps<CR>")

-- register
vim.keymap.set("n", "<leader>r", "<cmd>Telescope registers<CR>")

-- buffers
vim.keymap.set("n", "sb", "<cmd>Telescope buffers<CR>")

-- lsp related
vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>")
vim.keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>")
vim.keymap.set("n", "<leader>li", "<cmd>Telescope lsp_type_definitions<CR>")
