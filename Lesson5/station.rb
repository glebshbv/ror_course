class Station
  attr_accessor :name

  def initialize(name)
    @name = name
    @current_train_list = []
  end

  def receive_train(name)
    @current_train_list.new(name)
  end

  def current_trains
    @current_train_list
  end

end
