class Interface
  attr_reader :all_stations, :all_routes, :all_trains, :selected_station

  def initialize
    @all_stations = []
    @all_routes = []
    @all_trains = []
  end
  def new_station
    print "Enter a station name: "
    name = gets.chomp

    @all_stations << Station.new(name)
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
    number = gets.chomp.to_i
    if type == "cargo"
      @all_trains << CargoTrain.new(number)
    elsif type == "passenger"
      @all_trains << PassengerTrain.new(number)
    end
  end

  def set_train_route
    if @all_trains.any? && @all_routes.any?
      print "Enter the train number: "
      number = gets.chomp.to_i

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
    number = gets.chomp.to_i

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
    number = gets.chomp.to_i

    train = get_train(number)

    if @all_trains.include?(train)
      train.remove_carriage
    else
      puts "Error"
    end
  end

  def move_train_forward
    print "Enter a train number: "
    number = gets.chomp.to_i

    train = get_train(number)

    if @all_trains.include?(train)
      train.move_forward
    else
      puts "Error"
    end
  end

  def move_train_backward
    print "Enter a train number: "
    number = gets.chomp.to_i

    train = get_train(number)

    if @all_trains.include?(train)
      train.move_backward
    else
      puts "Error"
    end
  end

  protected
  #Данные методы используются только другими методами в рамках класса.
  #Нет необходимости делать их публичными.

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