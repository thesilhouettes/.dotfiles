local present, articblush = pcall(require, "articblush")

if not present then
  error "Articblush colour theme is not present."
end

articblush.setup {
  italics = {
    code = true,
    comments = false,
  },
  nvim_tree = {
    contrast = true,
  },
}

-- brighter comments
-- I spent so much time finding these groups...
vim.api.nvim_set_hl(0, "Comment", { fg = "#999999" })
vim.api.nvim_set_hl(0, "SpecialComment", { fg = "#999999" })
vim.api.nvim_set_hl(0, "TSComment", { fg = "#999999" })
