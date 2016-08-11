class SearchController < ApplicationController

  def search
    @users = User.search {
      keywords params[:query]
      order_by :created_at, :asc
    }.results
  end
end
