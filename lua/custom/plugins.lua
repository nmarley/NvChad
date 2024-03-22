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
      -- setting rust_recommended_style to 0 disables the crappy defaults,
      -- which sets textwidth to 99 instead of 80
      vim.g.rust_recommended_style = 0
    end,
  },
}
return plugins
