local M = {}

M.copilot = {
  -- Possible configurable fields can be found on:
  -- https://github.com/zbirenbaum/copilot.lua?tab=readme-ov-file#setup-and-configuration
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = "<Tab>",  -- Replace <key combination> with your preferred keys
    },
  },
  filetypes = {
    markdown = true,
  },
}

return M
