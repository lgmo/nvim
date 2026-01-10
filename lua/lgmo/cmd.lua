vim.api.nvim_create_user_command(
    'Eva',
    function(_)
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.expandtab = true

        require('conform').setup({ format_on_save = false })
    end,
    {}
)

vim.api.nvim_create_user_command(
    'ChangeNumber',
    function(_)
        if (vim.opt.relativenumber:get()) then
            vim.opt.relativenumber = false 
        else
            vim.opt.relativenumber = true
        end
    end,
    {}
)

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local Path = require("plenary.path")

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

vim.api.nvim_create_user_command(
    'Dirs',
    function(_)
        local root = vim.loop.cwd()
        local dirs = scan_dirs(root)
        for i, dir in ipairs(dirs) do
            -- Remove o prefixo root + o separador de caminho
            dirs[i] = dir:sub(#root + 2)  -- +2 para remover também a barra (/ ou \)
        end

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
    end,
    {}
)
