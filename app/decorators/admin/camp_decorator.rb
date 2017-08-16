module Admin
  class CampDecorator < ::CampDecorator
    decorates 'Camp'
    decorates_association :day_schedules, with: Admin::DayScheduleDecorator
    decorates_association :participants, with: ParticipantDecorator

    def delegations_path
      h.admin_camp_delegations_path(object)
    end

    def day_schedules_path
      h.admin_camp_day_schedules_path(object)
    end

    def to_param
      id.to_s
    end

    def badge_info
      "#{title},<br/>".html_safe + shortened_date_range
    end

    def shortened_date_range
      "#{I18n.l start_date, format: '%B, %d'} &mdash; #{I18n.l finish_date, format: '%B, %d'}".html_safe
    end
  end
end
