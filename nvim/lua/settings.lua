local opt = vim.opt

-- Appearance
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.cursorline = true
opt.showmode = false

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Performance
opt.updatetime = 300
opt.timeout = true
opt.timeoutlen = 500

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Keymaps
local map = vim.keymap.set
map("n", "<leader>w", ":write<CR>", { desc = "Save file" })
map("n", "<leader>q", ":quit<CR>", { desc = "Quit" })
map("n", "<leader>e", ":NeoTreeFocusToggle<CR>", { desc = "Toggle file explorer" })
