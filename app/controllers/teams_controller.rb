class TeamsController < ApplicationController
  load_camp_parent
  load_and_authorize_resource through: :camp, only: :index

  def index
    @teams = @camp.teams.accessible_by(current_ability, :index).includes(:participants).
      ordered_by_name.decorate
    decorate_current_camp
  end

  def my
    camp_ability.authorize! :index_my, Team
    @teams = Team.accessible_by(camp_ability, :index_my).decorate
    decorate_current_camp
  end
end
