require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "c",
    "cpp",
    "lua",
    "go",
    "rust",
    "javascript",
    "typescript",
    "tsx",
    "markdown",
    "html",
    "css",
    "scss",
    "java",
    "latex",
    "vim",
    "json",
    "jsonc",
    "graphql",
    "bash",
    "python",
  },

  highlight = {
    enable = true,
  },
}
