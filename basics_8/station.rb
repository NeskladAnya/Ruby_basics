class Station
  include InstanceCounter
  attr_reader :station_trains, :station_name

  @@instances = []

  def self.all
    @@instances
  end

  def initialize(station_name)
    @station_name = station_name
    @station_trains = []
    @@instances.push(self)
    register_instance
    validate!
  end

  def valide?
    validate!
    true
  rescue
    false
  end

  def train_arrives(train)
    @station_trains << train
  end

  def train_type(type)
    station_trains.select { |train| train.type == type }
  end

  def train_departs(train)
    @station_trains.delete(train)
  end

  def trains_info
    raise 'No trains at the station' if @station_trains.empty?

    station_block do |train| 
      puts "The train number: #{train.number}, the train type: #{train.type}, the number of carriages: #{train.carriages.count}"
    end
  rescue Exception => e
    puts e.message
  end

  def station_block(&block)
    station_trains.each(&block)
  end

  private

  def validate!
    raise 'A station name cannot be empty' if station_name.empty?
    raise 'A station name should be at least 2 symbols' if station_name.length < 2
  end
end
