---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- Catppuccin colorscheme
  { import = "astrocommunity.colorscheme.catppuccin" },
  
  -- Tabby
  {
    "TabbyML/vim-tabby",
    lazy = false,
    dependencies = {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        options = {
          g = {
            tabby_keybinding_accept = "<C-l>",
            tabby_keybinding_trigger_or_dismiss = "<C-\\>",
          },
        },
      },
    },
  },

  -- Override splash
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⡀⠀⠀⠀⠀⡶⠖⣶⠤⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⢀⣠⡴⠚⡉⠡⢈⠙⢦⣴⠞⠛⠳⣦⡘⠛⢩⣿⣦⠀⠀⠀⠀⠀⠀⢀⣀⣀⠀⠀⠀⠀⢀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠛⠷⢤⣴⣀⣁⣂⣬⣼⣇⣤⡌⠐⢈⠻⡦⠘⠛⡛⣧⠀⠀⠀⠀⣰⠏⠀⠙⣧⣀⣀⣴⠋⠈⠙⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⡀⠀⣶⠶⠻⢧⡀⢹⣻⡟⣿⠃⣾⣧⠁⣰⣄⠙⣿⣛⠀⣀⣀⣰⠇⠀⠀⠀⠸⢻⠻⠃⠀⠀⠀⢘⣆⣀⡀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⢀⣴⣾⡝⠛⠛⣀⣴⣾⠧⢼⣯⣧⣿⡷⠇⣻⣀⣯⢹⡀⢄⡿⠀⣉⣽⢿⠃⠠⡾⠆⢠⣷⠄⠰⡷⠀⠘⣿⡽⣧⣀⠀⠀⠀⠀⠀⠀⠀",
        "⢀⡤⠶⠖⠋⣐⣴⠟⠁⡀⠄⡂⠈⣿⣿⠶⠶⢦⣍⠉⠈⠙⠛⠁⠀⢠⠏⠀⠀⢀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠘⣇⠀⠀⠀⠀⠀⠀⠀",
        "⡾⠷⢶⡌⠐⠈⡁⢄⣂⡰⢸⡿⣦⣿⣿⢀⠐⡀⠌⣧⠀⠀⠀⠀⢀⣾⣰⠖⠛⠉⠉⠈⢻⡿⣽⠷⣦⡀⠀⠀⠀⢰⣿⡆⠀⠀⠀⠀⠀⠀",
        "⢴⠛⠉⢰⡟⣧⠀⣸⡟⣇⢈⣷⢹⣿⣿⢦⣔⡀⢂⣿⠀⠀⠀⡴⢋⣿⣿⡆⠀⠀⠀⠀⠀⢷⣾⣿⠋⠁⠀⠀⠀⠀⠙⣻⡄⠀⠀⠀⠀⠀",
        "⠸⢦⣥⡾⠁⠿⣤⠼⠇⠛⠋⠀⠀⣿⣿⠀⠈⠉⠉⠁⠀⠀⠘⢷⡟⠮⣝⣇⠀⠀⠀⠀⢀⣀⡿⠁⠀⠀⠀⠀⠀⠀⠸⣿⣧⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⢸⡏⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⣻⠀⠀⠀⢸⠇⠀⠀⠻⠤⠶⠖⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⢹⡀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣹⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡇⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠈⠓⣶⠶⠶⠶⠶⠶⠶⠶⠶⣶⠛⠀⠀⠀⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢘⡇⠀⣴⣿⣦",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⠀⠀⠀⠀⠀⠀⠀⢠⡇⠀⠀⠀⠀⠈⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣤⣾⣅⣩⠏",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⣸⠁⠀⠀⠀⠀⢠⡞⠳⡦⠀⠀⠀⠀⠀⠀⠀⣠⠦⣤⡀⠀⠀⠀⠀⠀⢠⣿⣇⣼⠿⠋⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠓⠒⠒⠖⠲⠒⠒⠛⠀⠀⠀⠀⠀⠀⠙⠓⠒⠒⠒⠒⠒⠦⠶⠴⠿⠶⠶⠴⠖⠒⠒⠒⠚⠛⠉⠁⠀⠀⠀⠀",
      }
      return opts
    end,
  },

  -- Bracket Rainbow
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
}
