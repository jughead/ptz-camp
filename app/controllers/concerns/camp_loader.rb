module CampLoader
  extend ActiveSupport::Concern

  class_methods do
    def load_camp
      load_resource id_param: :slug, find_by: :slug
    end

    def load_camp_parent
      load_resource :camp, id_param: :camp_slug, find_by: :slug
    end
  end
end
