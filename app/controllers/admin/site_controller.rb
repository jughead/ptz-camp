class Admin::SiteController < Admin::ApplicationController
  load_current_camp
  decorate_current_camp

  def home
    authorize! :get, :home
  end
end
