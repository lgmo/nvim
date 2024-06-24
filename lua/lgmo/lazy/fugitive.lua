return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

        local theprimeagen_fugitive = vim.api
            .nvim_create_augroup('ThePrimeagenFugitive', {})

        local autocmd = vim.api.nvim_create_autocmd

        autocmd('BufWinEnter', {
            group = theprimeagen_fugitive,
            pattern = '*',
            callback = function()
                if vim.bo.ft ~= 'fugitive' then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = { buffer = bufnr, remap = false }
                vim.keymap.set('n', '<leader>p', function()
                    vim.cmd.Git({'pull', '--rebase'})
                end)
            end,
        })

        vim.keymap.set('n', 'gu', '<cmd>diffget //2<CR>')
        vim.keymap.set('n', 'gh', '<cmd>diffget //3<CR>')
    end,

}

