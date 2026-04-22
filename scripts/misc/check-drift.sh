pacman -Qqett | sort | comm -23 - <(grep -vE '^\s*(#|$)' \
  ~/.local/share/omarchy/install/omarchy-base.packages | sort)
