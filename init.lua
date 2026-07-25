---------------------------------------------------------------------------------
-- setup autocmd
---------------------------------------------------------------------------------
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'gitcommit', 'gitrebase', 'gitconfig' },
  callback = function()
    vim.bo.bufhidden = 'delete'
  end,
})

vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  pattern = '*',
  callback = function()
    vim.opt_local.number = false
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove { 'r', 'o' }
  end,
})

---------------------------------------------------------------------------------
-- define filetypes
---------------------------------------------------------------------------------
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'python', 'zig' },
  callback = function()
    vim.opt_local.autoindent = true
    vim.opt_local.smartindent = true
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'vim', 'lua', 'bash', 'fish', 'haskell', 'lhaskell', 'cabal' },
  callback = function()
    vim.opt_local.autoindent = true
    vim.opt_local.smartindent = true
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.yaml.j2' },
  command = 'set filetype=yaml',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'typescript.tsx', 'javascript.jsx' },
  callback = function()
    vim.opt_local.autoindent = true
    vim.opt_local.smartindent = true
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.filetype.add({
  pattern = {
    ['.*%.network'] = 'systemd',
    ['.*%.netdev'] = 'systemd',
    ['.*%.link'] = 'systemd',
  },
})

---------------------------------------------------------------------------------
-- define keymaps
---------------------------------------------------------------------------------
vim.api.nvim_set_keymap('n', '<Left>', '<C-w><<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Right>', '<C-w>><CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Up>', '<C-w>+<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Down>', '<C-w>-<CR>', { noremap = true })
vim.api.nvim_set_keymap('t', ';;', '<C-\\><C-n>', { noremap = true })
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<ScrollWheelUp>', '<C-Y>', { noremap = true })
vim.api.nvim_set_keymap('n', '<ScrollWheelDown>', '<C-E>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-i>', '<C-i>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', 'gT', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Tab>', 'gt', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':cnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':cprev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-c>', ':cclose<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ';cp', ':let @+=expand("%:p")<CR>', { noremap = true, silent = true }) -- copy filepath of buffer

-- Use Terminal shortcut
vim.cmd([[
  autocmd TermOpen * startinsert
  function! s:Openterm() abort
    let w = winwidth(win_getid())
    let h = winheight(win_getid()) * 2.1
    if h > w
      exe 'split'
      exe 'term'
    else
      exe 'vsplit'
      exe 'term'
    endif
  endfunction
  nmap <silent> tt :<C-u>silent call <SID>Openterm()<CR>
]])

-- Clear all buffers
function ClearBuffers()
  local buffers = vim.api.nvim_list_bufs()
  local unsaved = {}
  local to_delete = {}

  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
      if vim.bo[buf].modified then
        table.insert(unsaved, buf)
      else
        table.insert(to_delete, buf)
      end
    end
  end

  if #unsaved > 0 then
    local names = vim.iter(unsaved):map(function(b) return vim.api.nvim_buf_get_name(b) end):totable()
    vim.notify('Keeping unsaved buffers:\n' .. table.concat(names, '\n'), vim.log.levels.WARN)
  end

  for _, buf in ipairs(to_delete) do
    vim.api.nvim_buf_delete(buf, { force = true })
  end

  print('Closed ' .. #to_delete .. ' buffers, kept ' .. #unsaved .. ' unsaved')
end

vim.api.nvim_set_keymap('n', '<Leader>cl', ':lua ClearBuffers()<cr>', { noremap = true, silent = true })

---------------------------------------------------------------------------------
-- options
---------------------------------------------------------------------------------
vim.o.encoding = 'utf-8'
vim.o.fileformat = 'unix'
vim.o.fileencoding = 'utf-8'
vim.o.mouse = 'a'
vim.o.foldenable = false
vim.o.wildmenu = true
vim.o.pumborder = 'rounded'
vim.o.winborder = 'rounded'
vim.o.completeopt = 'menu,menuone,noinsert,noselect,popup,fuzzy'
vim.opt.autocomplete = true
vim.o.belloff = 'all'
vim.o.number = true
vim.o.scrolloff = 999 -- Keep the cursor centered in the screen

-- Tab and Indentation
vim.o.autoindent = true  -- Continue indent of the previous line on newline
vim.o.smartindent = true -- Auto-insert indentation according to syntax
vim.o.shiftwidth = 4     -- Indentation amount for < and > commands
vim.o.tabstop = 4        -- Number of spaces that a tab in the file counts for
vim.o.expandtab = true   -- Convert tabs to spaces

-- String search settings
vim.o.incsearch = true  -- Incremental search, searching as you type
vim.o.ignorecase = true -- Case insensitive searching
vim.o.smartcase = true  -- Case sensitive if search pattern contains uppercase
vim.o.hlsearch = true   -- Highlight search results

-- window split config
vim.o.splitright = true

-- statusline & tabline & cmdheight
vim.o.showtabline = 1
vim.o.laststatus = 0
vim.o.cmdheight = 0

-- colorscheme
vim.opt.background = 'dark'
if vim.env.TERM == 'xterm-ghostty' or vim.env.COLORTERM == 'truecolor' then
  vim.opt.termguicolors = true
end

-- cursorline highlight
vim.o.cursorline = true

-- buffer
vim.o.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  command = 'checktime',
})

