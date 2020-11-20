require 'json'
require 'open-uri'

puts 'Cleaning database'
Dose.delete_all
Ingredient.delete_all
Cocktail.delete_all


# INGREDIENTS
puts 'Creating new ingredients...'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_serialized = open(url).read
ingredients = JSON.parse(ingredients_serialized)

ingredients["drinks"].each do |element|
  ingredient = element["strIngredient1"]
  Ingredient.create!(name: ingredient)
end

mint = Ingredient.create(name: "Mint")
o_juice = Ingredient.create(name: "Orange juice")
olives = Ingredient.create(name: "Olive")

vodka = Ingredient.find_by(name: "Vodka")
rum = Ingredient.find_by(name: "Rum")
gin = Ingredient.find_by(name: "Gin")

puts 'Done!'

# COCKTAILS
puts 'Creating new cocktails...'

# mojito
mojito_file = URI.open("https://images.unsplash.com/photo-1455621481073-d5bc1c40e3cb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=883&q=80")
mojito = Cocktail.new(name: "Mojito")
mojito.photo.attach(io: mojito_file, filename: 'mojito.jpg', content_type: 'image/jpg')
mojito.save!

# bloody mary
bloody_mary_file = URI.open("https://images.unsplash.com/photo-1541546339599-ecdbfcf77378?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=734&q=80")
bloody_mary = Cocktail.new(name: "Bloody Mary")
bloody_mary.photo.attach(io: bloody_mary_file, filename: 'bloody_mary.jpg', content_type: 'image/jpg')
bloody_mary.save!

# sex on the beach
sex_on_the_beach_file = URI.open("https://noseychef.com/wp-content/uploads/2018/07/IMG_3744.jpg")
sex_on_the_beach = Cocktail.new(name: "Sex on the Beach")
sex_on_the_beach.photo.attach(io: sex_on_the_beach_file, filename: 'sex_on_the_beach.jpg', content_type: 'image/jpg')
sex_on_the_beach.save!

# martini
martini_file = URI.open("https://images.unsplash.com/photo-1575023782549-62ca0d244b39?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80")
martini = Cocktail.new(name: "Martini")
martini.photo.attach(io: martini_file, filename: 'martini.jpg', content_type: 'image/jpg')
martini.save!

puts 'Done!'

# DOSES
puts 'Creating new doses...'
Dose.create!(description: "6 Leaves", cocktail: mojito, ingredient: mint)
Dose.create!(description: "1.5 oz", cocktail: mojito, ingredient: rum)
Dose.create!(description: "4.5 cl", cocktail: bloody_mary, ingredient: vodka)
Dose.create!(description: "9 cl", cocktail: bloody_mary, ingredient: Ingredient.find_by(name: "Tomato juice"))
Dose.create!(description: "1.33 oz", cocktail: sex_on_the_beach, ingredient: vodka)
Dose.create!(description: "1.33 oz", cocktail: sex_on_the_beach, ingredient: o_juice)
Dose.create!(description: "8 cl", cocktail: martini, ingredient: gin)
Dose.create!(description: "4 cl", cocktail: martini, ingredient: Ingredient.find_by(name: "Dry Vermouth"))
Dose.create!(description: "1", cocktail: martini, ingredient: olives)

puts 'Done!'
