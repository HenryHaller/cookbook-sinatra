# require_relative 'view'
require_relative 'recipe'
require 'csv'
class Cookbook
  attr_reader :recipes
  def initialize(csv_file_path)
    # @view = View.new
    @csv_file_path = csv_file_path
    @recipes = []
    CSV.foreach(csv_file_path).each do |row|
      unless  row.length == 0
        r = {}
        r[:name] = row[0].strip
        r[:description] = row[1].strip
        r[:url] = row[2].strip
        r[:prep_time] = row[3].strip
        row[4].nil? ? r[:cook_time] = nil : r[:cook_time] = row[4].strip
        r[:difficulty] = row[5].strip
        row[6].strip == 'true' ? r[:done] = true : r[:done] = false
        # puts r
        @recipes.push(Recipe.new(r))
      end
    end
  end

  # def print_recipe(index)
  #   index = index - 1
  #   recipe = @recipes[index]
  #   puts "#{index} Name: #{recipe.name}\nDescription: #{recipe.description}"
  # end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes.push(recipe)
    #puts "Added: #{recipe.name}: #{recipe.description}"
    save
  end

  def remove_recipe(index)
    # list
    #puts "\nYou chose:\nIndex:#{index}\nName:#{@recipes[index].name}\nDescription:#{@recipes[index].name}\n\n"
    @recipes.delete_at(index)
    save
  end

  def mark_as_done(index)
    @recipes[index].done = true
    save
  end



  private

  def save
    CSV.open(@csv_file_path, "wb") do |csv|
      @recipes.each do
        |recipe| csv << [recipe.name,
         recipe.description,
         recipe.url,
         recipe.prep_time,
         recipe.cook_time,
         recipe.difficulty,
         recipe.done]
      end
    end
  end
end