-- session
vim.o.sessionoptions = 'buffers,curdir,folds,help,tabpages,winsize,terminal,options,globals'

-- configure searching path && ignore specify directory
vim.opt.path:append(vim.fn.getcwd() .. '/**')
vim.opt.wildignore:append { '*/.git/*', '*/node_modules/*' }

-- configure netrw
vim.g.netrw_liststyle = 3 -- default listing style as treeview

---------------------------------------------------------------------------------
-- manage plugins by vim.pack
-- concept:
-- - disable unnecessary default plugins for better performance
---------------------------------------------------------------------------------
local disabled_built_ins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'matchit',
  'tar',
  'tarPlugin',
  'rrhelper',
  'spellfile_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
}
for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

vim.pack.add({
  { src = 'https://github.com/norcalli/nvim-colorizer.lua' },
  { src = 'https://github.com/devoc09/sphere.vim' },
  { src = 'https://github.com/ibhagwan/fzf-lua' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/devoc09/session-manager.nvim' },
  { src = 'https://github.com/folke/snacks.nvim' },
  { src = 'https://codeberg.org/ziglang/zig.vim' },
  { src = 'https://github.com/sebdah/vim-delve' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/tpope/vim-fugitive' },
  { src = 'https://github.com/justinmk/vim-ug' },
  { src = 'https://github.com/romus204/tree-sitter-manager.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },
})

vim.api.nvim_create_user_command('Packdel', function()
  local inactive_packs = vim.iter(vim.pack.get())
      :filter(function(x) return not x.active end)
      :map(function(x) return x.spec.name end)
      :totable()
  vim.pack.del(inactive_packs)
end, { desc = 'Delete inactive packages in vim.pack' })

-- configure session-manager.nvim
require('session-manager').setup({
  options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
  auto_load = true,
})

-- configure sphere.vim
vim.g.transparent_background = 0
vim.cmd('colorscheme sphere')

-- configure fzf-lua
local fzflua = require('fzf-lua')
fzflua.setup({
  defaults = {
    file_icons = false,
    git_icons = false,
    color_icons = false,
  },
  files = {
    fd_opts = "--color=never --type f --hidden --follow --exclude .git",
  },
  grep = {
    rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git/' -e",
  },
})
vim.keymap.set('n', '<C-f>', function() fzflua.files() end)
vim.keymap.set('n', '<C-l>', function() fzflua.live_grep_native() end)

-- Switch working directory using ghq + fzf-lua with session-manager integration
vim.keymap.set('n', '<leader>w', function()
  require('fzf-lua').fzf_exec('ghq list -p', {
    prompt = 'GHQ Repos> ',
    actions = {
      ['default'] = function(selected)
        local new_dir = selected[1]
        if new_dir == vim.fn.getcwd() then
          return
        end

        local sm = require('session-manager')

        -- Save current session before switching
        sm.save()

        -- Close all buffers forcefully
        vim.cmd('silent! %bd!')

        -- Change working directory
        vim.cmd('cd ' .. vim.fn.fnameescape(new_dir))

        -- Update session-manager's current session pointer
        sm.current = sm.get_current()

        -- Restore session if it exists, otherwise just print directory change
        if vim.fn.filereadable(sm.current) ~= 0 then
          sm.load()
          print('Restored session: ' .. new_dir)
        else
          print('Changed directory to: ' .. new_dir)
        end
      end,
    },
  })
end, { noremap = true, silent = true })

-- configure snacks.nvim
local snacks = require('snacks')
snacks.setup({
  indent = { enabled = true },
})

---------------------------------------------------------------------------------
-- LSP settings
---------------------------------------------------------------------------------
vim.lsp.config['lua_ls'] = {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        pathStrict = true,
        path = { "?.lua", "?/init.lua" },
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.list_extend(vim.api.nvim_get_runtime_file("lua", true), {
          "${3rd}/luv/library",
          "${3rd}/busted/library",
          "${3rd}/luassert/library",
        }),
        checkThirdParty = "Disable",
      },
    },
  }
}

