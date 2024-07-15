# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances ||= 0
    end

    def increment_instances
      @instances = instances + 1
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.increment_instances
    end
  end
end

class Train
  include InstanceCounter

  @@trains = {}

  class << self
    def find(number)
      @@trains[number]
    end

    def all
      @@trains
    end
  end

  attr_reader :number

  def initialize(number)
    @number = number
    @@trains[number] = self
  end
end
