class Admin::ScheduleDaysController < Admin::ApplicationController
  before_action :set_schedule_day, only: [:show, :edit, :update, :destroy]

  # Temporarily added some methods

  def index
    @schedule_days = ScheduleDay.all
  end

  def show
  end

  def new
    @schedule_day = ScheduleDay.new
  end

  def edit
  end

  def create
    @schedule_day = ScheduleDay.new(schedule_day_params)

    if @schedule_day.save
      redirect_to action: :index, notice: 'Schedule day was successfully created.'
    else
      render :new
    end
  end

  def update
    if @schedule_day.update(schedule_day_params)
        redirect_to action: :index, notice: 'Schedule day was successfully updated.'
    else
        render :edit
    end
  end

  def destroy
    @schedule_day.destroy
    redirect_to action: :index, notice: 'Schedule day was successfully destroyed.'
  end

  private
    def set_schedule_day
      @schedule_day = ScheduleDay.find(params[:id])
    end

    def schedule_day_params
      params.require(:schedule_day).permit(:camp_id, :date, :content)
    end
end
