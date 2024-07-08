class Station
  include InstanceCounter

  attr_reader :name, :current_train_list

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
    raise StandardError, "Station name cannot be empty" if name.nil? || name.strip.empty?
    raise StandardError, "Station name must be at least 2 characters long" if name.length < 2
  end

  def valid?
    validate!
    true
  rescue
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
end
