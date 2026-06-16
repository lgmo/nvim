require 'lgmo.lazy_init'
require 'lgmo.mappings'
require 'lgmo.opt'
require 'lgmo.appearence'
require 'lgmo.cmd'
require 'lgmo.autocmd'

-- Set the starting scale factor (1.0 is 100%).
vim.g.neovide_scale_factor = 1.0

-- The core function for zooming.
local function change_scale_factor(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

-- Create keymaps to call the zoom function.
-- <C--> is for zooming out, <C-=> (or <C-+>) for zooming in.
vim.keymap.set("n", "<C-->", function() change_scale_factor(1 / 1.25) end, { desc = "Zoom Out" })
vim.keymap.set("n", "<C-=>", function() change_scale_factor(1.25) end, { desc = "Zoom In" })

if vim.g.neovide then
    vim.g.neovide_cursor_animation_length = 0       -- Disables the glide animation
    vim.g.neovide_cursor_trail_size = 0             -- Disables the smear/trail trail effect
    vim.g.neovide_cursor_animate_command_line = false -- Disables jumping to the command line
end
