return {
  -- autocompletion
  {
     "neoclide/coc.nvim",
     branch = "release",
  },
  -- indentation helpers
  {
    "tpope/vim-sleuth"
  },
  {
    "editorconfig/editorconfig-vim"
  }

   -- {
   --    "windwp/nvim-ts-autotag",
   --    ft = { "html", "javascriptreact" },
   --    after = "nvim-treesitter",
   --    config = function()
   --       require("nvim-ts-autotag").setup()
   --    end,
   -- },
   -- {
   --    "jose-elias-alvarez/null-ls.nvim",
   --    after = "nvim-lspconfig",
   --    config = function()
   --       require("custom.plugins.null-ls").setup()
   --    end,
   -- },
   --
   -- {
   --    "nvim-telescope/telescope-media-files.nvim",
   --    after = "telescope.nvim",
   --    config = function()
   --       require("telescope").setup {
   --          extensions = {
   --             media_files = {
   --                filetypes = { "png", "webp", "jpg", "jpeg" },
   --             },
   --             -- fd is needed
   --          },
   --       }
   --       require("telescope").load_extension "media_files"
   --    end,
   -- },
   --
   -- {
   --    "Pocco81/TrueZen.nvim",
   --    cmd = {
   --       "TZAtaraxis",
   --       "TZMinimalist",
   --       "TZFocus",
   --    },
   --    config = function()
   --       require "custom.plugins.truezen"
   --    end,
   -- }, 
}
