class Route
  attr_reader :stations

  def initialize(starting_station, end_station)
    @starting_station = starting_station
    @end_station = end_station
    @stations = [starting_station, end_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    case
    when station == @starting_station then puts "Начальную станцию нельзя удалить"
    when station == @end_station then puts "Конечную станцию нельзя удалить"
    when @stations.include?(station) then @stations.delete(station)
    else puts "Станции не найдено"
    end
  end
end