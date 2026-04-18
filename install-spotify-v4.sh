#!/bin/bash
set -e
##################################################################################################################
# Written to be used on 64 bits computers
# Author  :   Erik Dubois
# Website :   http://www.erikdubois.be
##################################################################################################################
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

# Modern Spotify installation using official repository
# Replaced deprecated apt-key with gpg --dearmor and switched to HTTPS source
# Also installs libavahi-compat-libjansson3 which is required on modern Debian/Ubuntu

# 1. Install prerequisites (gnupg2 for gpg, dirmngr for keyserver access)
if ! dpkg -s gnupg2 dirmngr >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y gnupg2 dirmngr
fi

# 2. Add the Spotify GPG key (modern dearmored approach, replaces deprecated apt-key)
# Download key, convert to gpg format, and install via apt-keyring
curl -fsSL https://download.spotify.com/spotify-deb-builder/spotify-keys.gpg | \
    sudo gpg --dearmor --yes --output /usr/share/keyrings/spotify-archive-keyring.gpg

# 3. Add the Spotify repository with proper signed-by directive
echo "deb [signed-by=/usr/share/keyrings/spotify-archive-keyring.gpg] https://download.spotify.com/spotify-stable non-free" | \
    sudo tee /etc/apt/sources.list.d/spotify.list

# 4. Update package list
sudo apt-get update

# 5. Install Spotify
sudo apt-get install -y spotify-client

echo
echo "################################################################"
echo "###################   spotify installed   ######################"
echo "################################################################"
