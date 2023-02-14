# Miika's Neovim Configuration

This is my personal Nvim configuration that is:

- Single-file
- Documented
- As minimal as possible for my needs - unused plugins and features are removed
- Used for JavaScript, Python, Bash, HTML, XML, CSS, JSON, and Lua
- Used on my job as an Odoo developer
- Used on writing documents (Markdown, LaTeX, reStructuredText)

## Installation

- Ensure the following packages are installed (Debian). It is recommended to download
  Node.js from the [NodeSource repository](https://github.com/nodesource/distributions)
  and Go from [go.dev](https://go.dev/dl/):

        sudo apt install clang cmake libclang-dev python3-pip nodejs ctags golang \
        && pip3 install --upgrade pynvim black pylint pylint-odoo \
        && npm install --save-dev prettier @prettier/plugin-xml \
        && go install mvdan.cc/sh/v3/cmd/shfmt@latest

- Copy and paste the `init.lua` file into `$HOME/.config/nvim/init.lua`
- Start Neovim (`nvim`) and run `PackerSync`
- Restart Neovim

## Custom Keymaps Cheatsheet

| Keymap            | List                                                                                                                    |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `<space>`         | The leader key `<leader>`                                                                                               |
| `<C-J>`           | Switch to window below `<C-W>j`                                                                                         |
| `<C-K>`           | Switch to window above `<C-W>k`                                                                                         |
| `<C-H>`           | Switch to window left `<C-W>h`                                                                                          |
| `<C-L>`           | Switch to window right `<C-W>l`                                                                                         |
| `<leader>co`      | Open quickfix list `:copen<CR>`                                                                                         |
| `<leader>cc`      | Close quickfix list `:cclose<CR>`                                                                                       |
| `<leader>cj`      | Go to next item on quickfix list `:cnext<CR>`                                                                           |
| `<leader>ck`      | Go to previous item on quickfix list `:cprev<CR>`                                                                       |
| `<leader>t`       | Nvim-tree: Toggles nvim-tree `:NvimTreeToggle<CR>`                                                                      |
| `<leader><space>` | Telescope: Buffers `require('telescope.builtin').buffers`                                                               |
| `<leader>sf`      | Telescope: Files `require('telescope.builtin').find_files`                                                              |
| `<leader>sb`      | Telescope: Fuzzy find buffer contents `require('telescope.builtin').current_buffer_fuzzy_find`                          |
| `<leader>sh`      | Telescope: List available help tags `require('telescope.builtin').help_tags`                                            |
| `<leader>st`      | Telescope: List tags in current directory `require('telescope.builtin').tags`                                           |
| `<leader>so`      | Telescope: List tags in current buffer `require('telescope.builtin').tags { only_current_buffer = true }`               |
| `<leader>sd`      | Telescope: Search for string under your cursor in current directory `require('telescope.builtin').grep_string`          |
| `<leader>sp`      | Telescope: Search for string in current directory as you type `require('telescope.builtin').live_grep`                  |
| `<leader>?`       | Telescope: List previously opened files `require('telescope.builtin').oldfiles`                                         |
| `<leader>e`       | Diagnostics: Show diagnostics in a floating window `vim.diagnostics.open_float`                                         |
| `<leader>q`       | Diagnostics: Add buffer diagnostics to the quickfix list `vim.diagnostics.setqflist`                                    |
| `<leader>[`       | Diagnostics: Go to previous diagnostic `vim.diagnostics.goto_prev`                                                      |
| `<leader>]`       | Diagnostics: Go to next diagnostic `vim.diagnostics.goto_next`                                                          |
| `gD`              | LSP: Jump to the declaration of the symbol under cursor `vim.lsp.buf.declaration`                                       |
| `gd`              | LSP: Jump to the definition of the symbol under cursor `vim.lsp.buf.definition`                                         |
| `K`               | LSP: Displays hover information about the symbol under the cursor in a floating window `vim.lsp.buf.definition`         |
| `gi`              | LSP: Lists all the implementations of the symbol under cursor `vim.lsp.buf.implementation`                              |
| `<C-k>`           | LSP: Displays signature information about the symbol under the cursor in a floating window `vim.lsp.buf.signature_help` |
| `<leader>wa`      | LSP: Add the folder at path to the workspace folders `vim.lsp.buf.add_workspace_folder`                                 |
| `<leader>wr`      | LSP: Remove the folder at path from the workspace folders `vim.lsp.buf.remove_workspace_folder`                         |
| `<leader>wl`      | LSP: List the workspace folders `vim.lsp.buf.list_workspace_folders`                                                    |
| `<leader>D`       | LSP: Jump to the definition of the type of the symbol under cursor `vim.lsp.buf.type_definition`                        |
| `<leader>rn`      | LSP: Renames all references to the symbol under cursor `vim.lsp.buf.rename`                                             |
| `gr`              | LSP: List all the references to the symbol under cursor `vim.lsp.buf.references`                                        |
| `<leader>ca`      | LSP: Selects a code action available at the current cursor position `vim.lsp.buf.code_action`                           |
| `<leader>so`      | LSP / Telescope: Lists LSP document symbols in the current buffer `require('telescope.builtin').lsp_document_symbols`   |
| `<leader>bf`      | LSP: Format the current buffer `vim.lsp.buf.formatting`                                                                 |
