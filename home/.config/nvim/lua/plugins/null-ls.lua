local null_ls = require "null-ls"
local sources = {
  null_ls.builtins.code_actions.eslint.with {
    command = "vscode-eslint-language-server",
  },
  null_ls.builtins.diagnostics.eslint,
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.formatting.rustfmt,
  null_ls.builtins.formatting.stylua.with {
    extra_args = {
      "--call-parentheses=None",
      "--indent-width=2",
      "--column-width=80",
      "--indent-type=Spaces",
    },
  },
  null_ls.builtins.code_actions.shellcheck,
  null_ls.builtins.diagnostics.shellcheck,
  null_ls.builtins.formatting.shfmt,
  -- null_ls.builtins.diagnostics.golangci_lint,
  null_ls.builtins.formatting.blue,
  -- I noticed semgrep is eating so much memory??
  -- null_ls.builtins.diagnostics.semgrep.with {
  --   disabled_filetypes = {
  --     "typescript",
  --     "javascript",
  --     "javascriptreact",
  --     "typescriptreact",
  --   },
  --   extra_args = {
  --     "--config",
  --     "auto",
  --   },
  -- },
  --
  -- another python linter
  null_ls.builtins.diagnostics.flake8,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup {
  debug = true,
  sources = sources,
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
}
