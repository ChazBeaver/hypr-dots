return {
  {
    dir = "/home/chaz/Projects/home/themes/jungle-lab.nvim",
    name = "jungle-lab",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("jungle-lab")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "jungle-lab",
    },
  },
}
