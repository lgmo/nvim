return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        vim.api.nvim_create_autocmd('User', {
            pattern = 'TSUpdate',
            callback = function()
                require('nvim-treesitter.parsers').templ = {
                    install_info = {
                        url = 'https://github.com/vrischmann/tree-sitter-templ.git',
                        files = { 'src/parser.c', 'src/scanner.c' },
                        branch = 'master',
                    },
                }
            end,
        })
        vim.treesitter.language.register('templ', 'templ')

        require('nvim-treesitter').install({
            'vimdoc',
            'javascript',
            'typescript',
            'c',
            'lua',
            'rust',
            'terraform',
            'templ',
        })

        vim.api.nvim_create_autocmd('FileType', {
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end,
}
