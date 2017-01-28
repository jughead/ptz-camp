class TelegramNotification
  def initialize(telegram_user, message)
    @telegram_user = telegram_user
    @message = message
  end

  def run
    TelegramBot.api.sendMessage(chat_id: @telegram_user.telegram_chat_id, text: @message.text)
  end
end
