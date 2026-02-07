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
vim.api.nvim_set_keymap('n', ';c', ':let @+=expand("%:p")<CR>', { noremap = true, silent = true }) -- copy filepath of buffer

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
function clearBuffers()
  local buffers = vim.api.nvim_list_bufs()

  for _, buffer in ipairs(buffers) do
    if vim.api.nvim_buf_get_option(buffer, 'modified') then
      print('Buffer ' .. buffer .. 'has unsaved changes')
    else
      vim.api.nvim_buf_delete(buffer, { force = true })
    end
  end
end

vim.api.nvim_set_keymap('n', '<Leader>cl', ':lua clearBuffers()<cr>', { noremap = true, silent = true })

---------------------------------------------------------------------------------
-- options
---------------------------------------------------------------------------------
vim.o.encoding = 'utf-8'
vim.o.fileformat = 'unix'
vim.o.fileencoding = 'utf-8'
vim.o.mouse = 'a'
vim.o.foldenable = false
vim.o.wildmenu = true
vim.o.completeopt = 'menu,menuone,noinsert,noselect,popup'
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
vim.o.winborder = 'rounded'

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
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/ibhagwan/fzf-lua' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter',        version = 'master' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },
  { src = 'https://github.com/windwp/nvim-ts-autotag' },
  { src = 'https://github.com/phaazon/hop.nvim',                       version = 'v2' },
  { src = 'https://github.com/devoc09/session-manager.nvim' }, -- TODO: there is a bug when load by vim.pack.add. unload plugins when session auto load
  { src = 'https://github.com/folke/snacks.nvim' },
  { src = 'https://github.com/ziglang/zig.vim' },
  { src = 'https://github.com/sebdah/vim-delve' },
  { src = 'https://github.com/terrastruct/d2-vim' },
  { src = 'https://github.com/dcampos/nvim-snippy' },
  { src = 'https://github.com/hrsh7th/nvim-cmp' },
  { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
  { src = 'https://github.com/hrsh7th/cmp-path' },
  { src = 'https://github.com/hrsh7th/cmp-buffer' },
  { src = 'https://github.com/dcampos/cmp-snippy' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
})

-- configure session-manager.nvim
require('session-manager').setup({
  options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
  auto_load = true,
})

-- configure treesitter
local treesitter = require('nvim-treesitter.configs')
treesitter.setup({
  ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline', 'go', 'rust', 'zig', 'typescript' },
  ignore_install = { 'javascript' },
  sync_install = false,
  auto_install = false,
  highlight = { enable = true },
  textobjects = { enable = true },
  context = {
    enable = true,
    multiwindow = true,
  },
  indent = {
    enable = true,
  },
})

local ts_autotag = require('nvim-ts-autotag')
ts_autotag.setup({
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = true,
  },
})

-- configure sphere.vim
vim.g.transparent_background = 1
vim.cmd('colorscheme sphere')

-- configure fzf-lua
local fzflua = require('fzf-lua')
fzflua.setup({
  files = {
    fd_opts = "--color=never --type f --hidden --follow --exclude .git",
  },
  grep = {
    rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git/' -e",
  },
})
vim.keymap.set('n', '<C-g>', function() fzflua.files() end)
vim.keymap.set('n', '<C-p>', function() fzflua.grep() end)

-- configure hop.nvim
local hop = require('hop')
hop.setup({ multi_windows = true })
vim.keymap.set('n', 'f', function() hop.hint_char1() end)

-- configure snacks.nvim
local snacks = require('snacks')
snacks.setup({
  indent = { enabled = true },
})

-- configure nvim-cmp
local cmp = require('cmp')
local snippy = require('snippy')
local opts = {
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'snippy' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping(function(original)
      if snippy.can_jump(1) then
        snippy.next()
      elseif cmp.visible() then
        cmp.select_next_item()
      else
        original()
      end
    end, { 'i', 's' }),
    ['<C-p>'] = cmp.mapping(function(original)
      if snippy.can_jump(-1) then
        snippy.previous()
      elseif cmp.visible() then
        cmp.select_prev_item()
      else
        original()
      end
    end, { 'i', 's' }),
  }),
  snippet = {
    expand = function(args)
      require 'snippy'.expand_snippet(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered({ border = 'single' }),
    documentation = cmp.config.window.bordered({ border = 'single' }),
  },
}
cmp.setup(opts)

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
  'gopls',
  'hls',
  'lua_ls',
  'tsgo',
  'rust_analyzer',
  'zls'
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
