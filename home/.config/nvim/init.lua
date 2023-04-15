-- prelude and leader settings {{{
--
-- TheSilhouette's Neovim Configuration!!
--
-- (which is just a rip off of kickstart.nvim)
--`
--

-- set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

if not table.unpack then
	---@diagnostic disable-next-line: deprecated
	table.unpack = unpack
end

-- }}}

-- list of plugins with lazy.nvim {{{
-- install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- install plugins
require("lazy").setup({

	-- git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	-- detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	{ -- lsp magic
		"neovim/nvim-lspconfig",
		dependencies = {
			-- fancy ui downloading lsp servers
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- fancy download status for lsp servers :)
			{ "j-hui/fidget.nvim", opts = {
				sources = {
					ltex = {
						ignore = true,
					},
				},
			} },

			-- signatures!!
			"folke/neodev.nvim",
		},
	},

	-- automatic latex compilation
	"lervag/vimtex",

	-- completion
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"SirVer/ultisnips",
	"quangnguyen30192/cmp-nvim-ultisnips",

	-- pending keybindigs ( I find it annoying)
	-- { 'folke/which-key.nvim', opts = {} },
	"articblush/articblush.nvim",

	{ -- status
		"nvim-lualine/lualine.nvim",
	},

	-- file tree
	"kyazdani42/nvim-tree.lua",

	-- snazzy buffer / tab top bar
	{ "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

	{ -- indentation helper
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			char = "┊",
			show_trailing_blankline_indent = false,
		},
	},

	-- automatic bracket closing
	"windwp/nvim-autopairs",

	-- toggle comments
	{ "numToStr/Comment.nvim", opts = {} },

	-- formatter
	"mhartington/formatter.nvim",

	-- typescript smart actions
	"jose-elias-alvarez/nvim-lsp-ts-utils",

	-- auto closing tsx tags finally
	"windwp/nvim-ts-autotag",

	-- delete surrounding parenthesis
	"tpope/vim-surround",

	-- markdown note taking
	"jakewvincent/mkdnflow.nvim",

	-- markdown preview
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
	},

	-- toggle term!
	"akinsho/toggleterm.nvim",

	-- tjdevrie's magic
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},

	{ -- syntax highlighter
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	},
}, {})
-- }}}

-- options {{{

vim.o.compatible = false
vim.o.encoding = "UTF8"
vim.o.laststatus = 2
vim.o.hidden = true

-- wider space between lines
vim.o.linespace = 2

-- spacing and indents
vim.o.autoindent = true
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2

vim.o.signcolumn = "yes"
-- enable break indent
vim.o.breakindent = true

-- highlight on search
vim.o.hlsearch = false

-- need line numbers
vim.o.number = true
vim.o.numberwidth = 4

-- mouse interactivity
vim.o.mouse = "a"

-- sync keyboard
vim.o.clipboard = "unnamedplus"

-- save undo history
vim.o.undofile = true

-- case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- nicer colours (alacritty of course has this)
vim.o.termguicolors = true

vim.o.foldmethod = "marker"

-- wordwrap
-- it only breaks the line visually
vim.o.wrap = true
vim.o.textwidth = 80

-- fixed column for diagnostics to appear
-- show autodiagnostic popup on cursor hover_range
-- goto previous / next diagnostic warning / error
-- show inlay_hints more frequently
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

--- split window position
vim.o.splitbelow = true
vim.o.splitright = true

-- no virtual text diagnostics
vim.diagnostic.config({
	virtual_text = false,
})

-- }}}

-- vimtex {{{
vim.g.vimtex_quickfix_open_on_warning = 0

-- stolen from https://ejmastnak.github.io/tutorials/vim-latex/compilation.html
-- Filter out some compilation warning messages from QuickFix display
vim.g.vimtex_quickfix_ignore_filters = {
	"Underfull \\hbox",
	"Overfull \\hbox",
	"LaTeX Warning: .\\+ float specifier changed to",
	"LaTeX hooks Warning",
	'Package siunitx Warning: Detected the "physics" package:',
	"Package hyperref Warning: Token not allowed in a PDF string",
}

vim.api.nvim_create_augroup("CompileDot", {
	clear = true,
})

local function compile_dot_file()
	local filename = vim.fn.expand("%")
	local image = filename:gsub(".dot", ".png", 1)
	pcall(function()
		local success = os.execute("dot -Tpng " .. filename .. " >" .. image)
		if not success then
			print("Something is wrong")
		end
	end)
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = "CompileDot",
	pattern = { "*.dot" },
	callback = compile_dot_file,
})

local function open_viewer()
	local filename = vim.fn.expand("%")
	local image = filename:gsub(".dot", ".png", 1)
	pcall(function()
		os.execute("sxiv " .. image .. " >/dev/null 2>&1 &")
	end)
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = "CompileDot",
	pattern = { "*.dot" },
	callback = open_viewer,
	once = true,
})

vim.api.nvim_create_user_command("DotViewer", open_viewer, {})

-- }}}

-- markdown note taking {{{
require("mkdnflow").setup({})
-- }}}

-- ultisnips options {{{
vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
vim.g.UltiSnipsSnippetDirectories = {
	os.getenv("HOME") .. "/.config/nvim/ultisnips",
}
--- }}}

-- keybindings {{{
-- toggle nvim tree
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- smart next line
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- rolling esc in insert mode and terminal mode
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("t", "jk", "<C-\\><C-n>")

-- save with Ctrl+S
vim.keymap.set("n", "<C-s>", ":w<cr>")
vim.keymap.set("i", "<C-s>", ":w<cr>")

-- navigate between integrated terminal and editor
vim.keymap.set("t", "<M-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<M-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<M-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<M-l>", "<C-\\><C-n><C-w>l")
vim.keymap.set("n", "<M-h>", "<C-w>h")
vim.keymap.set("n", "<M-j>", "<C-w>j")
vim.keymap.set("n", "<M-k>", "<C-w>k")
vim.keymap.set("n", "<M-l>", "<C-w>l")

-- increase, decrease size of splits
vim.keymap.set("n", "<M-=>", "<C-w>+")
vim.keymap.set("n", "<M-->", "<C-w>-")
vim.keymap.set("n", "<M-.>", "<C-w><lt>")
vim.keymap.set("n", "<M-,>", "<C-w>>")

-- turning off highlighted items after search
vim.keymap.set("n", "<F3>", ":nohighlight")

-- quick quit
vim.keymap.set("n", "Z", "ZZ")
vim.keymap.set("n", "Q", "ZQ")

-- go to wiki dir
vim.keymap.set("n", "Z", "ZZ")
vim.keymap.set("n", "Q", "ZQ")

-- toggle term
vim.keymap.set("n", "<M-t>", '<Cmd>exe v:count1 . "ToggleTerm"<CR>', { silent = true, noremap = true })

vim.keymap.set("i", "<M-t>", '<Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>', { silent = true, noremap = true })

-- exit the terminal with the same key binding
vim.keymap.set("t", "<M-t>", '<Cmd>exe v:count1 . "ToggleTerm"<CR>', { silent = true, noremap = true })

-- formatting files
vim.keymap.set("n", "<leader>f", ":Format<CR>", { silent = true })
vim.keymap.set("n", "<leader>F", ":FormatWrite<CR>", { silent = true })

-- cycle between tabs and buffers
-- bufferline will determine it for us, auto matically
vim.keymap.set("n", "eh", ":BufferLineCyclePrev<cr>")
vim.keymap.set("n", "el", ":BufferLineCycleNext<cr>")

-- this moves a buffer back and forth
vim.keymap.set("n", "sh", ":BufferLineMovePrev<cr>")
vim.keymap.set("n", "sl", ":BufferLineMoveNext<cr>")

-- }}}

-- highlight on yank {{{
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
-- }}}

-- articblush and lualine config {{{
require("articblush").setup({
	italics = {
		code = true,
		comments = false,
	},
	nvim_tree = {
		contrast = true,
	},
})

-- brighter comments
-- I spent so much time finding these groups...
vim.api.nvim_set_hl(0, "Comment", { fg = "#999999" })
vim.api.nvim_set_hl(0, "SpecialComment", { fg = "#999999" })
vim.api.nvim_set_hl(0, "TSComment", { fg = "#999999" })

require("lualine").setup({
	options = {
		icons_enabled = true,
		component_separators = "|",
		section_separators = "",
		theme = "articblush",
	},
})

-- }}}

-- telescope config {{{
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
})

-- enable telescope fzf native, if installed
-- pcall is used so that when exceptions are thrown the script
-- still continues
pcall(require("telescope").load_extension, "fzf")

vim.keymap.set("n", "<C-p>", require("telescope.builtin").oldfiles, { desc = "<C-p> Find recently opened files" })

vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Keymaps" })

vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })

vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

vim.keymap.set("n", "<leader>?", require("telescope.builtin").keymaps, { desc = "Help!!!" })
-- }}}

-- nvim treesitter config {{{
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"cpp",
		"lua",
		"python",
		"tsx",
		"typescript",
		"help",
		"vim",
		"latex",
	},

	auto_install = true,

	highlight = {
		enable = true,
		-- let vimtex do the magic
		disable = { "latex" },
		additional_vim_regex_highlighting = { "latex", "markdown" },
	},
	indent = { enable = true, disable = { "python" } },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<M-space>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
})
-- }}}

-- diagnostics keymaps {{{
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
--- }}}

-- lspconfig configs {{{
local on_attach = function(_, bufnr)
	-- helper for mapping keys for nonrmal mode
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<F2>", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<C-x>", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")
end

local servers = {
	pyright = {},
	tsserver = {},
	lua_ls = {
		Lua = {
			format = { enable = false },
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
	yamlls = {},
	texlab = {},
	emmet_ls = {
		single_file_support = true,
	},
	html = {},
	cssls = {},
	jsonls = {},
	bashls = {},
	-- perlnavigator = {
	-- 	settings = {
	-- 		perlnavigator = {
	-- 			perlPath = "perl",
	-- 			enableWarnings = true,
	-- 			perltidyProfile = "",
	-- 			perlcriticProfile = "",
	-- 			perlcriticEnabled = true,
	-- 		},
	-- 	},
	-- },
	ltex = {
		-- I know this line is strange but it is how it works
		ltex = {
			language = "en-GB",
		},
	},
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
-- }}}

-- mason: ensure the servers above are installed {{{
require("mason").setup()

local mason_lspconfig = require("mason-lspconfig")

local ensure_installed = vim.tbl_keys(servers)

table.insert(ensure_installed, "prettierd")
table.insert(ensure_installed, "stylua")
table.insert(ensure_installed, "pyright")
table.insert(ensure_installed, "ltex_ls")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		})
	end,
})
--- }}}

-- nvim-cmp setup {{{
-- stolen from NvChad
-- local icons = {
-- 	Text = "",
-- 	Method = "",
-- 	Function = "",
-- 	Constructor = "",
-- 	Field = "ﰠ",
-- 	Variable = "",
-- 	Class = "ﴯ",
-- 	Interface = "",
-- 	Module = "",
-- 	Property = "ﰠ",
-- 	Unit = "塞",
-- 	Value = "",
-- 	Enum = "",
-- 	Keyword = "",
-- 	Snippet = "",
-- 	Color = "",
-- 	File = "",
-- 	Reference = "",
-- 	Folder = "",
-- 	EnumMember = "",
-- 	Constant = "",
-- 	Struct = "פּ",
-- 	Event = "",
-- 	Operator = "",
-- 	TypeParameter = "",
-- }

local cmp = require("cmp")

vim.opt.completeopt = "menuone,noselect"
local cmp_window = require("cmp.utils.window")

function cmp_window:has_scrollbar()
	return false
end

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),

		-- use tabs to navigate the list
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "ultisnips" }, -- For ultisnips users.
	}, {
		{ name = "buffer" },
	}),
})
-- }}}

-- neodev: setup neovim lua configuration {{{
require("neodev").setup()
--- }}}

-- formatter setup {{{
local util = require("formatter.util")
local prettierd = function(lang)
	return { require("formatter.filetypes." .. lang).prettierd }
end
local clang = function()
	-- check if there is a speicifc project file, or else use default
	local f = io.open(".clang-format", "r")
	local style = "-style=file"
	if f == nil then
		style = '-style="{IndentWidth: ' .. vim.api.nvim_buf_get_option(0, "tabstop") .. '}"'
	end
	return {
		function()
			return {
				exe = "clang-format",
				args = {
					style,
					"-assume-filename",
					util.escape_path(util.get_current_buffer_file_name()),
				},
				stdin = true,
				try_node_modules = true,
			}
		end,
	}
end

require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		c = clang(),
		cpp = clang(),
		typescript = prettierd("typescript"),
		javascript = prettierd("javascript"),
		-- markdown = prettierd("markdown"),
		html = prettierd("html"),
		css = prettierd("css"),
		javascriptreact = prettierd("javascriptreact"),
		typescriptreact = prettierd("typescriptreact"),
		json = prettierd("json"),
		yaml = { require("formatter.filetypes.yaml").yamlfmt },
		python = {
			function()
				return {
					exe = "autopep8",
					args = { "-a", "-" },
					stdin = 1,
				}
			end,
		},
		sh = { require("formatter.filetypes.sh").shellfmt },
		lua = {
			require("formatter.filetypes.lua").stylua,
			exe = "stylua",
			args = {
				"--call-parentheses=None",
				"--indent-width=2",
				"--column-width=80",
				"--indent-type=Spaces",
				"--search-parent-directories",
				"--stdin-filepath",
				util.escape_path(util.get_current_buffer_file_path()),
				"--",
				"-",
			},
			stdin = true,
		},
		-- fallback
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

local format_auto_group = vim.api.nvim_create_augroup("FormatAutoGroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		vim.cmd("FormatWrite")
	end,
	group = format_auto_group,
	pattern = "*",
})

-- }}}

-- toggle term setup {{{
-- local nvimtree = require("nvim-tree")
-- local nvimtree_view = require("nvim-tree.view")

-- local function set_nvimtree_when_open_term(terminal)
-- 	if nvimtree_view.is_visible() and terminal.direction == "horizontal" then
-- 		local nvimtree_width = vim.fn.winwidth(nvimtree_view.get_winnr())
-- 		nvimtree.toggle()
-- 		nvimtree_view.View.width = nvimtree_width
-- 		nvimtree.toggle(false, true)
-- 	end
-- end

require("toggleterm").setup({
	direction = "horizontal",
	insert_mappings = true,
	persist_size = true,
	start_in_insert = true,
	float_opts = {
		border = "single",
		width = 120,
		height = 50,
		winblend = 3,
	},
	-- on_open = set_nvimtree_when_open_term,
})
-- }}}

-- nvim tree setup {{{
require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = 30,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
			},
		},
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
	},
})
-- }}}

-- other plugin setups {{{
require("bufferline").setup()
require("nvim-autopairs").setup()
-- }}}
