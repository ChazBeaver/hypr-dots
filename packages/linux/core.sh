#!/usr/bin/env bash
set -euo pipefail
# hyprdots/packages/linux/core.sh
# Hyprland/Linux environment packages. Not cross-platform apps (those live in appdots).

PACMAN_PKGS=(
  # --- Hardware / Wayland env ---
  ddcutil          # monitor brightness/contrast over DDC
  wev              # wayland event viewer
)

AUR_PKGS=(
  # --- GTK / icon themes used by apps running under Hyprland ---
  colloid-gtk-theme-git
  colloid-icon-theme-git
  candy-icons-git
  qogir-icon-theme
  tela-icon-theme
)

is_installed() {
  pacman -Q "$1" >/dev/null 2>&1
}

install_yay() {
  if command -v yay >/dev/null 2>&1; then
    return
  fi
  echo "==> Installing yay (AUR helper)"
  sudo pacman -S --needed --noconfirm git base-devel
  local tmp_dir
  tmp_dir=$(mktemp -d)
  git clone https://aur.archlinux.org/yay.git "$tmp_dir/yay"
  pushd "$tmp_dir/yay" >/dev/null
  makepkg -si --noconfirm
  popd >/dev/null
  rm -rf "$tmp_dir"
}

echo "==> Refreshing package databases"
sudo pacman -Sy --noconfirm

echo "==> Installing PACMAN packages"
for pkg in "${PACMAN_PKGS[@]}"; do
  if is_installed "$pkg"; then
    echo "  ✓ Already installed: $pkg"
  else
    echo "  + Installing: $pkg"
    sudo pacman -S --needed --noconfirm "$pkg" || echo "  ✗ Failed: $pkg"
  fi
done

echo
echo "==> Ensuring AUR helper (yay)"
install_yay

echo
echo "==> Installing AUR packages"
for pkg in "${AUR_PKGS[@]}"; do
  if is_installed "$pkg"; then
    echo "  ✓ Already installed: $pkg"
  else
    echo "  + Installing (AUR): $pkg"
    yay -S --needed --noconfirm "$pkg" || echo "  ✗ Failed: $pkg"
  fi
done

echo
echo "🎉 hyprdots Linux packages done."
