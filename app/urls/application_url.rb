# frozen_string_literal: true
class ApplicationUrl
  attr_reader :object

  def initialize(object, context:nil)
    @object = object
    @context = context
  end

  def url
    context.public_send(url_method, *parameters)
  end

  def path
    puts path_method
    context.public_send(path_method, *parameters)
  end

  def url_method
    :"#{route}_url"
  end

  def path_method
    :"#{route}_path"
  end

  def route
    object.class.name.parameterize
  end

  private

    def context
      @context || Rails.application.routes.url_helpers
    end

end
