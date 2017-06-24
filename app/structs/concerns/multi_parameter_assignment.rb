module MultiParameterAssignment
  extend ActiveSupport::Concern

  include MultiparameterAttributeAssignment

  def class_for_attribute(name)
    registry = self.class.multi_parameter_assignment_registry
    if registry.has_key?(name.to_sym)
      registry[name.to_sym]
    end
  end

  class_methods do
    def attribute(method, type, *args)
      klass = case type
      when :date
        Date
      when :time
        Time
      end

      register_for_multi_parameter_assignment(method, klass) if klass

      super
    end

    def multi_parameter_assignment_registry
      @multi_parameter_assignment_registry ||= {}
    end

    def register_for_multi_parameter_assignment(method, klass)
      multi_parameter_assignment_registry[method] = klass
    end
  end

end
