module Admin
  class CampDecorator < ::CampDecorator
    decorates 'Camp'
    decorates_association :day_schedules, with: Admin::DayScheduleDecorator

    def delegations_path
      h.admin_camp_delegations_path(object)
    end

    def day_schedules_path
      h.admin_camp_day_schedules_path(object)
    end

    def to_param
      id.to_s
    end
  end
end
