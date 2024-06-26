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
