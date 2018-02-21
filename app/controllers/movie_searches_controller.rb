require 'movies/omdb_search'
class MovieSearchesController < ApplicationController 
  layout 'welcome'
  before_action :find_by_imdb_id, only: :show
  def index  
    if params[:movies].present?
      search_client= Services::Movies::OmdbSearch.new
      search_client.search_by_contents(params[:movies])
      @results = search_client.finish_search 
    end  
  end 
  def show

  end 

  private
  def find_by_imdb_id
    search_client = Services::Movies::OmdbSearch.new
    search_client.search_by_contents({imdb: params[:id]})
    @movie = search_client.finish_search
  end 
end 
