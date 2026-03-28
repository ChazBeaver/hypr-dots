return {
  {
    dir = "/home/chaz/Projects/home/themes_nvim/jellyfish.nvim",
    name = "jellyfish",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("jellyfish")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "jellyfish",
    },
  },
}
