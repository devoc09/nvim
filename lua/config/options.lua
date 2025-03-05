vim.o.encoding = "utf-8"
vim.o.fileformat = "unix"
vim.o.fileencoding = "utf-8"
vim.o.mouse = "a"
vim.o.foldenable = false
vim.o.wildmenu = true
vim.o.completeopt = "menu,menuone,noinsert,noselect"
vim.o.number = false
-- vim.o.clipboard = 'unnamed'
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

-- statusline & tabline
vim.o.showtabline = 1
-- vim.o.tabline='%t'
vim.o.laststatus = 3

vim.o.colorcolumn = "100" -- Highlight 100 character limit

-- colorscheme
vim.opt.background = "dark"

-- cursorline highlight
vim.o.cursorline = true

-- buffer
vim.o.autoread = true

-- session
vim.o.sessionoptions = 'buffers,curdir,folds,help,tabpages,winsize,terminal,options,globals'
