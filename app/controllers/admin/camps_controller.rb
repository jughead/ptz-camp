class Admin::CampsController < Admin::ApplicationController
  load_and_authorize_resource :camp
  decorate_current_camp

  def new
  end

  def create
    if @camp.save
      redirect_to action: :index, notice: 'The camp has been created successfully'
    else
      render action: :new
    end
  end

  def index
    @camps = @camps.order(created_at: :desc)
  end

  def edit
  end

  def show
  end

  def update
    if @camp.update(update_params)
      redirect_to action: :index, notice: 'The camp has been updated successfully'
    else
      render action: :edit
    end
  end

  def dashboard
    @participants = @camp.participants
  end

  private

    def update_params
      params.require(:camp).permit(:title, :slug, :telegram_intro, :front_page)
    end

    def create_params
      params.require(:camp).permit(:title, :slug, :telegram_intro, :start_date, :finish_date, :front_page)
    end
end
