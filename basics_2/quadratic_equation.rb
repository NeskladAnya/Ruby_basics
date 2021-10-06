puts "Введите коофициент a."
a = gets.to_f
puts "a = #{a}"

puts "Введите коофициент b."
b = gets.to_f
puts "b = #{b}"

puts "Введите коофициент c."
c = gets.to_f
puts "c = #{c}"

D = b**2 - 4 * a * c

if D < 0
  puts "Дискриминант равен #{D}. Корней нет."
elsif D > 0
  x1 = (-b + Math.sqrt(D)) / (2 * a)
  x2 = (-b - Math.sqrt(D)) / (2 * a)
  puts "Дискриминант равен #{D}. Корни: x1 = #{x1}, x2 = #{x2}."
else
  x1 = -b / (2 * a)
  puts "Дискриминант равен #{D}. Корни: x1 = x2 = #{x1}."
end
