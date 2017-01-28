module Telegram
  class StartCommand < BaseCommand
    def execute
      camp = CampFinder.new.current.find
      if camp
        reply_text camp.telegram_intro
      else
        reply_text "Hello #{message.from.first_name}"
      end

      TelegramUserFinder.new.from_tmessage(message).create_or_update
    end
  end
end
