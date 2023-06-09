#EXAMPLES

def add_five(num)
    return num + 5
  end

#MYWORK

def greet(name)
    return "Hello, #{name}!"
  end

  def check_codeword(codeword)
    if codeword == "horse"
      return "Correct! Come in."
    elsif codeword.chars.first == "h" && codeword.chars.last == "e"
      return "Close, but nope."
    else
      return "WRONG!"
    end
  end

  def report_length(str)
    length = str.length
    return "This string was #{length} characters long."
  end

  #EXAMPLE OF CLASS BASED TESTS

class Reminder
def initialize(name)
    @name = name
end

def remind_me_to(task)
    @task = task
end

def remind()
    return "#{@task}, #{@name}!"
end
end

#MYWORK

class Counter
  def initialize
      @count = 0
  end

  def add(num)
      @count += num
  end

  def report
      return "Counted to #{@count} so far."
  end
end

class StringBuilder
  def initialize
      @str = ""
  end

  def add(str)
      @str += str
  end

  def size
      return @str.length
  end

  def output
      return @str
  end
end

class StringBuilder
  def initialize
    @str = ""
  end

  def add(str)
    @str += str
  end

  def size
    return @str.length
  end

  def output
    return @str
  end
end

#string = StringBuilder.new
#string = string.add('foo')
#string.output()

class Gratitudes
  def initialize
    @gratitudes = []
  end

  def add(gratitude)
    @gratitudes.push(gratitude)
  end

  def format
    formatted = "Be grateful for: "
    formatted += @gratitudes.join(", ")
    return formatted
  end
end

#ERROR CHECKING

class Present
  def wrap(contents)
    fail "A contents has already been wrapped." unless @contents.nil?
    @contents = contents
  end

  def unwrap
    fail "No contents have been wrapped." if @contents.nil?
    return @contents
  end
end

class PasswordChecker
  def check(password)
    if password.length >= 8
      return true
    else
      fail "Invalid password, must be 8+ characters."
    end
  end
end

def check_grammar(text)
  if text[0] !~ /[A-Z]/ || text[-1] !~ /[.?!]/
    puts "here"
    return false
  end
  
  if text.scan(/\w[.?!]\s/).size == text.scan(/\w[.?!]\s[A-Z]/).size
    return true
  else
    return false
  end
end

#puts check_grammar("This is how you write. blue sentence.")

#puts check_grammar("This is how you write... a sentence. But does this work?")

#puts check_grammar("This is not how you write a sentencE")

def todo_check(text)
  return text.include?('#TODO')
end

puts todo_check("Time for the park")

puts todo_check("I have somethings #TODO shopping, #TODO cleaning")

puts todo_check("I have some things to do today")