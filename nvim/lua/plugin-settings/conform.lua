-- Configure conform.nvim for autoformatting
require("conform").setup({
    formatters_by_ft = {
        python = { "black" },
        lua = { "stylua" },
        javascript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        java = { "astyle" },
        cpp = { "clang-format" },
        rust = { "rustfmt" },
        -- go = { "gofmt" },
    },
    -- Format on save with a 500ms timeout, fallback to LSP if formatter fails
    format_on_save = {
        timeout_ms = 2,
        lsp_fallback = true,
    },
    -- Optional: Customize formatter options
    formatters = {
        black = {
            prepend_args = { "--fast" }, -- Optional: Speed up Black
        },
        prettier = {
            prepend_args = { "--single-quote", "--trailing-comma", "es5" }, -- Customize Prettier
        },
        ["astyle"] = {
            command = "astyle", -- Adjust if using JAR: e.g., "java -jar /path/to/astyle.jar"
        },
    },
})

-- Optional: Keymap to manually trigger formatting
vim.api.nvim_set_keymap("n", "<leader>for", "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<CR>", { noremap = true, silent = true })

-- Configure nvim-treesitter for autoindenting
require("nvim-treesitter.configs").setup({
    ensure_installed = { "python", "lua", "javascript", "html", "css", "java", "cpp", "rust"},
    indent = {
        enable = true,
        -- Disable for Python due to occasional issues; rely on Black for indentation
        disable = { "python" },
    },
    highlight = { enable = true }, -- Optional: Enable syntax highlighting
})
