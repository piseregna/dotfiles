
local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
-- All'interno del file txt.lua
vim.api.nvim_set_keymap('n', '<leader>ft', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap('n', '<A-b>',  ':call setreg("+", @+, "b")<CR>', opts)
keymap('n', '<A-c>',  ':call setreg("+", @+, "c")<CR>', opts)
keymap('n', '<A-l>',  ':call setreg("+", @+, "l")<CR>', opts)

-- Copia e incolla dalla clipboard
keymap('n', 'gp', '"+p' , opts)
keymap('n', 'gP', '"+P' , opts)
keymap('v', 'gy', '"+y' , opts)
keymap('v', 'gY', '"+Y' , opts)

keymap('n', '<leader>p','_p' , opts)
keymap('n', '<leader>P','_P' , opts)

keymap('n', '<leader>a', 'ggVG' , opts)

keymap('n', '<C-h>' , '<C-w>h' ,opts)
keymap('n', '<C-j>' , '<C-w>j' ,opts)
keymap('n', '<C-k>' , '<C-w>k' ,opts)
keymap('n', '<C-l>' , '<C-w>l' ,opts)

keymap('n', '<C-S-Left>', ':vertical resize +5<CR>',opts)
keymap('n', '<C-S-Right>', ':vertical resize -5<CR>',opts)
keymap('n', '<C-S-Up>', ':horizontal resize +5<CR>',opts)
keymap('n', '<C-S-Down>', ':horizontal resize -5<CR>',opts)

keymap('v', '<C-S-y>', 'hy:%s/<C-r>h//g<left><left>', opts)

keymap('n', '<C-tab>',' :bn<CR>',opts)
keymap('n', '<S-tab>',' :bp<CR>',opts)

