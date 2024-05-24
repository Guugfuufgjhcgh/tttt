import requests
import logging
from bs4 import BeautifulSoup
from telegram import Update, ParseMode
from telegram.ext import Updater, CommandHandler, MessageHandler, Filters, CallbackContext

# توكن البوت
TOKEN = '7146827876:AAFmdap94RX3TePp_iWHvzzMpcHSPX8SQUM'
ADMIN_ID = 6024389409

# وظيفة التعامل مع أمر /start
def start(update: Update, context: CallbackContext) -> None:
    user = update.message.from_user
    username = user.username
    url = f'https://t.me/{username}'
    req = requests.get(url).text
    soup = BeautifulSoup(req, 'html.parser')
    photo = soup.find('meta', property="og:image")['content']
    bio = soup.find('meta', property="og:description")['content']

    user_id = user.id
    first_name = user.first_name
    lang = user.language_code

    caption = (
        f'<b>▪ Nick: @{username}\n'
        f'▪ ID: {user_id}\n'
        f'▪ First: {first_name}\n'
        f'▪️ Bio: {bio}\n'
        f'▪️ Lang: {lang}\n'
        f'▪ Deve: @ttxxxn</b>'
    )
    context.bot.send_photo(chat_id=update.effective_chat.id, photo=photo, caption=caption, parse_mode=ParseMode.HTML)

# الرد على الرسائل
def all_messages(update: Update, context: CallbackContext) -> None:
    name = update.message.from_user.first_name
    update.message.reply_text(f'What, {name}')

# تعريف الأوامر
def roy(update: Update, context: CallbackContext) -> None:
    if update.effective_user.id == ADMIN_ID:
        hearts = "❤️🧡💛💚💙💜❤️🧡💛💚💙💜❤️🧡💛💚💙💜❤️🧡💛💚💙💜"
        update.message.reply_text(hearts)
    else:
        update.message.reply_text('عذراً، هذا الأمر مخصص للأدمين فقط.')

def tok_roy(update: Update, context: CallbackContext) -> None:
    if update.effective_user.id == ADMIN_ID:
        info = """
        ╔══════════════╗
        ║ الاسم: الاصطورة TIK tok roy
        ║ العمر: انت الك
        ║ الشهرة: هكر لاتعبس معة 💀
        ║ الوظيفة: مطور بلغة بائثون 🐍
        ╚══════════════╝
        """
        update.message.reply_text(info)
    else:
        update.message.reply_text('عذراً، هذا الأمر مخصص للأدمين فقط.')

def leave(update: Update, context: CallbackContext) -> None:
    if update.effective_user.id == ADMIN_ID:
        update.message.reply_text('غادرت لك قائدي roy.')
        context.bot.leave_chat(update.effective_chat.id)
    else:
        update.message.reply_text('عذراً، هذا الأمر مخصص للأدمين فقط.')

def bn(update: Update, context: CallbackContext) -> None:
    if update.effective_user.id == ADMIN_ID:
        message = (
            "🚨⚠️ اختراق جاري ⚠️🚨\n"
            "💀💀💀💀💀💀💀💀💀💀\n"
            "تم اختراقك 💀💀💀"
        )
        update.message.reply_text(message)
    else:
        update.message.reply_text('عذراً، هذا الأمر مخصص للأدمين فقط.')

def source_time(update: Update, context: CallbackContext) -> None:
    if update.effective_user.id == ADMIN_ID:
        source_code = """
        from telethon import TelegramClient
        from telethon.tl.functions.account import UpdateProfileRequest
        from datetime import datetime
        import asyncio

        api_id = ''
        api_hash = ''
        phone_number = ''

        async def update_profile(client):
            while True:
                try:
                    # الحصول على الوقت الحالي
                    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

                    # تغيير اسم الحساب
                    await client(UpdateProfileRequest(
                        first_name=f' {current_time}',
                        last_name=''
                    ))
                    print("Profile name updated")

                    # تغيير البايو
                    await client(UpdateProfileRequest(
                        about=f' {current_time}'
                    ))
                    print("Profile bio updated")

                except Exception as e:
                    print(f"An error occurred: {e}")

                await asyncio.sleep(1)

        async def main():
            async with TelegramClient('session_name', api_id, api_hash) as client:
                print("Client Created and Logged in")
                await update_profile(client)

        asyncio.run(main())
        """
        update.message.reply_text("إليك يا سيدي سورس الوقت:")
        update.message.reply_text(source_code)
    else:
        update.message.reply_text('عذراً، هذا الأمر مخصص للأدمين فقط.')

def hack(update: Update, context: CallbackContext) -> None:
    if update.effective_user.id == ADMIN_ID:
        target_user = update.message.reply_to_message.from_user.username if update.message.reply_to_message else "unknown"
        message = f"💀 جاري اختراق {target_user} 💀\nتم الاختراق بنجاح!"
        update.message.reply_text(message)
    else:
        update.message.reply_text('عذراً، هذا الأمر مخصص للأدمين فقط.')

def main() -> None:
    # إعداد البوت
    updater = Updater(TOKEN, use_context=True)

    # احصل على مخصص المحدثات
    dispatcher = updater.dispatcher

    # تعريف الأوامر
    dispatcher.add_handler(CommandHandler("start", start))
    dispatcher.add_handler(CommandHandler("roy", roy))
    dispatcher.add_handler(CommandHandler("tok_roy", tok_roy))
    dispatcher.add_handler(CommandHandler("leave", leave))
    dispatcher.add_handler(CommandHandler("bn", bn))
    dispatcher.add_handler(CommandHandler("source_time", source_time))
    dispatcher.add_handler(CommandHandler("hack", hack))

    # الرد على جميع الرسائل
    dispatcher.add_handler(MessageHandler(Filters.text & ~Filters.command, all_messages))

    # ابدأ البوت
    updater.start_polling()

    # حافظ على البوت قيد التشغيل
    updater.idle()

if __name__ == '__main__':
    main()

