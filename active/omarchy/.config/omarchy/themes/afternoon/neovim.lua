return {
  {
    dir = "/home/chaz/Projects/home/themes_nvim/afternoon.nvim",
    name = "afternoon",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("afternoon")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "afternoon",
    },
  },
}
