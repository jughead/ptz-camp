module Admin
  class DayScheduleDecorator < ::DayScheduleDecorator
    decorates 'DaySchedule'

    def edit_path
      h.edit_admin_camp_day_schedule_path(camp, self)
    end

    def form_path
      if persisted?
        h.admin_camp_day_schedule_path(camp, self)
      else
        h.admin_camp_day_schedules_path(camp)
      end
    end
  end
end
