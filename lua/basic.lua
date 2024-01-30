-- configuration for basic usage of neovim

-- utf8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = 'utf-8'
-- save 8 lines when moving using "jkhl"
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- use relative line number
vim.wo.number = true
vim.wo.relativenumber = true
-- highlight the current line
vim.wo.cursorline = true
-- show the indication icon on the left
vim.wo.signcolumn = "yes"
-- reference line on the right, indicate the line is too long
vim.wo.colorcolumn = "100"
-- set tab equals 4 spaces
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftround = true
-- length when using "<" ">" to move the line left and right
vim.o.shiftwidth = 1
vim.bo.shiftwidth = 1
-- use the space to substitute tab
vim.o.expandtab = true
vim.bo.expandtab = true
-- align the new line to the current line
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true
-- ignore Capslock when searching unless including Capslock in your keyowrd
vim.o.ignorecase = true
vim.o.smartcase = true
-- hilight when searching
vim.o.hlsearch = true
-- searching while inputing
vim.o.incsearch = true
-- height of the command line
vim.o.cmdheight = 2
-- when file was modified, auto reload
vim.o.autoread = true
vim.bo.autoread = true
-- turnoff the wrap functionality
vim.wo.wrap = false
-- Can use the <Left><Right> jump to the next line
vim.o.whichwrap = '<,>,[,]'
-- hide the buffer that has been modified
vim.o.hidden = true
-- support the mouse operation
vim.o.mouse = "a"
-- forbidden the bkp file
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
-- smaller updatetime
vim.o.updatetime = 100
-- timeout for waiting for the shortcut keys
vim.o.timeoutlen = 300
-- display the split window to the right and down
vim.o.splitbelow = true
vim.o.splitright = true
-- do not select the auto complete automatically
vim.g.completeopt = "menu,menuone,noselect,noinsert"
-- display schema
vim.o.background = "dark"
vim.o.termguicolors = true
vim.opt.termguicolors = true
-- the display of the special character
-- display the "space" with "·"
vim.o.list = true
vim.o.listchars = "space:·"
-- auto complete
vim.o.wildmenu = true
-- Dont' pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. 'c'
-- limit the length of the auto completion to 10 lines
vim.o.pumheight = 10
-- show tablines for ever
vim.o.showtabline = 2
-- turnoff the status line because we use plugins
vim.o.showmode = false
