local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opts = {
    sources = {
        -- null_ls.builtins.formatting.biome,
        -- Run biome w/these extra args only if the biome.json file is not found
        null_ls.builtins.formatting.biome.with({
            condition = function(utils)
                return not utils.root_has_file("biome.json") and not utils.has_file("biome.json")
            end,
            extra_args = { "--indent-width=2", "--indent-style=space" },
        }),
        -- ... otherwise run biome w/config rules defined in biome.json
        null_ls.builtins.formatting.biome.with({
            condition = function(utils)
                return utils.root_has_file("biome.json") or utils.has_file("biome.json")
            end,
        }),
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
}
return opts
