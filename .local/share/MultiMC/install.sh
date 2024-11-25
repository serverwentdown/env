#!/bin/sh

set -euo pipefail

echo "Installing MultiMC"

INSTALL_LOCATION="$HOME/.local/share/MultiMC"
DOWNLOAD_URL="https://files.multimc.org/downloads/mmc-develop-lin64.tar.gz"

# Paths
mkdir -p "$INSTALL_LOCATION"

# Package
wget --output-document /tmp/multimc.tar.gz "$DOWNLOAD_URL"
tar --verbose --extract --strip-components 1 --file /tmp/multimc.tar.gz --directory "$INSTALL_LOCATION"

# Desktop Entry
cat > $HOME/.local/share/applications/MultiMC.desktop <<EOF
[Desktop Entry]
Type=Application
Name=MultiMC
Categories=Game;
Exec=$INSTALL_LOCATION/MultiMC -d $INSTALL_LOCATION
StartupNotify=true
Terminal=false
Path=$INSTALL_LOCATION
Icon=$INSTALL_LOCATION/icons/shortcut-icon.png
EOF

# Cleanup
rm /tmp/multimc.tar.gz
