class Interface
  attr_reader :all_stations, :all_routes, :all_trains, :selected_station, :menu_answer

  def initialize
    @all_stations = []
    @all_routes = []
    @all_trains = []
  end

  def interface_loop
    loop do
      self.menu
    
      if @menu_answer == 0
        break
      else
        self.sub_menu
        answer = self.sub_menu_answer
      end
    
      case answer
      when 1
        self.new_station
      when 2
        self.new_route
      when 3
        self.new_train
      when 4
        self.add_route_station
      when 5
        self.remove_route_station
      when 6
        self.set_train_route
      when 7
        self.add_carriage
      when 8
        self.remove_carriage
      when 9
        self.move_train_forward
      when 10
        self.move_train_backward
      when 11
        self.see_all_stations
      when 12
        self.display_station_trains
      else
        puts "Error"
      end
    end
  end

 # protected
  def menu
    puts "To create an object, type 1"
    puts "To perform actions with an object, type 2"
    puts "To see info, type 3"
    puts "To exit, type 0"
    puts "----------------"
    
    @menu_answer = gets.chomp.to_i
  end

  def sub_menu
    if @menu_answer == 1
      puts "To create a station, type 1"
      puts "To create a route, type 2"
      puts "To create a train, type 3"
      puts "----------------"
    elsif @menu_answer == 2
      puts "To add a station to the route, type 4"
      puts "To remove a station from the route, type 5"
      puts "To add a route to the train, type 6"
      puts "To add a carriage to the the train, type 7"
      puts "To detach a carriage from the train, type 8"
      puts "To move a train one station forward, type 9"
      puts "To move a train one station backward, type 10"
      puts "----------------"
    elsif @menu_answer == 3
      puts "To see a list of all stations, type 11"
      puts "To see a list of trains at the station, type 12"
      puts "----------------"
    end
  end

  def sub_menu_answer
    @sub_menu_answer = gets.chomp.to_i
  end

  def new_station
    print "Enter a station name: "
    name = gets.chomp

    @all_stations << Station.new(name)
  rescue Exception => e
    puts e.message
    retry
  end

  def see_all_stations
    if @all_stations.any?
      @all_stations.each { |station| puts station.station_name}
    else
      puts "Error"
    end
  end

  def new_route
    print "Enter the first station name: "
    first = gets.chomp

    print "Enter the last station name: "
    last = gets.chomp

    route = Route.new(first, last)
    
    @all_routes << route
    @all_stations.push(route.starting_station, route.end_station)
  end

  def add_route_station
    if @all_stations.any? && @all_routes.any?
      print "Enter the station name: "
      station_name = gets.chomp
      
      print "Enter the first route station: "
      first_station = gets.chomp

      print "Enter the last route station: "
      last_station = gets.chomp

      station = self.get_station(station_name)
      route = self.get_route(first_station, last_station)

      route.add_station(station)
    else
      puts "Error"
    end
  end

  def remove_route_station
    if @all_routes.any?
      print "Enter the station name: "
      station_name = gets.chomp
      
      print "Enter the first route station: "
      first_station = gets.chomp

      print "Enter the last route station: "
      last_station = gets.chomp

      station = self.get_station(station_name)
      route = self.get_route(first_station, last_station)
      
      route.remove_station(station) if route.stations.include?(station)
    else
      puts "Error"
    end
  end

  def display_station_trains
    print "Enter the station name: "
    name = gets.chomp

    station = self.get_station(name)
    station.station_trains.each do |train|
      puts train.number
    end
  end

  def new_train
    print "Enter the train type ('cargo' or 'passenger'): "
    type = gets.chomp.downcase

    print "Enter a train number: "
    number = gets.chomp
    if type == "cargo"
      @all_trains << CargoTrain.new(number)
    elsif type == "passenger"
      @all_trains << PassengerTrain.new(number)
    end
  end

  def set_train_route
    if @all_trains.any? && @all_routes.any?
      print "Enter the train number: "
      number = gets.chomp

      print "Enter the first route station: "
      first_station = gets.chomp

      print "Enter the last route station: "
      last_station = gets.chomp

      train = self.get_train(number)
      route = self.get_route(first_station, last_station)

      train.set_route(route)
    else
      puts "Error"
    end
  end

  def add_carriage
    print "Enter the train number: "
    number = gets.chomp

    train = get_train(number)
    
    if @all_trains.include?(train)
      if train.type == "cargo"
        carriage = CargoCarriage.new
      elsif train.type == "passenger"
        carriage = PassengerCarriage.new
      end
      train.add_carriage(carriage)
    else
      puts "Error"
    end
  end

  def remove_carriage
    print "Enter the train number: "
    number = gets.chomp

    train = get_train(number)

    if @all_trains.include?(train)
      train.remove_carriage
    else
      puts "Error"
    end
  end

  def move_train_forward
    print "Enter a train number: "
    number = gets.chomp

    train = get_train(number)

    if @all_trains.include?(train)
      train.move_forward
    else
      puts "Error"
    end
  end

  def move_train_backward
    print "Enter a train number: "
    number = gets.chomp

    train = get_train(number)

    if @all_trains.include?(train)
      train.move_backward
    else
      puts "Error"
    end
  end

  def get_station(name)
    @all_stations.find { |station| station.station_name == name}
  end

  def get_route(first_station, last_station)
    @all_routes.find do |route|
      route.stations.first.station_name == first_station && route.stations.last.station_name == last_station
    end
  end

  def get_train(number)
    @all_trains.find { |train| train.number == number}
  end
end