module Services
  module Movies
    class Movie
    def initialize(omdb_response)
      ratings_info = omdb_response.delete("Ratings")
      ratings_info.each do |ratings_source|
        source, rating =  ratings_source.values
        set_attr_accessor(source, rating)
      end if ratings_info.present?  
      omdb_response.each do |movie_param, movie_description|
        set_attr_accessor(movie_param, movie_description)
      end 
    end 
    private
    def set_attr_accessor(key, value)
      valid_key = valid_attr_accessor(key)
      self.class.__send__(:attr_accessor, valid_key)
      __send__("#{valid_key}=", value)
    end 
    def valid_attr_accessor(key)  
      key.underscore.gsub(' ', '_')
    end 
    end
  end 
end
