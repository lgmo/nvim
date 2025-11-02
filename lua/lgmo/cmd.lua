vim.api.nvim_create_user_command(
    'Eva',
    function(_)
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.expandtab = true

        require('conform').setup({ format_on_save = false })
    end,
    {}
)
