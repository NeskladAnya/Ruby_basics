class Train
  attr_reader :number, :type, :carriages_number
  attr_accessor :speed
  
  def initialize(number, type, carriages_number)
    @number = number
    @type = type
    @carriages_number = carriages_number
  end

  def stop
    @speed = 0
  end

  def change_carriages_number(value)
    if speed == 0
      @carriages_number += 1 if value == "прицепить"
      @carriages_number -= 1 if value == "отцепить"
    else
      puts "Остановите поезд, чтобы изменить количество вагонов!"
    end
  end
end