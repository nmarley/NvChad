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
    "hrsh7th/nvim-cmp",
    config = function(_, opts)
      local cmp = require "cmp"

      cmp.setup(opts)
      cmp.setup.filetype("markdown", {
        completion = {
          autocomplete = false,
        },
      })
    end,
  },

  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
      vim.g.rust_recommended_style = 0
    end,
  },
}
return plugins
