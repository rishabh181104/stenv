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
opt.softtabstop = 2
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

-- Keymaps
local map = vim.keymap.set

map("n", "<leader>w", ":write<CR>", { desc = "Save file" })
map("n", "<leader>q", ":quit<CR>", { desc = "Quit" })

map("i", "jk", "<C-c>", { desc = "Toogle to normal mode"})
map("v", "jk", "<C-c>", { desc = "Toogle to normal mode"})
map("s", "jk", "<C-c>", { desc = "Toogle to normal mode"})
map("x", "jk", "<C-c>", { desc = "Toogle to normal mode"})
map("c", "jk", "<C-c>", { desc = "Toogle to normal mode"})
map("t", "jk", "<C-c>", { desc = "Toogle to normal mode"})
map("o", "jk", "<C-c>", { desc = "Toogle to normal mode"})

map("n", "<leader>ter", ":terminal<CR>", { desc = "Opens a terminal"})

map({ "n", "v" }, "<Leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to system clipboard" })

map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
