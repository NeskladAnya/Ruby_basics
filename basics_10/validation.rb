module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :all_validations

    def validate(attribute, validation, addition = nil)
      @all_validations ||= []
      @all_validations << {attribute: attribute, validation: validation, addition: addition}
    end
  end

  module InstanceMethods
    def validate!
      @all_errors ||= []
      self.class.all_validations.each do |element|
        if element[:addition].nil? 
          send element[:validation], element[:attribute]
        else
          send element[:validation], element[:attribute], element[:addition]
        end
      end
      unless @all_errors.empty?
        puts @all_errors
        raise StandardError
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    private

    def validate_presence(attribute)
      if instance_variable_get("@#{attribute}").nil? || instance_variable_get("@#{attribute}").empty?
        @all_errors << "The attribute '#{attribute}'presence error"
      end
    end

    def validate_format(attribute, format)
      if instance_variable_get("@#{attribute}") !~ format
        @all_errors << "The attribute '#{attribute}' format error"
      end
    end

    def validate_class(attribute, attr_class)
      unless instance_variable_get("@#{attribute}").is_a?(attr_class)
        @all_errors << "The attribute '#{attribute}' class error"
      end
    end
  end
end
