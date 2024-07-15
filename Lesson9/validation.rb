module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(name, validation_type, param = nil)
      @validations ||= []
      @validations << { attr: name, type: validation_type, param: param }
    end

    def validations
      @validations
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        attr_value = instance_variable_get("@#{validation[:attr]}")
        send("validate_#{validation[:type]}", attr_value, validation[:param])
      end
      true
    end

    def valid?
      validate!
    rescue StandardError
      false
    end

    private

    def validate_presence(value, _param)
      raise "Value can't be nil or empty" if value.nil? || value.to_s.empty?
    end

    def validate_format(value, format)
      raise "Value doesn't match format" unless value =~ format
    end

    def validate_type(value, type)
      raise "Value is not of type #{type}" unless value.is_a?(type)
    end
  end
end
