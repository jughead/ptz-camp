module CampLoader
  extend ActiveSupport::Concern

  private

    def load_camp
      @camp = CampFinder.new.find_by_slug!(params[:slug])
    end
end
