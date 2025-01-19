local keymap = vim.keymap -- for conciseness

-- [[ Basic Keymaps ]]
--  See `:help keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

--
--  See `:help wincmd` for a list of all window commands
keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- tree explorer
keymap.set('n', '<leader>ee', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
keymap.set('n', '<leader>ef', '<cmd>NvimTreeFindFile<CR>', { desc = 'Toggle file explorer on current file' })
keymap.set('n', '<leader>ec', '<cmd>NvimTreeCollapse<CR>', { desc = 'Collapse file explorer' })
keymap.set('n', '<leader>er', '<cmd>NvimTreeRefresh<CR>', { desc = 'Refresh file explorer' })

-- utilities
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })
keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' })
keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up' })
keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines' })
keymap.set('n', 'n', 'nzzzv', { desc = 'Center next search result' })
keymap.set('n', 'N', 'Nzzzv', { desc = 'Center previous search result' })
keymap.set({ 'v' }, '<leader>D', [["_d]], { desc = 'Delete to black hole register' })
keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')
keymap.set('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace word under cursor' })

keymap.set('n', '<leader>o', 'o<ESC>', { desc = 'Insert new line below' })
keymap.set('n', '<leader>O', 'O<ESC>', { desc = 'Insert new line above' })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

----------------------
-- Plugin Keybinds
----------------------

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file [e]xplorer" })

-- telescope
-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = 'list all git commits (use <cr> to checkout) ["gc" for git commits]' })
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", { desc = 'list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]' })
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = 'list git branches (use <cr> to checkout) ["gb" for git branch]' })
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = 'list current changes per file with diff preview ["gs" for git status]' })

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = 'Mapping to [r]estart l[s]p if necessary' })

-- comment TODO
keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- You can also specify a list of valid jump keywords

keymap.set("n", "]t", function()
  require("todo-comments").jump_next({keywords = { "ERROR", "WARNING" }})
end, { desc = "Next error/warning todo comment" })


-- LuaSnip
local ls = require("luasnip")

keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})
