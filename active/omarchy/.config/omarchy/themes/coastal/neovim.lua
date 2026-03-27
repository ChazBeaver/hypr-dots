return {
  {
    dir = "/home/chaz/Projects/home/themes/coastal.nvim",
    name = "coastal",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("coastal")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "coastal",
    },
  },
}
