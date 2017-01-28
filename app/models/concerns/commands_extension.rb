module CommandsExtension
  extend ActiveSupport::Concern

  class Config
    attr_reader :klasses

    def initialize(base_class)
      @base_class = base_class
      @klasses = {}
    end

    def add(command_method)
      @klasses[command_method.to_sym] = command_class(command_method.to_s)
    end

    private
      def command_class(command_method)
        "#{@base_class.name.pluralize}::#{command_method.camelize}Command"
      end
  end

  class Commands
    def initialize(object, config)
      @object = object
      @klasses = config.klasses
    end

    def respond_to_missing?(method, include_all)
      registered_method?(method) || super
    end

    def method_missing(method, *args)
      if registered_method?(method)
        execute_command(method, *args)
      else
        super
      end
    end

    private

      def registered_method?(method)
        @klasses.has_key?(method)
      end

      def execute_command(method, *args)
        @klasses[method].constantize.new(@object, *args).execute
      end
  end

  def commands
    @commands ||= Commands.new(self, self.class.commands_config)
  end

  def reload(*args)
    @commands = nil
    super
  end

  def initialize_dup(other)
    super
    @commands = nil
  end

  class_methods do
    def commands_config
      @__commands_config ||= Config.new(self)
    end

    def add_command(*args)
      args.each do |arg|
        commands_config.add(arg)
      end

      delegate *args, to: :commands
    end
  end
end
