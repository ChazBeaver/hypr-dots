return {
  {
    dir = "/home/chaz/Projects/home/themes/dark-lotus.nvim",
    name = "dark-lotus",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("dark-lotus")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dark-lotus",
    },
  },
}
