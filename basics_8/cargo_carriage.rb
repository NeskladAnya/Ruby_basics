class CargoCarriage < Carriage
  attr_reader :capacity, :available_capacity, :used_capacity

  def initialize(capacity)
    @capacity = capacity
    @available_capacity = capacity
    @used_capacity = 0
    self.type
  end

  def type
    @type = "cargo"
  end

  def use_capacity(value)
    raise "Unsufficient capacity" if value > @available_capacity
    @available_capacity -= value
    @used_capacity += value
  rescue Exception => e
    puts e.message
  end
end