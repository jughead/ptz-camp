class TelegramUserFinder < BaseFinder
  def model
    TelegramUser
  end

  def new_model
    model.new
  end

  def from_tmessage(message)
    @message = message
    self
  end

  def find
    model.where(telegram_user_id: @message.from.id).first
  end

  def create_or_update
    assign_attributes(find) || build
  end

  def build
    assign_attributes(new_model)
  end

  def assign_attributes(object)
    return object unless object
    object.assign_attributes(
      telegram_user_id: @message.from.id,
      telegram_chat_id: @message.chat.id,
      first_name: @message.from.first_name,
      last_name: @message.from.last_name,
      username: @message.from.username,
    )
    object
  end
end
