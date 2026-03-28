return {
  {
    dir = "/home/chaz/Projects/home/themes_nvim/soot.nvim",
    name = "soot",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("soot")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "soot",
    },
  },
}
