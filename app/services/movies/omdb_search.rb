require 'movies/omdb_json_generator'
module Services
  module Movies
    class OmdbSearch
    attr_reader :omdb_search_client
    def initialize
      @omdb_search_client = Services::Movies::OmdbJsonClient.new
    end 

    def search_by_contents(contents)
      contents.each do |content| 
        #will take something like title or year
        @omdb_search_client.create_json_parse(content)
      end 
    end 

    def title(title)
      search_by_contents(title: title)
      finish_search
    end 

    def send_contents(contents)
      contents.each do |content|
        content_type, information = content
        search_by_contents(format_hash(content_type, information))
      end 
    end 
    
    def finish_search
      @omdb_search_client.search
    end 
    def reset_client
      @omdb_search_client.reset
    end 

    end
  end
end 
