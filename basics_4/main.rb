require_relative 'menu'
require_relative 'interface'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'

@interface = Interface.new
@menu = Menu.new

loop do
  @menu.menu

  if @menu.menu_answer == 0
    break
  else
    @menu.sub_menu
    answer = @menu.sub_menu_answer
  end

  case answer
  when 1
    @interface.new_station
  when 2
    @interface.new_route
  when 3
    @interface.new_train
  when 4
    @interface.add_route_station
  when 5
    @interface.remove_route_station
  when 6
    @interface.set_train_route
  when 7
    @interface.add_carriage
  when 8
    @interface.remove_carriage
  when 9
    @interface.move_train_forward
  when 10
    @interface.move_train_backward
  when 11
    @interface.see_all_stations
  when 12
    @interface.display_station_trains
  else
    puts "Error"
  end
end