class Admin::MessagesController < Admin::ApplicationController
  load_and_authorize_resource through: :current_user
  load_current_camp

  def index
    @messages = @messages.order(created_at: :desc)
  end

  def new
  end

  def create
    @message.assign_attributes(create_params)
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
