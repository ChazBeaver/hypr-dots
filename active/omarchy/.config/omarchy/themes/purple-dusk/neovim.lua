return {
  {
    dir = "/home/chaz/Projects/home/themes/purple-dusk.nvim",
    name = "purple-dusk",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("purple-dusk")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "purple-dusk",
    },
  },
}
