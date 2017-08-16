class ParticipantDecorator < ApplicationDecorator
  include ActiveModel::AttributeAssignment
  decorates_finders

  def role
    @role ||= (roles.first&.name || :participant).to_s.capitalize
  end

  def role=(value)
    @role = nil
    roles.delete_all if persisted?
    role = value.downcase.to_sym
    add_role(role) if Participant.roles.include?(role)
  end

  def assign_attributes(attributes)
    remaining = {}
    attributes.each do |attr, val|
      if respond_to?("#{attr}=")
        public_send("#{attr}=", val)
      else
        remaining[attr] = val
      end
    end
    object.assign_attributes(remaining)
  end

  def update(attributes)
    assign_attributes(attributes)
    save
  end

  def school
    participant.delegation.name
  end

  def self.roles
    @roles ||= Participant.roles.map{|r| r.to_s.capitalize}.freeze
  end

  delegate :first_name, :last_name, to: :personal
end
