class DelegationTshirtCountQuery
  def initialize(camp)
    @camp = camp
  end

  def query
    @camp.delegations.joins(:participants).
      group(:id).
      select(t[Arel.star]).
      select(tshirt_fields)
  end

  private

    def t
      @t ||= Delegation.arel_table
    end

    def tshirt_fields
      Participant.tshirts.map do |size, id|
        "SUM(CASE participants.tshirt WHEN #{id} THEN 1 ELSE 0 END) as #{size}_count"
      end
    end
end
