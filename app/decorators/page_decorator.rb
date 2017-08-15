class PageDecorator < ApplicationDecorator
  def to_param
    slug
  end

  def front_path
    if object.camp_id
      '/' + object.camp.slug
    else
      ''
    end + '/' + object.slug
  end
end
