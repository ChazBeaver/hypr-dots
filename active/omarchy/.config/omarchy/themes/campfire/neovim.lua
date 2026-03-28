return {
  {
    dir = "/home/chaz/Projects/home/themes_nvim/campfire.nvim",
    name = "campfire",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("campfire")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "campfire",
    },
  },
}
