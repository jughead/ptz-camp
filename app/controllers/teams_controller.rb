class TeamsController < ApplicationController
  load_camp_parent
  load_and_authorize_resource through: :camp

  def index
    @teams = @camp.teams.accessible_by(current_ability, :index).includes(:participants).
      ordered_by_name.decorate
    decorate_current_camp
  end
end
