class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :number, :type, :carriages, :current_station, :route
  attr_accessor :speed

  TRAIN_NUMBER = /\A[0-9a-zа-я]{3}-?[0-9a-zа-я]{2}\z/i

  @@trains = []

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def initialize(number)
    @number = number.to_s
    @type = nil
    @carriages = []
    @speed = 0
    @@trains.push(self)
    register_instance
    validate!
  end

  def valide?
    validate!
    true
  rescue
    false
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage)
    raise 'The carriage type error' if @type != carriage.type

    @carriages << carriage if speed.zero?
  rescue Exception => e
    puts e.message
  end

  def remove_carriage
    @carriages.delete_at(0) if speed.zero?
  end

  def set_route(route)
    @route = route
    @current_station = route.stations[0]
    route.stations[0].train_arrives(self)
  end

  def previous_station
    raise 'No previous station found' if @current_station == @route.stations.first

    @previous_station = @route.stations[@route.stations.index(@current_station) - 1]
  rescue Exception => e
    puts e.message
  end

  def next_station
    raise 'No next station found' if @current_station == @route.stations.last

    @next_station = @route.stations[@route.stations.index(@current_station) + 1]
  rescue Exception => e
    puts e.message
  end

  def move_forward
    raise 'No route found' if route.nil?
    raise 'No next station found' if next_station.nil?

    @current_station.train_departs(self)
    @current_station = @route.stations[@route.stations.index(@current_station) + 1]
    @current_station.train_arrives(self)
  rescue Exception => e
    puts e.message
  end

  def move_backward
    raise 'No route found' if route.nil?
    raise 'No previous station found' if previous_station.nil?

    @current_station.train_departs(self)
    @current_station = @route.stations[@route.stations.index(@current_station) - 1]
    @current_station.train_arrives(self)
  rescue Exception => e
    puts e.message
  end

  def carriage_info
    raise 'No carriages found' if carriages.empty?

    train_block do |carriage|
      puts "The carriage number: #{carriage.number}"
      puts "The carriage type: #{carriage.type}"
      puts "Available capacity: #{carriage.available_capacity}"
      puts "Used capacity: #{carriage.used_capacity}"
      puts '----------------'
    end
  rescue Exception => e
    puts e.message
  end

  def train_block(&block)
    carriages.each(&block)
  end

  private

  def validate!
    raise 'A train number cannot be empty' if number.empty?
    raise 'Incorrect number format' if number !~ TRAIN_NUMBER
  end
end
