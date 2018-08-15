module Coaches
  class CreateTeamCommand
    def initialize(camp, ability, params)
      @camp = camp
      @ability = ability
      @params = params
    end

    def execute
      @team = @camp.teams.new
      @form = TeamForm.new(@team)
      @form.assign_attributes(permited_params)
      @form.delegation = participant&.delegation
      @ability.authorize! :create, @form.team
      @form.team.save if @form.valid?
    end

    def errors
      @form.errors.present? && @form.errors || @form.team.errors
    end

    def team
      @form.team
    end

    private

    delegate :participant, to: :@ability

    def permited_params
      @params.permit(:name, :with_laptop, participant_ids: [])
    end
  end
end
