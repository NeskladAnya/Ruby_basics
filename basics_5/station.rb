class Station
    attr_reader :station_trains, :station_name
    
  def initialize(station_name)
    @station_name = station_name
    @station_trains = []
  end

  def train_arrives(train)
    @station_trains << train
  end

  def train_type(type)
    station_trains.select { |train| train.type == type}
  end

  def train_departs(train)
    @station_trains.delete(train)
  end

end

