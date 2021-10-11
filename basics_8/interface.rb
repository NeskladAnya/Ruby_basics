class Interface
  attr_reader :all_stations, :all_routes, :all_trains, :selected_station, :menu_answer

  def initialize
    @all_stations = []
    @all_routes = []
    @all_trains = []
  end

  ANSWERS = {
    1 => :new_station, 2 => :new_route, 3 => :new_train, 4 => :add_route_station,
    5 => :remove_route_station, 6 => :set_train_route, 7 => :add_carriage,
    8 => :remove_carriage, 9 => :use_capacity, 10 => :move_train_forward,
    11 => :move_train_backward, 12 => :see_all_stations,
    13 => :display_station_trains, 14 => :display_train_carriages
  }

  def interface_loop
    loop do
      menu
      break if @menu_answer.zero?

      sub_menu
      answer = sub_menu_answer

      send(ANSWERS[answer])
    end
  end

  protected

  def menu
    puts 'To create an object, type 1'
    puts 'To perform actions with an object, type 2'
    puts 'To see info, type 3'
    puts 'To exit, type 0'
    puts '----------------'

    @menu_answer = gets.chomp.to_i
  end

  def sub_menu
    case @menu_answer
    when 1
      puts 'To create a station, type 1'
      puts 'To create a route, type 2'
      puts 'To create a train, type 3'
      puts '----------------'
    when 2
      puts 'To add a station to the route, type 4'
      puts 'To remove a station from the route, type 5'
      puts 'To add a route to the train, type 6'
      puts 'To add a carriage to the the train, type 7'
      puts 'To detach a carriage from the train, type 8'
      puts 'To take a seat or use train capacity, type 9'
      puts 'To move a train one station forward, type 10'
      puts 'To move a train one station backward, type 11'
      puts '----------------'
    when 3
      puts 'To see a list of all stations, type 12'
      puts 'To see a list of trains at the station, type 13'
      puts 'To see a train carriages, type 14'
      puts '----------------'
    end
  end

  def sub_menu_answer
    @sub_menu_answer = gets.chomp.to_i
  end

  # Answers 1-3
  def new_station
    print 'Enter a station name: '
    name = gets.chomp

    @all_stations << Station.new(name)
    puts "A station #{name} was created"
  rescue Exception => e
    puts e.message
    retry
  end

  def new_route
    print 'Enter the first station name: '
    first = gets.chomp

    print 'Enter the last station name: '
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
    print 'Enter a train number: '
    number = gets.chomp

    print "Enter the train type ('cargo' or 'passenger'): "
    type = gets.chomp.downcase

    case type
    when 'cargo'
      @all_trains << CargoTrain.new(number)
    when 'passenger'
      @all_trains << PassengerTrain.new(number)
    else
      raise 'Incorrect train type'
    end
    puts "A #{type} train number #{number} was created"
  rescue Exception => e
    puts e.message
    retry
  end

  # Answers 4-11
  def add_route_station
    raise 'No stations found' if @all_stations.empty?
    raise 'No routes found' if @all_routes.empty?

    print 'Enter the station name: '
    station_name = gets.chomp

    print 'Enter the first route station: '
    first_station = gets.chomp

    print 'Enter the last route station: '
    last_station = gets.chomp

    station = get_station(station_name)
    raise 'No station found' if station.nil?

    route = get_route(first_station, last_station)
    raise 'No route found' if route.nil?

    route.add_station(station)
    puts "Station #{station_name} was added to the route #{first_station} - #{last_station}."
  rescue Exception => e
    puts e.message
  end

  def remove_route_station
    print 'Enter the station name: '
    station_name = gets.chomp

    station = get_station(station_name)
    raise 'No station found' if station.nil?

    print 'Enter the first route station: '
    first_station = gets.chomp

    print 'Enter the last route station: '
    last_station = gets.chomp

    route = get_route(first_station, last_station)
    raise 'No route found' if route.nil?

    route.remove_station(station)
  rescue Exception => e
    puts e.message
  end

  def set_train_route
    print 'Enter the train number: '
    number = gets.chomp

    train = get_train(number)
    raise 'No train found' if train.nil?

    print 'Enter the first route station: '
    first_station = gets.chomp

    print 'Enter the last route station: '
    last_station = gets.chomp

    route = get_route(first_station, last_station)
    raise 'No route found' if route.nil?

    train.set_route(route)
  end

  def add_carriage
    print 'Enter the train number: '
    number = gets.chomp

    train = get_train(number)
    raise 'No train found' if train.nil?

    case train.type
    when 'cargo'
      print 'Enter the carriage capacity: '
      capacity = gets.chomp.to_i

      carriage = CargoCarriage.new(capacity)
    when 'passenger'
      print 'Enter the number of seats: '
      seats = gets.chomp.to_i

      carriage = PassengerCarriage.new(seats)
    end

    puts 'A new carriage was added to the train'
    train.add_carriage(carriage)
  rescue Exception => e
    puts e.message
  end

  def remove_carriage
    print 'Enter the train number: '
    number = gets.chomp

    train = get_train(number)
    raise 'No train found' if train.nil?
    raise "The train doesn't have a carriage" if train.carriages.empty?

    train.remove_carriage
  rescue Exception => e
    puts e.message
  end

  def use_capacity
    print 'Enter a train number: '
    number = gets.chomp

    train = get_train(number)
    raise 'No train found' if train.nil?
    raise 'The train should have at least one carriage' if train.carriages.empty?

    puts "Total number of carriages: #{train.carriages.count}"

    print 'Enter the carriage number: '
    carriage_number = gets.chomp.to_i

    carriage = train.carriages[carriage_number-1]

    case carriage.type
    when 'passenger'
      carriage.use_capacity
    when 'cargo'
      print 'Enter the capacity: '
      capacity = gets.chomp.to_i

      carriage.use_capacity(capacity)
    end
  rescue Exception => e
    puts e.message
  end

  def move_train_forward
    print 'Enter a train number: '
    number = gets.chomp

    train = get_train(number)
    raise 'No train found' if train.nil?
    raise "The train doesn't have a route" if train.route.nil?

    train.move_forward
  rescue Exception => e
    puts e.message
  end

  def move_train_backward
    print 'Enter a train number: '
    number = gets.chomp

    train = get_train(number)
    raise 'No train found' if train.nil?
    raise "The train doesn't have a route" if train.route.nil?

    train.move_backward
  rescue Exception => e
    puts e.message
  end

  # Answers 12-14
  def see_all_stations
    raise 'No stations found' if @all_stations.empty?

    @all_stations.each { |station| puts station.station_name }
  rescue Exception => e
    puts e.message
  end

  def display_station_trains
    print 'Enter the staion name: '
    name = gets.chomp

    station = get_station(name)
    raise 'No station found' if station.nil?

    station.trains_info
  rescue Exception => e
    puts e.message
  end

  def display_train_carriages
    print 'Enter the train number: '
    number = gets.chomp

    train = get_train(number)
    raise 'No train found' if train.nil?

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
    @all_trains.find { |train| train.number == number }
  end
end
