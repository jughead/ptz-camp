# frozen_string_literal: true
module ModelType
  module_function

  # Helps with autoloading in development
  class LazyLocalType
    def initialize(name)
      @name = name
    end

    def new(*args)
      @name.constantize.new(*args)
    end
  end

  def autoload_local_type(name)
    unless Rails.env.production?
      LazyLocalType.new(name)
    else
      name.constantize
    end
  end

  def register(name, class_name, **args)
    object = autoload_local_type(class_name)
    ActiveModel::Type.register(name, object, **args)
    ActiveRecord::Type.register(name, object, **args)
  end
end

ModelType.register :personal_data, 'PersonalDataType'
