---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    local null_ls = require "null-ls"

    config.sources = {
      -- Python
      null_ls.builtins.formatting.black,

      -- Django
      null_ls.builtins.formatting.djlint.with({
        args = {
          "$FILENAME",
          "--preserve-blank-lines",
          "--reformat",
          "-"
        },
      }),
    }
    return config
  end,
}
