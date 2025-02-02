require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

-- Make vim stop outputting this:
-- <F13><F13><F13><F13><F13><F13><F13><F13><F13><F13><F13><F13><F13>
-- ... whenever I hold down <F13> key
-- Normal mode mapping
vim.keymap.set('n', '<F13>', '', { noremap = true, silent = true })
-- Insert mode mapping
vim.keymap.set('i', '<F13>', '', { noremap = true, silent = true })
-- Visual mode mapping
vim.keymap.set('v', '<F13>', '', { noremap = true, silent = true })
-- Command-line mode mapping (if needed)
vim.keymap.set('c', '<F13>', '', { noremap = true, silent = true })
