goods = Hash.new

loop do
  puts "Введите название товара:"
  item = gets.chomp.downcase

  break if item == "стоп"
  
  puts "Введите цену за единицу товара:"
  price = gets.chomp.to_f

  puts "Введите количество единиц товара:"
  quantity = gets.chomp.to_f

  goods[item] = { price: price, quantity: quantity}
end

total_price = 0

goods.each do |key, value|
  item_price = value[:price] * value[:quantity]
  total_price += item_price

  puts "Товар: #{key}. Цена за единицу: #{value[:price]}, количество: #{value[:quantity]}"
  puts "Стоимость товара: #{item_price}"
end

puts "Стоимость всех товаров: #{total_price}"