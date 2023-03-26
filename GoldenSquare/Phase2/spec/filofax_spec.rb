require 'filofax'
require 'multi_class_todo'
require 'multi_class_diary'

RSpec.describe FiloFax do
  context "when we add DiaryEntry" do
    it "comes back in the list" do
      my_filofax = FiloFax.new("Jimmy")
      diary_entry1 = DiaryEntry.new("Title ideas", "Bold as Fish and Chips")
      my_filofax.add(diary_entry1)
      expect(my_filofax.all).to eq [diary_entry1]
    end
  end
  context "when we want to total number of words" do
    it "returns the total number of words" do
      my_filofax = FiloFax.new("Jimmy")
      diary_entry1 = DiaryEntry.new("Title ideas", "Bold as Fish and Chips")
      my_filofax.add(diary_entry1)
      expect(my_filofax.count_words).to eq 5
    end
  end
  context "should count words" do
    it "returns the word count" do
      my_filofax = FiloFax.new("Jimmy")
      diary_entry1 = DiaryEntry.new("Title ideas", "Bold as Fish and Chips")
      diary_entry2 = DiaryEntry.new("Second Brainstorm", "Electric Westfield London " * 5)
      my_filofax.add(diary_entry1)
      my_filofax.add(diary_entry2)
      expect(my_filofax.count_words).to eq 20
    end
  end
  context "to estimate how long it would take to read the diary" do
    it "returns estimate of the reading time" do
      my_filofax = FiloFax.new("Jimmy")
      diary_entry1 = DiaryEntry.new("Title ideas", "Bold as Fish and Chips")
      diary_entry2 = DiaryEntry.new("Second Brainstorm", "Electric Westfield London " * 10)
      my_filofax.add(diary_entry1)
      my_filofax.add(diary_entry2)
      expect(my_filofax.reading_time(16)).to eq 3 
    end
  end
  context "to find a suitable entry to read given a specific time" do
    it "returns a suitable diary entry" do
      my_filofax = FiloFax.new("Jimmy")
      diary_entry1 = DiaryEntry.new("Title ideas", "Bold as Fish and Chips")
      diary_entry2 = DiaryEntry.new("Second Brainstorm", "Electric Westfield London " * 10)
      my_filofax.add(diary_entry1)
      my_filofax.add(diary_entry2)
      expect(my_filofax.find_best_entry_for_reading_time(16, 30)).to eq diary_entry2
    end
  end
  context "sucessfully initialise add a Todo and return full list in different configs" do
    it "returns the full todo list" do
      my_filofax = FiloFax.new("Jimmy")
      my_filofax.todo.add("Come up with some better titles")
      expect(my_filofax.todo.incomplete).to eq ["Come up with some better titles"]
    end
    it "adds another task and returns the updated list" do
      my_filofax = FiloFax.new("Jimmy")
      my_filofax.todo.add("Come up with some better titles")
      my_filofax.todo.add("Jamm all day!")
      expect(my_filofax.todo.incomplete).to eq ["Come up with some better titles", "Jamm all day!"]
    end
    it "return empty list for complete" do
      my_filofax = FiloFax.new("Jimmy")
      my_filofax.todo.add("Come up with some better titles")
      my_filofax.todo.add("Jamm all day!")
      expect(my_filofax.todo.complete).to eq []
    end
    it "Jamm task as complete and reflect in both lists" do
      my_filofax = FiloFax.new("Jimmy")
      my_filofax.todo.add("Come up with some better titles")
      my_filofax.todo.add("Jamm all day!")
      my_filofax.todo.complete_task("Jamm all day!")
      expect(my_filofax.todo.incomplete).to eq ["Come up with some better titles"]
      expect(my_filofax.todo.complete).to eq ["Jamm all day!"]
    end
    it "raise_error for unlisted task" do
      my_filofax = FiloFax.new("Jimmy")
      expect {my_filofax.todo.complete_task("Learn the flute.")}.to raise_error "Task must be in list to be completed"
    end
    it "adds all tasks and marks them all complete and returns relevent lists" do
      my_filofax = FiloFax.new("Jimmy")
      my_filofax.todo.add("Come up with some better titles")
      my_filofax.todo.add("Jamm all day!")
      my_filofax.todo.complete_all!
      expect(my_filofax.todo.complete).to eq ["Come up with some better titles", "Jamm all day!"]
      expect(my_filofax.todo.incomplete).to eq []
    end
  end
end