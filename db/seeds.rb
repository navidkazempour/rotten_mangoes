# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
20.times do 
  User.create!(firstname: Faker::Name.first_name, 
    lastname: Faker::Name.last_name, 
    email: Faker::Internet.email, 
    password: "mangouser", 
    password_confirmation: "mangouser")
end