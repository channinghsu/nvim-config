# Channing's Neovim

A small personal config for **reading files and checking git**; code is mostly written by AI tools.
Built on [lazy.nvim](https://github.com/folke/lazy.nvim). The previous full framework config lives in git history.

## Layout

```
init.lua                      -> require("user")
lua/user/
├─ init.lua                   -> leader, options, keymaps, autocmds, lazy
├─ options.lua                -> editor options, macOS clipboard
├─ keymaps.lua                -> my keymaps
├─ autocmds.lua               -> small autocmds (+ `gd` on LspAttach)
├─ gitsigns-keymaps.lua       -> <leader>g* hunk keys (attached by gitsigns)
├─ lazy.lua                   -> lazy.nvim bootstrap, imports user.plugins
├─ dashboard.lua              -> ASCII art for the start screen
├─ icons.lua  util.lua        -> icon table, palette helpers
├─ plugins/                   -> plugin specs
│  ├─ ui.lua                  -> theme, dashboard, statusline, bufferline, indent lines, markdown rendering, hop
│  ├─ tool.lua                -> file tree, telescope, which-key, toggleterm (lazygit)
│  └─ lsp.lua                 -> lspconfig, mason, completion, diagnostics, formatting, treesitter
└─ configs/                   -> one config function per plugin
```

## Plugins

| Area | Plugins |
|---|---|
| Look | catppuccin (transparent), lualine, bufferline, alpha (dashboard), indent-blankline, web-devicons |
| Files / search | nvim-tree, telescope (+ fzf-native, live-grep-args, zoxide), search.nvim |
| Git | gitsigns, lazygit via toggleterm |
| Code | nvim-treesitter (+ context), nvim-lspconfig, mason (+ mason-lspconfig), blink.cmp, tiny-inline-diagnostic, conform |
| Misc | which-key, hop, render-markdown |

No language servers are preconfigured: install one with `:Mason` and it is enabled automatically.
Formatters (stylua, prettier, ruff, shfmt) are used when installed, otherwise the LSP formats.

## Keymaps (leader = `<Space>`)

| Keys | Action |
|---|---|
| `H` / `L` | previous / next buffer |
| `<leader>x` | close buffer (`:bdelete`) |
| `<A-H/J/K/L>` | focus window left / down / up / right |
| `<leader>v` | vertical split |
| `<leader>e`, `<C-n>` | toggle file tree (`<leader>nf` find file, `<leader>nr` refresh) |
| `<leader>ff` / `fp` / `fg` / `fd` / `fm` / `fc` | search collections: files / patterns / git / dossiers / misc / collection picker |
| `<leader>fw` | grep in project (with args) |
| `<leader>fs` | grep word under cursor (visual: selection) |
| `<leader>fe` | recent files |
| `<leader>fz` | zoxide directories |
| `<leader>fr` | resume last search |
| `<C-p>` | list keymaps |
| `<leader>w` | hop to word |
| `gd` | go to definition (when an LSP is attached) |
| `<A-S-f>` | format buffer (conform) |
| `<A-=>` (visual) | format selection (LSP) |
| `]g` / `[g` | next / prev git hunk |
| `<leader>gs` `gr` `gR` `gp` `gb` | stage / reset hunk / reset buffer / preview / blame |
| `<leader>gg` | lazygit (floating terminal) |
| `<C-s>` / `jk` (insert) | save |
| `<C-q>` / `<A-S-q>` / `<leader>q` | save+quit / force quit / quit all |
| `<leader>i` | select all |
| `<leader>o` | toggle spell check |
| `tn` `tk` `tj` `to` | new / next / previous / only tab |

Also: insert/command-line Emacs-style keys, `J`/`K` move lines in visual mode, `Y`/`D` to end of line,
centered `n`/`N`, `<Esc>` clears search highlight, `<Esc><Esc>` leaves terminal mode.

## Markdown

`render-markdown` renders headings, lists, tables and code blocks in normal mode;
press `i` to edit the raw text.

## Adding things

Drop a spec into `lua/user/plugins/*.lua` (return a list of lazy.nvim specs); it is picked up automatically.
