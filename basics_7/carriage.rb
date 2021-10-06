class Carriage
  include Manufacturer

  attr_reader :type
  
  def initialize
    self.type
  end
end