class PagesController < ApplicationController
  load_camp_parent
  load_resource id_param: :slug, find_by: :slug, through: :camp, shallow: true
  decorate_current_camp
  authorize_resource

  layout 'pages'

  def show
  end
end
