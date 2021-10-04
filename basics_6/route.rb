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
    if @stations.include?(station) && (station != @stations[0] && station != @stations[-1])
      @stations.delete(station)
    end
  end
end