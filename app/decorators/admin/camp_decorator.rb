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
      "#{title},<br/>".html_safe + date_range
    end

    def date_range
      "#{I18n.l start_date, format: '%B, %d'} &mdash; #{I18n.l finish_date, format: '%B, %d'}".html_safe
    end

    def participants_without_teams(team)
      ParticipantDecorator.decorate_collection(object.participants.
        without_team(team).ordered_by_name.includes(:delegation)
      ).map do |participant|
        [participant.name_with_delegation, participant.id]
      end
    end
  end
end
