module Telegram
  class StartCommand < BaseCommand
    def execute
      log_info "Got /start message"
      reply_text "Hello #{message.from.first_name}"
    end
  end
end
