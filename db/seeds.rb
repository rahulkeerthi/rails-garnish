# SEED INGREDIENTS
# require 'pry-byebug'
require 'open-uri'
require 'json'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients = JSON.parse(open(url).read)
ingredients['drinks'].each do |ing|
  Ingredient.create!(name: ing['strIngredient1'])
end

# SEED CATEGORIES

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list'
categories = JSON.parse(open(url).read)
categories['drinks'].each do |cat|
  Category.create!(name: cat['strCategory'])
end
Category.create!(name: "Uncategorised")

# SEED GLASSES

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?g=list'
glasses = JSON.parse(open(url).read)
glasses['drinks'].each do |glass|
  Glass.create!(name: glass['strGlass'])
end
Glass.create!(name: "Any")

puts "Ingredients, Glasses and Categories created!"

# Make an admin user
User.create!(name: "Admin", email: "admin@garnish.com", password: "qwerty")

# Save admin user to variable so we can assign seeded cocktails to them as the creator
admin = User.first

puts "Admin created! Doing the cocktails and doses now!"

20.times do 
  url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'
  cocktails = JSON.parse(open(url).read)["drinks"].first

  # Iterate through the ingredients list in the API to make a hash of ingredients-dosage pairs. Ignore null values.
  doses = {}
  num = 1
  while num <= 15
    if cocktails["strIngredient#{num}"]
      doses[cocktails["strIngredient#{num}"]] = cocktails["strMeasure#{num}"] 
    end
    # binding.pry
    num += 1
  end

  # cocktails['drinks'].each do |cocktail|
    # Create a cocktail with info from the API and save it as drink so we can make the matching doses
    drink = Cocktail.create!(name: cocktails['strDrink'], description: "", category: Category.find_by_name(cocktails['strCategory']) || Category.last, glass: Glass.find_by_name(cocktails['strGlass']) || Glass.last, user: admin, image_url: cocktails['strDrinkThumb'])
    
    # Add the doses from the dose array to the cocktail
    doses.each do |key, value|
      # binding.pry
      Dose.create(cocktail: drink, ingredient: Ingredient.find_by_name(key.to_s.strip), description: value)
    end
  # end
end

puts "Seeding completed!"