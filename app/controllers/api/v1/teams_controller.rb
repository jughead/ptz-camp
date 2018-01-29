module Api
  module V1
    class TeamsController < Api::ApplicationController
      load_resource :camp
      load_and_authorize_resource :team, through: :camp, collection: [:my]

      def index
        render json: [
          {id: 1, full_name: 'Petrozavodsk SU: Fedulin'}
        ].to_json
        # render json: @teams.decorate
      end

      def my
        @teams = @teams.where(delegation: participant.delegation)
      end

      private

      delegate :participant, :camp_ability
    end
  end
end
