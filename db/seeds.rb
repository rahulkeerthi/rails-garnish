# INGREDIENTS

require 'open-uri'
require 'json'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients = JSON.parse(open(url).read)
ingredients['drinks'].each do |ing|
  Ingredient.create!(name: ing['strIngredient1'])
end

# CATEGORIES

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list'
categories = JSON.parse(open(url).read)
categories['drinks'].each do |cat|
  Category.create!(name: cat['strCategory'])
end

# GLASSES

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?g=list'
glasses = JSON.parse(open(url).read)
glasses['drinks'].each do |glass|
  Glass.create!(name: glass['strGlass'])
end

User.create!(name: "Admin", email: "admin@garnish.com", password: "qwerty")
admin = User.first

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?g=list'
cocktails = JSON.parse(open(url).read)
cocktails['drinks'].each do |cocktail|
  Cocktail.create!(name: cocktail['strDrink'], description: "", category: , glass: , user: admin)
  
  Dose.create!
end