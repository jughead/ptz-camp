class Admin::ParticipantsController < Admin::ApplicationController
  load_resource :camp
  load_resource :delegation, through: :camp
  load_and_authorize_resource through: :delegation
  decorate_current_camp

  def index
  end

  def edit
  end

  def show
  end

  def update
    if @participant.update(update_params)
      redirect_to action: :index, notice: 'The participant is updated'
    else
      render :new
    end
  end

  private

    def create_params
      params.require(:participant).permit(:arrival, :departure, :preferences)
    end
end
