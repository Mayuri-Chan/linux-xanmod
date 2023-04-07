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

all_files = glob.glob(f'{sys.argv[1]}/share/*.zst')

async def upload():
	client.loop = asyncio.get_event_loop()
	await client.start()
	media = []
	count = len(all_files)
	i = 1
	version = None
	caption = None
	now = datetime.now().strftime('%d/%m/%Y')
	r = r"(wulan17-)([0-9]{1,}\.[0-9]\.[0-9]{1,})(-[0-9]{1,}-x86_64)"
	for file in all_files:
		search = re.search(r, file)
		if search:
			version = search.group(2)
		if i == count:
			caption = f'''
🆕 linux-xanmod-anbox v{version}
👤 By wulan17
🖥 Archlinux-based Distro
⏱ Build Date {now}

#archlinux #kernel #xanmod
			'''
		media.append(InputMediaDocument(media=file, caption=caption))
		i = i+1
	await client.send_media_group(chat_id="wulan17", media=media)

asyncio.run(upload())
