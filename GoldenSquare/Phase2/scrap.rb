def check_todo(text)
  text.include?('#TODO')
end

puts check_todo('I should probably have some things to do today')

puts check_todo('I have things #TODO today')

puts check_todo('Time for the park')