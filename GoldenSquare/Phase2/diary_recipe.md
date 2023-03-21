# TDD RECIPES (Phase 2) Makers March '23

# Exersise One calculate_reading_time

> As a user
> So that I can manage my time
> I want to see an estimate of reading time for a text, assumint that I can read 200 words a minute.
> If passed an empty string, will return zero

```ruby
reading_time = calculate_reading_time(text)
```

* text is a sequence of words from zero onward "this is an example text"
* returns reading_time is an interger representing the minutes needed to read a text - rounded up to the nearest minute


### Tests (when text is passed in as a var, it represents the length of the text)

```ruby

# 1. TEST ON EMPTY STRING
calculate_reading_time("")
# => 0

# 2 TEST ROUNDING
calculate_reading_time(ONE_HUNDRED)
# => 1

# 3 TEST FOR SINGLE UNIT RETURN
calculate_reading_time(TWO_HUNDRED)
# => 1

# 4 TEST ROUNDING
calculate_reading_time(TWO_HUNDRED_AND_ONE)
# => 2

# 5 LARGER NUMBERS
calculate_reading_time(TWO_THOUSAND)
# => 10

# 6 TEST ROUNDING ON LARGE NUMBERS
calculate_reading_time(TWO_HUNDRED_THOUSAND_AND_ONE)
# => 1001

```

## IMPLEMENTATION

```ruby

def calculate_reading_time(text)
  word_count = text.split(/\W+/).length
  minutes = (word_count/200).ceil
  return minutes
end

# method to test large texts by inputting number instead of text. Allows to easily test large text rounding.
# assuming the first tests pass, the word_count variable is proven to work.
# calulate_reading_time_ln no defunct as shown "foo " * 3000 will also produce the same results


def calulate_reading_time_ln(num)
  minutes = (num/200).ceil
  return minutes
end

```

# Exercise Two check_grammar

> As a user
> So I can improve my grammar
> I want to verify that a text starts with a capital letter and ends with a suitable sentence-ending punctuation
> mark

```ruby
grammar_bool = check_grammar(text)
```

* text is a sequence of words from zero onward "this is an example text"
* grammar_bool is a true or false value returned if the text passes or fails the tests

* returns true if grammar holds to the rules and false if not. Works with undefined length of string
* with as many sentences contained. Rules: end sentences with .?! and starting with capital.

## Tests

```ruby
# 1. TEST ON EMPTY STRING
check_grammar("")
# => true

# 2. TEST ON A BAD SENTENCE
check_grammar("this is not how you write a sentencE")
# => false

# 3. TEST ON A GOOD SENTENCE
check_grammar("This is how you write a sentence.")
# => true

# 4. TEST ON A GOOD SENTENCE WITH HILIGHTED CAPITALS WITHIN
check_grammar("This is how you WRITE a sentence.")
# => true

# 5. TEST ON A GOOD SENTENCE WITH A ELLIPSIS WITH
check_grammar("This is how you write... a sentence.")
# => true

```

## IMPLEMENTATION

```ruby

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

```

# CHALLENGE check_todo

> As a user
> So that I can keep track of my tasks
> I want to check if a text includes the string #TODO

```ruby
todo_bool = check_todo(text)
```

* text is a sequence of words one or longer in length
* todo_bool evaluates triue if #TODO present in text, false if not

## TESTS

```ruby

# 1. TEST ON EMPTY STRING
check_todo('')
# => false

# 2. TEST ON FALSE TEXT
check_todo('Time for the park')
# => false

# 3. TEST ON TRUE TEXT
check_todo('I have things #TODO today')
# => true

# 4. TEST ON FALSE TEXT
check_todo('I should probably have some things to do today')
# => false

```

## IMPLEMENTATION

```ruby

def check_todo(text)
  text.include?('#TODO')
end

```