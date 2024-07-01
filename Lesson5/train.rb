class Train
  attr_accessor :number_wagons
  attr_reader :train_number, :route, :wagons

  def initialize(train_number)
    @train_number = train_number
    @current_speed = 0
    @route = nil
    @current_station = nil
    @wagons = []
    @current_station_index = 0
  end

  def accelerate(increment)
    @current_speed += increment
  end

  def current_speed
    @current_speed
  end

  def brake
    @current_speed = 0
  end

  def add_route(route)
    @route = route
    @current_station = route.departure_station
    puts "Current station of #{train_number} is #{@current_station.name}"
    @current_station.receive_train(self)
  end

  def current_station
    @route.full_route[@current_station_index]
  end

  def go_next_station
    @current_station_index += 1 if next_station
  end

  def go_previous_station
    @current_station_index -= 1 if previous_station
  end

  def add_wagon(wagon)
    connect_wagon(wagon) if current_speed == 0
  end

  def remove_wagon(wagon)
    disconnect_wagon(wagon)
  end

  private

  def next_station
    @route.full_route[@current_station_index + 1]
  end

  def previous_station
    @route.full_route[@current_station_index + 1]
  end

  def train_position
    index = @route.full_route.index(@current_station)
    previous_station = index > 0 ? @route.full_route[index - 1] : nil
    next_station = index < @route.full_route.length - 1 ? @route.full_route[index + 1] : nil
    puts "Current station is: #{@current_station.name}, Previous station is: #{previous_station&.name}, Next station is: #{next_station&.name}"
  end

  def connect_wagon(wagon)
    if current_speed == 0
      @wagons << wagon
      puts "Wagon connected"
    else
      puts "The train #{@train_number} is not stationary"
    end
  end

  def disconnect_wagon(wagon)
    if wagons.include?(wagon)
      wagons.delete(wagon)
      puts "Wagon disconnected"
    else
      puts "Wagon not found"
    end
  end

end
