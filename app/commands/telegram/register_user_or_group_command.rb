module Telegram
  class RegisterUserOrGroupCommand
    def initialize(tmessage)
      @tmessage = tmessage
    end

    def execute
      TelegramUserFinder.new.from_tmessage(@tmessage).create_or_update ||
        TelegramGroupFinder.new.from_tmessage(@tmessage).create_or_update
    end
  end
end
