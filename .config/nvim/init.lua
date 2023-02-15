-- Remap space as leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- SETTINGS
vim.opt.termguicolors = true -- Use full colors
vim.opt.background = "light" -- Background color
vim.o.hlsearch = false -- No highlight on search
vim.opt.clipboard = "unnamedplus" -- Share system clipboard
vim.opt.cursorline = true -- Highlight cursor line
vim.opt.colorcolumn = "88" -- Colorcolumn is 88
vim.opt.matchpairs:append({ "<:>" }) -- Highlights matching brackets - '%' to jump between them
vim.opt.showmode = false -- -- INSERT -- is not shown
vim.opt.signcolumn = "yes" -- Always show signcolumn
vim.opt.relativenumber = true -- Hybrid line numbers
vim.opt.number = true -- Hybrid line numbers
vim.opt.scrolloff = 8 -- Shows 8 lines under mouse when moving the file
-- Tabs and indent
vim.opt.tabstop = 4 -- Tab stops at 4 spaces
vim.opt.softtabstop = 4 -- Tab stops at 4 spaces
vim.opt.shiftwidth = 4 -- Default shift
vim.opt.expandtab = true -- Default tabs
vim.opt.smartindent = true -- Default tabs
-- Menus, search and completion
vim.opt.ignorecase = true -- Ignores case in search
vim.opt.smartcase = true -- Uses smartcase in search
vim.opt.incsearch = true -- Search incrementally
vim.opt.magic = true -- Magic for regex
vim.opt.wildmenu = true -- Use wildmenu
vim.opt.wildmode = "longest:full,full" -- First tab completes longest common string
vim.opt.completeopt = "menuone,noselect" -- Completion menu options
-- Misc
vim.opt.foldmethod = "expr" -- Use folding expression
vim.opt.foldlevel = 99 -- Never fold by default
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.eb = false -- No error bells
vim.opt.swapfile = false -- No swap file
vim.opt.backup = false -- No backup file
vim.opt.undofile = true -- Makes undofile for history
vim.opt.lazyredraw = true -- No redraw
vim.opt.updatetime = 100 -- Default is 4000 - less updates
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add" -- location of spellfile

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap to switch windows with Ctrl + hjkl
vim.keymap.set("n", "<C-J>", "<C-W>j", { silent = true })
vim.keymap.set("n", "<C-K>", "<C-W>k", { silent = true })
vim.keymap.set("n", "<C-L>", "<C-W>l", { silent = true })
vim.keymap.set("n", "<C-H>", "<C-W>h", { silent = true })

-- Quickfix list mappings
vim.keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "[Q]uickfix [O]pen" })
vim.keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "[Q]uickfix [C]lose" })
vim.keymap.set("n", "<leader>qj", ":cnext<CR>", { desc = "[Q]uickfix Next [J]" })
vim.keymap.set("n", "<leader>qk", ":cprev<CR>", { desc = "[Q]uickfix Previous [K]" })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "[D]iagnostics: Open [E]rrors" })
vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { desc = "[D]iagnostics: Goto Previous [K]" })
vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { desc = "[D]iagnostics: Goto Next [J]]" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "[D]iagnostics: Set [Q]uickfix" })

-- Show diagnostic source on diagnostic window
vim.diagnostic.config({
	float = {
		source = "always",
	},
	virtual_text = false,
})

-- PLUGIN SETTINGS
-- Ensure lazy.nvim (plugin manager) is installed
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

