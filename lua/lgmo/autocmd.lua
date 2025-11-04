local function check_is_eva_project_and_run_eva_cmd()
    local cwd = vim.fn.getcwd()

    local target_dir = vim.fn.expand('~/workspaces/eva/evaosb')

    if cwd:sub(1, #target_dir) == target_dir then
        vim.cmd('Eva')
    end
end

local eva_autocmds = vim.api.nvim_create_augroup('EvaConfig', { clear = true })

vim.api.nvim_create_autocmd(
    'VimEnter',
    {
        group = eva_autocmds,
        pattern = '*',
        callback = check_is_eva_project_and_run_eva_cmd,
    }
)

vim.api.nvim_create_autocmd(
    'FileType',
    {
        pattern = 'TelescopeResults',
        command = [[setlocal nofoldenable]],
        desc = 'Disable folding in telescope results',
    }
)
