require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'

class Creator

  attr_reader :stations, :trains

  def initialize
    @stations = []
    @trains = []
  end

  def set_station(name)
    @stations << Station.new(name)
  end

  def set_trains(train)
    @trains << train
  end

  def find_station(name)
    @stations.find { |station| station.name == name }
  end

  def find_train(number)
    @trains.find { |train| train.train_number == number }
  end

end

creator = Creator.new

loop do
  puts "Choose an action: (1) Create station (2) Create train (3) Add wagon (4) Remove wagon (5) Move train (6) List stations (7) List trains (8) Create route (9) Exit"
  action = gets.chomp.to_i

  case action
  when 1
    puts "Provide a Station Name. Type 'stop' if you wish to stop"
    station_name = gets.chomp
    break if station_name == "stop"
    creator.set_station(station_name)

  when 2
    puts "Let's create a train. Please provide train number. Type stop if you wish to stop"
    train_number = gets.chomp
    break if train_number == "stop"
    puts "Please provide train type: cargo or passenger"
    train_type = gets.chomp
    if train_type == "cargo"
      train = CargoTrain.new(train_number)
      creator.set_trains(train)
      puts "Train #{train.train_number} has been created"
    elsif train_type == "passenger"
      train = PassengerTrain.new(train_number)
      creator.set_trains(train)
      puts "Train #{train.train_number} has been created"
    else
      puts "Invalid train type"
    end

  when 3
    puts "Let's add wagon to train"
    puts "Available trains: #{creator.trains.map(&:train_number).join(', ')}"
    puts "Enter train number:"
    train_number = gets.chomp
    train = creator.find_train(train_number)
    if train
      puts "Choose type of Wagon: passenger or cargo. Type 'end' to finish"
      wagon_type = gets.chomp
      if wagon_type == "passenger" && train.is_a?(PassengerTrain)
        train.connect_wagons(PassengerWagon.new)
        puts "Passenger wagon added"
      elsif wagon_type == "cargo" && train.is_a?(CargoTrain)
        train.connect_wagons(CargoWagon.new)
        puts "Cargo wagon added"
      else
        puts "Invalid wagon type or mismatched train type"
      end
    else
      puts "Train not found"
    end
  when 4
    puts "Let's remove wagons from train"
    puts "Available trains: #{creator.trains.map(&:train_number).join(', ')}"
    train_number = gets.chomp
    train = creator.find_train(train_number)
    if train
      train.disconnect_wagon
      puts "Wagon removed"
    else
      puts "Train not found"
    end
  when 5
    puts "Let's move our train train"
    puts "Available trains: #{creator.trains.map(&:train_number).join(', ')}"
    puts "Enter train number:"
    train_number = gets.chomp
    train = creator.find_train(train_number)
    if train
      puts "Move train (1) forward or (2) backward?"
      direction = gets.chomp.to_i
      if direction == 1
        train.move_train(true)
      elsif direction == 2
        train.move_train(false)
      else
        puts "Invalid direction"
      end
    else
      puts "Train not found"
    end
  when 6
    puts "Stations list:"
    creator.stations.each { |station| puts station.name }

  when 7
    puts "Stations list:"
    creator.stations.each { |station| puts station.name }
    puts "Enter station name:"
    station_name = gets.chomp
    station = creator.find_station(station_name)
    if station
      puts "Trains at #{station.name}:"
      station.current_trains.each { |train| puts train.train_number }
    else
      puts "Station not found"
    end

  when 8
    puts "Let's create a Route"
    puts "Enter Departure Station"
    departure_station_name = gets.chomp
    departure_station = creator.find_station(departure_station_name)

    puts "Enter Arrival Station"
    arrival_station_name = gets.chomp
    arrival_station = creator.find_station(arrival_station_name)

    if departure_station && arrival_station
      route = Route.new(departure_station, arrival_station)

      puts "Does route have transit stations? Type 'yes' to add"
      input = gets.chomp

      if input == "yes"
        while true
          puts "Input Transit station name. Type 'end' to finish"
          transit_station_name = gets.chomp
          break if transit_station_name == "end"
          transit_station = creator.find_station(transit_station_name)
          if transit_station
            route.add_transit_station(transit_station)
          else
            puts "Station not found."
          end
        end
      end

      puts "Route created with departure station: #{departure_station.name}, arrival station: #{arrival_station.name}, transit stations: #{route.transit_stations.map(&:name).join(', ')}"

      puts "Available trains to assign route to: #{creator.trains.map(&:train_number).join(', ')}"
      puts "Enter train number to assign the route:"
      train_number = gets.chomp
      train = creator.find_train(train_number)

      if train
        train.add_route(route)
        puts "Route assigned to train #{train.train_number}"
      else
        puts "Train not found."
      end
    else
      puts "Invalid stations. Make sure both departure and arrival stations exist."
    end
  when 9
    break
  end
end
