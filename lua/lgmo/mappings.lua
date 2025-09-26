vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>w', vim.cmd.w, { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', vim.cmd.q, { desc = 'Close' })
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Worktree view' })


vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', ':bprev<CR>', { desc = 'Prev buffer' })
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tl', ':tabn<CR>', { desc = 'Go to next tab' })
vim.keymap.set('n', '<leader>th', ':tabp<CR>', { desc = 'Go to prev tab' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })

vim.keymap.set('n', '<C-Up>', ':resize +1<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width' })
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', { desc = 'Vertical split' })
vim.keymap.set('n', '<leader>sh', ':split<CR>', { desc = 'Horizontal Split' })
vim.keymap.set('n', '<S-Up>', function()
    vim.diagnostic.open_float()
end, { desc = 'Show diagnostic' })

function find_in_list(val, list)
    for _, el in ipairs(list) do
        if val == el then
            return true
        end
    end
    return false
end

function ts_move_helper(node_types, move_type)
    local ts_utils = require 'nvim-treesitter.ts_utils'

    local node = ts_utils.get_node_at_cursor()

    while node do
        if find_in_list(node:type(), node_types) then
            break
        end
        node = node:parent()
    end

    if node then
        local pos_table = {}
        pos_table.start_row, pos_table.start_col, pos_table.end_row, pos_table.end_col = node:range()

        vim.cmd(tostring(pos_table[move_type] + 1))
    end
end

function next_matching_node(node_types)
    local ts_utils = require 'nvim-treesitter.ts_utils'
    local node = ts_utils.get_node_at_cursor()
    if not node then return nil end

    local root = node:root()
    local current = node

    while current do
        local sibling = current:next_named_sibling()
        while sibling do
            if find_in_list(sibling:type(), node_types) then
                return sibling
            end
            sibling = sibling:next_named_sibling()
        end
        current = current:parent()
        if current == root then break end
    end

    return nil -- não encontrou
end

function ts_move_next_helper(node_types, move_type)
    local node = next_matching_node(node_types)

    if node then
        local pos_table = {}
        pos_table.start_row, pos_table.start_col, pos_table.end_row, pos_table.end_col = node:range()

        vim.cmd(tostring(pos_table[move_type] + 1))
    end
end

function prev_matching_node(node_types)
    local ts_utils = require 'nvim-treesitter.ts_utils'
    local node = ts_utils.get_node_at_cursor()
    if not node then return nil end

    local root = node:root()
    local current = node

    while current do
        local sibling = current:prev_named_sibling()
        while sibling do
            if find_in_list(sibling:type(), node_types) then
                return sibling
            end
            sibling = sibling:prev_named_sibling()
        end
        current = current:parent()
        if current == root then break end
    end

    return nil -- não encontrou
end

function ts_move_prev_helper(node_types, move_type)
    local node = prev_matching_node(node_types)

    if node then
        local pos_table = {}
        pos_table.start_row, pos_table.start_col, pos_table.end_row, pos_table.end_col = node:range()

        vim.cmd(tostring(pos_table[move_type] + 1))
    end
end

vim.keymap.set('n', ']f', function()
    local count = vim.v.count1
    for _ = 1, count do
        ts_move_helper(
            { 'function_definition', 'function_declaration', 'decorated_definition' },
            'end_row'
        )
    end
end, { desc = 'Go to the end of the function' })

vim.keymap.set('n', '[f', function()
    local count = vim.v.count1
    for _ = 1, count do
        ts_move_helper(
            { 'function_definition', 'function_declaration', 'decorated_definition' },
            'start_row'
        )
    end
end, { desc = 'Go to the start of the function' })

vim.keymap.set('v', ']f', function()
    local count = vim.v.count1
    for _ = 1, count do
        ts_move_helper(
            { 'function_definition', 'function_declaration', 'decorated_definition' },
            'end_row'
        )
    end
end, { desc = 'Go to the end of the function' })

vim.keymap.set('v', '[f', function()
    local count = vim.v.count1
    for _ = 1, count do
        ts_move_helper(
            { 'function_definition', 'function_declaration', 'decorated_definition' },
            'start_row'
        )
    end
end, { desc = 'Go to the start of the function' })

