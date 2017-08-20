class TeamDecorator < ApplicationDecorator
  def full_name
    "#{object.name}: #{participants.decorate.sort_by(&:last_name).map(&:last_name).join(', ')}"
  end
end
