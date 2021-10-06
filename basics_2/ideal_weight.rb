puts "What's your name?"
name = gets.chomp

puts "What's your height in cm?"
height = gets.chomp.to_i

ideal_weight = (height - 110) * 1.15

if ideal_weight < 0
  puts "Hi, #{name}! Your weight is ideal!"
else
  puts "Hi, #{name}! Your ideal weight is #{ideal_weight.to_i} kg!"
end