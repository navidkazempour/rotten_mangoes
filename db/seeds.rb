# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 20.times do 
#   User.create!(firstname: Faker::Name.first_name, 
#     lastname: Faker::Name.last_name, 
#     email: Faker::Internet.email, 
#     password: "mangouser", 
#     password_confirmation: "mangouser")
# end


@all_movies = Imdb::Top250.new.movies
@all_movies.each do |num|
  num = num.id
  movie = Imdb::Movie.new(num)
  Movie.create!(title: movie.title.gsub(/\d*\.\s*/, ''),
  release_date: movie.release_date,
  director: movie.director,
  runtime_in_minutes: movie.length,
  poster_image_url: movie.poster,
  description: movie.plot)
end
