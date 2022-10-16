local ok, nvimlsp = pcall(require, "lspconfig")
local utils = require "plugins/lsp/utils"

local base_on_attach = utils.base_on_attach
local default_on_attach = utils.default_on_attach

if not ok then
  return
end

-- add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local sumneko_lua_settings = {
  Lua = {
    runtime = {
      version = "luajit",
      path = runtime_path,
    },
    diagnostics = {
      -- get the language server to recognize the `vim` global
      -- this does not work for some reason?
      globals = {
        "vim",
      },
    },
    workspace = { -- make the server aware of neovim runtime files
      library = {
        vim.fn.expand "$VIMRUNTIME/lua",
        vim.fn.stdpath "config" .. "/lua",
      },
    },
    telemetry = {
      enable = false,
    },
  },
}

local servers = {
  -- we leave the setup of rust-analyzer to rust-tools
  sumneko_lua = {
    settings = sumneko_lua_settings,
    on_attach = default_on_attach,
  },
  cssls = {},
  jsonls = {
    on_attach = default_on_attach,
  },
  html = {
    on_attach = default_on_attach,
  },
  clangd = {},
  emmet_ls = {
    capabilities = capabilities,
    single_file_support = true,
  },
  bashls = {},
  gopls = {},
  awk_ls = {},
  eslint = {},
  yamlls = {},
  ltex = {},
  texlab = {},
  marksman = {},
  tailwindcss = {},
  -- it is very difficult for deno not to conflict with tsserver
  denols = {
    on_attach = default_on_attach,
    root_dir = nvimlsp.util.root_pattern "deno.json",
    single_file_support = false,
  },
  cmake = {},
  pyright = {},
  -- I wish this works but apparently not
  -- grammarly = {},
  jdtls = {},
}
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- check if there is a deno.json, if yes don't start the tsserver
local cwd = vim.fn.getcwd()
local denofile = cwd .. "/deno.json"
local exists, err = os.rename(denofile, denofile)

if err or not exists then
  servers["tsserver"] = {
    root_dir = function()
      return vim.loop.cwd()
    end,
    init_options = require("nvim-lsp-ts-utils").init_options,
    on_attach = function(client, bufnr)
      base_on_attach(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      local ts_utils = require "nvim-lsp-ts-utils"
      ts_utils.setup {
        update_imports_on_move = true,
        -- if there is no jsconfig.json, tsconfig.json or .git
        -- this plugin will not start if none of those are present
        -- this is for performance reasons. The plugin does not know when to
        -- ignore node_modules
        watch_dir = "src",
      }
      -- required to fix code action ranges and filter diagnostics
      ts_utils.setup_client(client)
      local opts = {
        buffer = bufnr,
        silent = true,
      }
      vim.keymap.set("n", "to", ":TSLspOrganize<CR>", opts)
      vim.keymap.set("n", "tr", ":TSLspRename<CR>", opts)
      vim.keymap.set("n", "ti", ":TSLspImportAll<CR>", opts)
    end,
  }
end

for name, settings in pairs(servers) do
  local base = {
    -- if there is no on_attach overrides, use the base one
    on_attach = base_on_attach,
    flags = {
      -- don't suggest on every keystroke
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  }

  for key, value in pairs(settings) do
    base[key] = value
  end

  nvimlsp[name].setup(base)
end
