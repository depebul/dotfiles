-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- UI
vim.opt.termguicolors = true
vim.opt.cursorline = true

-- Mouse support
vim.opt.mouse = "a"

-- Clipboard (use system clipboard)
vim.opt.clipboard = "unnamedplus"

-- Bootstrap lazy.nvim
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

require("config.lazy")
