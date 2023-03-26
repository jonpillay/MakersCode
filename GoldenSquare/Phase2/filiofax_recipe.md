# Multi Class FiloFax Recipe. Diary and Todo intergration.

> As a user
> So that I can record my experiences
> I want to keep a regulary diary

> As a user
> So that I can reflect on my experiences
> I want to read my past diary entries

> As a user
> So that I can reflect on my experiences in my busy day
> I want to select diary entries to read based on how much time I have and my reading speed

> As a user
> So that I can keep track of my tasks
> I want to keep a todo list along with my diary

> As a user
> So that I can keep track of my contacts
> I want to see a list of all of the mobile phone numbers in all my diary entries

## This FiloFax inplementation will depend on two previous class implementations contained in the 'Phase2' folder.
### These are Diary (multi_class diary) which itself depends on DiaryEntry (class_methods).
### The second parent class is Todo (multi_class_todo)
### The tests for recipe thus also depend on the Rpec for both parent classes (as does this recipe)

```ruby
my_filofax = FiloFax.new # inherits from Diary
get_name = my_filofax.get_name
add_entry = my_filofax.add(entry) # entry is an instance of DiaryEntry
all_entries = my_filofax.all
diary_words = my_filofax.count_words
reading_time = my_filofax.reading_time(wpm)
best_entry = my_filofax.find_best_entry_for_reading_time(wpm, minutes)
todo_access = my_filofax.todo # a Todo is initialised during the filofax initialisation 
my_filofax.todo.add_task(task)
all_todo = my_filofax.todo.list_all
todo_tasks = my_filofax.todo.incomplete
completed_tasks = my_filofax.todo.complete
mark_task_complete = my_filofax.todo.complete_task(task)
complete_all_tasks = my_filofax.todo.complete_all!


# TEST 1 TEST INITIALISATION WITH EMPTY STRING (error message differs from diary)
my_filofax = FiloFax.new(" ")
# => raise_error "FiloFax needs a name, so it itself can be organised"

#TEST 2 TEST PROPER INITIALISATION, ADD ENTRY AND RETURN CONTENTS


RSpec.describe FiloFax do
  context "when we add DiaryEntry"
    it "comes back in the list"
      my_filofax = FiloFax.new("Jimmy")
      diary_entry1 = DiaryEntry.new("Title ideas", "Bold as Fish and Chips")
      my_filofax.add(diary_entry1)
      expect(my_filofax.all).to eq [diary_entry1]
    end
  end
    context "when we want to total number of words"
    it "returns the total number of words"
      my_filofax = FiloFax.new("Jimmy")
      diary_entry1 = DiaryEntry.new("Title ideas", "Bold as Fish and Chips")
      my_filofax.add(diary_entry1)
      expect(my_filofax.count_words).to eq 5
    end
  end
  context "should count words"
    it "returns the word count"
      my_filofax = FiloFax.new("Jimmy")
      diary_entry1 = DiaryEntry.new("Title ideas", "Bold as Fish and Chips")
      diary_entry2 = DiaryEntry.new("Second Brainstorm", "Electric Westfield London " * 5)
      my_filofax.add(diary_entry1)
      my_filofax.add(diary_entry2)
      expect(my_filofax.count_words).to eq 20
    end
  end
  context "to estimate how long it would take to read the diary"
    it "returns estimate of the reading time"
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
      expect(my_filofax.find_best_entry_for_reading_time(16, 30)).to eq [my_title2] 
    end
  end
  context "sucessfully initialise add a Todo and return full list in different configs" do
    it "returns the full todo list" do
      my_filofax = FiloFax.new("Jimmy")
      my_filofax.todo.add_task("Come up with some better titles")
      expect(my_filofax.incomplete).to eq ["Come up with some better titles"]
    end
    it "adds another task and returns the updated list" do
      my_filofax = FiloFax.new("Jimmy")
      my_filofax.todo.add_task("Come up with some better titles")
      my_filofax.todo.add_task("Jamm all day!")
      expect(my_filofax.incomplete).to eq ["Come up with some better titles", "Jamm all day!"]
    end
    it "return empty list for complete" do
      my_filofax = FiloFax.new("Jimmy")
      my_filofax.todo.add_task("Come up with some better titles")
      my_filofax.todo.add_task("Jamm all day!")
      expect(my_filofax.complete).to eq ["Come up with some better titles", "Jamm all day!"]
    end
    it "Jamm task as complete and reflect in both lists" do
      my_filofax = FiloFax.new("Jimmy")
      my_filofax.todo.add_task("Come up with some better titles")
      my_filofax.todo.add_task("Jamm all day!")
      my_filofax.todo.complete_task("Jamm all day!")
      expect(my_filofax.incomplete).to eq ["Come up with some better titles"]
      expect(my_filofax.complete).to eq ["Jamm all day!"]
    end
    it "raise_error for unlisted task" do
      my_filofax = FiloFax.new("Jimmy")
      todo_list.complete_task("Learn the flute.")
      expect {todo_list.complete_task("Learn the flute.")}.to raise_error "Task must be in list to be completed"
    end
    it "adds all tasks and marks them all complete and returns relevent lists" do
      my_filofax = FiloFax.new("Jimmy")
      my_filofax.todo.add_task("Come up with some better titles")
      my_filofax.todo.add_task("Jamm all day!")
      my_filofax.todo.complete_all!
      expect(todo_list.complete).to eq ["Come up with some better titles", "Jamm all day!"]
      expect(todo_list.incomplete).to eq []
    end
  end
end

```