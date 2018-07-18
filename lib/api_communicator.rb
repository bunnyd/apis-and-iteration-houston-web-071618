require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
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

  results = response_hash["results"]  # now you have an array... so now list out items

  #array of all the URLs

  response_film_links = results.map do |result|

   if result["name"].downcase == character
      result["films"]
    end
  end

  film_URLs = response_film_links.flatten.compact

end


def parse_character_movies(response_film_links)
  # some iteration magic and puts out the movies in a nice list

  response_film_links.map do |film|     #iteration through the films array to get the film api
    response_film_string = RestClient.get(film)
    response_film_hash = JSON.parse(response_film_string) # return this

    title = response_film_hash["title"]
    episode_id = response_film_hash["episode_id"]
    director = response_film_hash["director"]
    opening_crawl = response_film_hash["opening_crawl"]

    puts "\n"
    puts "*" * 30
    puts title
    puts "Episode #{episode_id}"
    puts "Director: #{director}"
    puts "\n"
    puts opening_crawl
    puts "\n"

    end

end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
