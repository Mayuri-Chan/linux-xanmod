#!/bin/python
import asyncio
import os
import sys

from pyrogram import Client

BOT_SESSION = os.environ.get('TELEBOT', None)

client = Client(
	"kotori",
	session_string=BOT_SESSION,
	sleep_threshold=180
)

async def upload():
	client.loop = asyncio.get_event_loop()
	await client.start()
	await client.send_document(chat_id="@tsuki172", document=sys.argv[1])

asyncio.run(upload())
