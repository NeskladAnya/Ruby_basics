class Menu
  attr_reader :menu_answer
  
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
end