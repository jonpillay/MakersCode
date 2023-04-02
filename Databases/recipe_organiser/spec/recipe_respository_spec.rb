require 'recipe_repository'

RSpec.describe RecipeRepository do
    def reset_recipes_table
      seed_sql = File.read('spec/seeds_recipe_organiser.sql')
      connection = PG.connect({ host: '127.0.0.1', dbname: 'recipe_organiser' })
      connection.exec(seed_sql)
    end
    before(:each) do 
      reset_recipes_table
    end
    it "returns book information" do
      repo = RecipeRepository.new
      recipes = repo.all
      expect(recipes.length).to eq 3
      expect(recipes.first.name).to eq 'Spag Bol'
      expect(recipes.first.id).to eq '1'
      expect(repo.rated_higher_than(4).length).to eq 2
    end
  end