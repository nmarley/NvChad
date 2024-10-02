local overrides = require("custom.configs.overrides")

local plugins = {
  {
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
        opts = function()
            return require "custom.configs.null-ls"
        end,
        config = function(_, opts) require("null-ls").setup(opts) end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format",
        "gopls",
        "rust-analyzer",
        "typescript-language-server",
        "biome",
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

  -- 2024-08-25(nmarley): Add avante.nvim plugin to provide AI-driven code suggestions
  -- This is really shit right now, need a better plugin that doesn't need extra
  -- windows, just make suggestions like the Copilot plugin does, but using my
  -- own Claude API key. God what fucking horse shit.
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = false,
  --   -- Set this if you always want to pull the latest change
  --   -- version = false,
  --   build  = "make",
  --   -- Add any opts here
  --   -- opts = { },
  --   dependencies = {
  --       "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --       "stevearc/dressing.nvim",
  --       "nvim-lua/plenary.nvim",
  --       "MunifTanjim/nui.nvim",
  --   },
  -- },
}
return plugins
