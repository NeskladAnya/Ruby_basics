class Route
  attr_reader :stations

  def initialize(starting_station, end_station)
    @stations = [starting_station, end_station]
  end

  def add_station(station)
    @stations.insert(-2, station.station_name)
  end

  def remove_station(station)
    case
    when station == @stations[0] then puts "Начальную станцию удалить нельзя"
    when station == @stations[-1] then puts "Конечную станцию удалить нельзя"
    when @stations.include?(station) then @stations.delete(station)
    else puts "Станция не найдена"
    end
  end
end