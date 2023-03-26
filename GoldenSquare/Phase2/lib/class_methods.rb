class Organiser
  def initialize(name)
    raise "Organiser needs a name... so itself can be organised." if name.strip.empty?

    @name = name.strip
    @task_dict = {}
  end

  def get_name
    @name
  end

  def add_task(task)
    if task[-1] =~ /[.!]/ # removed so that the remind method formats properly. Did not remove '?' as could be relevant information.
      task.chop!
    end
    raise "There is no task without direction!" if task.strip.empty?
    raise "You already have this task set, please be more specific." if @task_dict.include?(task)
    @task_dict[task] = false
  end

  def mark_complete(task)
    raise "You cannot complete what you have not started - task does not exist" unless @task_dict.key?(task)
    @task_dict[task] = true
  end

  def list_all
    raise "There is nothing to list" if @task_dict.empty?
    all_list = []
    (0...@task_dict.length).to_a.each{ |i| all_list.push("#TASK #{i+1} - #{@task_dict.keys[i]}.")}
    return all_list
  end

  def list_complete
    complete = []
    (0...@task_dict.length).to_a.each { |i| @task_dict.values[i] == true ? complete.push("#TASK COMPLETED - #{@task_dict.keys[i]}") : () }

    raise "You've completed nothing!" if complete.empty?
    complete.push("Keep going, buddy!")
    return complete
  end

  def remind
    todo = []
    (0...@task_dict.length).to_a.each { |i| @task_dict.values[i] == false ? todo.push("#TASK #{i+1} - #{@task_dict.keys[i]}"): () }
    raise "Nothing to do, sit back and relax!" if todo.empty?
    todo.push("#{self.get_name}!")
    return todo.join(", ")
  end

  def remind_first_n(n)
    todo = []
    (0...@task_dict.length).to_a.each { |i| @task_dict.values[i] == false ? todo.push("#TASK #{i+1} - #{@task_dict.keys[i]}"): () }

    raise "Nothing to do, sit back and relax!" if todo.empty?
    todo.push("#{self.get_name}!")
    return todo.join(", ")
  end
end

#my_organiser = Organiser.new("Jimmy")
#my_organiser.mark_complete("Go to Machus Red Fox restuarant!")
#my_organiser.add_task("Go to Machus Red Fox restuarant!")
#my_organiser.add_task("Blue")
#print my_organiser.remind

#result = my_organiser.list_all

#puts result
#my_organiser.mark_complete("Go to Machus Red Fox restuarant.")

#my_organiser.list_complete