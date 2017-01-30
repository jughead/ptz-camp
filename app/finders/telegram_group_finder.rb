# frozen_string_literal: true
class TelegramGroupFinder < BaseFinder
  def model
    TelegramGroup
  end

  def new_model
    model.new
  end

  def from_tmessage(message)
    @message = message
    self
  end

  def private?
    @message.chat.type == 'private'
  end

  def public?
    !private?
  end

  def find
    if public?
      model.where(telegram_chat_id: @message.chat.id).first
    end
  end

  def create_or_update
    object = assign_attributes(find) || build
    object&.save
    object
  end

  def build
    assign_attributes(new_model)
  end

  def assign_attributes(object)
    return object unless object
    return if private?
    chat = @message.chat
    object.assign_attributes(
      telegram_chat_id: chat.id,
      title: chat.title,
    )
    object
  end
end
