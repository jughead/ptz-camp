class SendMessageNotificationsJob < ApplicationJob
  queue_as :default

  def perform(message)
    return if message.sent?
    amount = 0
    message.notifications.not_sent.find_each do |notification|
      notification.notify
      amount += 1
    end
  ensure
    message.add_sent_amount(amount)
  end
end
