require 'movies/movie'
require 'net/http'
require 'json' 
module Services
  module Movies
    class OmdbJsonClient
    attr_reader :api_key, :url 
    def initialize
      @api_key = '652bbfa4'
    end 

    def create_json_parse(movie_info)
      format_url(movie_info)
    end 
   
    def search
      create_movie
    end 

    def reset 
      @url = nil
    end
    private
    def format_url(movie_info = nil)
      @url = "http://omdbapi.com/?apikey=#{@api_key}" unless @url.present?
      if movie_info.present? 
          movie_type, movie_description = movie_info 
          movie_type=determine_type(movie_type)
          @url+= "&#{movie_type}=#{movie_description}"
      end
    end 

    def determine_type(movies)
      case movies.to_s
      when 'type'
        'type'
      when 'plot'
        'plot'
      else
        movies.to_s.first
      end 
    end

    def create_movie
      uri = URI(@url)
      response = Net::HTTP.get(uri)
      json_response = JSON.parse(response)
      if json_response.keys.include?("Search")
        json_response["Search"].map do |search_result|
          Services::Movies::Movie.new(search_result.merge(search: true))
        end 
      else 
        Services::Movies::Movie.new(json_response)
      end 
    end 
    end
  end
end 
