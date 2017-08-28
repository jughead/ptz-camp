class SendMessageNotificationsJob < ApplicationJob
  queue_as :default
  FORBIDDEN = 403.freeze

  def perform(message)
    return if message.sent?
    @amount = 0
    message.notifications.not_sent.find_each do |notification|
      begin
        notification.notify
        @amount += 1
      rescue Telegram::Bot::Exceptions::ResponseError => e
        raise e unless e.error_code.to_i == FORBIDDEN
      end
    end
  ensure
    message.add_sent_amount(@amount) if @amount
  end
end
