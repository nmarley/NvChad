local overrides = require("custom.configs.overrides")

local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "rust-analyzer",
        "typescript-language-server",
      }
    }
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    -- Lazy load when event occurs. Events are triggered
    -- as mentioned in:
    -- https://vi.stackexchange.com/a/4495/20389
    event = "InsertEnter",
    -- You can also have it load immediately at
    -- startup by commenting above and uncommenting below:
    -- lazy = false
    opts = overrides.copilot,
  },

  -- 2024-02-27(nmarley): Add rust.vim plugin to autoformat code upon save
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  -- 2024-02-27(nmarley): Add Rustaceanvim plugin for Rust lsp and other dev tools
  -- 2024-02-28(nmarley): Commented for now b/c it doesn't work w/copilot
  -- {
  --   "mrcjkb/rustaceanvim",
  --   version = "^4",
  --   ft = "rust",
  --   dependencies = "neovim/nvim-lspconfig",
  --   config = function()
  --       require "custom.configs.rustaceanvim"
  --   end
  -- },

  -- 2024-02-27(nmarley): TODO: Add crates plugin for Rust
  -- https://github.com/Saecki/crates.nvim?tab=readme-ov-file
}
return plugins
