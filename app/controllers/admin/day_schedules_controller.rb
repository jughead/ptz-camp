class Admin::DaySchedulesController < Admin::ApplicationController
  def edit
    @day_schedule = DaySchedule.find(params[:id])
  end

  def update
    @day_schedule = DaySchedule.find(params[:id])
    if @day_schedule.update(day_schedule_params)
      redirect_to edit_admin_camp_path(@day_schedule.camp), notice: "The day schedule has been updated succesfully"
    else
      render action: :edit
    end
  end

  private

    def day_schedule_params
      params.require(:day_schedule).permit(:content)
    end
end
