module Telegram
  class StartCommand < BaseCommand
    def execute
      log_info "Got /start message"
      reply_text "Hello #{message.from.first_name}"

      log_info "Add new TelegramUser"
      
      tmpUser = TelegramUser.new(:telegram_chat_id => message.chat.id, :first_name => message.from.first_name, :last_name => message.from.last_name, :username => message.from.username)
      tmpUser.save
    end
  end
end
