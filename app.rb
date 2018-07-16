require_relative "./recipedownloader"
require_relative "./recipe"
require_relative "./cookbook"
require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
set :bind, '0.0.0.0'


configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

recipedownloader = RecipeDownloader.new
cookbook = Cookbook.new("recipes.csv")
get '/' do
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/recipes' do
  r = {}
  r[:name] = params["name"]
  r[:description] = params["description"]
  r[:cook_time] = params["cook_time"]
  r[:prep_time] = params["prep_time"]
  r[:done] = false
  r[:url] = params["URL"]
  r[:difficulty] = params["difficulty"]
  @recipe = Recipe.new(r)
  cookbook.add_recipe(@recipe)
  erb :recipes
  redirect '/'
end

post '/delete' do
  cookbook.remove_recipe(params["index_to_delete"].to_i)
  redirect '/'
end

get '/auto_add' do
  erb :auto_add
end

post '/auto_add_results' do
  keyword = params["keyword"]
  @results_array = recipedownloader.scrape_and_parse(keyword)
  erb :auto_add_results
end

post '/done' do
  index = params["index_to_mark_as_done"].to_i
  cookbook.mark_as_done(index)
  redirect '/'
end
