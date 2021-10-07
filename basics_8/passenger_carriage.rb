class PassengerCarriage < Carriage
  def type
    @type = "passenger"
  end

  def use_capacity
    raise "No available seats" if @available_capacity == 0
    @available_capacity -= 1
    @used_capacity += 1
  rescue Exception => e
    puts e.message
  end

end