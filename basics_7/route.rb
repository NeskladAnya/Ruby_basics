class Route
  include InstanceCounter
  attr_reader :stations, :starting_station, :end_station

  def initialize(starting_station, end_station)
    @starting_station = Station.new(starting_station)
    @end_station = Station.new(end_station)
    @stations = [@starting_station, @end_station]
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    raise "No station found" unless @stations.include?(station)
    raise "The first station cannot be deleted" if station == self.stations[0]
    raise "The last station cannot be deleted" if station == self.stations[-1]
    
    @stations.delete(station)
    puts "The #{station.station_name} station was deleted"
  rescue StandardError => e
    puts e.message
  end
end
