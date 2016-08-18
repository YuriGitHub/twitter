class SearchController < ApplicationController

    # Search user
    def search
        search = User.solr_search do
            fulltext params[:query]
        end
        results = search
        respond_to do |format|
            format.json{
                results.each do |u|
                    if current_user.ifollow.find_by_id(u.id) != nil
                        u.is_follower = 'following'
                    else
                        u.is_follower = 'not_following'
                    end
                end
                render json: search.results
            }
            format.html{
                @users = results
                #render 'search/index'
                unless params[:query] == nil or params[:query] == ""
                    redirect_to root_path()+"?query="+params[:query]
                else
                    redirect_to root_path
                end
            }
        end

    end
end
