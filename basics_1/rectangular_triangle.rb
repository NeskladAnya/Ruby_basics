puts "Введите три стороны треугольника."

a = gets
puts "a = #{a}"

b = gets
puts "b = #{b}"

c = gets
puts "c = #{c}"

sides = [a, b, c].sort!
sides.map! {|s| s.to_f}

if sides[0]**2 + sides[1]**2 == sides[2]**2 && sides[0] == sides[1]
    puts "Треугольник прямоугольный и равнобедренный."
elsif sides[0]**2 + sides[1]**2 == sides[2]**2
    puts "Треугольник прямоугольный."
elsif sides[0] == sides[1] && sides[0] == sides[2]
    puts "Треугольник равносторонний."
elsif sides[0] == sides[1] || sides[0] == sides[2] || sides[1] == sides[2]
    puts "Треугольник равнобедренный."
else
    puts "Треугольник разносторонний."
end