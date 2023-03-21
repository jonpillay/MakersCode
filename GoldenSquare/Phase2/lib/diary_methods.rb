def make_snippet(text)
  # split needs improvement for special characters 
  words = text.split(/\W+/)
  if words.length <= 5
    return text
  else
    return "#{words[0..4].join(" ")}..."
  end
end

def count_words(text)
  if text.length == 0
    return 0
  else
    words = text.split(/\W+/)
    return words.length
  end
end

def calculate_reading_time(text, wpm=200)
  word_count = text.split(/\W+/).length
  minutes = (word_count/wpm.to_f).ceil
  return minutes
end

def check_grammar(text)
  # Check if text begins with capital and ends with sentence ending grammar
  if text[0] !~ /[A-Z]/ || text[-1] !~ /[.?!]/
    return false
  end
  
  # Check if the rest of the text matches up (numbers of ends folled by whitespace are matched with capitals)
  if text.scan(/\w[.?!]\s/).size == text.scan(/\w[.?!]\s[A-Z]/).size
    return true
  else
    return false
  end
end

def check_grammar_single(text)
  if text[0] =~ /[A-Z]/ && text[-1] =~ /[.?!]/
    return true
  else
    return false
  end
end

def check_todo(text)
  text.include?('#TODO')
end

#CLASS TESTING

class DiaryEntry
  def initialize(title, contents) # title, contents are strings
    @title = title
    @contents = contents
    @reading_pos = 0
  end

  def title
    @title
  end

  def contents
    @contents
  end

  def count_words_diary_entry
    count_words(self.contents)
  end

  def reading_time(text, wpm) # wpm is an integer representing the number of words the
                        # user can read per minute
    # Returns an integer representing an estimate of the reading time in minutes
    # for the contents at the given wpm.
    calculate_reading_time(text, wpm)
  end

  def reading_chunk(wpm, minutes) # `wpm` is an integer representing the number
                                  # of words the user can read per minute
                                  # `minutes` is an integer representing the
                                  # number of minutes the user has to read
    # Returns a string with a chunk of the contents that the user could read
    # in the given number of minutes.
    # If called again, `reading_chunk` should return the next chunk, skipping
    # what has already been read, until the contents is fully read.
    # The next call after that it should restart from the beginning.
    readable = wpm * minutes
    word_list = @contents.split(' ')
    if readable >= word_list.length - @reading_pos
      start = @reading_pos
      @reading_pos = 0
      return word_list[start..-1].join(' ')
    else
      start = @reading_pos
      @reading_pos += readable
      return word_list[start...start+readable].join(' ')
    end
  end
end

=begin

Tests for reading_chuck

entry = DiaryEntry.new("Gray Monday", "Still Monday, still gray! " * 1000)
puts entry.count_words_diary_entry
puts entry.reading_chunk(399, 10).length
puts entry.reading_chunk(400, 20).length
puts entry.reading_chunk(399, 10).length


entry = DiaryEntry.new("Gray Monday", "Still Monday, still gray! " * 25)

puts entry.count_words_diary_entry

puts entry.reading_chunk(40, 1).split(' ').length
puts entry.reading_chunk(40, 1).split(' ').length
puts entry.reading_chunk(40, 1).split(' ').length

=end

class GrammarStats
  def initialize
    @checked = 0
    @good = 0
  end

  def get_checked
    @checked
  end

  def get_good
    @good
  end

  def check(text) # text is a string
    # Returns true or false depending on whether the text begins with a capital
    # letter and ends with a sentence-ending punctuation mark.
    # my original check_grammar was designed to check texts one sentence or longer
    # I have written a simplified version for this situation (the longer version would have...
    # worked but seems cumbersome for application)

    if text.length == 0
      return nil
    end
    
    @checked += 1

    if check_grammar_single(text)
      @good += 1
      return true
    else
      return false
    end
  end

  def percentage_good
    # Returns as an integer the percentage of texts checked so far that passed
    # the check defined in the `check` method. The number 55 represents 55%.
    # used floor instead of ceil for harsher marking
    ((@good/@checked.to_f) * 100).floor
  end
end

=begin

grammar_checker = GrammarStats.new
grammar_checker.check("This is a bad sentance")
grammar_checker.check("This is a good sentance!")
grammar_checker.check("This is a bad sentance3")
grammar_checker.check("This is a good sentance!")

puts grammar_checker.percentage_good

=end