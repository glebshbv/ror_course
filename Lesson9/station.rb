# frozen_string_literal: true

class Station
  extend Accessors
  include Validation
  include InstanceCounter

  attr_accessor_with_history :name, :current_train_list
  strong_attr_accessor :name, String
  strong_attr_accessor :current_train_list, Array

  attr_reader :name, :current_train_list

  validate :name, :presence
  validate :name, :format, /\A[A-Z]{2}\z/
  validate :name, :type, String
  validate :current_train_list, :type, Array

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @current_train_list = []
    @@stations << self
    validate!
  end

  def validate!
    raise StandardError, 'Station name cannot be empty' if name.nil? || name.strip.empty?
    raise StandardError, "Station name must be in the format 'AA'" unless name.match?(/\A[A-Z]{2}\z/)
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def send_train(train)
    @current_train_list.delete(train)
  end

  def receive_train(train)
    @current_train_list << train
  end

  def current_train_list_with_names
    @current_train_list.map(&:train_number)
  end

  def each_train_on_station(&block)
    @current_train_list.each(&block)
  end
end
