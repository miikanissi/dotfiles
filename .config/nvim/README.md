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

| Keymap       | Description                                                                            | Mode           |
| ------------ | -------------------------------------------------------------------------------------- | -------------- |
| `<space>`    | The leader key `<leader>`                                                              | Normal, Visual |
| `<A-s>`      | Open horizontal split                                                                  | Normal         |
| `<A-v>`      | Open vertical split                                                                    | Normal         |
| `<A-q>`      | Close current split                                                                    | Normal         |
| `<A-h>`      | Move cursor to the left split                                                          | Normal         |
| `<A-j>`      | Move cursor to the down split                                                          | Normal         |
| `<A-k>`      | Move cursor to the up split                                                            | Normal         |
| `<A-l>`      | Move cursor to the right split                                                         | Normal         |
| `<A-C-h>`    | Resize split to the left                                                               | Normal         |
| `<A-C-j>`    | Resize split downwards                                                                 | Normal         |
| `<A-C-k>`    | Resize split upwards                                                                   | Normal         |
| `<A-C-l>`    | Resize split to the right                                                              | Normal         |
| `<A-S-h>`    | Swap buffer with the left split                                                        | Normal         |
| `<A-S-j>`    | Swap buffer with the down split                                                        | Normal         |
| `<A-S-k>`    | Swap buffer with the up split                                                          | Normal         |
| `<A-S-l>`    | Swap buffer with the right split                                                       | Normal         |
| `gl`         | Go to end of line `$`                                                                  | Normal         |
| `gh`         | Go to beginning of line `0`                                                            | Normal         |
| `U`          | Redo `<C-R>`                                                                           | Normal         |
| `gnn`        | Treesitter: Init selection                                                             | Normal         |
| `grc`        | Treesitter: Scope incremental                                                          | Visual         |
| `v`          | Treesitter: Node incremental                                                           | Visual         |
| `V`          | Treesitter: Node decremental                                                           | Visual         |
| `aa`         | Treesitter: Select outer parameter                                                     | Visual         |
| `ia`         | Treesitter: Select inner parameter                                                     | Visual         |
| `af`         | Treesitter: Select outer function                                                      | Visual         |
| `if`         | Treesitter: Select inner function                                                      | Visual         |
| `ac`         | Treesitter: Select outer class                                                         | Visual         |
| `ic`         | Treesitter: Select inner class                                                         | Visual         |
| `]m`         | Treesitter: Go to next function start                                                  | Normal         |
| `]]`         | Treesitter: Go to next class start                                                     | Normal         |
| `]M`         | Treesitter: Go to next function end                                                    | Normal         |
| `][`         | Treesitter: Go to next class end                                                       | Normal         |
| `[m`         | Treesitter: Go to previous function start                                              | Normal         |
| `[[`         | Treesitter: Go to previous class start                                                 | Normal         |
| `[M`         | Treesitter: Go to previous function end                                                | Normal         |
| `[]`         | Treesitter: Go to previous class end                                                   | Normal         |
| `<leader>a`  | Treesitter: Swap next parameter                                                        | Normal         |
| `<leader>A`  | Treesitter: Swap previous parameter                                                    | Normal         |
| `]c`         | Git: Next Git [C]hange                                                                 | Normal         |
| `[c`         | Git: Previous Git [C]hange                                                             | Normal         |
| `<leader>gs` | Git: [s]tage hunk                                                                      | Normal, Visual |
| `<leader>gr` | Git: [r]eset hunk                                                                      | Normal, Visual |
| `<leader>gS` | Git: [S]tage buffer                                                                    | Normal, Visual |
| `<leader>gu` | Git: [u]ndo stage hunk                                                                 | Normal, Visual |
| `<leader>gR` | Git: [R]eset buffer                                                                    | Normal, Visual |
| `<leader>gp` | Git: [p]review hunk                                                                    | Normal, Visual |
| `<leader>gb` | Git: [b]lame line                                                                      | Normal         |
| `<leader>gd` | Git: [d]iff against index                                                              | Normal         |
| `<leader>gD` | Git: [D]iff against last commit                                                        | Normal         |
| `<leader>gt` | Git: [t]oggle git show blame line                                                      | Normal         |
| `<leader>gT` | Git: [T]oggle git show deleted                                                         | Normal         |
| `<A-.>`      | Go to Next Buffer                                                                      | Normal         |
| `<A-,>`      | Go to Previous Buffer                                                                  | Normal         |
| `<A-<>`      | Re-order Buffer to Previous                                                            | Normal         |
| `<A->>`      | Re-order Buffer to Next                                                                | Normal         |
| `<A-1>`      | Go to Buffer 1                                                                         | Normal         |
| `<A-2>`      | Go to Buffer 2                                                                         | Normal         |
| `<A-3>`      | Go to Buffer 3                                                                         | Normal         |
| `<A-4>`      | Go to Buffer 4                                                                         | Normal         |
| `<A-5>`      | Go to Buffer 5                                                                         | Normal         |
| `<A-6>`      | Go to Buffer 6                                                                         | Normal         |
| `<A-7>`      | Go to Buffer 7                                                                         | Normal         |
| `<A-8>`      | Go to Buffer 8                                                                         | Normal         |
| `<A-9>`      | Go to Buffer 9                                                                         | Normal         |
| `<A-0>`      | Go to Last Buffer                                                                      | Normal         |
| `<A-p>`      | Toggle Buffer [P]in                                                                    | Normal         |
| `<A-S-q>`    | [Q]uit Buffer                                                                          | Normal         |
| `<A-u>`      | [U]ndo/Restore Closed Buffer                                                           | Normal         |
| `<leader>qo` | Open quickfix list                                                                     | Normal         |
| `<leader>qc` | Close quickfix list                                                                    | Normal         |
| `<leader>qj` | Go to next item on quickfix list                                                       | Normal         |
| `<leader>qk` | Go to previous item on quickfix list                                                   | Normal         |
| `<leader>de` | Diagnostics: Show diagnostics in a floating window                                     | Normal         |
| `<leader>dq` | Diagnostics: Add buffer diagnostics to the quickfix list                               | Normal         |
| `<leader>dk` | Diagnostics: Go to previous diagnostic                                                 | Normal         |
| `<leader>dj` | Diagnostics: Go to next diagnostic                                                     | Normal         |
| `<leader>sb` | Fzf: Buffers                                                                           | Normal         |
| `<leader>sf` | Fzf: Files                                                                             | Normal         |
| `<leader>so` | Fzf: List previously opened files                                                      | Normal         |
| `<leader>sh` | Fzf: List available help tags                                                          | Normal         |
| `<leader>ss` | Fzf: Search for string under your cursor in current directory                          | Normal         |
| `<leader>sl` | Fzf: Search for string in current directory as you type                                | Normal         |
| `<leader>sd` | LSP / Fzf: Lists LSP document symbols in the current buffer                            | Normal         |
| `<leader>sr` | LSP / Fzf: Lists LSP references of the symbol under the cursor                         | Normal         |
| `<leader>s.` | LSP / Fzf: Resume previous search                                                      | Normal         |
| `<leader>cr` | LSP: Renames all references to the symbol under cursor                                 | Normal         |
| `<leader>ca` | LSP: Selects a code action available at the current cursor position                    | Normal         |
| `<leader>cd` | LSP: Jump to the definition of the symbol under cursor                                 | Normal         |
| `<leader>ct` | LSP: Jump to the definition of the type of the symbol under cursor                     | Normal         |
| `<leader>ch` | LSP: Displays hover information about the symbol under the cursor in a floating window | Normal         |
| `<leader>ho` | Copilot: [O]pen                                                                        | Normal, Visual |
| `<leader>he` | Copilot: [E]xplain Selection                                                           | Normal, Visual |
| `<leader>hr` | Copilot: [R]eview Selection                                                            | Normal, Visual |
| `<leader>hf` | Copilot: [F]ix Selection                                                               | Normal, Visual |
| `<leader>hi` | Copilot: [I]mprove / Optimize Selection                                                | Normal, Visual |
| `<leader>hd` | Copilot: Create [D]ocumentation for Selection                                          | Normal, Visual |
| `<leader>ht` | Copilot: Create [T]ests for Selection                                                  | Normal, Visual |
| `<C-d>`      | Cmp: Scroll docs up                                                                    | Insert, Select |
| `<C-f>`      | Cmp: Scroll docs down                                                                  | Insert, Select |
| `<C-j>`      | Cmp: Select next item or complete                                                      | Insert, Select |
| `<C-k>`      | Cmp: Select previous item or complete                                                  | Insert, Select |
| `<C-h>`      | Cmp: Confirm selection                                                                 | Insert, Select |
| `<C-c>`      | Cmp: Abort completion                                                                  | Insert, Select |
| `<Tab>`      | Luasnip: Expand or jump snippet                                                        | Insert, Select |
| `<S-Tab>`    | Luasnip: Jump to previous snippet                                                      | Insert, Select |
| `<leader>zn` | Zk: Create a new note                                                                  | Normal         |
| `<leader>zo` | Zk: Open a note                                                                        | Normal         |
| `<leader>zf` | Zk: Find notes by query                                                                | Normal, Visual |
| `<leader>zt` | Zk: Find notes by tags                                                                 | Normal         |
| `<M-Enter>`  | Toggleterm: Open terminal inside Neovim in floating mode                               | Normal         |
