-- Set mapleader to space
vim.g.mapleader = " "

-- Disable Warning
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Disable netrw because of telescope-file-browser
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local options = {
  autowrite = true, -- Enable auto write
  confirm = true, -- Confirm to save changes before exiting modified buffer
  list = true, -- Show some invisible characters (tabs, spaces)
  expandtab = true, -- Use spaces instead of tabs
  tabstop = 2, -- Number of spaces tabs count for
  shiftwidth = 2, -- Size of an indent
  shiftround = true, -- Round indent
  smartindent = true, -- Insert indents automatically
  number = true, -- Print line number
  numberwidth = 1, -- Width of the number column
  relativenumber = true, -- Relative line numbers
  ignorecase = true, -- Ignore case in search
  smartcase = true, -- Don't ignore case with capitals
  showmode = false, -- Don't show mode
  wrap = false, -- Disable line wrap
  cursorline = true, -- Enable highlighting of the current line
  termguicolors = true, -- True color support
  clipboard = "unnamedplus",-- Sync with system clipboard
  undofile = true, -- Persistent undo history
  undodir = os.getenv "HOME" .. "/.cache/nvim/undodir", -- Undo directory
  guicursor = "a:block", -- Block cursor for all modes
  mouse = "a", -- Enable mouse mode
  splitright = true, -- Put new windows right of current
  splitbelow = true, -- Put new windows below current
  laststatus = 3, -- Global statusline
  conceallevel = 2, -- Hide * markup for bold and italic, but not markers with substitutions
  swapfile = false, -- Disable use of swap files
  backup = false, -- Disable backup file
  writebackup = false, -- if a file is begin edited by antother program (or was written to a file while editing with another program), it is not allowed to be edited
  fileencoding = "utf-8", -- The encoding written to a file
  wildmenu = true, -- Make tab completion for files/buffers act like bash
  signcolumn = "yes", -- Always show the sign column
  history = 100, -- Keep 100 lines of history
  cmdheight = 1, -- Set height of command line
}

for option, value in pairs(options) do
  vim.opt[option] = value
end
