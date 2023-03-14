require 'equality'

#EXAMPLE OF PROCEDURAL METHODS TESTS

RSpec.describe "add_five method" do
  it "adds 5 to 3 to return 8" do
    result = add_five(3)
    expect(result).to eq 8
  end
end

#MYWORK

RSpec.describe "greet method" do
  it "should greet 'Paul'" do
    result = greet('Paul')
    expect(result).to eq "Hello, Paul!"
  end
end

RSpec.describe "check_codeword method" do
  it "should return 'Correct! Come in.'" do
    result = check_codeword('horse')
    expect(result).to eq "Correct! Come in."
  end
  it "should return 'Close, but nope.'" do
    result = check_codeword('hire')
    expect(result).to eq "Close, but nope."
  end
  it "should return 'WRONG!'" do
    result = check_codeword('foo')
    expect(result).to eq "WRONG!"
  end
end

RSpec.describe "report_length method" do
  it "returns the length of a given string" do
    result = report_length('foo')
    expect(result).to eq "This string was 3 characters long."
  end
end

#EXAMPLE OF CLASS TESTS

RSpec.describe Reminder do
  it "reminds the user to do a task" do
    reminder = Reminder.new("Kay")
    reminder.remind_me_to("Walk the dog")
    result = reminder.remind()
    expect(result).to eq "Walk the dog, Kay!"
  end
# We would typically have a number of these examples.
end

#MYWORK

RSpec.describe Counter do
  it "counts and reports number" do
    counter = Counter.new
    counter.add(1)
    result = counter.report()
    expect(result).to eq "Counted to 1 so far."
  end
end