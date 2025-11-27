return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = 'Find files' },
        { '<leader>fg', '<cmd>Telescope live_grep<CR>',  desc = 'Fuzzy finder' },
        { '<leader>fb', '<cmd>Telescope buffers<CR>',    desc = 'Telescope buffers' },
        { '<leader>fh', '<cmd>Telescope help<CR>',       desc = 'Telescope help tags' },
    }
}
