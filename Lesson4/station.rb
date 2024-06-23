class Route
  attr_accessor :departure_station, :arrival_station

  def initialize(departure_station, arrival_station)
    @departure_station = departure_station
    @arrival_station = arrival_station
    @transit_stations_list = Array.new
  end

  def add_transit_station(transit_station)
    @transit_stations_list.push(transit_station)
  end

  def delete_transit_station(transit_station)
    @transit_stations_list.delete(transit_station)
  end

  def full_route
    return [@departure_station, *@transit_stations_list, @arrival_station]
  end
end

r1 = Route.new("SG", "KL")
r1.add_transit_station("JB")
r1.add_transit_station("MC")
r1.add_transit_station("SB")
print r1.full_route
r1.delete_transit_station("MC")
print r1.full_route

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

s1 = Station.new("first")
s2 = Station.new("second")

puts "#{s1.name} / #{s2.name}"

class Train
  attr_accessor :number_wagons, :current_station
  attr_reader :type, :train_number, :route

  def initialize(train_number, number_wagons, type)
    @train_number = train_number
    @number_wagons = number_wagons
    @type = type
    @current_speed = 0
    @route = nil
    @current_station = nil
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

  def connect_wagons(wagons)
    if current_speed == 0
      @number_wagons += wagons
    else
      puts "The train #{@train_number} is not stationary"
    end
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

end

t1 = Train.new("ab1", 11, "passenger")
t1.accelerate(10)
puts "Current speed: #{t1.current_speed}"
puts "Number wagons: #{t1.number_wagons}"
t1.connect_wagons(5)
puts "New Number wagons: #{t1.number_wagons}"
t1.brake
t1.connect_wagons(5)
puts "New Number wagons: #{t1.number_wagons}"
t1.add_route(r1)
puts "Train #{t1.train_number} route is #{t1.route.full_route}, with departure station: #{t1.current_station}"
puts "Moving traing: #{t1.move_train(forward=true)}"
puts "Train position is: #{t1.train_position}"
