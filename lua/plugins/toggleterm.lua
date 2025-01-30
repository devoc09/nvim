return {
  'akinsho/toggleterm.nvim',
  version = "*",
  keys = {
    { '<Leader>ti', '<cmd>lua ToggleTig()<CR>' }
  },
  config = function()
    local Terminal = require('toggleterm.terminal').Terminal
    local tig = Terminal:new({
      cmd = 'tig status',
      dir = 'git_dir',
      hidden = true,
      direction = 'float',
      on_open = function(term)
        vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<Leader>ti', '<cmd>close<cr>', { noremap = true, silent = true })
      end,
    })
    function ToggleTig()
      tig:toggle()
    end
    -- vim.api.nvim_set_keymap("n", ";t", "<cmd>lua ToggleTigTerminal()<CR>", { noremap = true, silent = true })
  end
}
