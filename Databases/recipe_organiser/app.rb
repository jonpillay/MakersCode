require_relative './lib/database_connection'
require_relative './lib/recipe_repository'

DatabaseConnection.connect('recipe_organiser')

def obj_list_print(filtered_list)
  filtered_list.each { |recipe| puts "#{recipe.id} - #{recipe.name} => Cooking Time = #{recipe.cooking_time}mins. Rating - #{recipe.rating}" }
end

recipe_org = RecipeRepository.new

p recipe_org.all[0].rating

#p recipre_org.rated_higher_than(4)

puts recipe_org.all.first.name

obj_list_print(recipe_org.rated_higher_than(4))