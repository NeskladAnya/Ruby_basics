class Carriage
  include Manufacturer

  attr_reader :capacity, :available_capacity, :used_capacity, :type, :number

  @@number = 0

  def initialize(capacity)
    @@number += 1
    @number = @@number
    @capacity = capacity.strip
    @available_capacity = capacity
    @used_capacity = 0
    @type = nil
  end

  def use_capacity(value)
    raise 'Unsufficient capacity' if value > @available_capacity

    @available_capacity -= value
    @used_capacity += value
  rescue StandardError => e
    puts e.message
  end
end
