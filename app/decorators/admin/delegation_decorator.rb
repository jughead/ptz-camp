module Admin
  class DelegationDecorator < ApplicationDecorator
    decorates 'Delegation'

    def update_path
      if persisted?
        h.admin_camp_delegation_path(camp, object)
      else
        h.admin_camp_delegations_path(camp)
      end
    end

  end
end
