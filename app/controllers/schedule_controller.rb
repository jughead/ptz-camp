class ScheduleController < ApplicationController
  include CampLoader
  before_action :load_camp
  before_action :load_day_schedules

  def show
  end

  private

    def load_day_schedules
      @day_schedules = @camp.day_schedules.decorate
    end

end
