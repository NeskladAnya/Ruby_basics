class Interface
  attr_reader :all_stations

  def initialize
    @all_stations = []
    @all_routes = []
    @all_trains = []
  end

  def new_station
    puts "Enter a station name"
    name = gets.chomp
    @all_stations << Station.new(name)
  end

  def see_all_stations
    @all_stations.each { |station| station.station_name}
  end

  def new_route
    puts "Enter the first station name"
    first = gets.chomp
    puts "Enter the last station name"
    last = gets.chomp
    @all_routes << Route.new(first, last)
  end

  def route_stations
    @all_routes.each { |route| puts route.stations}
  end

  def new_train
    puts "In order to select a train type, type 'cargo' or 'passenger'"
    type = gets.chomp
    puts "Enter a train number"
    number = gets.chomp.to_i
    @all_trains << CargoTrain.new(number) if type == "cargo"
    @all_trains << PassengerTrain.new(number) if type == "passenger"
  end

  def set_train_route
    puts "Select a train from the list"
  end



  
=begin
      "If you want to add a station to the route, type 3",
      "If you want to remove a station from the route, type 4",
      "If you want to check a list of trains at the station, type 5",
      "---",
      "If you want to add a route to the train, type 7",
      "If you want to check a list of route stations, type 8",
      "---",
      "If you want to add a carriage to the train, type 10",
      "If you want to detach a carriage from the train, type 11",
      "If you want to move a train one station forward, type 12",
      "If you want to move a train one station bacward, type 13",
      "---",
      "If you want to exit, type 0",
      "------------"
    ]
def add_station
    if @all_stations.empty?
      puts "Error"
    elsif @all_routes.empty?
      puts "Error"
    else
      puts "Select the station from the list #{@all_stations.select { |station| puts station}}"
      station_name = gets.chomp
      puts "Select the route from the list #{@all_routes.select { |route| puts route.stations }}"
    end
  end
  loop do
    self.menu
    self.menu.menu
    self.menu.set_option

    case self.menu.option
    when 1
      new_station
    when 3
      all_stations
    when 2
      unless @stations.empty? && @routes.empty?
        puts "Enter the station name"
        station_name = gets.chomp
        puts "Enter the route name"
        route_name = gets.chomp
      end
    when 5
      puts "Enter the first station name"
      first = gets.chomp
      puts "Enter the last station name"
      last = gets.chomp
      @routes << Route.new(first, last)
    when 8
      puts "What is the train number?"
      number = gets.chomp.to_i
      @trains << Train.new(number)
    when 0
      break
    end
  end
=end
end