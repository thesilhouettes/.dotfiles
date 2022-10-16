require("lsp_signature").setup {
  bind = true,
  handler_opt = {
    border = "none",
  },
  doc_lines = 5,
  floating_window_above_cur_line = true,

  transparency = 50,

  hint_prefix = "",

  toggle_key = "<A-k>",

  select_signature_key = "<A-n>",
}
