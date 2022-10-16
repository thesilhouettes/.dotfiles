local ok, lualine = pcall(require, "lualine")

if not ok then
  return
end

lualine.setup {
  options = {
    component_separators = { left = "|", right = "|" },
    -- the default arrows does not have the height of the whole bar so I removed it
    section_separators = { left = "", right = "" },
    -- don't show the bar on NvimTree splits
    disabled_filetypes = { "NvimTree" },
    theme = "articblush",
  },
}
