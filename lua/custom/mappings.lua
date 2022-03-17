local map = require("core.utils").map

-- telescope
map("n", "<leader>fp", ":Telescope media_files <CR>")
map("n", "<leader>te", ":Telescope <CR>")

-- truezen
map("n", "<leader>ta", ":TZAtaraxis <CR>")
map("n", "<leader>tm", ":TZMinimalist <CR>")
map("n", "<leader>tf", ":TZFocus <CR>")

map("n", "<C-_>", ":lua require('Comment.api').toggle_current_linewise()<CR>")
map("v", "<C-_>", ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>")
map("n", "<C-Bslash>", ":NvimTreeToggle<CR>")
