return {
  {
    dir = "/home/chaz/Projects/home/themes_nvim/aqua.nvim",
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
