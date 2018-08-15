module Api
  module V1
    class TeamsController < Api::ApplicationController
      load_resource :camp
      load_and_authorize_resource :team, through: :camp, only: :index

      def index
        render json: @teams.decorate.as_json
      end

      def my
        @teams = Team.accessible_by(camp_ability, :index_my)
        render json: @teams.decorate.as_json
      end

      def create
        @command = Coaches::CreateTeamCommand.new(@camp, camp_ability, params)
        if @command.execute
          render json: @command.team.decorate
        else
          render_model_errors(@command)
        end
      end

      def destroy
        @team = @camp.teams.find_by(id: params[:id])
        camp_ability.authorize! :destroy, @team
        if @team.destroy
          render json: {}, status: 200
        else
          render_model_errors(@team)
        end
      end

      private

      delegate :participant, to: :camp_ability
    end
  end
end
