class Route
  include InstanceCounter

  attr_accessor :departure_station, :arrival_station

  attr_reader :transit_stations_list

  def initialize(departure_station, arrival_station)
    @departure_station = departure_station
    @arrival_station = arrival_station
    @transit_stations_list = []
  end

  def add_transit_station(transit_station)
    @transit_stations_list.push(transit_station)
  end

  def delete_transit_station(transit_station)
    @transit_stations_list.delete(transit_station)
  end

  def full_route
    [@departure_station] + @transit_stations_list + [@arrival_station]
  end

  def full_route_station_names
    [@departure_station.name, *@transit_stations_list.map(&:name), @arrival_station.name]
  end
end
