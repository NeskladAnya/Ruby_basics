module Accessors
  def attr_accessor_with_history(*attributes)
    attributes.each do |attribute|
      var = "@#{attribute}".to_sym
      var_history = "@#{attribute}_history".to_sym

      define_method(attribute) { instance_variable_get(var) }

      define_method("#{attribute}=".to_sym) do |value|
        instance_variable_set(var, value)
        instance_variable_set(var_history, []) unless instance_variable_get(var_history)
        instance_variable_get(var_history).push(value)
      end

      define_method("#{attribute}_history".to_sym) { instance_variable_get(var_history) }
    end
  end

  def strong_attr_accessor(options = {})
    options.each do |attribute, class_name|
      var = "@#{attribute}".to_sym

      define_method(attribute) { instance_variable_get(var) }

      define_method("#{attribute}=".to_sym) do |value|
        raise "Incorrect class" unless value.is_a?(class_name)
        instance_variable_set(var, value)
      end
    end
  end
end

class Test
  extend Accessors

  attr_accessor_with_history :name
  strong_attr_accessor number: Integer, type: String
end
