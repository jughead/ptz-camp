# frozen_string_literal: true
class SendMessageNotificationsJob < ApplicationJob
  queue_as :default
  FORBIDDEN = 403.freeze
  BAD_REQUEST = 400.freeze
  CHAT_NOT_FOUND = 'Bad Request: chat not found'

  def perform(message)
    return if message.sent?
    @amount = 0
    message.notifications.not_sent.find_each do |notification|
      begin
        notification.notify
        @amount += 1
      rescue Telegram::Bot::Exceptions::ResponseError => e
        raise e unless allowed_error?(e)
      end
    end
  ensure
    message.add_sent_amount(@amount) if @amount
  end

  private

  def allowed_error?(error)
    code = error.error_code.to_i
    return true if code == FORBIDDEN
    return true if code == BAD_REQUEST && error.to_s.include?(CHAT_NOT_FOUND)
    false
  end
end
