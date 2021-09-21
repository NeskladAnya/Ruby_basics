class Train
  attr_reader :number, :type, :carriages_number, :current_station, :previous_station,
              :next_station, :route
  attr_accessor :speed
  
  def initialize(number, type, carriages_number)
    @number = number
    @type = type
    @carriages_number = carriages_number
  end

  def stop
    @speed = 0
  end

  def change_carriages_number(action)
    if speed == 0
      @carriages_number += 1 if action == "прицепить"
      @carriages_number -= 1 if action == "отцепить"
    else
      puts "Остановите поезд, чтобы изменить количество вагонов!"
    end
  end

  def set_route(route)
    @route = route.stations 
    @current_station = @route[0]
  end

  def previous_station
    if @current_station != @route.first
      previous_station = @route[@route.find_index(@current_station) - 1]
    else
      puts "Вы на начальной станции."
    end
  end

  def next_station
    if @current_station != @route.last
      next_station = @route[@route.find_index(@current_station) + 1]
    else
      puts "Вы на конечной станции."
    end
  end

  def move(action)
    case 
    when 
      action == "вперёд" then
      if @current_station == @route.last
        puts "Вы на конечной станции. Просьба покинуть вагон."
      else
        @current_station = @route[@route.find_index(@current_station) + 1]
      end

    when 
      action == "назад" then
      if @current_station == @route.first
        puts "Вы на начальной станции."
      else
        @current_station = @route[@route.find_index(@current_station) - 1]
      end
    end
  end

end