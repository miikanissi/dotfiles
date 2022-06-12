-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost',
    { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua' })

-- Install packages
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Package manager
    use 'gruvbox-community/gruvbox' -- Color scheme
    use 'ap/vim-css-color' -- highlight color codes in code
    use 'tpope/vim-fugitive' -- Git commands in nvim
    use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
    use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
    use 'ludovicchabant/vim-gutentags' -- Automatic tags management
    -- UI to select things (files, grep results, open buffers...)
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'nvim-lualine/lualine.nvim' -- Fancier statusline
    -- Add indentation guides even on blank lines
    use 'lukas-reineke/indent-blankline.nvim'
    -- Add git related info in the signs columns and popups
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    -- Highlight, edit, and navigate code using a fast incremental parsing library
    use 'nvim-treesitter/nvim-treesitter'
    -- Additional textobjects for treesitter
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'williamboman/nvim-lsp-installer' -- Automatically install LSPs
    use 'jose-elias-alvarez/null-ls.nvim' -- Null ls is used for formatting
    -- use 'alvan/vim-closetag'
    use 'windwp/nvim-ts-autotag'
    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
    }
end)
-- Theme and colors
vim.opt.termguicolors = true -- gui colors
vim.opt.background = "light" -- default to light background
vim.cmd [[colorscheme gruvbox]]
--Set highlight on search
vim.o.hlsearch = false
vim.opt.clipboard = "unnamedplus" -- uses system clipboard
-- Tabs and indent
vim.opt.tabstop = 4 -- tab stops at 4 spaces
vim.opt.softtabstop = 4 -- tab stops at 4 spaces
vim.opt.shiftwidth = 4 -- default shift
vim.opt.expandtab = true -- default tabs
vim.opt.smartindent = true -- default tabs
-- Mouse and cursor
vim.opt.mouse = 'a' -- Enable mouse support
vim.opt.guicursor = "" -- Insert mode cursor
vim.opt.cursorline = true -- Highlight curosr line

vim.opt.relativenumber = true -- hybrid line numbers
vim.opt.eb = false -- no error bells
vim.opt.ignorecase = true -- ignores case in search
vim.opt.smartcase = true -- uses smartcase in search
vim.opt.swapfile = false -- no swap file
vim.opt.backup = false -- no backup file
vim.opt.undofile = true -- makes undofile for history in undodir
vim.opt.modelines = 0 -- no modelines
vim.opt.colorcolumn = "88" -- colorcolumn is 80
vim.opt.lazyredraw = true -- no redraw
vim.opt.magic = true -- magic for regex
vim.opt.scrolloff = 8 -- shows 8 lines under mouse when moving the file
vim.opt.matchpairs:append { "<:>" } -- highlights matching brackets, '%' to jump between them
vim.opt.laststatus = 2 -- allows lightline to show
vim.opt.showmode = false -- -- INSERT -- is not shown as lightline shows it
vim.opt.updatetime = 100 -- default is 4000
vim.opt.signcolumn = "yes" -- always show signcolumns
vim.opt.wildmenu = true
vim.opt.completeopt = "menuone,noselect"
vim.opt.incsearch = true

--Set statusbar
require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'gruvbox',
        component_separators = '|',
        section_separators = '',
    },
}

-- Enable nvim-tree
require('nvim-tree').setup()
--Enable Comment.nvim
require('Comment').setup()

--Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- Indent blankline
require('indent_blankline').setup {
    char = '┊',
    show_trailing_blankline_indent = false,
}

-- Gitsigns
require('gitsigns').setup {
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
}

-- Telescope
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
}

-- Enable telescope fzf native
require('telescope').load_extension 'fzf'

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

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "html", "javascript", "python", "lua", "css", "bash" },
    autotag = {
        enable = true,
        filetypes = { "html", "xml" }
    },
    highlight = {
        enable = true, -- false will disable the whole extension
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
}
-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
-- LSP settings
require("nvim-lsp-installer").setup({
    -- List of servers to automatically install
    ensure_installed = { 'pyright', 'tsserver', 'eslint', 'bashls', 'cssls', 'html', 'sumneko_lua', 'jsonls', 'ccls' },
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
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
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
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers. Order matters
-- tsserver (TypeScript, JavaScript)
lspconfig.tsserver.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        -- Disable formatting v0.7
        client.resolved_capabilities.document_formatting = false
        -- Disable formatting v0.8
        client.server_capabilities.documentFormattingProvider = false
        on_attach(client, bufnr)
    end
}
-- eslint (JavaScript)
lspconfig.eslint.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        -- Disable formatting v0.7
        client.resolved_capabilities.document_formatting = false
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
}
-- sumneko_lua (Lua)
lspconfig.sumneko_lua.setup {
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
}

-- pyright (Python)
lspconfig.pyright.setup {
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
}
-- LSPs with default setup: bashls (Bash), cssls (CSS), html (HTML), ccls (C/C++), jsonls (JSON)
for _, lsp in ipairs { 'bashls', 'cssls', 'html', 'ccls', 'jsonls' } do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end
-- Null ls for automatic formatting
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
        require("null-ls").builtins.formatting.isort,
        require("null-ls").builtins.diagnostics.pylint.with({
            extra_args = { "--load-plugins=pylint_odoo", "-e", "odoolint" }
        }),
    },
})
-- Manually format buffer
vim.keymap.set('n', '<leader>bf', vim.lsp.buf.formatting, {})
-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
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
}
