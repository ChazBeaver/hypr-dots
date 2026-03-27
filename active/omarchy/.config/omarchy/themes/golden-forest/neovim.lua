return {
  {
    dir = "/home/chaz/Projects/home/themes/golden-forest.nvim",
    name = "golden-forest",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("golden-forest")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "golden-forest",
    },
  },
}
