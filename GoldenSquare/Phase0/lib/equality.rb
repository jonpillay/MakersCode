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