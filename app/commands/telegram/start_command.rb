module Telegram
  class StartCommand < BaseCommand
    def execute
      reply_text "Hello #{message.from.first_name}"
      
      tmpUser = TelegramUser.create(
      	:telegram_chat_id => message.chat.id,
      	:telegram_user_id => message.from.id,
    		:first_name => message.from.first_name,
    		:last_name => message.from.last_name,
    		:username => message.from.username
    	)
    end
  end
end
