local opt = vim.opt

-- Appearance
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.cursorline = true
opt.showmode = false

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

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

-- ThePrimeagen sets
opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50

-- Keymaps
local map = vim.keymap.set
map("n", "<leader>w", ":write<CR>", { desc = "Save file" })
map("n", "<leader>q", ":quit<CR>", { desc = "Quit" })
map("n", "<leader>e", ":NeoTreeFocusToggle<CR>", { desc = "Toggle file explorer" })
map("i", "jk", "<C-c>", { desc = "Toogle to normal mode"})
map("v", "jk", "<C-c>", { desc = "Toogle to normal mode"})
map("s", "jk", "<C-c>", { desc = "Toogle to normal mode"})
map("x", "jk", "<C-c>", { desc = "Toogle to normal mode"})
map("c", "jk", "<C-c>", { desc = "Toogle to normal mode"})
map("t", "jk", "<C-c>", { desc = "Toogle to normal mode"})
map("o", "jk", "<C-c>", { desc = "Toogle to normal mode"})
map("n", "<leader>ter", ":terminal<CR>", { desc = "Opens a terminal"})
