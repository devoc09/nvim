return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  keys = {
    { "sf", function() require('oil').open() end },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
  enabled = false,
}
