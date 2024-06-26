class Train
  attr_accessor :number_wagons, :current_station
  attr_reader :train_number, :route, :wagons

  def initialize(train_number)
    @train_number = train_number
    @current_speed = 0
    @route = nil
    @current_station = nil
    @wagons = []
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
    self.current_station = route.departure_station
  end

  def train_position
    unless @route
      puts "Please assign a route to the train"
    end

    index = @route.full_route.index(self.current_station)
    previous_station = @route.full_route[index - 1]
    next_station = @route.full_route[index + 1]
    return "Current station is: #{@current_station}, Previous station is #{previous_station}\
    Next station is: #{next_station}"
  end

  def move_train(forward=true)
    #if passed forward = false, this means moving train backwards
    unless @route
      puts "Please assign a route to the train"
      return
    end
    index = @route.full_route.index(self.current_station)
    if forward
      new_index = index += 1
      if new_index < @route.full_route.length
        self.current_station = @route.full_route[new_index]
      else
        puts "This is the end of the route"
      end
    else
      new_index = index -= 1
      if new_index >= 0
        self.current_station = @route.full_route[new_index]
      else
        puts "The train is the start of the route"
      end
    end
  end

  private

#Этот метод приватный потому что мы не можем дать возможность пользоваться конструктором для класса Train напрямую
  def wagons_constructor(wagon)
    if current_speed == 0
      @wagons << wagon
    else
      puts "The train #{@train_number} is not stationary"
    end
  end

  def disconnect_wagon
    if current_speed == 0 && !@wagons.empty?
      @wagons.pop
    else
      puts "The train is either moving or has no wagons to remove"
    end
  end

end

class PassengerTrain < Train

  def connect_wagons(wagon)
    if wagon.type == "passenger"
      wagons_constructor(wagon)
    else
      puts "Wrong type of wagon"
    end
  end

  def disconnect_wagons(wagon)
    if wagon.type == "passenger"
      disconnect_wagon(wagon)
    else
      puts "Wrong type of wagon"
    end
  end

end

class CargoTrain < Train
  def connect_wagons(wagon)
    if wagon.type == "cargo"
      wagons_constructor(wagon)
    else
      puts "Wrong type of wagon"
    end
  end

  def disconnect_wagons(wagon)
    if wagon.type == "cargo"
      disconnect_wagon(wagon)
    else
      puts "Wrong type of wagon"
    end
  end
end
