class PassengerCarriage < Carriage
  def type
    @type = 'passenger'
  end

  def use_capacity
    raise 'No available seats' if @available_capacity.zero?

    @available_capacity -= 1
    @used_capacity += 1
  rescue StandardError => e
    puts e.message
  end
end
