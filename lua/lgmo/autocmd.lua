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

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local Path = require("plenary.path")

-- Função recursiva: lista todos diretórios
local function scan_dirs(root)
    local results = {}
    local handle = vim.loop.fs_scandir(root)
    if not handle then return results end

    while true do
        local name, t = vim.loop.fs_scandir_next(handle)
        if not name then break end

        local full = root .. "/" .. name
        if t == "directory" and name ~= ".git" and name ~= "node_modules" then
            table.insert(results, full)
            -- recursivo
            local subdirs = scan_dirs(full)
            for _, d in ipairs(subdirs) do
                table.insert(results, d)
            end
        end
    end

    return results
end

vim.api.nvim_create_user_command("Dirs", function()
    local root = vim.loop.cwd()
    local dirs = scan_dirs(root)

    pickers.new({}, {
        prompt_title = "Directories",
        finder = finders.new_table({
            results = dirs,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(_, map)
            map("i", "<CR>", function(prompt_bufnr)
                local entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                local path = entry[1]
                vim.cmd("Explore " .. vim.fn.fnameescape(path))
            end)
            return true
        end,
    }):find()
end, {})
