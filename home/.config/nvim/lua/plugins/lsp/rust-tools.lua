local utils = require "plugins/lsp/utils"

local rt = require "rust-tools"

rt.setup {
  server = {
    on_attach = function(client, bufnr)
      utils.default_on_attach(client, bufnr)
      -- Hover actions
      vim.keymap.set(
        "n",
        "<C-space>",
        rt.hover_actions.hover_actions,
        { buffer = bufnr }
      )
    end,
  },
}
