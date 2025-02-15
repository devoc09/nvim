return {
    -- "devoc09/lflops.nvim",
    "sonph/onehalf",
    -- dir = '~/go/src/github.com.devoc09/devoc09/lflops.nvim',
    lazy = false,
    rtp = 'vim',
    config = function(plugin)
      -- require('lflops').setup({
      --   italic = {
      --     strings = false,
      --     emphasis = false,
      --     comments = false,
      --     operators = false,
      --     folds = false,
      --   },
      -- })
      vim.opt.rtp:append(plugin.dir .. "/vim")
      vim.cmd("colorscheme onehalfdark")
      vim.opt.background = "dark"
      vim.opt.termguicolors = true
    end,
}
