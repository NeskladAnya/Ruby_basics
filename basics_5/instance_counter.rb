module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethos
  end

  module ClassMethods
    @@count = 0

    def instances
      @@count
    end

    protected
    def increase_instance
      @@count += 1
    end
  end

  module InstanceMethos
    def register_instance
      self.class.send :increase_instance
    end
  end
end