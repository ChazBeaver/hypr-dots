return {
  {
    dir = "/home/chaz/Projects/home/themes/aqua.nvim",
    name = "aqua",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("aqua")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "aqua",
    },
  },
}
