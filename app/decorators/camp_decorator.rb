class CampDecorator < ApplicationDecorator
  decorates_association :pages, scope: :menu
  decorates_association :day_schedules, scope: :ordered

  def to_param
    slug
  end
end
