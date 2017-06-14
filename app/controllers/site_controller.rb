class SiteController < ApplicationController
  def home
    @camp = CampFinder.new.current.find&.decorate
    redirect_to @camp.path if @camp
  end
end
