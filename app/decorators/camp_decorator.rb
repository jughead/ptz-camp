class CampDecorator < ApplicationDecorator
  decorates_association :pages, scope: :menu

  def to_param
    slug
  end
end
