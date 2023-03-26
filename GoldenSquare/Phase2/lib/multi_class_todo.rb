$LOAD_PATH << '.'
$LOAD_PATH << '/lib/'

require 'class_methods'

# File: lib/todo.rb
class Todo
  def initialize(task) # task is a string
    @task = task
    @done = false
  end

  def task
    # Returns the task as a string
    @task
  end

  def mark_done!
    # Marks the todo as done
    # Returns nothing
    @done = true
  end

  def done?
    # Returns true if the task is done
    # Otherwise, false
    @done
  end
end

# File: lib/todo_list.rb
class TodoList
  def initialize(name)
    raise "Organiser needs a name... so itself can be organised." if name.strip.empty?

    @name = name
    @todo_list = []
  end

  def add(todo) # todo is an instance of Todo
    # Returns nothing
    @todo_list << Todo.new(todo)
  end

  def incomplete
    # Returns all non-done todos
    incomplete = []
    @todo_list.each { |todo| todo.done? == false ? incomplete << todo.task : next }
    return incomplete
  end

  def complete
    # Returns all complete todos
    complete = []
    @todo_list.each { |todo| todo.done? == true ? complete << todo.task : next }
    return complete
  end

  def complete_task(task)
    raise "Task must be in list to be completed" unless self.incomplete.select { |todo| todo == task }.length > 0
    @todo_list.each { |todo| todo.task == task ? todo.mark_done! : next }
  end

  def complete_all!
    # Marks all todos as complete
    @todo_list.each { |todo| todo.mark_done! }
  end
end