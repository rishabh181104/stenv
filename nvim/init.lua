-- Set leader key
vim.g.mapleader = " "

-- Load general settings
require("settings")

-- Load plugins
require("plugins")

-- Load plugin settings
local plugin_settings = {
  "colors",
  "whichkey",
  "lsp",
  "fzf-lua",
  "harpoon",
  "treesitter",
  "lualine",
  "neotree",
  "gitsigns",
  "autopairs",
  "debugger",
  "jupyter",
  "sql",
  "regex",
}

for _, module in ipairs(plugin_settings) do
  local ok, err = pcall(require, "plugin-settings." .. module)
  if not ok then
    vim.notify("Error loading plugin-settings/" .. module .. ": " .. err, vim.log.levels.ERROR)
  end
end
