module Admin
  class TeamDecorator < ::TeamDecorator
    decorates 'Team'
    decorates_association :participants, with: Admin::ParticipantDecorator

    def tshirts
      participants.map(&:tshirt).join(', ')
    end
  end
end
