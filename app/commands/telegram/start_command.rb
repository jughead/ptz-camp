module Telegram
  class StartCommand < BaseCommand
    def execute
      reply_text "Hello #{message.from.first_name}"
      TelegramUserFinder.new.from_tmessage(message).create_or_update
    end
  end
end
