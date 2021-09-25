class Train
  attr_reader :number, :type, :carriages, :current_station, :previous_station,
              :next_station, :route
  attr_accessor :speed
  
  def initialize(number)
    @number = number
    @type = self.type
    @carriages = []
    @speed = 0
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage)
    @carriages << carriage if speed == 0 && self.type == carriage.type
  end

  def remove_carriage(carriage)
    @carriages.delete(carriage) if speed == 0 && self.type == carriage.type
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
    unless self.next_station.nil?
      @current_station = @route.stations[@route.stations.index(@current_station) + 1]
    end
  end

  def move_backward
    unless self.previous_station.nil?
      @current_station = @route.stations[@route.stations.index(@current_station) - 1]
    end
  end

end