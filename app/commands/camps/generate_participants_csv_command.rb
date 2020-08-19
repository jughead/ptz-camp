module Camps
  class GenerateParticipantsCsvCommand
    def initialize(camp)
      @camp = camp
    end

    def execute
      tempfile = Tempfile.new
      CSV.open(tempfile.path, 'w') do |csv|
        csv << ['Delegation', 'Team', 'Participant email']
        query.each do |participant|
          csv << [participant.delegation&.name, participant.team&.name, participant.user&.email]
        end
      end
      tempfile
    rescue StandardError => e
      tempfile.unlink
      raise e
    end

    private

    def query
      @camp.participants.order(:delegation_id, :team_id).includes(:team, :delegation, :user)
    end
  end
end
