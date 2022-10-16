require("toggleterm").setup {
  open_mapping = "<M-t>",
  direction = "float",
  insert_mappings = true,
  persist_size = true,
  start_in_insert = true,
  float_opts = {
    border = "single",
    width = 120,
    height = 50,
    winblend = 3,
  },
}
