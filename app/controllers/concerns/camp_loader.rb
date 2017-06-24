module CampLoader
  extend ActiveSupport::Concern

  class_methods do
    def load_camp
      before_action :load_camp
    end
  end

  private

    def load_camp
      @camp = CampFinder.new.find_by_slug!(params[:slug] || params[:camp_slug])
    end
end