-- Install and setup plugins with lazy.nvim
require("lazy").setup({
	{
		"ishan9299/modus-theme-vim", -- Vim port of Modus themes
		config = function()
			vim.cmd("colorscheme modus-operandi")
		end,
	},

	{
		"numToStr/Comment.nvim", -- "gc" to comment visual regions/lines
		config = true,
	},

	{
		"norcalli/nvim-colorizer.lua", -- Highlight colors and colorcodes
		config = true,
	},

	{
		"nvim-lualine/lualine.nvim", -- Fancier statusline
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = false,
					theme = "auto",
					component_separators = "|",
					section_separators = "",
				},
				winbar = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { { "filename", file_status = true, path = 1 } },
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim", -- Add indentation guides
		config = function()
			require("indent_blankline").setup({
				char = "┊",
				show_trailing_blankline_indent = false,
			})
		end,
	},

	"jose-elias-alvarez/null-ls.nvim", -- Null ls is used for code formatting and pylint analysis

	"L3MON4D3/LuaSnip", -- Snippets plugin

	{
		"windwp/nvim-autopairs", -- Automatically close pairs
		event = "InsertEnter",
		config = true,
	},

	{
		"lewis6991/gitsigns.nvim", -- Git info in sign column and popups
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			})
		end,
	},

	{
		"ludovicchabant/vim-gutentags", -- Automatic tags management
		config = function()
			vim.g.gutentags_cache_dir = vim.fn.stdpath("config") .. "/gutentags"
		end,
	},

	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
			require("which-key").setup({
				plugins = {
					spelling = {
						enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
						suggestions = 20, -- how many suggestions should be shown in the list?
					},
				},
			})
		end,
	},

	{
		"nvim-telescope/telescope.nvim", -- Telescope fuzzy finder
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim", -- Fzf port for telescope
				build = "make",
			},
		},
		config = function()
			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
				},
				defaults = {
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
						},
					},
				},
			})
			require("telescope").load_extension("fzf")

			--Add leader shortcuts
			vim.keymap.set(
				"n",
				"<leader><space>",
				require("telescope.builtin").buffers,
				{ desc = "Telescope: Show Buffers" }
			)
			vim.keymap.set("n", "<leader>sf", function()
				require("telescope.builtin").find_files({ previewer = false })
			end, { desc = "Telescope: [S]earch [F]iles" })
			vim.keymap.set(
				"n",
				"<leader>sb",
				require("telescope.builtin").current_buffer_fuzzy_find,
				{ desc = "Telescope: [S]earch in [B]uffers" }
			)
			vim.keymap.set(
				"n",
				"<leader>sh",
				require("telescope.builtin").help_tags,
				{ desc = "Telescope: [S]earch [H]elp Tags" }
			)
			vim.keymap.set(
				"n",
				"<leader>st",
				require("telescope.builtin").tags,
				{ desc = "Telescope: [S]earch [T]ags" }
			)
			vim.keymap.set(
				"n",
				"<leader>ss",
				require("telescope.builtin").grep_string,
				{ desc = "Telescope: [S]earch [S]tring Under Cursor" }
			)
			vim.keymap.set(
				"n",
				"<leader>sl",
				require("telescope.builtin").live_grep,
				{ desc = "Telescope: [S]earch [L]ive Grep" }
			)
			vim.keymap.set(
				"n",
				"<leader>?",
				require("telescope.builtin").oldfiles,
				{ desc = "Telescope: [S]earch Recently Open Files [?]" }
			)
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter", -- Highlight, edit, and navigate code
		build = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects", -- Additional text objects via treesitter
			"windwp/nvim-ts-autotag", -- Automatically close html/xml tags
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"html",
					"javascript",
					"python",
					"lua",
					"css",
					"bash",
					"go",
					"gomod",
					"dockerfile",
					"gitcommit",
					"json",
					"latex",
					"rst",
					"markdown",
					"yaml",
					"help",
					"vim",
				},
				highlight = {
					enable = true,
				},
				autotag = {
					enable = true,
					filetypes = { "html", "xml" },
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
					},
				},
				indent = {
					enable = true,
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
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
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Folding provided by treesitter
			-- Treesitter has no native xml parser so fallback to html
			require("nvim-treesitter.parsers").filetype_to_parsername.xml = "html"
		end,
	},

	{
		"neovim/nvim-lspconfig", -- Collection of configurations for built-in LSP client
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{
				"j-hui/fidget.nvim", -- Useful status updates for LSP
				config = true,
			},
		},
	},

	{
		"hrsh7th/nvim-cmp", -- Autocompletion plugin
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- Autocompletion with LSPs
			"hrsh7th/cmp-buffer", -- Autocompletion from words in buffer
			"hrsh7th/cmp-path", -- Autocompletion from files
			"hrsh7th/cmp-cmdline", -- Autocompletion for nvim commands
			"saadparwaiz1/cmp_luasnip", -- Snippets autocompletion
		},
	},

	{
		"kyazdani42/nvim-tree.lua", -- File tree browser
		cmd = "NvimTreeToggle",
		keys = {
			{ "<leader>t", "<cmd>NvimTreeToggle", desc = "nvim-tree" },
		},
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			-- NVIM-TREE
			require("nvim-tree").setup()
			vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { desc = "Open Nvim [T]ree", silent = true })
		end,
	},
})

