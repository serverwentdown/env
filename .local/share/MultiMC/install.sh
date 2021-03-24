#!/bin/sh

set -euo pipefail

echo "Installing MultiMC"

INSTALL_LOCATION="$HOME/.local/share/MultiMC"
DOWNLOAD_URL="https://files.multimc.org/downloads/mmc-stable-lin64.tar.gz"
LOGO_URL="https://avatars2.githubusercontent.com/u/5411890"

# Paths
mkdir -p "$INSTALL_LOCATION"

# Package
wget --output-document /tmp/multimc.tar.gz "$DOWNLOAD_URL"
tar --extract --strip-components 1 --file /tmp/multimc.tar.gz --directory "$INSTALL_LOCATION"

# Logo
wget --output-document $HOME/.local/share/icons/multimc.png "$LOGO_URL"

# Desktop Entry
cat > $HOME/.local/share/applications/multimc.desktop <<EOF
[Desktop Entry]
Type=Application
Name=MultiMC
Categories=Game;
X-GNOME-FullName=MultiMC
Comment=MultiMC Minecraft Launcher
Icon=multimc
Exec=$INSTALL_LOCATION/MultiMC
EOF

# Cleanup
rm /tmp/multimc.tar.gz
