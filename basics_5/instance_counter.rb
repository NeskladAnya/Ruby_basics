module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethos
  end

  module ClassMethods

    def instances
      @instances
    end

    protected
    def increase_instance
      @instances = 0 if @instances.nil?
      @instances += 1
    end
  end

  module InstanceMethos
    def register_instance
      self.class.send :increase_instance
    end
  end
end