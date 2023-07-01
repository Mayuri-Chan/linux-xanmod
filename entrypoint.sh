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
git clone https://github.com/xanmod/linux -b "$major_version" --single-branch src/linux-"$major_version" --depth=1 > /dev/null 2>&1
cd src/linux-"$major_version"
wget https://raw.githubusercontent.com/Locietta/xanmod-kernel-WSL2/main/0001-5.15.y-dxgkrnl.patch
git apply 0001-5.15.y-dxgkrnl.patch
wget https://raw.githubusercontent.com/Locietta/xanmod-kernel-WSL2/main/0002-dxgkrnl-enable-mainline-support.patch
git apply 0002-dxgkrnl-enable-mainline-support.patch
rm *.patch
rm CONFIGS/xanmod/gcc/config_x86-64-v1
wget -O CONFIGS/xanmod/gcc/config_x86-64-v1 https://raw.githubusercontent.com/Locietta/xanmod-kernel-WSL2/main/wsl2_defconfig
sed -i 's/locietta/wulan17/g' CONFIGS/xanmod/gcc/config_x86-64-v1
#cd ../..
#MAKEFLAGS="-j$(nproc)" makepkg -s --noconfirm
make CC=clang HOSTCC=clang LLVM=1 LLVM_IAS=1 -j$(nproc)
EOF

cd /home/wulan17
if [[ ! -z $(ls linux-xanmod-*.pkg.* | cut -d "/" -f 5) ]]; then
	cp src/linux-"$major_version"/arch/x86/boot/bzImage /home/wulan17/share/
	cp linux-xanmod-*.pkg.* share/
else
	exit 1
fi
