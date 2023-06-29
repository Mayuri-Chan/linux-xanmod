#!/bin/python
import asyncio
import glob
import os
import re
import sys

from datetime import datetime
from pyrogram import Client
from pyrogram.types import InputMediaDocument

BOT_SESSION = os.environ.get('TELEBOT', None)

client = Client(
	"kotori",
	session_string=BOT_SESSION,
	sleep_threshold=180
)

all_files = glob.glob(f'{sys.argv[1]}/share/*')

async def upload():
	client.loop = asyncio.get_event_loop()
	await client.start()
	media = []
	count = len(all_files)
	i = 1
	version = None
	caption = None
	now = datetime.now().strftime('%d/%m/%Y')
	for file in all_files:
		if i == count:
			caption = f'''
🆕 linux-xanmod for WSL2 v{os.environ.get("pkg_version", None)}
👤 By wulan17
🖥 Archlinux-based WSL2
⏱ Build Date {now}

#archlinux #kernel #xanmod #WSL #WSL2
			'''
		media.append(InputMediaDocument(media=file, caption=caption))
		i = i+1
	await client.send_media_group(chat_id="wulan17", media=media)

asyncio.run(upload())
