require_relative 'station'
require_relative 'route'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'menu'
require_relative 'interface'

@menu = Menu.new
@interface = Interface.new

loop do
  @menu.menu
  @menu.set_option

  case @menu.option
  when 1
    @interface.new_station
  when 2
    @interface.see_all_stations
  when 3
    @interface.add_station
  when 6
    @interface.new_route
  when 9
    @interface.new_train
  else
    puts "Hi"
  end

=begin
class Main < Menu
  attr_reader :menu

  def initialize
    @menu = Menu.new
    @stations = []
    @routes = []
    @trains = []
  end

  def new_station
    puts "Enter a station name"
    name = gets.chomp
    @stations << Station.new(name)
    puts @stations
  end

  def all_stations
    @stations.each { |station| puts station}
  end

  loop do
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