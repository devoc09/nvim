return {
  {
    -- 'hrsh7th/nvim-deck',
    dir = '~/go/src/github.com.devoc09/devoc09/nvim-deck',
    config = function ()
      local deck = require('deck')
      require('deck.easy').setup()

      vim.api.nvim_create_autocmd('User', {
        pattern = 'DeckStart',
        callback = function(e)
          local ctx = e.data.ctx -- [[@as deck.Context]]

          -- normal-mode mapping
          ctx.keymap('n', '<Esc>', function()
            ctx.set_preview_mode(false)
          end)
          ctx.keymap('n', '<Tab>', deck.action_mapping('choose_action'))
          ctx.keymap('n', '<C-l>', deck.action_mapping('refresh'))
          ctx.keymap('n', 'i', deck.action_mapping('prompt'))
          ctx.keymap('n', 'a', deck.action_mapping('prompt'))
          ctx.keymap('n', '@', deck.action_mapping('toggle_select'))
          ctx.keymap('n', '*', deck.action_mapping('toggle_select_all'))
          ctx.keymap('n', 'p', deck.action_mapping('toggle_preview_mode'))
          ctx.keymap('n', 'd', deck.action_mapping('delete'))
          ctx.keymap('n', '<CR>', deck.action_mapping('default'))
          ctx.keymap('n', 'o', deck.action_mapping('open'))
          ctx.keymap('n', 'O', deck.action_mapping('open_keep'))
          ctx.keymap('n', 's', deck.action_mapping('open_split'))
          ctx.keymap('n', 'v', deck.action_mapping('open_vsplit'))
          ctx.keymap('n', 't', deck.action_mapping('open_tabnew'))
          ctx.keymap('n', 'N', deck.action_mapping('create'))
          ctx.keymap('n', '<C-u>', deck.action_mapping('scroll_preview_up'))
          ctx.keymap('n', '<C-d>', deck.action_mapping('scroll_preview_down'))

          -- cmdline-mode mapping.
          ctx.keymap('c', '<C-y>', function()
            vim.api.nvim_feedkeys(vim.keycode('<Esc>'), 'n', true)
            vim.schedule(function()
              ctx.do_action('default')
            end)
          end)
          ctx.keymap('c', '<C-j>', function()
            ctx.set_cursor(ctx.get_cursor() + 1)
          end)
          ctx.keymap('c', '<C-k>', function()
            ctx.set_cursor(ctx.get_cursor() - 1)
          end)

          -- If you want to start the filter by default, call ctx.prompt() here
          ctx.prompt()
        end
      })
      -- Example key bindings for launching nvim-deck sources. (These mapping required `deck.easy` calls.)
      vim.keymap.set('n', '<Leader>ff', '<Cmd>Deck files<CR>', { desc = 'Show recent files, buffers, and more' })
      vim.keymap.set('n', '<Leader>gr', '<Cmd>Deck grep<CR>', { desc = 'Start grep search' })
      vim.keymap.set('n', '<Leader>gi', '<Cmd>Deck git<CR>', { desc = 'Open git launcher' })
      vim.keymap.set('n', '<Leader>he', '<Cmd>Deck helpgrep<CR>', { desc = 'Live grep all help tags' })

      -- Show the latest deck context.
      vim.keymap.set('n', '<Leader>;', function()
        local ctx = require('deck').get_history()[1]
        if ctx then
          ctx.show()
        end
      end)
    end,
  },
}
