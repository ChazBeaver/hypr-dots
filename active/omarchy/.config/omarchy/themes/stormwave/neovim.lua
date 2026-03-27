return {
  {
    dir = "/home/chaz/Projects/home/themes/stormwave.nvim",
    name = "stormwave",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("stormwave")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "stormwave",
    },
  },
}
