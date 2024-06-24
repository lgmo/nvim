require('lgmo.remap')
require('lgmo.lazy_init')
require('lgmo.set')

vim.opt.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50'

local augroup = vim.api.nvim_create_augroup
local LgmoGroup = augroup('lgmo', {})

local autocmd = vim.api.nvim_create_autocmd

autocmd('LspAttach', {
    group = LgmoGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set(
            'n', 'gd', function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set('n', '<leader>vws', function()
            vim.lsp.buf.workspace_symbol()
        end, opts)
        vim.keymap.set('n', '<leader>vd', function()
            vim.diagnostic.open_float() end, opts
        )
        vim.keymap.set('n', '<leader>vca', function()
            vim.lsp.buf.code_action() end, opts
        )
        vim.keymap.set('n', '<leader>vrr', function()
            vim.lsp.buf.references() end, opts
        )
        vim.keymap.set('n', '<leader>vrn', function()
            vim.lsp.buf.rename() end, opts
        )
        vim.keymap.set('i', '<C-h>', function()
            vim.lsp.buf.signature_help() end, opts
        )
    end
})

