# Miika's Neovim Configuration

This is my personal Nvim configuration that is:

- Single-file
- Documented
- As minimal as possible for my needs - unused plugins and features are removed
- Used for JavaScript, Python, Go, Bash, HTML, XML, CSS, JSON, and Lua
- Used for writing documents (Markdown, LaTeX, reStructuredText)

## Installation

- Ensure the following packages are installed (Debian). It is recommended to download
  Node.js from the [NodeSource repository](https://github.com/nodesource/distributions)
  and Go from [go.dev](https://go.dev/dl/):

```bash
sudo apt install clang cmake libclang-dev python3-pip nodejs golang shellcheck \
&& pip3 install --upgrade --break-system-packages pynvim pylint pylint-odoo djlint \
&& npm install --save-dev prettier @prettier/plugin-xml \
&& go install mvdan.cc/sh/v3/cmd/shfmt@latest
```

- Copy and paste the `init.lua` file into `$HOME/.config/nvim/init.lua`
- Start Neovim (`nvim`)

## Custom Keymaps Cheatsheet

| Keymap            | List                                                                                                            |
| ----------------- | --------------------------------------------------------------------------------------------------------------- |
| `<space>`         | The leader key `<leader>`                                                                                       |
| `<C-J>`           | Switch to window below `<C-W>j`                                                                                 |
| `<C-K>`           | Switch to window above `<C-W>k`                                                                                 |
| `<C-H>`           | Switch to window left `<C-W>h`                                                                                  |
| `<C-L>`           | Switch to window right `<C-W>l`                                                                                 |
| `gl`              | Go to end of line `$`                                                                                           |
| `gh`              | Go to beginning of line `0`                                                                                     |
| `U`               | Redo `<C-R>`                                                                                                    |
| `<leader>n`       | Jump to notes file at `~/Documents/notes.md`                                                                    |
| `<leader>qo`      | Open quickfix list `:copen<CR>`                                                                                 |
| `<leader>qc`      | Close quickfix list `:cclose<CR>`                                                                               |
| `<leader>qj`      | Go to next item on quickfix list `:cnext<CR>`                                                                   |
| `<leader>qk`      | Go to previous item on quickfix list `:cprev<CR>`                                                               |
| `<leader>de`      | Diagnostics: Show diagnostics in a floating window `vim.diagnostics.open_float`                                 |
| `<leader>dq`      | Diagnostics: Add buffer diagnostics to the quickfix list `vim.diagnostics.setqflist`                            |
| `<leader>dk`      | Diagnostics: Go to previous diagnostic `vim.diagnostics.goto_prev`                                              |
| `<leader>dj`      | Diagnostics: Go to next diagnostic `vim.diagnostics.goto_next`                                                  |
| `<leader><space>` | Fzf: Buffers `require('fzf-lua').buffers`                                                                       |
| `<leader>sf`      | Fzf: Files `require('fzf-lua').files`                                                                           |
| `<leader>so`      | Fzf: List previously opened files `require('fzf-lua').oldfiles`                                                 |
| `<leader>sh`      | Fzf: List available help tags `require('fzf-lua').help_tags`                                                    |
| `<leader>ss`      | Fzf: Search for string under your cursor in current directory `require('fzf-lua').grep_cword`                   |
| `<leader>sl`      | Fzf: Search for string in current directory as you type `require('fzf-lua').live_grep`                          |
| `<leader>sd`      | LSP / Fzf: Lists LSP document symbols in the current buffer `require('fzf-lua').lsp_document_symbols`           |
| `<leader>sr`      | LSP / Fzf: Lists LSP references of the symbol under the cursor `require('fzf-lua').lsp_references`              |
| `<leader>cr`      | LSP: Renames all references to the symbol under cursor `vim.lsp.buf.rename`                                     |
| `<leader>ca`      | LSP: Selects a code action available at the current cursor position `vim.lsp.buf.code_action`                   |
| `<leader>cd`      | LSP: Jump to the definition of the symbol under cursor `vim.lsp.buf.definition`                                 |
| `<leader>ct`      | LSP: Jump to the definition of the type of the symbol under cursor `vim.lsp.buf.type_definition`                |
| `<leader>ch`      | LSP: Displays hover information about the symbol under the cursor in a floating window `vim.lsp.buf.definition` |
| `<leader>zn`      | Zk: Create a new note                                                                                           |
| `<leader>zo`      | Zk: Open a note                                                                                                 |
| `<leader>zf`      | Zk: Find notes by query                                                                                         |
| `<leader>zt`      | Zk: Find notes by tags                                                                                          |
