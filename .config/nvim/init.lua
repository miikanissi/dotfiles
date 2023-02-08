-- PACKAGES
-- Ensure Packer (plugin manager) is installed
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

-- Install plugins with Packer
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Package manager
    use 'ishan9299/modus-theme-vim' -- Vim port of Modus themes
    use 'norcalli/nvim-colorizer.lua' -- Highlight colors
    -- A note taking plugin
    use {
        'vimwiki/vimwiki',
        config = function()
            vim.g.vimwiki_list = {
                {
                    path = '~/Documents/vimwiki/',
                    syntax = 'markdown',
                    ext = '.md',
                    auto_diary_index = 1,
                    auto_generate_links = 1,
                }
            }
            vim.g.vimwiki_global_ext = 0
        end
    }
    use 'tpope/vim-fugitive' -- Git commands in nvim
    use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Git info in sign column and popups
    use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
    -- Automatic tags management
    use {
        'ludovicchabant/vim-gutentags',
        config = function()
            vim.g.gutentags_cache_dir = "~/.config/nvim/gutentags"
        end
    }
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Telescope fuzzy finder
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- Fzf port for telescope
    use 'nvim-lualine/lualine.nvim' -- Fancier statusline
    use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides
    use 'alvan/vim-closetag' -- Automatically close html/xml tags
    use 'nvim-treesitter/nvim-treesitter' -- Highlight and navigate using a parsing library
    use 'nvim-treesitter/nvim-treesitter-textobjects' -- Additional treesitter objects
    use 'nvim-treesitter/nvim-treesitter-context' -- Show context of current buffer ie sticky definition
    use 'windwp/nvim-autopairs' -- Automatically close pairs
    use 'williamboman/nvim-lsp-installer' -- Automatically install LSPs
    use {
        'neovim/nvim-lspconfig',
        requires= {
            -- Useful status updates for LSP
            'j-hui/fidget.nvim',
        },
    } -- Collection of configurations for built-in LSP client
    use 'jose-elias-alvarez/null-ls.nvim' -- Null ls is used for code formatting and pylint analysis
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- Autocompletion with LSPs
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'saadparwaiz1/cmp_luasnip' -- Snippets autocompletion
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
    } -- File tree browser

    if is_bootstrap then
        require('packer').sync()
    end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})


-- SETTINGS
-- Theme, colors and gui
vim.opt.termguicolors = true -- Use full colors
vim.opt.background = "light" -- Background color
vim.cmd('colorscheme modus-operandi') -- Theme
vim.o.hlsearch = false -- No highlight on search
vim.opt.clipboard = "unnamedplus" -- Share system clipboard
vim.opt.cursorline = true -- Highlight cursor line
vim.opt.colorcolumn = "88" -- Colorcolumn is 88
vim.opt.matchpairs:append { "<:>" } -- Highlights matching brackets - '%' to jump between them
vim.opt.showmode = false -- -- INSERT -- is not shown as lightline shows it
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
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Folding provided by treesitter
vim.opt.foldlevel = 99 -- Never fold by default
vim.opt.mouse = 'a' -- Enable mouse support
vim.opt.eb = false -- No error bells
vim.opt.swapfile = false -- No swap file
vim.opt.backup = false -- No backup file
vim.opt.undofile = true -- Makes undofile for history
vim.opt.lazyredraw = true -- No redraw
vim.opt.updatetime = 100 -- Default is 4000 - less updates

--Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap to switch windows with Ctrl + hjkl
vim.keymap.set('n', '<C-J>', "<C-W>j", { silent = true })
vim.keymap.set('n', '<C-K>', "<C-W>k", { silent = true })
vim.keymap.set('n', '<C-L>', "<C-W>l", { silent = true })
vim.keymap.set('n', '<C-H>', "<C-W>h", { silent = true })

-- Location list mappings
vim.keymap.set('n', '<leader>lo', ":lopen<CR>")
vim.keymap.set('n', '<leader>lc', ":lclose<CR>")
vim.keymap.set('n', '<leader>lj', ":lnext<CR>")
vim.keymap.set('n', '<leader>lk', ":lprev<CR>")

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- PLUGINS
-- Lualine
require('lualine').setup({
    options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
    },
})
-- nvim-colorizer.lua
require ('colorizer').setup()
-- Closetag
local closetag_regions = {}
closetag_regions['typescript.tsx'] = 'jsxRegion,tsxRegion'
closetag_regions['javascript.jsx'] = 'jsxRegion'
closetag_regions['typescriptreact'] = 'jsxRegion,tsxRegion'
closetag_regions['javascriptreact'] = 'jsxRegion'
vim.g['closetag_xhtml_filetypes'] = 'xml,xhtml,javascript.jsx,jsx,typescript.tsx,typescriptreact'
vim.g['closetag_xhtml_filenames'] = '*.html,*.xml,*.xhtml,*.js,*.jsx,*.tsx'
vim.g['closetag_filetypes'] = 'html,htmldjango,xml,xhtml,phtml,javascript.jsx,jsx,typescript.tsx,typescriptreact'
vim.g['closetag_emptyTags_caseSensitive'] = 1
vim.g['closetag_regions'] = closetag_regions
vim.g['closetag_shortcut'] = '>'
vim.g['closetag_close_shortcut'] = '<leader>>'