vim.lsp.enable({
  'gopls',         -- go
  'hls',
  'lua_ls',        -- lua
  'tsgo',          -- typescript
  'ty',            -- python
  'rust_analyzer', -- rust
  'zls'            -- zig
})

-- Keymaps of LSP
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    -- Disable default keymaps
    vim.bo[ev.buf].omnifunc = nil
    vim.bo[ev.buf].tagfunc = nil
    vim.bo[ev.buf].formatexpr = nil

    -- Set Keymaps
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    local keyopts = { remap = true, silent = true }
    if client:supports_method('textDocument/implementation') then
      vim.keymap.set('n', 'gD', vim.lsp.buf.implementation, keyopts)
    end
    if client:supports_method('textDocument/definition') then
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, keyopts)
    end
    if client:supports_method('textDocument/typeDefinition') then
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, keyopts)
    end
    if client:supports_method('textDocument/references') then
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, keyopts)
    end
    if client:supports_method('textDocument/rename') then
      vim.keymap.set('n', 'gn', vim.lsp.buf.rename, keyopts)
    end
    if client:supports_method('textDocument/codeAction') then
      vim.keymap.set('n', '<Leader>k', vim.lsp.buf.code_action, keyopts)
    end
    if client:supports_method('textDocument/inlineCompletion') then
      vim.keymap.set('i', '<C-j>', vim.lsp.inline_completion.get, keyopts)
    end
    if client:supports_method('textDocument/completion') then
      local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
-- Auto format on save
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if not client:supports_method('textDocument/willSaveWaitUntil') and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000, async = false })
        end
      })
    end
  end
})

-- Diagnostics
vim.diagnostic.config({
  virtual_lines = true,
})

---------------------------------------------------------------------------------
-- delve
---------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>db", "<cmd>DlvToggleBreakpoint<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dd", "<cmd>DlvDebug<cr>", { noremap = true, silent = true })

---------------------------------------------------------------------------------
-- tree-sitter
---------------------------------------------------------------------------------
require('tree-sitter-manager').setup(
  {
    auto_install = true,                                                                      -- auto-install when a new filetype is encountered
    noauto_install = { "c", "lua", "markdown", "markdown_inline", "query", "vim", "vimdoc" }, -- blacklist from auto_install
    highlight = true,                                                                         -- enable treesitter highlighting (use list to whitelist)
  }
)

require('treesitter-context').setup({
  multiwindow = true,
})
