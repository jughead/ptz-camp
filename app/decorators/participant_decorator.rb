class ParticipantDecorator < ApplicationDecorator
  def role
    participant.has_role?(:coach) ? 'Coach' : 'Participant'
  end

  def role=(value)
    case value
    when 'Coach'
      participant.add_role(:coach)
    when 'Participant'
      participant.remove_role(:coach)
    end
  end

  def update(attributes)
    remaining = {}
    attributes.each do |attr, val|
      if respond_to?("#{attr}=")
        public_send("#{attr}=", val)
      else
        remaining[attr] = val
      end
    end
    assign_attributes(remaining)
    save
  end

  def school
    participant.delegation.name
  end

  delegate :first_name, :last_name, to: :personal
end
