# Miika's Neovim Configuration

This is my personal nvim configuration that is:

- Single-file
- Documented
- As minimal as possible (not really)
- Used for JavaScript, Python, Bash, HTML, XML, CSS, JSON, C, and Lua
- Used on my job as an Odoo developer

## Installation

- Ensure the following packages are installed (debian). It is recommended to download
  nodejs from the [NodeSource repository](https://github.com/nodesource/distributions):

        sudo apt install clang cmake libclang-dev rapidjson-dev llvm-dev python3-pip  \
        nodejs && pip3 install --upgrade black pylint pylint-odoo && npm install \
        --save-dev prettier @prettier/plugin-xml

- Copy and paste the `init.lua` file into `$HOME/.config/nvim/init.lua`
- Start neovim (`nvim`) and run `PackerSync`
- Restart neovim

## Custom keymapping cheatsheet

| Keymap      | List                                      |
| ----------- | ----------------------------------------- |
| `<leader>t` | Toggles nvim-tree (`:NvimTreeToggle<CR>`) |
