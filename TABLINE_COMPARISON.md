# NvChad and Kickstart tabline comparison

## Summary

The old NvChad setup used NvChad's built-in `tabufline` module from
`NvChad/ui`. It was not using `akinsho/bufferline.nvim` or another standalone
tabline plugin.

For the current Kickstart setup, the cleanest low-bloat replacement is
`mini.tabline`, because `nvim-mini/mini.nvim` is already installed and loaded
by the config. This provides visible buffer tabs without adding another plugin
or reintroducing NvChad-specific UI dependencies.

## Old NvChad behavior

The old setup enabled the tabline through NvChad defaults:

- `lua/core/default_config.lua` enabled `ui.tabufline`.
- `lua/core/init.lua` set `vim.opt.tabline` to render
  `nvchad.tabufline.modules`.
- `lua/core/mappings.lua` configured buffer navigation mappings:
  - `<Tab>` moved to the next buffer.
  - `<S-Tab>` moved to the previous buffer.
  - `<leader>x` closed the current buffer through NvChad's buffer close helper.

The actual implementation lived in the external `NvChad/ui` plugin under
`lua/nvchad/tabufline`. That module tracks listed buffers per tabpage, renders
clickable buffer labels, shows modified indicators, provides close buttons, and
handles some NvChad-specific UI details.

## Why not reuse NvChad tabufline directly

Reusing `nvchad.tabufline` directly inside Kickstart would pull in a set of
NvChad assumptions:

- It calls `require("core.utils").load_config()` and expects NvChad config
  shapes.
- It loads Base46 highlight cache files such as `tbline`.
- It expects NvChad globals and helper modules.
- It brings back the distribution coupling that the Kickstart move was meant to
  avoid.

That makes exact reuse possible, but not clean. It would be more maintenance
than the feature is worth.

## Recommended Kickstart replacement

Use `mini.tabline` from the already installed `mini.nvim` plugin.

This keeps the setup lean and provides the core behavior that mattered from
NvChad:

- visible file buffers across the top of the editor
- clear current, visible, hidden, and modified buffer states
- automatic disambiguation for files with the same name
- optional icons when a Nerd Font is enabled
- support for multiple Vim tabpages without extra configuration

The suggested mappings mirror the old muscle memory:

- `<Tab>` runs `:bnext`.
- `<S-Tab>` runs `:bprevious`.
- `<leader>x` deletes the current buffer.

This is the most practical match to the previous NvChad experience while
preserving the lighter Kickstart style.
