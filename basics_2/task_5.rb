months = {
  "1" => 31,
  "2" => 28,
  "3" => 31,
  "4" => 30,
  "5" => 31,
  "6" => 30,
  "7" => 31,
  "8" => 31,
  "9" => 30,
  "10" => 31,
  "11" => 30,
  "12" => 31
}

count = 0

puts "Insert a year"
year = gets.to_i

puts "Insert a month number"
month = gets.to_i

puts "Insert a day"
day = gets.to_i

leap_year = year if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0

if year != leap_year && month == 2 && day == 29
  puts "Sorry, year #{year} is not a leap year."

else
  months["2"] = 29 if year == leap_year

  months.each do |m, d|
    case
    when m.to_i < month then count += d
    when m.to_i == month then count += day
    end
  end
end

puts count
