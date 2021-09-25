class Menu
  attr_reader :option
  
  def options
    @options = [
      "If you want to create a station, type 1",
      "If you want to check a list of all stations, type 2",
      "If you want to add a station to the route, type 3",
      "If you want to remove a station from the route, type 4",
      "If you want to check a list of trains at the station, type 5",
      "---",
      "If you want to create a route, type 6",
      "If you want to add a route to the train, type 7",
      "If you want to check a list of route stations, type 8",
      "---",
      "If you want to create a train, type 9",
      "If you want to add a carriage to the train, type 10",
      "If you want to detach a carriage from the train, type 11",
      "If you want to move a train one station forward, type 12",
      "If you want to move a train one station bacward, type 13",
      "---",
      "If you want to exit, type 0",
      "------------"
    ]
  end

  def menu
    self.options.each { |station| puts station}
  end

  def set_option
    @option = gets.chomp.to_i
  end
end