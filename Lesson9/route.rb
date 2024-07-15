# frozen_string_literal: true

class Route
  extend Accessors
  include Validation

  attr_accessor_with_history :departure_station, :arrival_station
  strong_attr_accessor :departure_station, String
  strong_attr_accessor :arrival_station, String


  attr_accessor :departure_station, :arrival_station
  attr_reader :transit_stations_list

  validate :departure_station, :presence
  validate :departure_station, :type, Station
  validate :arrival_station, :presence
  validate :arrival_station, :type, Station


  def initialize(departure_station, arrival_station)
    @departure_station = departure_station
    @arrival_station = arrival_station
    @transit_stations_list = []
    validate!
  end

  def validate!
    raise StandardError, 'Departure station cannot be nil' if departure_station.nil?
    raise StandardError, 'Arrival station cannot be nil' if arrival_station.nil?
    raise StandardError, 'Departure and arrival stations cannot be the same' if departure_station == arrival_station
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
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
