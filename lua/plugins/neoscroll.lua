return {
  "karb94/neoscroll.nvim",
  config = function()
    require('neoscroll').setup({
      mappings = {
        '<C-u>', '<C-d>', '<C-y>', '<C-e>'
      },
    })
  end,
  enabled  = false,
}
