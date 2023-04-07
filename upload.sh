#!/bin/bash
export TELEBOT

apt install -y python3.10 python3-pip
python3 -m pip install pyrofork==2.1.4 tgcrypto
python3 upload.py "$(pwd)"
