return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim', -- Add the extension here
    },
    keys = {
        { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = 'Find files' },
        { '<leader>fg', '<cmd>Telescope live_grep_args<CR>',  desc = 'Fuzzy finder' },
        { '<leader>fb', '<cmd>Telescope buffers<CR>',    desc = 'Telescope buffers' },
        { '<leader>fh', '<cmd>Telescope help<CR>',       desc = 'Telescope help tags' },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local lga_actions = require("telescope-live-grep-args.actions")
      local lg_args = {
        auto_quoting = true,
        mappings = {
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            ["<C-space>"] = lga_actions.to_fuzzy_refine,
          },
        },
      }


      opts.extensions = opts.extensions or {}
      opts.extensions.live_grep_args = lg_args
      telescope.setup(opts)
      telescope.load_extension("live_grep_args")
    end,
}
