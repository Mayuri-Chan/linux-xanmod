#!/bin/bash
export major_version=6.5
wget -O temp_makefile https://raw.githubusercontent.com/xanmod/linux/"$major_version"/Makefile
eval $(grep -o "^\(VERSION\|PATCHLEVEL\|SUBLEVEL\) = [0-9a-zA-Z_-]\+" temp_makefile | tr -d \ )
export pkg_version="$VERSION.$PATCHLEVEL.$SUBLEVEL"
echo "pkg: $pkg_version"
if [ "$pkg_version" != "$last_version" ]; then
    docker build . -t xanmod
    mkdir share
    docker run --name xanmod -v $(pwd)/share:/home/wulan17/share -e major_version="$major_version" -e pkg_version="$pkg_version" -t xanmod
    export TELEBOT
    apt install -y python3.10 python3-pip
    python3 -m pip install pyrofork==2.1.4 tgcrypto
    python3 upload.py "$(pwd)"
else
    echo "Package up-to-date. skipping..."
    exit 0
fi
