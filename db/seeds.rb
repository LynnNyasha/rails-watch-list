# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'
require 'json'

# Define the API endpoint
API_URL = 'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc&without_genres=99,10755&vote_count.gte=200'

# Replace 'YOUR_API_KEY' with your actual TMDb API key
API_KEY = 'dc77136a982ce150ad616cbdf4d29fb4'

# Fetch movie data from the API
def fetch_movies
  url = "#{API_URL}&api_key=#{API_KEY}"
  response = URI.open(url).read
  JSON.parse(response)['results']
end

# Seed movies
def seed_movies
  movies = fetch_movies

  movies.each do |movie_data|
    Movie.create!(
      title: movie_data['title'],
      overview: movie_data['overview'],
      poster_url: "https://image.tmdb.org/t/p/original/#{movie_data['poster_path']}",
      rating: movie_data['vote_average']
    )
  end
end

# Call the method to seed movies
seed_movies
