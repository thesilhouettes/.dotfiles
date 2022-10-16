local action_layout = require "telescope.actions.layout"
require("telescope").setup {
  pickers = {
    find_files = {
      hidden = true,
    },
  },
  defaults = {
    layout_config = {
      horizontal = {
        borderchars = {
          { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
          results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
          preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        },
        width = 0.8,
        -- previewer = false,
        -- prompt_title = false
      },
    },
    file_ignore_patterns = {
      "node_modules/.*",
      ".git/.*",
      "dist/.*",
      "build/.*",
    },
    mappings = {
      n = {
        ["<M-p>"] = action_layout.toggle_preview,
      },
      i = {
        ["<M-p>"] = action_layout.toggle_preview,
      },
    },
  },
}
