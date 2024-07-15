module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history_var_name = "@#{name}_history".to_sym

      define_method(name) { instance_variable_get(var_name)}

      define_method("#{name}=") do |value|
        history = instance_variable_get(history_var_name) || []
        history << instance_variable_get(var_name)
        instance_variable_set(history_var_name, history)
        instance_variable_set(var_name, value)
      end

      define_method("#{name}_history") { instance_variable_get(history_var_name) || [] }
    end
  end

  def strong_attr_accessor(name, requested_class)
    var_name = "@#{name}".to_sym

    define_method(name) { instance_variable_get(var_name)}

    define_method("#{name}=") do |value|
      unless value.is_a?(requested_class)
        raise TypeError, "Expected instance of #{requested_class}, got #{value.class}"
      end
      instance_variable_set(var_name, value)
    end
  end
end
