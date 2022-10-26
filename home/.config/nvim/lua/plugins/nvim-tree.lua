local ok, tree = pcall(require, "nvim-tree")

if not ok then
  return
end

tree.setup {
  update_focused_file = {
    enable = true,
    update_root = true,
  },
}
