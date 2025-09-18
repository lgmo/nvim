require 'lgmo.lazy_init'
require 'lgmo.mappings'
require 'lgmo.opt'
require 'lgmo.appearence'

-- local lsps = require 'lgmo.lsps'
-- 
-- for _, setup in ipairs(lsps) do
--     -- vim.lsp.config[setup.name] = setup.config
--     vim.api.nvim_create_autocmd('BufEnter', {
--         pattern = setup.patterns,
--         callback = function(ev)
--             vim.lsp.config[setup.name] = setup.cfg
--             vim.lsp.enable(setup.name)
--             if type(setup.init_config) == "function" then
--                 print('so far so good')
--                 setup.init_config()
--             end
--         end,
--     })
-- end


-- vim.api.nvim_create_autocmd('BufEnter', {
--     pattern = { '*.js', '*.jsx', '*.ts', '*.tsx' },
--     callback = function(ev)
--         vim.lsp.config['ts_ls'] = { 
--             cmd = { 'typescript-language-server', '--stdio' }, 
--             filetypes = { 'js', 'jsx', 'ts', 'tsx', 'javascript' }, 
--             root_makers = { { 'package.json' }, '.git' } 
--         }
--         vim.lsp.enable('ts_ls')
--         -- print('we did it', setup.name)
--         -- vim.lsp.enable(setup.name)
--     end,
-- })



-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'lua',
--   callback = function(ev)
--     vim.lsp.start({
--       name = 'lua_ls',
--       cmd = {'lua-language-server'},
-- 
--       -- Set the "root directory" to the parent directory of the file in the
--       -- current buffer (`ev.buf`) that contains either a "setup.py" or a
--       -- "pyproject.toml" file. Files that share a root directory will reuse
--       -- the connection to the same LSP server.
--       root_dir = vim.fs.root(ev.buf, { { '.luarc.json', '.luarc.jsonc' }, '.git' }),
--     })
--   end,
-- })

