class Admin::DaySchedulesController < Admin::ApplicationController
  before_action :load_day_schedule
  before_action :load_camp

  def edit
  end

  def update
    if @day_schedule.update(day_schedule_params)
      redirect_to admin_camp_path(@camp), notice: "The day schedule has been updated succesfully"
    else
      render action: :edit
    end
  end

  private

    def day_schedule_params
      params.require(:day_schedule).permit(:content)
    end

    def load_camp
      @camp = @day_schedule.camp
    end

    def load_day_schedule
      @day_schedule = DaySchedule.find(params[:id])
    end
end
