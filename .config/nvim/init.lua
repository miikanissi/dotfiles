--Remap space as leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- SETTINGS
vim.opt.termguicolors = true -- Use full colors
vim.opt.background = "light" -- Background color
vim.o.hlsearch = true -- Highlight on search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear search on escape
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
vim.opt.completeopt = "menuone,noselect,noinsert,popup" -- Completion menu options
-- Misc
vim.opt.foldmethod = "expr" -- Use folding expression
vim.opt.foldlevel = 99 -- Never fold by default
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.eb = false -- No error bells
vim.opt.swapfile = false -- No swap file
vim.opt.backup = false -- No backup file
vim.opt.undofile = true -- Makes undofile for history
vim.opt.lazyredraw = true -- No redraw
vim.opt.updatetime = 200 -- Default is 4000 - more updates
vim.opt.timeoutlen = 300 -- Default is 1000 - faster
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add" -- location of spellfile
vim.opt.splitbelow = true -- Split opened below instead of above
vim.opt.splitright = true -- Split opened to the right instead of left
-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

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
		"miikanissi/modus-themes.nvim", -- Modus themes
		priority = 1000,
		config = function()
			require("modus-themes").setup({
				hide_inactive_statusline = true,
				line_nr_column_background = false,
				sign_column_background = false,
			})
			vim.cmd.colorscheme("modus")
		end,
	},

	{
		"NvChad/nvim-colorizer.lua", -- Highlight colors and colorcodes
		opts = { user_default_options = { names = false } },
	},

	{
		"nvim-lualine/lualine.nvim", -- Fancier statusline
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VimEnter",
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = "|",
				section_separators = "",
			},
			sections = {
				lualine_c = {
					{
						"filename",
						file_status = false,
						path = 3,
					},
				},
			},
			inactive_sections = {
				lualine_c = {
					{
						"filename",
						file_status = false,
						path = 1,
					},
				},
			},
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim", -- Add indentation guides
		main = "ibl",
		event = "VimEnter",
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}
			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			vim.g.rainbow_delimiters = { highlight = highlight }
			require("ibl").setup({ scope = { highlight = highlight }, indent = { char = "┊" } })

			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},

	{
		"lewis6991/gitsigns.nvim", -- Git tools and info in sign column and popups
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "VimEnter",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Git: Next Git [C]hange" })

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Git: Previous Git [C]hange" })

				-- Actions
				-- visual mode
				map("v", "<leader>gs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Git: [s]tage hunk" })
				map("v", "<leader>gr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Git: [r]eset hunk" })
				-- normal mode
				map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Git: [s]tage hunk" })
				map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Git: [r]eset hunk" })
				map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Git: [S]tage buffer" })
				map("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "Git: [u]ndo stage hunk" })
				map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Git: [R]eset buffer" })
				map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Git: [p]review hunk" })
				map("n", "<leader>gb", gitsigns.blame_line, { desc = "Git: [b]lame line" })
				map("n", "<leader>gd", gitsigns.diffthis, { desc = "Git: [d]iff against index" })
				map("n", "<leader>gD", function()
					gitsigns.diffthis("@")
				end, { desc = "Git: [D]iff against last commit" })
				-- Toggles
				map(
					"n",
					"<leader>gt",
					gitsigns.toggle_current_line_blame,
					{ desc = "Git: [t]oggle git show blame line" }
				)
				map("n", "<leader>gT", gitsigns.toggle_deleted, { desc = "Git: [T]oggle git show deleted" })
			end,
		},
	},

	{
		"romgrk/barbar.nvim", -- Tab bar with buffers
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			vim.g.barbar_auto_setup = false
			-- Move to next/previous
			vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", { desc = "Go to Next Buffer" })
			vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { desc = "Go to Previous Buffer" })
			-- Re-order to next/preivous
			vim.keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { desc = "Re-order Buffer to Previous" })
			vim.keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { desc = "Re-order Buffer to Next" })
			-- Goto buffer in position...
			vim.keymap.set("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", { desc = "Go to Buffer 1" })
			vim.keymap.set("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", { desc = "Go to Buffer 2" })
			vim.keymap.set("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", { desc = "Go to Buffer 3" })
			vim.keymap.set("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", { desc = "Go to Buffer 4" })
			vim.keymap.set("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", { desc = "Go to Buffer 5" })
			vim.keymap.set("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", { desc = "Go to Buffer 6" })
			vim.keymap.set("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", { desc = "Go to Buffer 7" })
			vim.keymap.set("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", { desc = "Go to Buffer 8" })
			vim.keymap.set("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", { desc = "Go to Buffer 9" })
			vim.keymap.set("n", "<A-0>", "<Cmd>BufferLast<CR>", { desc = "Go to Last Buffer" })
			-- Toggle buffer pin/unpin
			vim.keymap.set("n", "<A-p>", "<Cmd>BufferPin<CR>", { desc = "Toggle Buffer [P]in" })
			vim.keymap.set("n", "<A-S-c>", "<Cmd>BufferClose<CR>", { desc = "[Q]uit Buffer" })
			vim.keymap.set("n", "<A-u>", "<Cmd>BufferRestore<CR>", { desc = "[U]ndo/Restore Closed Buffer" })
		end,
		opts = { icons = { buffer_index = true } },
	},

	{
		"folke/which-key.nvim", -- Document keybinds
		event = "VeryLazy",
		opts = {
			plugins = {
				spelling = {
					enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
					suggestions = 20, -- how many suggestions should be shown in the list?
				},
			},
			spec = {
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>c_", hidden = true },
				{ "<leader>d", group = "[D]iagnostics" },
				{ "<leader>d_", hidden = true },
				{ "<leader>g", group = "[G]it", mode = { "n", "v" } },
				{ "<leader>g_", hidden = true },
				{ "<leader>h", group = "[H]elp / Copilot" },
				{ "<leader>h_", hidden = true },
				{ "<leader>q", group = "[Q]uickfix" },
				{ "<leader>q_", hidden = true },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>s_", hidden = true },
				{ "<leader>z", group = "[Z]k Notes" },
				{ "<leader>z_", hidden = true },
			},
		},
	},

	{
		"ibhagwan/fzf-lua", -- Fuzzy finder / search
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VimEnter",
		config = function()
			require("fzf-lua").setup({
				fzf_colors = {
					["fg"] = { "fg", "CursorLine" },
					["bg"] = { "bg", "Normal" },
					["hl"] = { "fg", "Comment" },
					["fg+"] = { "fg", "Normal" },
					["bg+"] = { "bg", "CursorLine" },
					["hl+"] = { "fg", "Statement" },
					["info"] = { "fg", "PreProc" },
					["prompt"] = { "fg", "Conditional" },
					["pointer"] = { "fg", "Exception" },
					["marker"] = { "fg", "Keyword" },
					["spinner"] = { "fg", "Label" },
					["header"] = { "fg", "Comment" },
					["gutter"] = "-1",
				},
			})
			--Add leader shortcuts
			vim.keymap.set("n", "<leader>sb", require("fzf-lua").buffers, { desc = "Fzf: [B]uffers" })
			vim.keymap.set("n", "<leader>sf", require("fzf-lua").files, { desc = "Fzf: [F]iles" })
			vim.keymap.set("n", "<leader>sh", require("fzf-lua").help_tags, { desc = "Fzf: [H]elp Tags" })
			vim.keymap.set("n", "<leader>ss", require("fzf-lua").grep_cword, { desc = "Fzf: [S]tring Under Cursor" })
			vim.keymap.set("n", "<leader>sl", require("fzf-lua").live_grep, { desc = "Fzf: [L]ive Grep" })
			vim.keymap.set("n", "<leader>so", require("fzf-lua").oldfiles, { desc = "Fzf: [O]ld Files" })
			vim.keymap.set("n", "<leader>so", require("fzf-lua").oldfiles, { desc = "Fzf: [O]ld Files" })
			vim.keymap.set("n", "<leader>s.", require("fzf-lua").resume, { desc = "Fzf: Resume" })
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter", -- Highlight, edit, and navigate code
		build = ":TSUpdateSync",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects", -- Additional text objects via treesitter
			"windwp/nvim-ts-autotag", -- Automatically close html/xml tags
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"comment",
					"css",
					"csv",
					"diff",
					"go",
					"gomod",
					"git_config",
					"git_rebase",
					"gitcommit",
					"gitignore",
					"html",
					"htmldjango",
					"javascript",
					"json",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"python",
					"rst",
					"scss",
					"sql",
					"vim",
					"vimdoc",
					"xml",
					"yaml",
				},
				highlight = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						scope_incremental = "grc",
						node_incremental = "v",
						node_decremental = "V",
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
			require("nvim-ts-autotag").setup({})
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Folding provided by treesitter
		end,
	},

	{
		"neovim/nvim-lspconfig", -- Collection of configurations for built-in LSP client
		dependencies = {
			-- Automatically install LSPs and tools to stdpath for neovim
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local lsp_group = vim.api.nvim_create_augroup("mn-lsp-attach", { clear = true })
			vim.api.nvim_create_autocmd("LspAttach", {
				group = lsp_group,
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("<leader>cr", vim.lsp.buf.rename, "[R]ename")
					map("<leader>ca", vim.lsp.buf.code_action, "Code [A]ction")
					map("<leader>cd", vim.lsp.buf.definition, "Goto [D]efinition")
					map("<leader>ct", vim.lsp.buf.type_definition, "[T]ype Definition")
					map("<leader>ch", vim.lsp.buf.hover, "[H]over Documentation")
					map("<leader>sr", require("fzf-lua").lsp_references, "[R]eferences")
					map("<leader>sd", require("fzf-lua").lsp_document_symbols, "[D]ocument Symbols")

					-- Highlight references under cursor
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup = vim.api.nvim_create_augroup("mn-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
					end
					-- Enable inlay hints on insert mode
					-- vim.api.nvim_create_autocmd("InsertEnter", {
					-- 	buffer = event.buf,
					-- 	callback = function()
					-- 		vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
					-- 	end,
					-- 	group = lsp_group,
					-- })
					-- vim.api.nvim_create_autocmd("InsertLeave", {
					-- 	buffer = event.buf,
					-- 	callback = function()
					-- 		vim.lsp.inlay_hint.enable(false, { bufnr = event.buf })
					-- 	end,
					-- 	group = lsp_group,
					-- })
				end,
			})
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("mn-lsp-detach", { clear = true }),

				callback = function(event)
					vim.lsp.buf.clear_references()

					local _, _ = pcall(function()
						vim.api.nvim_clear_autocmds({ group = "mn-lsp-highlight", buffer = event.buf })
					end)
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local words = {}
			for word in io.open(vim.fn.stdpath("config") .. "/spell/en.utf-8.add", "r"):lines() do
				table.insert(words, word)
			end

			local servers = {
				eslint = {
					settings = {
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
				},
				bashls = {},
				cssls = {},
				html = {},
				jsonls = {},
				ltex = {
					settings = {
						ltex = {
							dictionary = {
								["en-US"] = words,
							},
						},
					},
				},
				gopls = {},
				lua_ls = {
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							telemetry = { enable = false },
							diagnostics = {
								globals = { "vim", "awesome" },
							},
							hint = { enable = true },
						},
					},
				},
				jedi_language_server = {
					init_options = {
						diagnostics = { enable = false },
					},
				},
				ruff = {},
			}

			local tools = {
				{ "stylua" },
				{ "shfmt" },
				{ "prettier" },
				{ "djlint" },
				{ "pylint" },
				{ "rstcheck" },
				{ "sqlfluff" },
			}

			-- MASON.NVIM
			require("mason").setup({
				ensure_installed = tools, -- not an option from mason.nvim, we install these manually below
				max_concurrent_installers = 10,
			})

			local mason_registry = require("mason-registry")

			-- Install additional tools not provided by mason-registry after installing the main tools
			mason_registry:on("package:install:success", function(pkg)
				-- Install additional tool for pylint
				if pkg.name == "pylint" then
					require("plenary.job")
						:new({
							command = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/pylint/venv/bin/pip"),
							args = { "install", "pylint-odoo" },
							cwd = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/pylint"),
							on_exit = function(_, return_val)
								if return_val == 0 then
									vim.print("pylint-odoo was successfully installed")
								else
									vim.print("failed to install pylint-odoo")
								end
							end,
						})
						:start()
				end
			end)

			-- Install tools
			mason_registry.refresh(function()
				for _, tool in ipairs(tools) do
					local pkg_name = tool[1]
					local version = tool.version
					local pkg = require("mason-registry").get_package(pkg_name)

					-- Define a callback function to handle the result of get_installed_version
					local function ensure_installed_version(success, installed_version_or_err)
						if success then
							-- If the installed version is different from the desired version, install the package with the desired version
							if version and installed_version_or_err ~= version then
								pkg:install({ version = version })
							end
						else
							print(
								"Error getting installed version for " .. pkg_name .. ": " .. installed_version_or_err
							)
						end
					end

					-- Check if the package is installed and ensure it is the correct version
					if pkg:is_installed() then
						pkg:get_installed_version(ensure_installed_version)
					-- If the package is not installed, install it
					else
						pkg:install({ version = version })
					end
				end
			end)

			-- MASON-LSPCONFIG.NVIM
			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers or {}),
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{
		"mfussenegger/nvim-lint", -- Non LSP code linting
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		opts = {
			events = { "BufWritePost", "BufReadPost", "InsertLeave" },
			linters_by_ft = {
				python = { "pylint" },
				htmldjango = { "djlint" },
				rst = { "rstcheck" },
				sql = { "sqlfluff" },
				psql = { "sqlfluff" },
			},
		},
		config = function(_, opts)
			local lint = require("lint")

			lint.linters_by_ft = opts.linters_by_ft

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd(opts.events, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},

	{
		"stevearc/conform.nvim", -- Non LSP code formatting
		lazy = false,
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat Current Buffer",
			},
		},
		opts = {
			notify_on_error = false,
			formatters = {
				injected = {
					options = { ignore_errors = true },
				},
				sqlfluff = {
					args = { "fix", "--dialect", "postgres", "-" },
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
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
				sql = { "sqlfluff" },
				psql = { "sqlfluff" },
				markdown = { "prettier", "injected" },
				["*"] = { "injected" },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				["_"] = { "trim_whitespace" },
			},
		},
	},

	{
		"hrsh7th/nvim-cmp", -- Autocompletion plugin
		event = "VimEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- Autocompletion with LSPs
			"hrsh7th/cmp-buffer", -- Autocompletion from words in buffer
			"hrsh7th/cmp-path", -- Autocompletion from files
			"hrsh7th/cmp-cmdline", -- Autocompletion for nvim commands
			{ "L3MON4D3/LuaSnip", version = "v2.*" }, -- Snippets plugin
			"saadparwaiz1/cmp_luasnip", -- Snippets autocompletion
			"windwp/nvim-autopairs", -- Automatically close pairs
			"zbirenbaum/copilot.lua", -- GitHub Copilot integration
			"zbirenbaum/copilot-cmp", -- GitHub Copilot as a completion source
			{ "CopilotC-Nvim/CopilotChat.nvim", branch = "main", build = "make tiktoken" }, -- GitHub Copilot chat
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local cmp = require("cmp")

			-- Copilot setup
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
			require("copilot_cmp").setup()
			require("CopilotChat").setup({
				model = "claude-3.5-sonnet",
				question_header = "## Miika",
				chat_autocomplete = true,
				context = "buffers",
				-- default mappings
				mappings = {
					complete = {
						insert = "",
					},
					close = {
						normal = "q",
						insert = "",
					},
					reset = {
						normal = "<C-l>",
						insert = "",
					},
					submit_prompt = {
						normal = "<CR>",
						insert = "<C-s>",
					},
					accept_diff = {
						normal = "<C-y>",
						insert = "<C-y>",
					},
					yank_diff = {
						normal = "gy",
					},
					show_diff = {
						normal = "gd",
					},
					show_info = {
						normal = "gi",
					},
					show_context = {
						normal = "gs",
					},
				},
			})

			local copilot_map = function(keys, func, desc)
				vim.keymap.set({ "n", "v" }, keys, func, { desc = "Copilot: " .. desc })
			end

			copilot_map("<leader>ho", ":CopilotChat<CR>", "[O]pen")
			copilot_map("<leader>he", ":CopilotChatExplain<CR>", "[E]xplain Selection")
			copilot_map("<leader>hr", ":CopilotChatReview<CR>", "[R]eview Selection")
			copilot_map("<leader>hf", ":CopilotChatFix<CR>", "[F]ix Selection")
			copilot_map("<leader>hi", ":CopilotChatOptimize<CR>", "[I]mprove / Optimize Selection")
			copilot_map("<leader>hd", ":CopilotChatDocs<CR>", "Create [D]ocumentation for Selection")
			copilot_map("<leader>ht", ":CopilotChatTests<CR>", "Create [T]ests for Selection")
			copilot_map("<leader>hc", ":CopilotChatStop<CR>", "[C]cancel Current Output")
			copilot_map("<leader>hs", ":CopilotChatSave ", "[S]ave Chat History")
			copilot_map("<leader>hl", ":CopilotChatLoad ", "[L]oad Chat History")

			-- LuaSnip setup
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load({ paths = "./vscode-snippets/" })
			local luasnip_types = require("luasnip.util.types")
			luasnip.config.setup({
				ext_opts = {
					[luasnip_types.choiceNode] = {
						active = {
							virt_text = { { "●", "TSRainbowOrange" } },
						},
					},
					[luasnip_types.insertNode] = {
						active = {
							virt_text = { { "●", "TSRainbowGreen" } },
						},
					},
				},
			})

			cmp.setup({
				mapping = {
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-j>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_next_item()
						else
							cmp.complete()
						end
					end, { "i", "s" }),
					["<C-k>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_prev_item()
						else
							cmp.complete()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping.confirm({ select = true }),
					["<C-c>"] = cmp.mapping.abort(),
					["<Tab>"] = cmp.mapping(function(fallback)
						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "luasnip" },
					{
						name = "buffer",
						keyword_length = 4,
						option = {
							get_bufnrs = function()
								return vim.api.nvim_list_bufs()
							end,
						},
					},
					{ name = "copilot" },
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

			-- Autopairs setup, automatically close pairs
			require("nvim-autopairs").setup({})
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	{
		"stevearc/oil.nvim", -- File explorer
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- Custom select function to open oil and close it after opening a split
			-- @param opts nil | table
			--      vertical boolean Open in vertical split
			--      horizontal boolean Open in horizontal split
			local select = function(opts)
				local oil = require("oil")
				if opts.horizontal then
					oil.select({ horizontal = true })
				elseif opts.vertical then
					oil.select({ vertical = true })
				else
					oil.select()
				end
				vim.cmd.wincmd({ args = { "p" } })
				oil.close()
				vim.cmd.wincmd({ args = { "p" } })
			end

			require("oil").setup({
				default_file_explorer = true,
				delete_to_trash = true,
				view_options = {
					show_hidden = true,
					natural_order = true,
					is_always_hidden = function(name, _)
						return name == ".." or name == ".git"
					end,
				},
				win_options = { wrap = true },
				use_default_keymaps = false,
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-s>"] = {
						callback = function()
							select({ horizontal = true })
						end,
						mode = "n",
					},
					["<C-v>"] = {
						callback = function()
							select({ vertical = true })
						end,
						mode = "n",
					},
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["<C-l>"] = "actions.refresh",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = "actions.tcd",
					["gs"] = "actions.change_sort",
					["gx"] = "actions.open_external",
					["g."] = "actions.toggle_hidden",
					["g\\"] = "actions.toggle_trash",
				},
			})
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		end,
	},
	{
		"akinsho/toggleterm.nvim", -- Terminal inside Neovim
		version = "*",
		event = "VimEnter",
		opts = {
			open_mapping = [[<M-Enter>]],
			direction = "float",
		},
	},

	{
		"zk-org/zk-nvim", -- Note taking with Zettelkasten method
		config = function()
			require("zk").setup({
				picker = "fzf_lua",

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
		end,
	},
	{
		"mrjones2014/smart-splits.nvim", -- Better window navigation
		config = function()
			require("smart-splits").setup({
				default_amount = 1,
				at_edge = "stop",
			})
			-- Open/close splits
			vim.keymap.set("n", "<A-s>", "<C-W>s", { silent = true })
			vim.keymap.set("n", "<A-v>", "<C-W>v", { silent = true })
			vim.keymap.set("n", "<A-c>", ":close<CR>", { silent = true })
			-- moving between splits
			vim.keymap.set("n", "<A-h>", require("smart-splits").move_cursor_left)
			vim.keymap.set("n", "<A-j>", require("smart-splits").move_cursor_down)
			vim.keymap.set("n", "<A-k>", require("smart-splits").move_cursor_up)
			vim.keymap.set("n", "<A-l>", require("smart-splits").move_cursor_right)
			-- resizing splits
			vim.keymap.set("n", "<A-C-h>", require("smart-splits").resize_left)
			vim.keymap.set("n", "<A-C-j>", require("smart-splits").resize_down)
			vim.keymap.set("n", "<A-C-k>", require("smart-splits").resize_up)
			vim.keymap.set("n", "<A-C-l>", require("smart-splits").resize_right)
			-- swapping buffers between windows
			vim.keymap.set("n", "<A-S-h>", require("smart-splits").swap_buf_left)
			vim.keymap.set("n", "<A-S-j>", require("smart-splits").swap_buf_down)
			vim.keymap.set("n", "<A-S-k>", require("smart-splits").swap_buf_up)
			vim.keymap.set("n", "<A-S-l>", require("smart-splits").swap_buf_right)
		end,
	},
	{
		"iamcco/markdown-preview.nvim", -- Preview markdown files in browser
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
})
