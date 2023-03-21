require 'diary_methods'

RSpec.describe "make_snippet" do
  it "given an empty string, return an empty string" do
    result = make_snippet('')
    expect(result).to eq ''
  end
  it "given a string of 4 words, return those 4 words" do
    result = make_snippet('tree car house park')
    expect(result).to eq 'tree car house park'
  end
  it "given a string of 6 words, return 5 words followed by a '...'" do
    result = make_snippet('tree car house park dog tennis')
    expect(result).to eq "tree car house park dog..."
  end
  it "given a string of 6 words, return 5 words followed by a '...' (words seperated by non white space)" do
    result = make_snippet('tree,car,house,park,dog,tennis')
    expect(result).to eq "tree car house park dog..."
  end
end

RSpec.describe "count_words" do
  it "given an empty string, returns 0" do
    result = count_words('')
    expect(result).to eq 0
  end
  it "given a string of 7 words, returns 7" do
    result = count_words('tree house car foo park bar honey')
    expect(result).to eq 7
  end
  it "given a string of 7 words, returns 7 (words seperated by non white space)" do
    result = count_words('tree,house*car-foo)park>bar|honey')
    expect(result).to eq 7
  end
end

RSpec.describe "calculate_reading_time" do
  it "given an empty string, returns 0" do
    result = calculate_reading_time('')
    expect(result).to eq 0
  end
  it "given a string 100 words long, returns 1 (test rounding)" do
    result = calculate_reading_time('foo ' * 100)
    expect(result).to eq 1
  end
  it "given a string 200 words long, returns 1" do
    result = calculate_reading_time('foo ' * 200)
    expect(result).to eq 1
  end
  it "given a string 201 words long, returns 2 (test rounding and math accuracy)" do
    result = calculate_reading_time('foo ' * 201)
    expect(result).to eq 2
  end
  it "given a string 2000 words long, returns 10" do
    result = calculate_reading_time('foo ' * 2000)
    expect(result).to eq 10
  end
  it "given a string 200,001 words long, returns 1001" do
    result = calculate_reading_time('foo ' * 200001)
    expect(result).to eq 1001
  end
end

RSpec.describe "check_grammar" do
  it "given an empty string, returns false" do
    result = check_grammar('')
    expect(result).to eq false
  end
  it "given an bad string, returns false" do
    result = check_grammar("this is not how you write a sentencE")
    expect(result).to eq false
  end
  it "given an good string, returns true" do
    result = check_grammar("This is how you write a sentence.")
    expect(result).to eq true
  end
  it "test on a good sentance with hightlighted capitals within" do
    result = check_grammar("This is how you WRITE a sentence.")
    expect(result).to eq true
  end
  it "test on a good sentance with an ellipsis within" do
    result = check_grammar("This is how you write... a sentence.")
    expect(result).to eq true
  end
end

RSpec.describe "check_todo" do
  it "given an empty string, returns false" do
    result = check_todo('')
    expect(result).to eq false
  end
  it "given an false string, returns false" do
    result = check_todo('Time for the park')
    expect(result).to eq false
  end
  it "given an true string, returns true" do
    result = check_todo('I have things #TODO today')
    expect(result).to eq true
  end
  it "given an false string containing 'to do', returns false" do
    result = check_todo('I have things to do today')
    expect(result).to eq false
  end
end

