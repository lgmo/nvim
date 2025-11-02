return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    -- opts = function()
    --         vim.api.nvim_create_autocmd('BufEnter', {
    --             pattern = '*',
    --             callback = function(ev)
    --                 vim.cmd('TSEnable highlight')
    --             end,
    --         })
    --         return {
    --         ensure_installed = {
    --             "c",
    --             "lua",
    --             "vim",
    --             "vimdoc",
    --             "query",
    --             "markdown",
    --             "markdown_inline"
    --         },
    --         auto_install = true,
    --         highlight = {
    --             enable = true,
    --         },
    --     }
    config = function(plugin, opts)
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                'vimdoc',
                'javascript',
                'typescript',
                'c',
                'lua',
                'rust',
                'terraform'
            },

            sync_install = false,

            auto_install = true,

            -- indent = {
            --     enable = true,
            -- },

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'markdown' },
            },
        })

        local treesitter_parser_config = require('nvim-treesitter.parsers').get_parser_configs()
        treesitter_parser_config.templ = {
            install_info = {
                url = 'https://github.com/vrischmann/tree-sitter-templ.git',
                files = { 'src/parser.c', 'src/scanner.c' },
                branch = 'master',
            },
        }
        vim.treesitter.language.register('templ', 'templ')

        vim.api.nvim_create_autocmd('BufEnter', {
            pattern = '*',
            callback = function(ev)
                vim.cmd('TSEnable highlight')
            end,
        })
    end
    -- require'nvim-treesitter.configs'.setup {
    --}
    --end
}
