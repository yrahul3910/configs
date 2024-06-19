# Neovim config

This document goes over how this neovim config is set up. Briefly, this is a modification of [NvChad](https://nvchad.com/). Most important are the keybindings, which are detailed below:

* `j` and `k` are reversed. I prefer it this way.
* `<C-\>` opens a new [terminal](https://github.com/akinsho/toggleterm.nvim). You can use `<num><C-\>` to open a different terminal. Inside the floating terminal window, `<Esc>` will go back while leaving the process running in the background.
* `<leader>bc` closes the current buffer.
* `<leader>a` shows the [aerial](https://github.com/stevearc/aerial.nvim) window.
* `<C-]>` goes to definition. Do NOT use `gd` or `gD`! Those are broken.
* `<leader>fw` finds all occurrences of some string using [ripgrep](https://github.com/BurntSushi/ripgrep)
* `<leader>ff` is find files.
* `<leader>o` adds a new line below, but does not enter insert mode like `o` does.
* `<leader>th` shows all available themes, and `<leader>tl` switches to a light theme.
* `<leader>xx` shows the [trouble](https://github.com/folke/trouble.nvim) window.
* `<C-n>` opens up `nvim-tree`.