-- LUASNIP
local luasnip = require("luasnip")
require("luasnip.loaders.from_snipmate").load()

-- LSP PLUGINS AND SETTINGS
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local on_attach = function(_, bufnr)
	-- Theme, colors and gui
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame" })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction" })

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition" })
	vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "LSP: [G]oto [R]eferences" })
	vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "LSP: [G]oto [I]mplementation" })
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "LSP: Type [D]efinition" })
	vim.keymap.set(
		"n",
		"<leader>ds",
		require("telescope.builtin").lsp_document_symbols,
		{ desc = "[D]ocument [S]ymbols" }
	)
	vim.keymap.set(
		"n",
		"<leader>ws",
		require("telescope.builtin").lsp_dynamic_workspace_symbols,
		{ desc = "[W]orkspace [S]ymbols" }
	)

	-- See `:help K` for why this keymap
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation" })
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation" })

	-- Lesser used LSP functionality
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration" })
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "LSP: [W]orkspace [A]dd Folder" })
	vim.keymap.set(
		"n",
		"<leader>wr",
		vim.lsp.buf.remove_workspace_folder,
		{ desc = "LSP: [W]orkspace [R]emove Folder" }
	)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { desc = "LSP: [W]orkspace [L]ist Folders" })

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "LSP: Format Current Buffer" })
end

-- Create dictionary word list for ltex lsp from vim spellfile
local words = {}
for word in io.open(vim.fn.stdpath("config") .. "/spell/en.utf-8.add", "r"):lines() do
	table.insert(words, word)
end

-- Server list for LSP
local servers = {
	pyright = {},
	eslint = {
		codeAction = {
			disableRuleComment = {
				enable = true,
				location = "separateLine",
			},
			showDocumentation = {
				enable = true,
			},
		},
		codeActionOnSave = {
			enable = false,
			mode = "all",
		},
		format = false,
		nodePath = "",
		onIgnoredFiles = "off",
		packageManager = "npm",
		quiet = false,
		rulesCustomizations = {},
		run = "onType",
		useESLintClass = false,
		validate = "on",
		workingDirectory = {
			mode = "location",
		},
	},
	bashls = {},
	cssls = {},
	html = {},
	jsonls = {},
	lemminx = {},
	ltex = {
		ltex = {
			dictionary = {
				["en-US"] = words,
			},
		},
	},
	gopls = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
}

-- MASON.NVIM
require("mason").setup()

-- MASON-LSPCONFIG.NVIM
local mason_lspconfig = require("mason-lspconfig")
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

-- NULL-LS.NVIM
-- LSP formatting filter
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- Ignore formatting from these LSPs
			local lsp_formatting_denylist = {
				eslint = true,
				lemminx = true,
				lua_ls = true,
			}
			if lsp_formatting_denylist[client.name] then
				return false
			end
			return true
		end,
		bufnr = bufnr,
	})
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
	sources = {
		require("null-ls").builtins.formatting.prettier.with({
			extra_filetypes = { "xml" },
		}),
		require("null-ls").builtins.formatting.black.with({
			extra_args = { "--experimental-string-processing" }, -- Enable experimental split long strings flag
		}),
		require("null-ls").builtins.formatting.djlint,
		require("null-ls").builtins.formatting.isort,
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.shfmt,
		require("null-ls").builtins.diagnostics.djlint,
		require("null-ls").builtins.diagnostics.flake8,
		require("null-ls").builtins.diagnostics.pylint.with({
			extra_args = { "--load-plugins=pylint_odoo", "-e", "odoolint" }, -- Load pylint_odoo plugin for pylint
		}),
	},
})

-- NVIM-CMP
local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "buffer", keyword_length = 4 },
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer", keyword_length = 3 },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline", keyword_length = 3 },
	}),
})
