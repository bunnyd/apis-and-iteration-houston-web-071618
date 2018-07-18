require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_film_hash = {}
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film

  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  results = response_hash["results"]

  films_hash = results.map do |result|
    if result["name"].downcase == character
      result["films"]
    end
  end
    film_urls = films_hash.compact.flatten
# binding.pry

  film_urls.map do |film| #iterates through each of the films array and
    response_film_string = RestClient.get(film)
    response_film_hash = JSON.parse(response_film_string) #return this
  end
  # binding.pry
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  # response_film_hash
  # get_and_parse_film
  films_hash.map do |film|
    title = film["title"]
    episode_id = film["episode_id"]
    director = film["director"]
    opening_crawl = film["opening_crawl"]

    puts "*" * 30
    puts "Film Title: #{title}"
    puts "Episode ID: #{episode_id}"
    puts "Director: #{director}"
    puts "Opening Crawl: \n #{opening_crawl}"
  end


  # binding.pry
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