RSpec.describe DiaryEntry do
  it "returns title" do
    entry = DiaryEntry.new("Gray Monday", "Still Monday, still gray!")
    result = entry.title
    expect(result).to eq "Gray Monday"
  end
  it "returns contents" do
    entry = DiaryEntry.new("Gray Monday", "Still Monday, still gray!")
    result = entry.contents
    expect(result).to eq "Still Monday, still gray!"
  end
  it "returns the amount of words" do
    entry = DiaryEntry.new("Gray Monday", "Still Monday, still gray!")
    result = entry.count_words_diary_entry()
    expect(result).to eq 4
  end
  it "returns the amount of words (times 100)" do
    entry = DiaryEntry.new("Gray Monday", "Still Monday, still gray! " * 100)
    result = entry.count_words_diary_entry()
    expect(result).to eq 400
  end
  it "returns 1 minute reading time for a short passage" do
    entry = DiaryEntry.new("Gray Monday", "Still Monday, still gray! ")
    result = entry.reading_time(entry.contents, 200)
    expect(result).to eq 1
  end
  it "returns 1 minute reading time for a longer passage" do
    entry = DiaryEntry.new("Gray Monday", "Still Monday, still gray! " * 50)
    result = entry.reading_time(entry.contents, 200)
    expect(result).to eq 1
  end
  it "returns 2 minutes reading time for a slightly longer passage" do
    entry = DiaryEntry.new("Gray Monday", "Still Monday, still gray! " * 50 + "foo")
    result = entry.reading_time(entry.contents, 200)
    expect(result).to eq 2
  end
  it "returns 20 minutes reading time for a long passage" do
    entry = DiaryEntry.new("Gray Monday", "Still Monday, still gray! " * 1000)
    result = entry.reading_time(entry.contents, 200)
    expect(result).to eq 20
  end
  it "returns 20 minutes reading time for a long passage" do
    entry = DiaryEntry.new("Gray Monday", "Still Monday, still gray! " * 1000 + "bar")
    result = entry.reading_time(entry.contents, 200)
    expect(result).to eq 21
  end
  it "returns 40 minutes reading time for a long passage and slower reading speed" do
    entry = DiaryEntry.new("Gray Monday", "Still Monday, still gray! " * 1000)
    result = entry.reading_time(entry.contents, 100)
    expect(result).to eq 40
  end
  it "repeated calls read through the contents and then roll back to the start. Should be 4, 4, 3 on rotation" do
    entry = DiaryEntry.new("Gray Monday", "Still Monday, still gray! But we are still here on Tuesday.")
    result = entry.reading_chunk(4, 1)
    expect(result).to eq "Still Monday, still gray!"
    result2 = entry.reading_chunk(4, 1)
    expect(result2).to eq "But we are still"
    result3 = entry.reading_chunk(4, 1)
    expect(result3).to eq "here on Tuesday."
    result4 = entry.reading_chunk(4, 1)
    expect(result4).to eq "Still Monday, still gray!"
  end
  it "returns the first 40 words of entry" do
    entry = DiaryEntry.new("Gray Monday", "Still Monday, still gray! " * 1000)
    result = entry.reading_chunk(40, 1).split(' ').length
    expect(result).to eq 40
  end
  it "returns the first 80 words of entry (same wpm, double time)" do
    entry = DiaryEntry.new("Gray Monday", "Still Monday, still gray! " * 1000)
    result = entry.reading_chunk(40, 2).split(' ').length
    expect(result).to eq 80
  end
end

RSpec.describe GrammarStats do
  it "returns nil on an empty string and does not count" do
    grammar_checker = GrammarStats.new
    result = grammar_checker.check("")
    expect(result).to eq nil
    result2 = grammar_checker.get_checked
    expect(result2).to eq 0
  end
  it "return false and does not count on a bad string" do
    grammar_checker = GrammarStats.new
    result = grammar_checker.check("This is a bad sentencE")
    expect(result).to eq false
    result2 = grammar_checker.get_good
    expect(result2).to eq 0
  end
  it "return true and counts on a good string" do
    grammar_checker = GrammarStats.new
    result = grammar_checker.check("This is a good sentence.")
    expect(result).to eq true
    result2 = grammar_checker.get_good
    expect(result2).to eq 1
  end
  it "returns 50 (percent) on half good and half bad strings" do
    grammar_checker = GrammarStats.new
    grammar_checker.check("This is a bad sentance")
    grammar_checker.check("This is a good sentance!")
    grammar_checker.check("This is a bad sentance3")
    grammar_checker.check("This is a good sentance!")
    result = grammar_checker.percentage_good
    expect(result).to eq 50
  end
  it "returns 25 (percent) on one good and rest bad strings" do
    grammar_checker = GrammarStats.new
    grammar_checker.check("This is a bad sentance")
    grammar_checker.check("This is a good sentanceQ")
    grammar_checker.check("This is a bad sentance3")
    grammar_checker.check("This is a good sentance!")
    result = grammar_checker.percentage_good
    expect(result).to eq 25
  end
  it "returns 33 (percent) on one good and two bad strings (checking rounding)" do
    grammar_checker = GrammarStats.new
    grammar_checker.check("This is a bad sentance")
    grammar_checker.check("This is a bad sentance3")
    grammar_checker.check("This is a good sentance!")
    result = grammar_checker.percentage_good
    expect(result).to eq 33
  end
  it "returns 66 (percent) on one good and two bad strings (checking rounding)" do
    grammar_checker = GrammarStats.new
    grammar_checker.check("This is a bad sentance")
    grammar_checker.check("This is a good sentance.")
    grammar_checker.check("This is a good sentance!")
    result = grammar_checker.percentage_good
    expect(result).to eq 66
  end
end