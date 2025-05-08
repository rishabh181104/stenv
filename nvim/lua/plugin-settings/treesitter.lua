require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "html", "css", "javascript", "typescript", "java",
    "cpp", "rust", "python", "sql", "lua",
  },
  highlight = { enable = true },
  indent = { enable = true },
})
