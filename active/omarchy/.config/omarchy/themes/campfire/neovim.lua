return {
  {
    dir = "/home/chaz/Projects/home/themes/campfire.nvim",
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
