return {
  {
    dir = "/home/chaz/Projects/home/themes/terracotta.nvim",
    name = "terracotta",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("terracotta")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "terracotta",
    },
  },
}
