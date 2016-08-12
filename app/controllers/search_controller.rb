class SearchController < ApplicationController
  
  # Search user
  def search
    search = Sunspot.search( User ) do
     fulltext params[:query]
    end
    results = search.results 
        respond_to do |format|
        format.json{
            results.each do |u|
                if current_user.followers.find_by_id(u.id) != nil
                    u.is_follower = 'following'
                else
                    u.is_follower = 'not_following'
                end
            end
            render json: search.results
        }
        format.html{
            @users = results
            @users
        }
    end
    
  end
end
