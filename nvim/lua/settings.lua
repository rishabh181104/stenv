local opt = vim.opt

-- Appearance
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.cursorline = true
opt.showmode = false
opt.signcolumn = "yes"

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Text Wrapping
opt.wrap = true
opt.linebreak = true
opt.showbreak = '↪'
opt.textwidth = 80  -- Optional: Enforce max line length
opt.sidescroll = 1

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

-- Undo and Backup
opt.swapfile = false
opt.backup = false
local undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.fn.mkdir(undodir, "p")  -- Create undodir if it doesn't exist
opt.undodir = undodir
opt.undofile = true

-- Search Highlighting
opt.hlsearch = false
opt.incsearch = true

-- Scroll Offset
opt.scrolloff = 8
opt.isfname:append("@-@")

-- Keymaps
local map = vim.keymap.set

map("n", "<leader>w", ":write<CR>", { desc = "Save file" })
map("n", "<leader>q", ":quit<CR>", { desc = "Quit" })

-- Simplified multi-mode mapping for jk
map({ "i", "v", "s", "x", "c", "t", "o" }, "jk", "<C-c>", { desc = "Toggle to normal mode" })

map("n", "<leader>ter", ":terminal<CR>", { desc = "Opens a terminal" })

map({ "n", "v" }, "<Leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to system clipboard" })

map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

map("n", "<leader>git", ":LazyGit<CR>", { desc = "Open LazyGit" })  -- Adjusted command (verify plugin)
