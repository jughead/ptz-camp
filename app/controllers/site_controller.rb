class SiteController < ApplicationController
  def home
    @camp = Camp.last
    redirect_to @camp.path if @camp
  end
end
