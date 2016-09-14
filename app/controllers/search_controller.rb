class SearchController < ApplicationController

    # Search user
    def search_users
        search = Sunspot.search( User ) do
            fulltext params[:query]
        end
        results = search.results
        respond_to do |format|
            format.json{
                results.each_with_index do |u,index|
                    if current_user.ifollow.find_by_id(u.id) != nil
                        u.is_follower = 'following'
                    else
                        u.is_follower = 'not_following'
                    end
                    results.delete_at(index) if u.id == current_user.id
                end
                render json: search.results
            }
        end

    end

    def search_posts
        search = Sunspot.search( Post ) do
            fulltext params[:query]
            
        end
        respond_to do |format|
            format.json{
                render json: search.results

            }
        end
    end

end
