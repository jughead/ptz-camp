module Admin
  class TeamDecorator < ::TeamDecorator
    decorates 'Team'
    decorates_association :participants, with: Admin::ParticipantDecorator
  end
end
