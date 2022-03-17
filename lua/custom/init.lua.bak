-- This is an example init file , its supposed to be placed in /lua/custom dir
-- lua/custom/init.lua

-- This is where your custom modules and plugins go.
-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!

local hooks = require "core.hooks"

-- MAPPINGS
-- To add new plugins, use the "setup_mappings" hook,
-- try :help key-notation
hooks.add("setup_mappings", function(map)
   map("n", "<leader>cc", ":Telescope <CR>", opt)
   map("n", "<leader>q", ":q <CR>", opt)
   map("n", "<C-_>", ":lua require('Comment.api').toggle_current_linewise()<CR>", opt)
   map("v", "<C-_>", ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", opt)
   map("n", "<C-Bslash>", ":NvimTreeToggle<CR>", opt)
end)

-- NOTE : opt is a variable  there (most likely a table if you want multiple options),
-- you can remove it if you dont have any custom options

-- Install plugins
-- To add new plugins, use the "install_plugins" hook,

-- examples below:

hooks.add("install_plugins", function(use)
   -- automatic commenting out by hotkey by file type
   use {
      "preservim/nerdcommenter",
--      event = "InsertEnter",
   }

   -- autocompletion packages
   use {
      "neoclide/coc.nvim",
      branch = "release",
--      event = "InsertEnter",
   }

   -- indentation and style management packages
   use {
      "tpope/vim-sleuth",
--      event = "InsertEnter",
   }
   use {
      "editorconfig/editorconfig-vim",
--      event = "InsertEnter",
   }

   -- automatic code formatting
   use {
      "Chiel92/vim-autoformat",
      -- run = ":GoUpdateBinaries",
      ft = {"python"},
      -- config = "vim.cmd [[GoUpdateBinaries]]"
--      event = "InsertEnter",
   }


   -- language specific utilities
   use {
      "fatih/vim-go",
      -- run = ":GoUpdateBinaries",
      ft = "go",
      -- config = "vim.cmd [[GoUpdateBinaries]]"
--      event = "InsertEnter",
   }

end)

-- https://github.com/nanotee/nvim-lua-guide#using-api-functions

-- OPTIONS
-- tab related
vim.o.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- spell checking
vim.spelllang = en
-- vim.spell = true
vim.o.spell = true
-- vim.api.nvim_set_option("spell", true)

-- AUTOCMDS / AUGROUPS
-- added backslashes so backslash would be literal!
-- usually this would be "autocmd BufWritePre * :%s/\s\+$//e"
vim.cmd "BufWritePre * :%s/\\s\\+$//e"

-- set helpfull indicators
-- vim.go.list
-- vim.opt.showbreak=↪\
-- set listchars=tab:→\ ,eol:¬,trail:·,nbsp:⍽,extends:>,precedes:<

-- NOTE: we heavily suggest using Packer's lazy loading (with the 'event' field)
-- see: https://github.com/wbthomason/packer.nvim
-- https://nvchad.github.io/config/walkthrough
