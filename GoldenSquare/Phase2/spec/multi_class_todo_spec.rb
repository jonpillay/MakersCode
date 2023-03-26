require 'multi_class_todo'
require 'class_methods'

RSpec.describe TodoList do
  context "attempt to initialise without name" do
    it "return a fail message" do
      expect {todo_list = TodoList.new("")}.to raise_error "Organiser needs a name... so itself can be organised."
    end
  end
  context "sucessfully initialise add a Todo and return full list in different configs" do
    it "returns the full todo list" do
      todo_list = TodoList.new("Mikel")
      todo_list.add("Beat City at the Ethiad")
      expect(todo_list.incomplete).to eq ["Beat City at the Ethiad"]
    end
    it "adds another task and returns the updated list" do
      todo_list = TodoList.new("Mikel")
      todo_list.add("Beat City at the Ethiad")
      todo_list.add("Beat Chelsea at home")
      expect(todo_list.incomplete).to eq ["Beat City at the Ethiad", "Beat Chelsea at home"]
    end
    it "return empty list for complete" do
      todo_list = TodoList.new("Mikel")
      todo_list.add("Beat City at the Ethiad")
      todo_list.add("Beat Chelsea at home")
      expect(todo_list.complete).to eq []
    end
    it "mark City task as complete and reflect in both lists" do
      todo_list = TodoList.new("Mikel")
      todo_list.add("Beat City at the Ethiad")
      todo_list.add("Beat Chelsea at home")
      todo_list.complete_task("Beat City at the Ethiad")
      expect(todo_list.complete).to eq ["Beat City at the Ethiad"]
      expect(todo_list.incomplete).to eq ["Beat Chelsea at home"]
    end
    it "mark City task as complete and reflect in both lists" do
      todo_list = TodoList.new("Mikel")
      todo_list.add("Beat City at the Ethiad")
      todo_list.add("Beat Chelsea at home")
      todo_list.complete_task("Beat City at the Ethiad")
      expect {todo_list.complete_task("Lift the trophy")}.to raise_error "Task must be in list to be completed"
      expect(todo_list.complete).to eq ["Beat City at the Ethiad"]
      expect(todo_list.incomplete).to eq ["Beat Chelsea at home"]
    end
    it "adds all tasks and marks them all complete and returns relevent lists" do
      todo_list = TodoList.new("Mikel")
      todo_list.add("Beat City at the Ethiad")
      todo_list.add("Beat Chelsea at home")
      todo_list.add("Lift the trophy")
      todo_list.complete_all!
      expect(todo_list.complete).to eq ["Beat City at the Ethiad", "Beat Chelsea at home", "Lift the trophy"]
      expect(todo_list.incomplete).to eq []
    end
  end
end