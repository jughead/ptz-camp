class ParticipantUrl < ApplicationUrl
  def camp
    object.camp
  end

  def parameters
    [{slug: camp.slug}]
  end
end
