class TeamDecorator < ApplicationDecorator
  def full_name
    "#{object.name}: #{participants.decorate.sort_by(&:last_name).map(&:last_name).join(', ')}"
  end

  def as_json(*args)
    {id: id, full_name: full_name, with_laptop: with_laptop}.as_json(*args)
  end

  def to_json(*args)
    as_json(*args).to_json(*args)
  end
end
