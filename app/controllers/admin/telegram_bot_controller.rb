class Admin::TelegramBotController < Admin::ApplicationController
  def register
    TelegramBot.register
    redirect_to :back
  end
end
