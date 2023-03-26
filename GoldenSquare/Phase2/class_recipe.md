# CLASS METHODS RECIPES. JONATHAN PILLAY. MAKERS MARCH '23

# EXERCISE 1

> As a user
> So that I can keep track of my tasks
> I want a program that I can ass todo tasks to and see a list of them.

> As a user
> So that I can focus on tasks to complete
> I want to mark tasks as complete and have them dissapear from the list

```ruby
my_organiser = Organiser.new
get_name = my_organiser.get_name
add_task = my_organiser.add_task(task)
mark_complete = my_organiser.task_complete(task)
all_my_taks = my_organiser.list_all
todo_tasks = my_organiser.list_todo
completed_tasks = my_organiser.list_completed
```

* Organiser an object that initialises with an empty dictionary for tasks to be added to as a key.
* It's value is a bool with a default value of false (for unfinished) to be changed to true when completed 
* text is a string decision of a specific task
* task_complete sets the corresponding value to true
* list_all, list_todo, and list_completed all filter return relevent tasks

# EXPECTED BEHAVIOUR

```ruby

#1 ATTEMPT TO CREATE ORGANISER WITHOUT NAME (SHOULD LEAD TO FAIL AND ERROR MESSAGE)

my_organiser = Organiser.new("") => # fails with "Organiser needs a name... so itself can be organised"

#2 INITIALISE AN INSTANCE OF THE CLASS AND RETURN NAME

my_organiser = Organiser.new("Sammy")
my_organiser.get_name => # returns "Sammy"

#3 CREATE ORGANISER. ADD TASK, RUN LISTS, COMPLETE TASKS, RUN LISTS. (CHECKS ADD, COMPLETE AND FILTERING)

my_organiser = Organiser.new("Jimmy")
my_organiser.mark_complete("Go to Machus Red Fox restuarant.") # => fails with "You cannot complete what you have not started - task does not exist"
my_organiser.add_task("Go to Machus Red Fox restuarant.")
my_organiser.list_all => "#TASK 1 - Go to Machus Red Fox restuarant."
my_organiser.remind => "#TASK 1 - Go to Machus Red Fox restuarant, Jimmy."
my_organiser.list_completed => # fails with "No completed tasks"
my_organiser.mark_complete("Go to Machus Red Fox restuarant.")
my_organiser.list_completed => "#TASK COMPLETED - Go to Machus Red Fox restuarant. Keep going, buddy!"
my_organiser.add_task("Go home and grill steaks.")

```