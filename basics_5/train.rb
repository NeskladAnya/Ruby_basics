class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :number, :type, :carriages, :current_station, :previous_station,
              :next_station, :route
  attr_accessor :speed

  @@trains = []

  def self.find(number)
    @@trains.find { |train| train.number == number}
  end
  
  def initialize(number)
    @number = number.to_str
    @type = self.type
    @carriages = []
    @speed = 0
    @@trains.push(self)
    register_instance 
  end

  def stop
    @speed = 0
  end

#private
  def add_carriage(carriage)
    @carriages << carriage if speed == 0 && self.type == carriage.type
  end

  def remove_carriage
    @carriages.delete_at(0) if speed == 0
  end

  def set_route(route)
    @route = route
    @current_station = route.stations[0]
    route.stations[0].train_arrives(self)
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
    unless self.route.nil? && self.next_station.nil?
      @current_station.train_departs(self)
      @current_station = @route.stations[@route.stations.index(@current_station) + 1]
      @current_station.train_arrives(self)
    end
  end

  def move_backward
    unless self.route.nil? && self.previous_station.nil?
      @current_station.train_departs(self)
      @current_station = @route.stations[@route.stations.index(@current_station) - 1]
      @current_station.train_arrives(self)
    end
  end
end