-- use map to represent vim.api.nvim_set_key_map
local map = vim.api.nvim_set_keymap
-- use local to represent normal options
local opt = {noremap = true, silent = true}

-- set leader key
map("", "<Space>", "<Nop>", opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- map('mode', 'button', 'button_mapped', 'option')
-- mode includes: n for Normal, i for Insear, v for Visual t for Terminal, c for Command
-- cancel the 's' button functionality
map("n", "s", "", opt)
-- split the window
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
-- close the current window
map("n", "sc", "<C-w>c", opt)
-- close all the other windows
map("n", "so", "<C-w>o", opt)
-- Alt + hjkl to jump to different windows
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)
-- adjust the size of the herionzental adjscent windows
map("n", "<C-Left>", ":vertical resize +1<CR>", opt)
map("n", "<C-Right>", ":vertical resize -1<CR>", opt)
-- adjust the size of the vertical adjscent windows
map("n", "<C-Down>", ":resize +1<CR>", opt)
map("n", "<C-Up>", ":resize -1<CR>", opt)
-- set all windows to equal size
map("n", "s=", "<C-w>=", opt)
-- Terminal related keybindings
map("n", "<leader>t", ":sp | terminal<CR>", opt)
map("n", "<leader>vt", ":vsp | terminal<CR>", opt)
map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)
-- modify the code indentation in normal mode
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- move the selected chunck up and down
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)
-- reconfigure the behaviour of "ve" to not yank but to keep the old one
map("v", "P", "_dP", opt)
-- scrolling
map("n", "<C-j>", "4j", opt)
map("n", "<C-k>", "4k", opt)
map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)
-- do not copy when paste in visual mode
map("v", "p", '"_dP', opt)
-- exit
map("n", "q", ":q<CR>", opt)
map("n", "qq", ":q!<CR>", opt)
map("n", "Q", ":qa!<CR>", opt)
-- insert mode
map("i", "<C-h>", "<ESC>I", opt)
map("i", "<C-l>", "<ESC>A", opt)

local pluginKeys = {}

-- treesitter fold
map("n", "zz", ":foldclose<CR>", opt)
map("n", "Z", ":foldopen<CR>", opt)

-- nvim-tree
map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)
map("n", "<leader>m", ":NvimTreeToggle<CR>", opt)

-- bufferline
-- shift Tab
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- close
--"moll/vim-bbye"
map("n", "<C-w>", ":Bdelete!<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opt)

-- Telescope
-- search file
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
-- global search
map("n", "<C-f>", ":Telescope live_grep<CR>", opt)
-- Telescope list, insertmode keybindings
pluginKeys.telescopeList = {
  i = {
    -- move up and down
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",
    ["<C-n>"] = "move_selection_next",
    ["<C-p>"] = "move_selection_previous",
    -- history
    ["<Down>"] = "cycle_history_next",
    ["<Up>"] = "cycle_history_prev",
    -- close window
    -- ["<esc>"] = actions.close,
    ["<C-c>"] = "close",
    -- scroll up and down the preview window
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
  },
}

-- MarkDown
map("n", "<leader>mp", ":MarkdownPreview<CR>", opt)
map("i", "<leader>mp", ":MarkdownPreview<CR>", opt)
map("v", "<leader>mp", ":MarkdownPreview<CR>", opt)
map("n", "<leader>mc", ":MarkdownPreviewStop<CR>", opt)
map("i", "<leader>mc", ":MarkdownPreviewStop<CR>", opt)
map("v", "<leader>mc", ":MarkdownPreviewStop<CR>", opt)

-- Tagbar
map("n", "<F2>", ":Tagbar<CR>", opt)
map("i", "<F2>", ":Tagbar<CR>", opt)
map("v", "<F2>", ":Tagbar<CR>", opt)

return pluginKeys

