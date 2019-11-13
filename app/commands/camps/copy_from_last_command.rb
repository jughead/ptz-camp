module Camps
  class CopyFromLastCommand
    def initialize(to)
      @to = to
      @from = Camp.where.not(id: to.id).order(created_at: :desc).take
    end

    def execute
      return unless @from

      @from.delegations.each do |delegation|
        new_delegation = @to.delegations.find_or_initialize_by(name: delegation.name)
        new_delegation.max_teams = delegation.max_teams
        new_delegation.save!
      end
    end
  end
end
