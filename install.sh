#!/usr/bin/env bash

# Bash strict mode
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

# install build dependencies and cleanup apt cache
apt-get update
apt-get install --no-install-recommends --quiet curl git-core ca-certificates wget build-essential autopoint debhelper dh-autoreconf gcc libavutil-dev libavcodec-dev libavformat-dev libjpeg-dev libsqlite3-dev libexif-dev libid3tag0-dev libogg-dev libvorbis-dev libflac-dev -y
rm -rf /var/lib/apt/lists/*

# Download source and untar
cd /tmp
wget https://sourceforge.net/projects/minidlna/files/latest/download?source=files -O minidlna.tar.gz
tar -xvf minidlna*.tar.gz


# Apply patch, compile and install
# TODO: Apply patch
cd minidlna-*
git apply /tmp/*.patch
./configure && make && make install


# Cleanup
apt-get purge wget git-core build-essential ca-certificates autopoint debhelper dh-autoreconf gcc -y
apt-get autoremove -y
rm -rf /tmp/minidlna*