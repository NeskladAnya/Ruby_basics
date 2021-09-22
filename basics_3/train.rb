class Train
  attr_reader :number, :type, :carriages_number, :current_station, :previous_station,
              :next_station, :route
  attr_accessor :speed
  
  def initialize(number, type, carriages_number)
    @number = number
    @type = type
    @carriages_number = carriages_number
  end

  def stop
    @speed = 0
  end

  def add_carriage
    @carriages_number += 1 if speed == 0
  end

  def remove_carriage
    @carriages_number -= 1 if speed == 0
  end

  def set_route(route)
    @route = route
    @current_station = route.stations[0]
  end

  def previous_station
    if @current_station != @route.stations.first
      previous_station = @route.stations[@route.stations.index(@current_station) - 1]
    end
  end

  def next_station
    if @current_station != @route.stations.last
      next_station = @route.stations[@route.stations.index(@current_station) + 1]
    end
  end

  def move_forward
    unless @current_station == @route.stations.last
      @current_station = @route.stations[@route.stations.index(@current_station) + 1]
    end
  end

  def move_backward
    unless @current_station == @route.stations.first
      @current_station = @route.stations[@route.stations.index(@current_station) - 1]
    end
  end

end