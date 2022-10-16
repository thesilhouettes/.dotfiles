require("mason").setup {}

require("mason-tool-installer").setup {

  ensure_installed = {
    "texlab",
    "marksman",
    "tailwindcss-language-server",
    "rust-analyzer",
    "lua-language-server",
    "typescript-language-server",
    "gopls",
    "html-lsp",
    "css-lsp",
    "clangd",
    "emmet-ls",
    "bash-language-server",
    "gopls",
    "awk-language-server",
    "yaml-language-server",
    "json-lsp",
    "cmake-language-server",
    "grammarly-languageserver",
    "pyright",
    "deno",
    "ltex-ls",
    "jdtls",

    -- linters and formatters
    "eslint-lsp",
    "prettier",
    "stylua",
    "shellcheck",
    "shfmt",
    "blue",
    "flake8",

    -- debuggers
    "debugpy",
    "delve",
  },
}
