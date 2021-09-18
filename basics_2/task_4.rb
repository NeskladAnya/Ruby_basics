letters = {}
vowels = ["a", "e", "i", "o", "u"]

count = 0

for letter in ("a".."z").to_a
  count += 1
  if vowels.include? letter
    letters[letter] = count
  end
end