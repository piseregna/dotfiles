return {
  {'nvim-lua/plenary.nvim' },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>ff",
        function() require("telescope.builtin").find_files() end,
        desc = "Find Plugin File",
      },
      {
        "<leader>fg",
        function() require("telescope.builtin").live_grep() end,
        desc = "Find Plugin File",
      },
      {
        "<leader>fb",
        function() require("telescope.builtin").buffers() end,
        desc = "Find Plugin File",
      },
    },
  }, 
}
