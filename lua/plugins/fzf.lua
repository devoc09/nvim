return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { '<C-g>', function() require('fzf-lua').files() end },
    { '<C-p>', function() require('fzf-lua').grep() end },
  },
  opts = {},
}
