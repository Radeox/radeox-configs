return {
  "AstroNvim/astrocommunity",

  -- Kanagawa colorscheme
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },
  
  -- Copilot
  { import = "astrocommunity.completion.copilot-lua" },
  { -- further customize the options set by the community
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        keymap = {
          accept = "<C-l>",
          accept_word = false,
          accept_line = false,
          next = "<C-.>",
          prev = "<C-,>",
          dismiss = "<C/>",
        },
      },
    },
  },

  -- Smartcolumns
  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      colorcolumn = 120,
      disabled_filetypes = { "help" },
    },
  },

  -- Bracket Rainbow
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },

  -- EzBookmarks
  {
    "radeox/ezbookmarks.nvim"
  },
}