class Messages::CreateNotificationsCommand
  def initialize(message)
    @message = message
  end

  def execute
    TelegramUser.find_each do |telegram_user|
      Notification.where(telegram_user: telegram_user, message: @message).
        first_or_create!
    end
  end
end
