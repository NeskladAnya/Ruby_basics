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
        self.use_capacity
      when 10
        self.move_train_forward
      when 11
        self.move_train_backward
      when 12
        self.see_all_stations
      when 13
        self.display_station_trains
      when 14
        self.display_train_carriages
      else
        puts "Error"
      end
    end
  end

  protected
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
      puts "To take a seat or use train capacity, type 9"
      puts "To move a train one station forward, type 10"
      puts "To move a train one station backward, type 11"
      puts "----------------"
    elsif @menu_answer == 3
      puts "To see a list of all stations, type 12"
      puts "To see a list of trains at the station, type 13"
      puts "To see a train carriages, type 14"
      puts "----------------"
    end
  end

  def sub_menu_answer
    @sub_menu_answer = gets.chomp.to_i
  end

#Answers 1-3
  def new_station
    print "Enter a station name: "
    name = gets.chomp

    @all_stations << Station.new(name)
    puts "A station #{name} was created"
  rescue Exception => e
    puts e.message
    retry
  end

  def new_route
    print "Enter the first station name: "
    first = gets.chomp

    print "Enter the last station name: "
    last = gets.chomp

    route = Route.new(first, last)
    
    @all_routes << route
    @all_stations.push(route.starting_station, route.end_station)
    puts "A new route #{first} - #{last} was created"
  rescue Exception => e
    puts e.message
    retry
  end

  def new_train
    print "Enter a train number: "
    number = gets.chomp

    print "Enter the train type ('cargo' or 'passenger'): "
    type = gets.chomp.downcase

    if type == "cargo"
      @all_trains << CargoTrain.new(number)
    elsif type == "passenger"
      @all_trains << PassengerTrain.new(number)
    else
      raise "Incorrect train type"
    end
    puts "A #{type} train number #{number} was created"
  rescue Exception => e
    puts e.message
    retry
  end

#Answers 4-11
  def add_route_station
    raise "No stations found" if @all_stations.empty?
    raise "No routes found" if @all_routes.empty?

    print "Enter the station name: "
    station_name = gets.chomp
      
    print "Enter the first route station: "
    first_station = gets.chomp

    print "Enter the last route station: "
    last_station = gets.chomp

    station = self.get_station(station_name)
    raise "No station found" if station.nil?

    route = self.get_route(first_station, last_station)
    raise "No route found" if route.nil?

    route.add_station(station)
    puts "Station #{station_name} was added to the route #{first_station} - #{last_station}."
  rescue Exception => e
    puts e.message
  end

  def remove_route_station
    raise "No routes found" if @all_routes.empty?

    print "Enter the station name: "
    station_name = gets.chomp
    
    print "Enter the first route station: "
    first_station = gets.chomp

    print "Enter the last route station: "
    last_station = gets.chomp

    station = self.get_station(station_name)
    raise "No station found" if station.nil?

    route = self.get_route(first_station, last_station)
    raise "No route found" if route.nil?
    
    route.remove_station(station)
  rescue Exception => e
    puts e.message
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

    raise "No train found" unless @all_trains.include?(train)
    
    if train.type == "cargo"
      print "Enter the carriage capacity: "
      capacity = gets.chomp.to_i

      carriage = CargoCarriage.new(capacity)
    elsif train.type == "passenger"
      print "Enter the number of seats: "
      seats = gets.chomp.to_i

      carriage = PassengerCarriage.new(seats)
    end

    puts "A new carriage was added to the train"
    train.add_carriage(carriage)
  rescue Exception => e
    puts e.message
  end

  def remove_carriage
    print "Enter the train number: "
    number = gets.chomp

    train = get_train(number)

    raise "No train found" unless @all_trains.include?(train)
    raise "The train doesn't have a carriage" if train.carriages.nil?

    train.remove_carriage
  rescue Exception => e
    puts e.message
  end

  def use_capacity
    print "Enter a train number: "
    number = gets.chomp

    train = get_train(number)

    raise "No train found" unless @all_trains.include?(train)
    raise "The train should have at least one carriage" if train.carriages.empty?

    puts "Total number of carriages: #{train.carriages.count}"

    print "Enter the carriage number: "
    carriage_number = gets.chomp.to_i

    carriage = train.carriages[carriage_number-1]

    if carriage.type == "passenger"
      carriage.use_capacity
    elsif carriage.type == "cargo"
      print "Enter the capacity: "
      capacity = gets.chomp.to_i

      carriage.use_capacity(capacity)
    end
  rescue Exception => e
    puts e.message
  end

  def move_train_forward
    print "Enter a train number: "
    number = gets.chomp

    train = get_train(number)

    raise "No train found" unless @all_trains.include?(train)
    raise "The train doesn't have a route" if train.route.nil?

    train.move_forward
  rescue Exception => e
    puts e.message
  end

  def move_train_backward
    print "Enter a train number: "
    number = gets.chomp

    train = get_train(number)

    raise "No train found" unless @all_trains.include?(train)
    raise "The train doesn't have a route" if train.route.nil?

    train.move_backward
  rescue Exception => e
    puts e.message
  end

#Answers 12-14
  def see_all_stations
    raise "No stations found" if @all_stations.empty?
    @all_stations.each { |station| puts station.station_name}
  rescue Exception => e
      puts e.message
  end

  def display_station_trains
    print "Enter the staion name: "
    name = gets.chomp

    station = self.get_station(name)

    raise "No station found" if station.nil?

    station.trains_info
  rescue Exception => e
    puts e.message
  end

  def display_train_carriages
    print "Enter the train number: "
    number = gets.chomp

    train = self.get_train(number)

    raise "No train found" unless @all_trains.include?(train)

    train.carriage_info
  rescue Exception => e
    puts e.message
  end

  def get_station(name)
    @all_stations.find { |station| station.station_name == name }
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