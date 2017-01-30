class Messages::CreateNotificationsCommand
  def initialize(message)
    @message = message
  end

  def execute
    TelegramUser.find_each do |telegram_user|
      Notification.where(recipient: telegram_user, message: @message).
        first_or_create!
    end

    TelegramGroup.find_each do |telegram_group|
      Notification.where(recipient: telegram_group, message: @message).
        first_or_create!
    end
  end
end
