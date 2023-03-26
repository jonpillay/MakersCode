# File: letter_counter.rb

class LetterCounter
  def initialize(text)
    @text = text
  end

  def calculate_most_common()
    # Lowered the Hash default value down to 0, starting from 1 was inflating the final results (returned the right letter, wrong count)
    counter = Hash.new(0)
    most_common = nil
    most_common_count = 1
    @text.chars.each do |char|
      next unless is_letter?(char)
      counter[char] = (counter[char] || 1) + 1
      # > could be changed to >= - would mean if later characters were found in the string that == most_common would replace.
      # At the moment it has to be greater than. 
      if counter[char] > most_common_count
        most_common = char
        # removed the + operater below, it was accumalating all the most_common counts rather than swapping them out.
        most_common_count = counter[char]
      end
    end
    return [most_common_count, most_common]
  end

  private

  def is_letter?(letter)
    return letter =~ /[a-z]/i
  end
end

counter = LetterCounter.new("Digital Punk")
p counter.calculate_most_common

# Intended output:
# [2, "i"]