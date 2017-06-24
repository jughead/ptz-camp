module Admin
  class DayScheduleDecorator < ::DayScheduleDecorator
    decorates 'DaySchedule'
    def edit_path
      h.edit_admin_camp_day_schedule_path(camp, self)
    end
  end
end
