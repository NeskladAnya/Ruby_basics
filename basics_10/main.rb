require_relative 'accessors'
require_relative 'instance_counter'
require_relative 'manufacturer'
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
@interface.interface_loop
