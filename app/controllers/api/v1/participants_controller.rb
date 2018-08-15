module Api
  module V1
    class ParticipantsController < Api::ApplicationController
      load_resource :camp

      def unused
        @participants = Participant.accessible_by(camp_ability, :index_unused).left_joins(:team).merge(Team.where(id: nil))
        query = params[:q]
        words = query.split
        @participants.merge!(Participant.match_first_name(words).or(Participant.match_last_name(words)))
        render json: Participants::UnusedDecorator.decorate_collection(@participants)
      end

      private

      delegate :participant, to: :camp_ability
    end
  end
end
