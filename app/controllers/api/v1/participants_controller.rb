module Api
  module V1
    class ParticipantsController < Api::ApplicationController
      load_resource :camp

      def unused
        @participants = Participant.accessible_by(camp_ability, :index_unused).left_joins(:team).merge(Team.where(id: nil))
        render json: Participants::UnusedDecorator.decorate_collection(@participants)
      end

      private

      delegate :participant, to: :camp_ability
    end
  end
end
