class SiteController < ApplicationController
  def home
    @camp = CampFinder.new.current.find&.decorate
    redirect_to @camp if @camp
  end
end