-- Nvim-tree
require('nvim-tree').setup()
vim.keymap.set('n', '<leader>t', ":NvimTreeToggle<CR>", { silent = true })

--Enable Comment.nvim
require('Comment').setup()

-- Enable nvim-autopairs
require("nvim-autopairs").setup()

-- Indent blankline
require('indent_blankline').setup({
    char = '┊',
    show_trailing_blankline_indent = false,
})

-- Gitsigns
require('gitsigns').setup({
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
})

-- Telescope
require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
})
-- Enable telescope fzf native
-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

--Add leader shortcuts
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>sf', function()
    require('telescope.builtin').find_files { previewer = false }
end)
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags)
vim.keymap.set('n', '<leader>st', require('telescope.builtin').tags)
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').grep_string)
vim.keymap.set('n', '<leader>sp', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>so', function()
    require('telescope.builtin').tags { only_current_buffer = true }
end)
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles)

-- Treesitter
require('nvim-treesitter.configs').setup({
    ensure_installed = { "c", "html", "javascript", "python", "lua", "css", "bash", "go", "gomod" },
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
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
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
    },
})
require("treesitter-context").setup({
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            "class",
            "function",
            "method",
            "for",
            "while",
            "if",
            "switch",
            "case",
        },
    },
})


-- LSP PLUGINS AND SETTINGS
-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
require("nvim-lsp-installer").setup({
    -- List of servers to automatically install
    ensure_installed = { 'pyright', 'tsserver', 'eslint', 'bashls', 'cssls', 'html', 'sumneko_lua', 'jsonls', 'clangd',
        'lemminx', 'gopls' },
    -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    automatic_installation = true,
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})
local lspconfig = require 'lspconfig'

-- Common LSP On Attach function
local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
        vim.inspect(vim.lsp.buf.list_workspace_folders())
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
    vim.diagnostic.config({virtual_text = false})
end

-- Turn on lsp status information
require('fidget').setup()

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable the following language servers. Order matters
-- tsserver (TypeScript, JavaScript)
lspconfig.tsserver.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        -- Disable formatting v0.8
        client.server_capabilities.documentFormattingProvider = false
        on_attach(client, bufnr)
    end
})
-- eslint (JavaScript)
lspconfig.eslint.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        -- Disable formatting v0.8
        client.server_capabilities.documentFormattingProvider = false
        on_attach(client, bufnr)
    end,
    settings = {
        codeAction = {
            disableRuleComment = {
                enable = true,
                location = "separateLine"
            },
            showDocumentation = {
                enable = true
            }
        },
        codeActionOnSave = {
            enable = false,
            mode = "all"
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
            mode = "location"
        }
    }
})
-- sumneko_lua (Lua)
lspconfig.sumneko_lua.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})
-- pyright (Python)
lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                diagnosticSeverityOverrides = {
                    reportMissingImports = "none",
                },
            },
        },
    },
})
-- lemminx (XML)
lspconfig.lemminx.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        -- Disable formatting v0.8
        client.server_capabilities.documentFormattingProvider = false
        on_attach(client, bufnr)
    end
})
-- LSPs with default setup: bashls (Bash), cssls (CSS), html (HTML), clangd (C/C++), jsonls (JSON)
for _, lsp in ipairs { 'bashls', 'cssls', 'html', 'clangd', 'jsonls', 'gopls' } do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

-- Null ls for automatic formatting and additional analysis
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
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
    sources = {
        require("null-ls").builtins.formatting.prettier.with({
            extra_filetypes = { "xml" }
        }),
        require("null-ls").builtins.formatting.black,
        require("null-ls").builtins.formatting.djlint,
        require("null-ls").builtins.formatting.isort,
        require("null-ls").builtins.diagnostics.djlint,
        require("null-ls").builtins.diagnostics.pylint.with({
            extra_args = { "--load-plugins=pylint_odoo", "-e", "odoolint" } -- Load pylint_odoo plugin for pylint
        }),
    },
})
-- Manually format buffer
vim.keymap.set('n', '<leader>bf', vim.lsp.buf.formatting, {})
-- luasnip setup
local luasnip = require 'luasnip'
require("luasnip.loaders.from_snipmate").load()

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
})
