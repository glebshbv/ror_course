class Station
  attr_reader :name, :current_train_list

  def initialize(name)
    @name = name
    @current_train_list = []
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
