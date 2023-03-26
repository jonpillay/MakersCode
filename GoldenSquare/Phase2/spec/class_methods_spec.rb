require 'class_methods'

RSpec.describe Organiser do
  it "returns a fail message when attempting to initialise an instance of Organiser without name" do
    expect { Organiser.new(" ") }.to raise_error "Organiser needs a name... so itself can be organised."
  end
  it "returns my_organiser.name. Initilise properly and return name" do
    my_organiser = Organiser.new("Sammy")
    result = my_organiser.get_name
    expect(result).to eq "Sammy"
  end
  it "initialises and instance of the class and returns the name" do
    my_organiser = Organiser.new("Jimmy")
    expect {my_organiser.mark_complete("Go to Machus Red Fox restuarant")}.to raise_error "You cannot complete what you have not started - task does not exist"
    my_organiser.add_task("Go to Machus Red Fox restuarant.")
    result = my_organiser.list_all()
    expect(result).to eq ["#TASK 1 - Go to Machus Red Fox restuarant."]
    my_organiser.add_task("Pickup steaks for dinner.")
    result2 = my_organiser.list_all()
    expect(result2).to eq ["#TASK 1 - Go to Machus Red Fox restuarant.", "#TASK 2 - Pickup steaks for dinner."]
    result2 = my_organiser.remind
    expect(result2).to eq "#TASK 1 - Go to Machus Red Fox restuarant, #TASK 2 - Pickup steaks for dinner, Jimmy!"
    expect {my_organiser.list_complete}.to raise_error "You've completed nothing!"
    my_organiser.mark_complete("Go to Machus Red Fox restuarant")
    result3 = my_organiser.list_complete
    expect(result3).to eq ["#TASK COMPLETED - Go to Machus Red Fox restuarant", "Keep going, buddy!"]
    my_organiser.add_task("Go home and grill steaks.")
  end
end