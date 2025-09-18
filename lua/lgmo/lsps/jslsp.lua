return {
	name = 'ts_ls',
	cfg = { 
        cmd = { 'typescript-language-server', '--stdio' }, 
        filetypes = { 'js', 'jsx', 'ts', 'tsx', 'javascript' }, 
        root_markers = { { 'package.json' }, '.git' },
    },

    -- {
	-- 	cmd = {'typescript-language-server', '--stdio'},
	-- 	filetypes = {'js', 'jsx', 'ts', 'tsx'},
	-- 	--root_makers = { {'package.json'}, '.git'}
	-- },
    patterns = { '*.js', '*.jsx', '*.ts', '*.tsx' },
}
