def say_hello(name)
  return "hello #{name}"
end

# Intended output:
#
# > say_hello("kay")
# => "hello kay"

#puts say_hello("kay")

def factorial(n)
  product = n
  p "at the start product is #{product}"
  while n > 1
    n -= 1
    p "we multiply #{product} by #{n}"
    product *= n
    p "we get #{product}"
  end
  product
end

#puts factorial(12)

#below is the first attempt to debug the encode/decode methods. The completed script is below the comment block.
#keeping for historical value

=begin

def encode(plaintext, key)
  cipher = key.chars.uniq + (('a'..'z').to_a - key.chars)
  p cipher
  ciphertext_chars = plaintext.chars.map do |char|
    #puts char
    #puts cipher[(65 + plaintext.chars.find_index(char)) % 26 ]
    #cipher[65 - char.chr]
    puts cipher.find_index(char)
    #puts ((65 + cipher.find_index(char)) % 26)
  end
  return ciphertext_chars.join
end

def decode(ciphertext, key)
  cipher = key.chars.uniq + (('a'...'z').to_a - key.chars)
  plaintext_chars = ciphertext.chars.map do |char|
    cipher[65 - char.ord]
  end
  return plaintext_chars.join
end

# Intended output:
#
# > encode("theswiftfoxjumpedoverthelazydog", "secretkey")
# => "EMBAXNKEKSYOVQTBJSWBDEMBPHZGJSL"
#
# > decode("EMBAXNKEKSYOVQTBJSWBDEMBPHZGJSL", "secretkey")
# => "theswiftfoxjumpedoverthelazydog"

puts encode("theswiftfoxjumpedoverthelazydog", "secretkey")

#puts decode("EMBAXNKEKSYOVQTBJSWBDEMBPHZGJSL", "secretkey")

=end

def encode(plaintext, key)
  cipher = key.chars.uniq + (('a'..'z').to_a - key.chars)
  ciphertext_chars = plaintext.chars.map do |char|
    (65 + cipher.find_index(char)).chr
  end
  return ciphertext_chars.join
end

def decode(ciphertext, key)
  cipher = key.chars.uniq + (('a'..'z').to_a - key.chars)
  plaintext_chars = ciphertext.chars.map do |char|
    #puts char
    #puts char.ord
    cipher[char.ord - 65]
  end
  return plaintext_chars.join
end

# Intended output:
#
# > encode("theswiftfoxjumpedoverthelazydog", "secretkey")
# => "EMBAXNKEKSYOVQTBJSWBDEMBPHZGJSL"
#
# > decode("EMBAXNKEKSYOVQTBJSWBDEMBPHZGJSL", "secretkey")
# => "theswiftfoxjumpedoverthelazydog"

#puts encode("theswiftfoxjumpedoverthelazydog", "secretkey")

#puts decode("EMBAXNKEKSYOVQTBJSWBDEMBPHZGJSL", "secretkey")

def get_most_common_letter(text)
  counter = Hash.new(0)
  text.gsub!(/\W/, '')
  text.chars.each do |char|
    counter[char] += 1
  end
  counter.to_a.sort_by { |k, v| -v }[0][0]
end

# Intended output:
# 
# > get_most_common_letter("the roof, the roof, the roof is on fire!")
# => "o"

#puts get_most_common_letter("the roof, the roof, the roof is on fire!")