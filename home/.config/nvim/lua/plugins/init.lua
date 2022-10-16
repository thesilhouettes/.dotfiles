local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end

require("packer").startup(function(use)
  -- packer can manage itself
  use "wbthomason/packer.nvim"

  -- startup dashboard
  use {
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
  }

  use { "articblush/articblush.nvim", as = "articblush" }

  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  }
  -- file tree
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
  }

  -- automatically indent new line
  use "lukas-reineke/indent-blankline.nvim"

  -- snazzy buffer / tab top bar
  use "akinsho/bufferline.nvim"

  -- file searcher
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      {
        "nvim-lua/plenary.nvim",
      },
    },
  }

  -- treesitter (syntax highlighting ?)
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "moll/vim-bbye"
  use "RRethy/vim-illuminate"

  -- lsp client config and installer
  use {
    "neovim/nvim-lspconfig",
  }

  -- mainly for rust
  use "simrat39/rust-tools.nvim"

  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  }

  -- toggle comment
  use "terrortylor/nvim-comment"

  -- auto completion
  use "hrsh7th/nvim-cmp"

  -- lsp source for nvim-cmp
  use "hrsh7th/cmp-nvim-lsp"

  -- signatures
  use "Issafalcon/lsp-overloads.nvim"

  -- ultisnip snippet plugin (I replaced luasnip with this)
  use "SirVer/ultisnips"
  use "quangnguyen30192/cmp-nvim-ultisnips"

  -- automatic latex compilation
  use "lervag/vimtex"

  -- show function signature when typing
  use "ray-x/lsp_signature.nvim"

  -- colour rgb strings
  use "norcalli/nvim-colorizer.lua"

  -- integrated terminal like vscode
  use {
    "akinsho/toggleterm.nvim",
    tag = "v1.*",
  }

  -- formatting (also with prettier)
  use "jose-elias-alvarez/null-ls.nvim"

  -- typescript smart actions
  use "jose-elias-alvarez/nvim-lsp-ts-utils"

  -- git signs
  use {
    "lewis6991/gitsigns.nvim",
  }

  -- auto closing tsx tags finally
  use "windwp/nvim-ts-autotag"

  -- markdown preview
  use { "ellisonleao/glow.nvim", branch = "main" }

  -- discord rich presence
  use "andweeb/presence.nvim"

  -- auto closing brackets
  use "windwp/nvim-autopairs"

  -- delete surrounding parenthesis
  use "tpope/vim-surround"

  -- diagnostics window
  use "folke/trouble.nvim"

  -- spell checker with lsp
  -- use "lewis6991/spellsitter.nvim"

  -- rainbow colour brackets
  use "p00f/nvim-ts-rainbow"

  -- editor config support
  use "gpanders/editorconfig.nvim"

  -- note taking plugin
  use "jakewvincent/mkdnflow.nvim"

  -- cmake building tool
  -- use "Shatur/neovim-cmake"

  -- lua docs
  use "nanotee/luv-vimdocs"
  use "milisims/nvim-luaref"

  -- debugger
  use "rcarriga/nvim-dap-ui"
  use "mfussenegger/nvim-dap"
  use "theHamsta/nvim-dap-virtual-text"

  -- use "mfussenegger/nvim-dap-python"
  -- my own plugins...
  -- use "/home/silhouette/.local/sources/plugins/spautocmd.nvim"

  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- configs for each plugin
require "plugins/alpha"
require "plugins/treesitter"
require "plugins/nvim-tree"
require "plugins/mason"
require "plugins/lsp/lspconfig"
require "plugins/lsp/lsp-signature"
require "plugins/lsp/rust-tools"
require "plugins/nvim-cmp"
require "plugins/null-ls"
require "plugins/dap"
require "plugins/trouble"

require "plugins/bufferline"
require "plugins/lualine"
require "plugins/gitsigns"
require "plugins/colorizer"

require "plugins/nvim-comment"
require "plugins/autopairs"
require "plugins/autotag"
require "plugins/indent-blankline"

require "plugins/toggleterm"
require "plugins/telescope"
require "plugins/rich-presence"
require "plugins/mkdnflow"
require "plugins/articblush"
require "plugins/illuminate"

-- local cmake_build = {
--   BufWrite = {
--     trigger = {
--       ":!cmake --build ./build",
--       key = "<leader>c",
--     },
--   },
-- }
--
-- local cmake_cpp_build = {
--   BufWrite = {
--     trigger = {
--       ":!cmake --build ./build",
--       key = "<leader>cpp",
--     },
--   },
-- }

-- require("spautocmd").setup {
--   cmds = {
--     c = cmake_build,
--     cpp = cmake_cpp_build,
--   },
-- }
