require 'twilio-ruby'




menu = { 'Cheeseburger' => 7, 'Cheeseburger and Chips' => 10, 'Rum' => 3, 'Rum with ice' => 3.50, 
  'Vegiburger' => 7, 'Vegiburger and Chips' => 10, 'Mushroom Soup' => 5, 'Toast' => 2, 'Jam' => 0.50 }

class Customer
  attr_accessor :name, :order
  def initialize(name)
    raise "Please enter your name" if name.strip.empty?
    @name = name
    @order = Hash.new(0)
  end
end

def print_menu(item_dict)
  item_dict.each.with_index(1) { |(item, price), index| puts "#{index} #{item} || £#{price}" }
end

def print_order(order_dict, total)
  order_dict.each.with_index(1) { |(item, quantity), index| puts "#{index}. #{quantity} X #{item}" }
  puts "Your total to pay is #{total}"
end

def take_order(food)
  puts "Hello! Please enter your name!"
  customer = Customer.new(gets.chomp)
  puts "Hello #{customer.name} welcome to the virtual beach shack! Have a look at our menu!"
  print_menu(food)
  order_total = 0
  loop do
    puts "Please enter the number of the item you would like to order! Or type 'order' to go to checkout."
    choice = gets.chomp
    if (1..food.length).to_a.include?(choice.to_i)
      choice = choice.to_i
      item = food.to_a[choice-1]
      customer.order[item[0]] += 1
      order_total += item[1]
      puts "This is your order so far"
      print_order(customer.order, order_total)
    else
      if choice == 'order'
        break
      else
        puts "Please enter the number of a menu item, or type 'order to go to checkout"
        next
      end
    end
  end
  puts "This is your final order"
  print_order(customer.order, order_total)
  puts "Would you like to finalise this order? Please type 'YES' or 'NO'"
  choice = gets.chomp.downcase
  if choice == 'yes'
    puts 'Excellent! Your order is on the way, if you would like a conformation text message please enter your number or type feed me to exit'
    number = gets.chomp
    word = 'me'
    if number == 'feed me'
      puts "Your food is on the way"
    else
      # TWILIO INFORMATION. REPLACE YOUR OWN CREDNTIALS IF YOU WANT TO RUN SMS FROM YOUR MACHINE.
      word = "Hello, World!"
      twilio_SID = ENV['twilio_SID']
      twilio_AUTH = ENV['twilio_AUTH']
      client = Twilio::REST::Client.new(twilio_SID, twilio_AUTH)
      from = '+14406933831'
      number = number.to_i
      client.messages.create(
        :from => from,
        :to => number,
        :body => word
      )
    end
  elsif choice == 'no'
    puts 'OK! See you next time!'
  else
    puts "Say What?"
  end
end

take_order(menu)

#puts ENV['twilio_SID']