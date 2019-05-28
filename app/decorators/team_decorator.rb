class TeamDecorator < ApplicationDecorator
  decorates_association :participants, with: ::ParticipantDecorator

  def full_name
    "#{object.name}: #{participants.sort_by(&:last_name).map(&:last_name).join(', ')}"
  end

  def as_json(*args)
    {
      id: id,
      full_name: full_name,
      with_laptop: with_laptop,
      with_display: with_display,
      keyboard: keyboard,
      mouse: mouse,
    }.as_json(*args)
  end

  def to_json(*args)
    as_json(*args).to_json(*args)
  end
end
