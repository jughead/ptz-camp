class Admin::DaySchedulesController < Admin::ApplicationController
  load_resource :camp
  load_and_authorize_resource through: :camp
  decorate_current_camp

  def index
  end

  def edit
    decorate
  end

  def update
    if @day_schedule.update(update_params)
      redirect_to admin_camp_path(@camp), notice: "The day schedule has been updated succesfully"
    else
      decorate
      render action: :edit
    end
  end

  private

    def update_params
      params.require(:day_schedule).permit(:content)
    end

    def decorator_class
      Admin::DayScheduleDecorator
    end

    def decorate
      @day_schedule &&= decorator_class.decorate(@day_schedule)
      @day_schedules &&= decorator_class.decorate_collection(@day_schedules)
    end
end
