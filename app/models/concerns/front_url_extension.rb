module FrontUrlExtension
  extend ActiveSupport::Concern

  included do
    delegate :url, :path, to: :url_builder
  end

  class_methods do
    def url_builder_class
      @url_builder_class ||= "#{name}Url".constantize
    end
  end

  private

    def url_builder
      url_builder_class.new(self)
    end

    def url_builder_class
      self.class.url_builder_class
    end
end
