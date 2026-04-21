local config = require("plugins.configs.lspconfig")
local on_attach = config.on_attach
local capabilities = config.capabilities

vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_markers = { "Cargo.toml" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        loadOutDirsFromCheck = true,
        allFeatures = true,
      },
    }
  }
})

vim.lsp.config("gopls", {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
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

vim.lsp.config("clangd", {
  cmd = { "clangd" },
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
})

vim.lsp.enable({
  "lua_ls",
  "rust_analyzer",
  "gopls",
  "ts_ls",
  "clangd",
})
