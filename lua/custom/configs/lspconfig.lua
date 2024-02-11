local config = require("plugins.configs.lspconfig")
local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

-- 2024-02-11(nmarley): Rust LSP config via DreamsOfCode tutorial
-- https://www.youtube.com/watch?v=mh_EJhH49Ms
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = util.root_pattern("Cargo.toml"),
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        loadOutDirsFromCheck = true,
        allFeatures = true,
      },
    }
  }
}


-- 2024-01-31(nmarley): Go LSP config (added this at some point in the past 3 months)
lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", "git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      gofumpt = true,
      staticcheck = true,
    }
  }
}

-- 2024-01-31(nmarley): Add typescript LSP config
-- lspconfig.typescript.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--
--   init_options = {
--     preferences = {
--       disableSuggestions = true,
--     }
--   }
-- }
