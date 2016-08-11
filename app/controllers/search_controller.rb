class SearchController < ApplicationController
  
  # Search user
  def search
    @search = Sunspot.search( User ) do
     fulltext params[:query]
    end
    @users = @search.results
    
    render 'search/index'
  end
end
