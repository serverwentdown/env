#!/bin/sh

# Custom Kernel
sudo dnf install fedpkg ccache
fedpkg clone -a kernel
cd kernel
sudo dnf builddep kernel.spec
git checkout origin/f30 # Didn't work...
echo CONFIG_KEYBOARD_APPLESPI=y >> kernel-local
./configs/build_configs.sh # Seems optional
make release
fedpkg local
sudo dnf install --nogpgcheck ./x86_64/kernel-*.rpm

# ZFS
sudo dnf install http://download.zfsonlinux.org/fedora/zfs-release$(rpm -E %dist).noarch.rpm
sudo dnf install kernel-devel zfs

# GNOME
dconf write /org/gnome/desktop/input-sources/xkb-options '["caps:escape"]'

# Sway
sudo dnf install sway
sudo dnf remove rxvt-unicode
sudo dnf copr enable gagbo/kitty-latest
sudo dnf install kitty

# ZSH
sudo dnf install zsh

# Yadm
sudo dnf copr enable thelocehiliosan/yadm
sudo dnf install yadm
# Password Store
sudo dnf install pass

# thefuck
sudo dnf install thefuck

# Neovim
sudo dnf install neovim

# Firefox
# Comes with Fedora Workstation, sudo dnf install firefox
# GNOME Web
flatpak install fedora org.gnome.Epiphany
# Geary
flatpak install fedora org.gnome.Geary
# Spotify 
flatpak install flathub com.spotify.Client
# Telegram
flatpak install flathub org.telegram.desktop
# Discord
flatpak install flathub com.discordapp.Discord
# Inkscape
#flatpak install flathub org.inkscape.Inkscape
# Krita
#flatpak install flathub org.kde.krita
# darktable
#flatpak install flathub org.darktable.Darktable
