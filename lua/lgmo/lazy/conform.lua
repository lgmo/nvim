return {
    'stevearc/conform.nvim',
    opts = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                require("conform").format({ bufnr = args.buf })
            end,
        })
        return {
            formatters_by_ft = {
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                -- python = { "ruff" },
                -- You can customize some of the format options for the filetype (:help conform.format)
                -- rust = { "rustfmt", lsp_format = "fallback" },
                -- Conform will run the first available formatter
                -- javascript = { "prettierd", "prettier", stop_after_first = true },
            },
            format_on_save = function(bufnr)
                return { timeout_ms = 3000, lsp_fallback = true }
            end,
        }
    end,
}
