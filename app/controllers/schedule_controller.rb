class ScheduleController < ApplicationController
  load_camp
  decorate_current_camp
  before_action :load_day_schedules

  def show
  end

  private

    def load_day_schedules
      @day_schedules = @camp.day_schedules.map(&:decorate)
    end

end
