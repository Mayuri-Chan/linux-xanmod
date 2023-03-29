#!/bin/bash
sudo -i -u wulan17 bash << EOF
cd ~
MAKEFLAGS="-j$(nproc)" makepkg -s --noconfirm
EOF

cd /home/wulan17
if [[ ! -z $(ls linux-xanmod-*.pkg.* | cut -d "/" -f 5) ]]; then
	cp linux-xanmod-*.pkg.* share/
else
	exit 1
fi
