class Admin::MessagesController < Admin::ApplicationController
  def index
    @messages = current_user.messages
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(create_params)
    @message.user = current_user
    if @message.save
      CreateMessageNotificationsJob.perform_later(@message)
      redirect_to action: :index, notice: 'The message is being processed'
    else
      render :new
    end
  end

  private

    def create_params
      params.require(:message).permit(:text)
    end
end
