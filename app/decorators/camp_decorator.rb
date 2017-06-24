class CampDecorator < ApplicationDecorator
  def to_param
    slug
  end
end
