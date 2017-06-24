module CampDecoration
  extend ActiveSupport::Concern

  class_methods do
    def decorate_current_camp
      before_action :decorate_current_camp
    end
  end
end
