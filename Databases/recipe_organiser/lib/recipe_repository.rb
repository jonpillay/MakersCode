require_relative './recipe'

class RecipeRepository

  def create_objs(results)
    objs = []
    results.each do |details|
      obj = Recipe.new
      obj.id = details['id']
      obj.name = details['name'] 
      obj.cooking_time = details['cooking_time']
      obj.rating = details['rating']
      objs << obj
    end
    return objs
  end

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT * FROM recipes;'
    result_set = DatabaseConnection.exec_params(sql, [])
    create_objs(result_set)
  end

  def find_by_id(id)
    sql = 'SELECT * FROM recipes WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    create_objs(result_set)
  end

  def find_suitable_time(time)
    sql = 'SELECT * FROM recipes WHERE cooking_time <= $1;'
    params = [time]
    result_set = DatabaseConnection.exec_params(sql, params)
    create_objs(result_set)
  end

  def rated_higher_than(limit)
    sql = 'SELECT * FROM recipes WHERE rating >= $1;'
    params = [limit]
    result_set = DatabaseConnection.exec_params(sql, params)
    create_objs(result_set)
  end

  # Executes the SQL query:
  # SELECT id, name, cohort_name FROM students;

  # Returns an array of Student objects.
end