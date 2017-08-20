module Participants
  class WithoutTeamQuery
    def initialize(team=nil, relation=Participant.all)
      @relation = relation
      @team = team
    end

    def query
      @relation = @relation.where(free_or_in_current_team)
    end

    private

    def participants
      @participants ||= Participant.arel_table
    end

    def free
      participants[:team_id].eq nil
    end

    def free_or_in_current_team
      if @team
        free.or(participants[:team_id].eq @team.id)
      else
        free
      end
    end
  end
end
