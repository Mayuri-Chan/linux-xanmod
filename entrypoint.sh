#!/bin/bash
echo "Major: $major_version"
echo "Pkg: $pkg_version"
sudo -i -u wulan17 bash << EOF
export major_version="$major_version"
export pkg_version="$pkg_version"
cd ~
git config --global user.name wulan17
git config --global user.email "wulan17@wulan17.my.id"
mkdir src
echo "Cloning sources..."
git clone https://github.com/xanmod/linux -b "$major_version" --single-branch src/linux-"$major_version" > /dev/null 2>&1
cd src/linux-"$major_version"
git fetch https://github.com/Mayuri-Chan/linux-xanmod 6.4
git cherry-pick c8ed02a622e1fdaea0ba2f558c2868deda84cab2 80db63aa1ae5e564554aa9f91ce86970b8bfcd8b ba922dacf72ff41f8f621f85dd99174f6cfdb783
cd ../..
MAKEFLAGS="-j$(nproc)" makepkg -s --noconfirm
EOF

cd /home/wulan17
if [[ ! -z $(ls linux-xanmod-*.pkg.* | cut -d "/" -f 5) ]]; then
	cp linux-xanmod-*.pkg.* share/
else
	exit 1
fi
