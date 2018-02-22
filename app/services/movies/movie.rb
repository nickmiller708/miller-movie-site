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

    def valid?
     (@response.present? && @response.eql?("True")) || @search.present?
    end 

    def fresh_movie? 
      if rotten_tomatoes.present?
        rotten_tomatoes.gsub('%','').to_i >= 60
      else 
        false
      end 
    end 

    def rotten_info
      find_information(['rotten'])
    end 

    def imdb_information
      find_information(['imdb', 'internet'])
    end
 
    def metacritic_information
      find_information(['meta'])
    end 
    
    def imdb_link
      imdb_id.present? ? "https://www.imdb.com/title/#{imdb_id}" : nil 
    end 

    def determine_metacritic_rank
      score = metacritic_raw_score
      case score
      when (81 .. 100)
      "Universal Acclaim"
      when (61 .. 80)
      "Generally Favorable Reviews"
      when (40 .. 60)
      "Mixed or Average Reviews" 
      when (20 .. 39)
      "Generally Unfavorable Reviews"
      when (0 .. 19)
      "Overwhelming Dislike"
      else
      "Could not determine"
      end 
    end

    def determine_metric_color
      score =  metacritic_raw_score
      case score
      when (61 .. 100)
      "green"
      when (40 .. 60)
      "yellow"
      else
      "red"
      end 
    end  
      
    private

    def find_information(contents)
      defined_methods.map do |method|
        found_content =   contents.map do |content|
          [method, self.try(method.to_sym)] if (method =~ /#{content}/)
        end.compact.first
        found_content if found_content.present?
      end.compact.to_h
    end 
 
    def set_attr_accessor(key, value)
      valid_key = valid_attr_accessor(key.to_s)
      self.class.__send__(:attr_accessor, valid_key)
      __send__("#{valid_key}=", value)
    end 
    def valid_attr_accessor(key)  
      key.underscore.gsub(' ', '_')
    end 
    def defined_methods
      instance_variables.map{|element| element.to_s.gsub('@', '')}
    end 
    def metacritic_raw_score
      (metacritic.present? && !metacritic.eql?("N/A")) ? metacritic.gsub("/100", "").to_i : 0
    end 
    end
  end 
end
