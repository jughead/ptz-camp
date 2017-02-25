class Admin::CampsController < Admin::ApplicationController
  def new
    @camp = Camp.new(title: "Petrozavodsk Programming Camp #{Date.current.year}")
  end

  def create
    @camp = Camp.new(camp_params)
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
    @camp = Camp.find(params[:id])
  end

  def update
    @camp = Camp.find(params[:id])
    if @camp.update(camp_params)
      redirect_to action: :index, notice: 'The camp has been updated successfully'
    else
      render action: :edit
    end
  end

  private

    def camp_params
      params.require(:camp).permit(:title, :slug, :telegram_intro)
    end
end
