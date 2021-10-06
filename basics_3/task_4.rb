letters = {}
vowels = ["a", "e", "i", "o", "u"]

count = 0

for letter in ("a".."z").to_a
  count += 1
  letters[letter] = count if vowels.include? letter
end