vim.keymap.set('n', '<leader>fn', function()
    local count = vim.v.count1
    for _ = 1, count do
        ts_move_next_helper(
            { 'function_definition', 'function_declaration', 'decorated_definition' },
            'start_row'
        )
    end
end, { desc = 'Go to the next function' })

vim.keymap.set('n', '<leader>fp', function()
    local count = vim.v.count1
    for _ = 1, count do
        ts_move_prev_helper(
            { 'function_definition', 'function_declaration', 'decorated_definition' },
            'start_row'
        )
    end
end, { desc = 'Go to the previews function' })

vim.keymap.set('v', '<leader>fn', function()
    local count = vim.v.count1
    for _ = 1, count do
        ts_move_next_helper(
            { 'function_definition', 'function_declaration', 'decorated_definition' },
            'start_row'
        )
    end
end, { desc = 'Go to the next function' })

vim.keymap.set('n', '<leader>fp', function()
    local count = vim.v.count1
    for _ = 1, count do
        ts_move_prev_helper(
            { 'function_definition', 'function_declaration', 'decorated_definition' },
            'start_row'
        )
    end
end, { desc = 'Go to the previews function' })

vim.keymap.set('n', ']c', function()
    local count = vim.v.count1
    for _ = 1, count do
        ts_move_helper(
            { 'class_definition' },
            'end_row'
        )
    end
end, { desc = 'Go to the end of the class' })

vim.keymap.set('n', '[c', function()
    local count = vim.v.count1
    for _ = 1, count do
        ts_move_helper(
            { 'class_definition' },
            'start_row'
        )
    end
end, { desc = 'Go to the start of the class' })

vim.keymap.set('v', ']c', function()
    local count = vim.v.count1
    for _ = 1, count do
        ts_move_helper(
            { 'class_definition' },
            'end_row'
        )
    end
end, { desc = 'Go to the end of the class' })

vim.keymap.set('v', '[c', function()
    local count = vim.v.count1
    for _ = 1, count do
        ts_move_helper(
            { 'class_definition' },
            'start_row'
        )
    end
end, { desc = 'Go to the start of the class' })

vim.keymap.set('n', '<leader>cn', function()
    local count = vim.v.count1
    for _ = 1, count do
        ts_move_next_helper(
            { 'class_definition' },
            'start_row'
        )
    end
end, { desc = 'Go to the next class' })

vim.keymap.set('n', '<leader>cp', function()
    local count = vim.v.count1
    for _ = 1, count do
        ts_move_prev_helper(
            { 'class_definition' },
            'start_row'
        )
    end
end, { desc = 'Go to the previews class' })


vim.keymap.set('v', '<leader>cn', function()
    local count = vim.v.count1
    for _ = 1, count do
        ts_move_next_helper(
            { 'class_definition' },
            'start_row'
        )
    end
end, { desc = 'Go to the next class' })

vim.keymap.set('v', '<leader>cp', function()
    local count = vim.v.count1
    for _ = 1, count do
        ts_move_prev_helper(
            { 'class_definition' },
            'start_row'
        )
    end
end, { desc = 'Go to the previews class' })


-- Adiciona linhas acima com count
vim.keymap.set('n', '<leader>O', function()
    local count = vim.v.count1
    local row = vim.fn.line('.') - 1
    local lines = {}
    for _ = 1, count do
        table.insert(lines, "")
    end
    vim.api.nvim_buf_set_lines(0, row, row, false, lines)
    vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
end, { desc = 'Add new line(s) above' })

-- Adiciona linhas abaixo com count
vim.keymap.set('n', '<leader>oo', function()
    local count = vim.v.count1
    local row = vim.fn.line('.')
    local lines = {}
    for _ = 1, count do
        table.insert(lines, "")
    end
    vim.api.nvim_buf_set_lines(0, row, row, false, lines)
    vim.api.nvim_win_set_cursor(0, { row + count, 0 })
end, { desc = 'Add new line(s) below' })

-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })

vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action)
