vim.cmd([[
  call plug#begin('~/.local/share/nvim/plugged')

  " Theme
  Plug 'EdenEast/nightfox.nvim' " Vim-Plug
  
  Plug 'ibhagwan/fzf-lua', { 'on': ['FzfLua'] }

  " LSP and completion
  Plug 'neovim/nvim-lspconfig'              " LSP client
  Plug 'hrsh7th/nvim-cmp'                   " Completion engine
  Plug 'hrsh7th/cmp-nvim-lsp'               " LSP source
  Plug 'hrsh7th/cmp-buffer'                 " Buffer source
  Plug 'hrsh7th/cmp-path'                   " Path source
  Plug 'L3MON4D3/LuaSnip'                   " Snippet engine
  Plug 'saadparwaiz1/cmp_luasnip'           " LuaSnip source

  " Fuzzy finder (Picker)
  Plug 'ibhagwan/fzf-lua', { 'branch': 'main' }

  " File navigation
  Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2' }
  Plug 'nvim-lua/plenary.nvim'

  " Syntax highlighting
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

  " Statusline
  Plug 'nvim-lualine/lualine.nvim'

  " File explorer
  Plug 'stevearc/oil.nvim'

  " Git integration
  Plug 'lewis6991/gitsigns.nvim'

  " Auto-pairs
  Plug 'windwp/nvim-autopairs'

  " Debugging (DAP)
  Plug 'mfussenegger/nvim-dap'
  Plug 'rcarriga/nvim-dap-ui'
  Plug 'nvim-neotest/nvim-nio'
  Plug 'mfussenegger/nvim-dap-python'       " Python DAP
  Plug 'leoluz/nvim-dap-go'                 " Go DAP (for reference)

  " Data science (Jupyter, Python)
  Plug 'goerz/jupytext.vim'                 " Jupyter notebook support
  Plug 'bfredl/nvim-ipy'                    " Interactive Python

  " SQL/PostgreSQL
  Plug 'tpope/vim-dadbod'                   " Database client
  Plug 'kristijanhusak/vim-dadbod-ui'       " Database UI
  Plug 'kristijanhusak/vim-dadbod-completion'  " SQL completion

  " Regex testing (cybersecurity)
  Plug 'tpope/vim-abolish'                  " Advanced regex tools
  Plug 'markonm/traces.vim'                 " Live regex preview

  " which key"
  Plug 'folke/which-key.nvim'

  "Auto indenting/formatting"
  Plug 'stevearc/conform.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  call plug#end()
]])
