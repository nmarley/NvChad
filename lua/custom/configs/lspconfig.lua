local config = require("plugins.configs.lspconfig")
local on_attach = config.on_attach
local capabilities = config.capabilities

-- Updated to use vim.lsp.config instead of deprecated lspconfig
-- local lspconfig = require("lspconfig")

local util = require "lspconfig/util"

-- 2024-02-11(nmarley): Rust LSP config via DreamsOfCode tutorial
-- https://www.youtube.com/watch?v=mh_EJhH49Ms
vim.lsp.config.rust_analyzer = {
  cmd = { "rust-analyzer" },
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
vim.lsp.config("gopls", {
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
})

-- 2024-01-31(nmarley): Add typescript LSP config
-- lspconfig.tsserver.setup {
vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,

  init_options = {
    preferences = {
      disableSuggestions = true,
    }
  }
})

-- 2024-05-29(nmarley): Add C++/clangd LSP config via DreamsOfCode tutorial
-- https://www.youtube.com/watch?v=lsFoZIg-oDs
vim.lsp.config("clangd", {
  cmd = { "clangd" },
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
})
