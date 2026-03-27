return {
  {
    dir = "/home/chaz/Projects/home/themes/green-sky.nvim",
    name = "green-sky",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("green-sky")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "green-sky",
    },
  },
}
