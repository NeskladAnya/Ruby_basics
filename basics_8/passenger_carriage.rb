class PassengerCarriage < Carriage
  attr_reader :available_seats, :taken_seats
  def initialize(seats)
    @seats = seats
    @available_seats = seats
    @taken_seats = 0
    self.type
  end

  def type
    @type = "passenger"
  end

  def take_seat
    raise "No available seats" if @available_seats == 0
    @available_seats -= 1
    @taken_seats += 1
  rescue Exception => e
    puts e.message
  end

end