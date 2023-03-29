#!/bin/bash
export TELEBOT
export TELECH
export TELEID
export TELEHASH

apt install -y python3.10 python3-pip
python3 -m pip install pyrofork==2.1.4 tgcrypto
for file in $(find "$(pwd)/share" -name '*.zst')
do
  python3 upload.py "$file"
done
