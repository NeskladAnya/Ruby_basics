arr = []
arr.push(0, 1)

arr.each do |n|
  f = n + arr.last
  break if f > 100
  arr.push(f)
end

puts arr