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

RSpec.describe StringBuilder do
  it "returns 0 when counting an empty string" do
    string = StringBuilder.new
    result = string.size
    expect(result).to eq 0
  end
  it "returns 'foo' when added via 'add' method" do
    string = StringBuilder.new
    string.add('foo')
    result = string.output
    expect(result).to eq 'foo'
  end
  it "returns 3 when 'foo' is counted" do
    string = StringBuilder.new
    string.add('foo')
    result = string.size
    expect(result).to eq 3
  end
  it "returns 6 when 'foobar' is counted" do
    string = StringBuilder.new
    string.add('foobar')
    result = string.size
    expect(result).to eq 6
  end
end

RSpec.describe Gratitudes do
  it "return formatted gratitudes even when the list is empty (also checks for proper initialisation)" do
    grats = Gratitudes.new
    result = grats.format
    expect(result).to eq "Be grateful for: "
  end
  it "return formatted gratitudes when a single gratitude added" do
    grats = Gratitudes.new
    grats.add('foo')
    result = grats.format
    expect(result).to eq "Be grateful for: foo"
  end
end

#ERROR CHECKING

RSpec.describe Present do
  context "when there is no centents to wrap 'contents has already been wrapped'" do
    it "fails" do
      present = Present.new()
      present.wrap("bear")
      expect { present.wrap("glue") }.to raise_error "A contents has already been wrapped."
    end
  end
  context "when there is no centents to unwrap 'contents has already been unwrapped'" do
    it "fails" do
      present = Present.new()
      expect { present.unwrap() }.to raise_error "No contents have been wrapped."
    end
  end
  context "when contents are sucessfully wrapped" do
    it "succeeds" do 
      present = Present.new 
      expect(present.wrap("blabla")).to eq "blabla"
    end
  end
end

RSpec.describe PasswordChecker do
  context "when password is too short, throw error message" do
    it "fails" do
      password = "passwor"
      checker = PasswordChecker.new
      expect { checker.check(password) }.to raise_error "Invalid password, must be 8+ characters."
    end
  end
  context "when user sucessefuly log in" do
    it "succeds " do
      password = "password"
      checker = PasswordChecker.new
      expect(checker.check(password)).to eq true
    end
  end
end