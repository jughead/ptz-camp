module Camps
  class GenerateParticipantsCsvCommand
    def initialize(camp)
      @camp = camp
    end

    def execute
      tempfile = Tempfile.new
      CSV.open(tempfile.path, 'w') do |csv|
        csv << ['Team', 'Participant email']
        data.each do |team|
          csv << [team[:name], team[:participant_emails]]
        end
      end
      tempfile
    rescue StandardError => e
      tempfile.unlink
      raise e
    end

    private

    def data
      query.map do |team|
        {
          name: [team.delegation&.name, team.name].compact.join(': '),
          participant_emails: team.participants.map { |participant| participant&.user&.email }.compact.join(', '),
        }
      end
    end

    def query
      @camp.teams.order(:id).includes(:delegation, participants: :user)
    end
  end
end
