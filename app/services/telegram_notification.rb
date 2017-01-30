class TelegramNotification
  def initialize(recipient, message)
    @recipient = recipient
    @message = message
  end

  def run
    TelegramBot.api.sendMessage(chat_id: @recipient.telegram_chat_id, text: @message.text)
  end
end
