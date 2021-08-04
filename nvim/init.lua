require'plugins'

vim.cmd'colorscheme one'
vim.opt.background = 'light'

vim.g.indent_blankline_filetype_exclude = { 'dashboard' }
vim.g.indent_blankline_buftype_exclude = { 'vim-plug', 'toggleterm' }
vim.g.indent_blankline_use_treesitter = true

vim.cmd'syntax enable'
vim.cmd'filetype plugin indent on'
vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.shortmess = vim.opt.shortmess + 'c'
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 300
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.autochdir = true
vim.g.mapleader=' '
vim.g.dashboard_default_executive = 'fzf'

require'terminal'
require'lsp'
require'mappings'
require'bufferline'.setup {}