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

-- Helix inspired keybindings
vim.keymap.set("n", "gh", "0", { desc = "[G]oto Beginning of Line [H]", silent = true })
vim.keymap.set("n", "gl", "$", { desc = "[G]oto End of Line [L]", silent = true })
vim.keymap.set("n", "U", "<C-R>", { desc = "Redo", silent = true })

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

-- Keymap to jump to my notes file
vim.keymap.set("n", "<leader>n", ":edit ~/Documents/notes.md<CR>G", { desc = "Jump to [N]otes" })

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
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup({
				indent = { char = "┊" },
			})
		end,
	},

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
					file_ignore_patterns = { "i18n" },
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
				{ desc = "Telescope: [S]earch Current [B]buffer" }
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
					"vimdoc",
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
			vim.treesitter.language.register("html", "xml")
		end,
	},

	{
		"neovim/nvim-lspconfig", -- Collection of configurations for built-in LSP client
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	},

	{
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				python = { "pylint", "flake8" },
				htmldjango = { "djlint" },
				rst = { "rstcheck" },
			}
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},

	{
		"stevearc/conform.nvim", -- Non LSP code formatting
		opts = {},
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

	{
		"mickael-menu/zk-nvim", -- Note taking with Zettelkasten method
		config = function()
			require("zk").setup({
				picker = "telescope",

				lsp = {
					config = {
						cmd = { "zk", "lsp" },
						name = "zk",
					},

					-- automatically attach buffers in a zk notebook that match the given filetypes
					auto_attach = {
						enabled = true,
						filetypes = { "markdown" },
					},
				},
			})
			-- Create a new note after asking for its title.
			vim.api.nvim_set_keymap(
				"n",
				"<leader>zn",
				"<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>",
				{ noremap = true, silent = false, desc = "[Z]k [N]ew Note" }
			)

			-- Open notes.
			vim.api.nvim_set_keymap(
				"n",
				"<leader>zo",
				"<Cmd>ZkNotes { sort = { 'modified' } }<CR>",
				{ noremap = true, silent = false, desc = "[Z]k [O]pen Notes" }
			)
			-- Open notes associated with the selected tags.
			vim.api.nvim_set_keymap(
				"n",
				"<leader>zt",
				"<Cmd>ZkTags<CR>",
				{ noremap = true, silent = false, desc = "[Z]k Open Notes with [T]ags" }
			)

			-- Search for the notes matching a given query.
			vim.api.nvim_set_keymap(
				"n",
				"<leader>zf",
				"<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
				{ noremap = true, silent = false, desc = "[Z]k [F]ind Notes" }
			)
			-- Search for the notes matching the current visual selection.
			vim.api.nvim_set_keymap(
				"v",
				"<leader>zf",
				":'<,'>ZkMatch<CR>",
				{ noremap = true, silent = false, desc = "[Z]k [F]ind Notes" }
			)

			-- Add the key mappings only for Markdown files in a zk notebook.
			if require("zk.util").notebook_root(vim.fn.expand("%:p")) ~= nil then
				local function map(...)
					vim.api.nvim_buf_set_keymap(0, ...)
				end

				-- Open the link under the caret.
				map(
					"n",
					"<CR>",
					"<Cmd>lua vim.lsp.buf.definition()<CR>",
					{ noremap = true, silent = false, desc = "Open Link Under Caret" }
				)

				-- Create a new note after asking for its title.
				-- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
				map(
					"n",
					"<leader>zn",
					"<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
					{ noremap = true, silent = false, desc = "[Z]k [N]ew Note in Current Directory" }
				)
				-- Create a new note in the same directory as the current buffer, using the current selection for title.
				map("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", {
					noremap = true,
					silent = false,
					desc = "[Z]k [N]ew Note in Current Directory with Selection as [T]itle",
				})
				-- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
				map(
					"v",
					"<leader>znc",
					":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
					{
						noremap = true,
						silent = false,
						desc = "[Z]k [N]ew Note in Current Directory with Selection as [C]ontent",
					}
				)

				-- Open notes linking to the current buffer.
				map(
					"n",
					"<leader>zb",
					"<Cmd>ZkBacklinks<CR>",
					{ noremap = true, silent = false, desc = "[Z]k Open [B]acklinks" }
				)
				-- Alternative for backlinks using pure LSP and showing the source context.
				--map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
				-- Open notes linked by the current buffer.
				map(
					"n",
					"<leader>zl",
					"<Cmd>ZkLinks<CR>",
					{ noremap = true, silent = false, desc = "[Z]k Open Back[L]inks with LSP" }
				)

				-- Preview a linked note.
				map(
					"n",
					"<leader>zp",
					"<Cmd>lua vim.lsp.buf.hover()<CR>",
					{ noremap = true, silent = false, desc = "[Z]k [P]review Linked Note" }
				)
				-- Open the code actions for a visual selection.
				map(
					"v",
					"<leader>za",
					":'<,'>lua vim.lsp.buf.range_code_action()<CR>",
					{ noremap = true, silent = false, desc = "[Z]k Code [A]ctions" }
				)
			end
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
	vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP [C]: [R]ename" })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP [C]: Code [A]ction" })
	vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "LSP [C]: Goto [D]efinition" })
	vim.keymap.set("n", "<leader>ct", vim.lsp.buf.type_definition, { desc = "LSP [C]: [T]ype Definition" })
	vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "LSP [C]: [H]over Documentation" })
	vim.keymap.set(
		"n",
		"<leader>sr",
		require("telescope.builtin").lsp_references,
		{ desc = "Telescope: Search [R]eferences" }
	)
	vim.keymap.set(
		"n",
		"<leader>sd",
		require("telescope.builtin").lsp_document_symbols,
		{ desc = "Telescope: Search [D]ocument Symbols" }
	)

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

-- CONFORM
require("conform").setup({
	formatters = {
		black = {
			prepend_args = { "--preview" },
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		html = { "prettier" },
		htmldjango = { "djlint" },
		xml = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		sh = { "shfmt" },
		markdown = { "prettier" },
		["*"] = { "codespell" },
		-- Use the "_" filetype to run formatters on filetypes that don't
		-- have other formatters configured.
		["_"] = { "trim_whitespace" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 5000,
		lsp_fallback = true,
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

vim.lsp.set_log_level("info")
