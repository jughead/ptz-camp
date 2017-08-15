module Admin
  class PageDecorator < ::PageDecorator
    decorates 'Page'
    decorates_association :camp, with: Admin::CampDecorator

    def to_param
      id.to_s
    end
  end
end
