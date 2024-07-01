class Program

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def start
    #I create the "create_seeds" mock data for ease of checking. not oblogatory method.
    create_seeds
    loop do
      show_menu
      choice = make_choice
      take_action(choice.to_i)
    end
  end

  private

  def create_seeds
    ("a".."d").each do |name|
      @stations << Station.new(name)
    end

    3.times do
      departure = @stations.first
      arrival = @stations.last
      route = Route.new(departure, arrival)
      route.add_transit_station(@stations[1])
      route.add_transit_station(@stations[2])
      @routes << route
    end

    5.times do |t|
      cargo_train = CargoTrain.new(rand(1..100))
      passenger_train = PassengerTrain.new(rand(1..100))

      cargo_train.add_route(@routes.sample)
      passenger_train.add_route(@routes.sample)

      @trains << cargo_train
      @trains << passenger_train
    end


  end

  def show_menu
    puts "Choose an action: (1) Create station (2) See stations (3) Create train (4) See trains (5) Create route (6) Update route (7) See all routes (8) Assign route to train (9) Manage train wagons (10) Move train (11) See stations with trains (0) Exit"

  end

  def make_choice
    gets.chomp
  end

  def take_action(choice)
    case choice
    when 1
      create_station
    when 2
      display_stations
    when 3
      create_train
    when 4
      display_trains
    when 5
      create_route
    when 6
      display_routes
    when 7
      update_route
    when 8
      assign_route_to_train
    when 9
      manage_train_wagons
    when 10
      move_train
    when 11
      display_stations_with_trains
    when 0
      exit
    else
      puts "Invalid choice. Please choose a valid action."
    end
  end

  def create_station
    puts "Type station name:"
    set_station(make_choice.to_s)
  end

  def set_station(name)
    @stations << Station.new(name)
  end

  def display_stations
    @stations.empty? && (puts "No stations have been added yet."; return nil)
    puts "List of stations:"
    @stations.each { |station| puts station.name }
  end

  def create_train
    set_new_train
  end

  def set_new_train
    puts "Please provide train type: (1) Cargo (2) Passenger"
    choice = make_choice.to_i
    case choice
    when 1
      train_number = set_new_train_number
      add_train(CargoTrain.new(train_number))
    when 2
      train_number = set_new_train_number
      add_train(PassengerTrain.new(train_number))
    else
      puts "Invalid choice. Please enter 1 for Cargo or 2 for Passenger."
    end
  end

  def set_new_train_number
    puts "Please provide train number:"
    make_choice.to_s
  end

  def add_train(train)
    @trains << train
  end

  def create_route
    return puts "Please add stations first." if display_stations.nil?
    route = Route.new(assign_arrival_station, assign_departure_station)
    set_transit_stations(route)
    @routes << route
  end

  def assign_arrival_station
    puts "Assign Arrival Station"
    assign_station
  end

  def assign_departure_station
    puts "Assign Departure Station"
    assign_station
  end

  def assign_station
    find_station(make_choice.to_s)
  end

  def set_transit_stations(route)
    loop do
      display_stations
      transit_station = collect_transit_station
      break if transit_station == :finish
      route.add_transit_station(transit_station) if transit_station
    end
  end

  def collect_transit_station
    puts "Input Transit station name (or '0' to finish):"
    input = make_choice
    return :finish if input == '0'
    find_station(input)
  end

  def update_route
    display_routes
    puts "Please select route. Enter 0 to exit"
    route_index = make_choice.to_i - 1
    return if route_index == -1
    route = find_route(route_index + 1)
    puts "Please choose your action: (1) Edit Route, (2) Delete Route, (0) to exit"
    choice = make_choice.to_i
    case choice
    when 1
      update_chosen_route(route)
    when 2
      delete_route(route)
    when 3
      add_transit_stations(route)
    when 0
      return
    end
    #TODO: Add stations to route
  end

  def assign_route_to_train
    display_trains
    puts "Please choose Train number to add"
    train = find_train(make_choice.to_i)
    display_routes
    puts "Please choose Index of Route to add"
    route = find_route(make_choice.to_i)
    train.add_route(route)
  end

  def update_chosen_route(route)
    puts "Current stations in the route:"
    display_stations_inside_route(route)

    puts "Please choose the station number to edit:"
    station_index = make_choice.to_i - 1

    puts "Available stations to swap with:"
    display_stations_with_index

    puts "Please choose the station number to swap with:"
    new_station_index = gets.chomp.to_i - 1

    route.full_route[station_index] = @stations[new_station_index]
    puts "Station updated successfully."
  end

  def add_transit_stations(route)
    puts "Current transit stations in the route:"
    display_stations_inside_route(route)

    loop do
      puts "Available stations to add:"
      display_stations_with_index

      puts "Please choose the station number to add (0 to finish):"
      station_index = make_choice.to_i - 1

      break if station_index == -1

      if station_index >= 0 && station_index < @stations.size
        new_station = @stations[station_index]
        if route.transit_stations_list.include?(new_station)
          puts "Station already exists in transit stations."
        else
          route.add_transit_station(new_station)
          puts "Station added successfully."
        end
      else
        puts "Invalid station number."
      end
    end
  end

  def display_routes
    @routes.each_with_index { |route, index| puts "Index: (#{index + 1}) / Route: #{route.full_route_station_names}" }
  end

  def display_stations_inside_route(route)
    route.full_route.each_with_index { |station, index| puts "#{index + 1}. #{station.name}" }
  end

  def display_stations_with_index
    @stations.each_with_index { |station, index| puts "#{index + 1}. #{station.name}" }
  end

  def move_train
    display_trains
    puts "Please choose Train number to move"
    train = find_train(make_choice.to_i)
    puts "Please choose (1) to move train forward, and (2) to move backwards. (0) to exit"
    choice = make_choice.to_i
    case choice
      when 1
        train.move_train_forward
      when 2
        train.move_train_backward
      when 0
        return
    end
  end

  def display_trains
    @trains.each_with_index { |train, index| puts "#{train.type} Train Number: #{train.train_number} \ Assigned Route: #{train.route}" }
  end

  def display_stations_with_trains
    @stations.each { |station| puts "Station: #{station.name} / Trains: #{station.current_train_list_with_names}" }
  end

  def manage_train_wagons
    display_trains
    puts "Please choose Train number to add wagons"
    train = find_train(make_choice.to_i)
    loop do
      puts "Please choose (1) to add wagons, and (2) to remove wagons. (0) to exit"
      choice = make_choice.to_i
        case choice
        when 1
          puts "Train type: #{train.type}"
          wagon = train.type == "cargo" ? CargoWagon.new : PassengerWagon.new
          train.add_wagon(wagon)
        when 2
          show_train_wagons(train)
          puts "Please choose the wagon number to remove:"
          wagon_index = make_choice.to_i - 1
          wagon = train.wagons[wagon_index]
          train.remove_wagon(wagon)
        when 0
            break
        end
    end
  end


  def show_train_wagons(train)
    train.wagons.each_with_index { |wagon, index| puts "#{index + 1}. Wagon type: #{wagon.type}" }
  end

  def find_route(index)
    @routes[index - 1]
  end

  def find_station(name)
    @stations.find { |station| station.name == name }
  end

  def find_train(number)
    @trains.find { |train| train.train_number == number }
  end

  def delete_route(index)
    @routes.delete(find_route(index))
  end
end
