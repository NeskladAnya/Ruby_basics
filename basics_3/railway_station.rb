class Station
    attr_reader :trains
    
  def initialize(name)
    @name = name
    @trains = []
  end

  def train_arrives(train)
    @trains << train
  end

  def train_type(type)
    trains.select { |train| train.type == type}
  end

  def train_departs(train)
    @trains.delete(train)
  end

end

