class Admin::CampsController < Admin::ApplicationController
  before_action :load_camp, only: %i(edit show update)
  def new
    @camp = Camp.new(title: "Petrozavodsk Programming Camp #{Date.current.year}")
  end

  def create
    @camp = Camp.new(create_camp_params)
    if @camp.save
      redirect_to action: :index, notice: 'The camp has been created successfully'
    else
      render action: :new
    end
  end

  def index
    @camps = Camp.order(created_at: :desc)
  end

  def edit
  end

  def show
  end

  def update
    if @camp.update(edit_camp_params)
      redirect_to action: :index, notice: 'The camp has been updated successfully'
    else
      render action: :edit
    end
  end

  private

    def edit_camp_params
      params.require(:camp).permit(:title, :slug, :telegram_intro)
    end

    def create_camp_params
      params.require(:camp).permit(:title, :slug, :telegram_intro, :start_date, :finish_date)
    end

    def load_camp
      @camp = Camp.find(params[:id])
    end
end
