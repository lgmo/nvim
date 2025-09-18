return {
    name = 'pyright',
    cfg = {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'py', 'python' },
        root_markers = { { 'pyproject.toml', 'requirements.txt' }, '.git' },
    },
    patterns = { '*.py' },
}
