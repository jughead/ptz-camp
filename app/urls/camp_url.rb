class CampUrl < ApplicationUrl
  def camp
    object
  end

  def parameters
    [{slug: camp.slug}]
  end
end
