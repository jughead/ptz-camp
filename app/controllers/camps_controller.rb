class CampsController < ApplicationController
  include CampLoader
  before_action :load_camp

  def show
  end
end
