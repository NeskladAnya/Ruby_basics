class Route
  attr_reader :stations

  def initialize(starting_station, end_station)
    @stations = [starting_station, end_station]
  end

  def add_station(station)
    @stations.insert(-2, station.station_name)
  end

  def remove_station(station)
    if @stations.include?(station) && (station != @stations[0] && station != @stations[-1])
      @stations.delete(station)
    end
  end
end