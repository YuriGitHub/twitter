class VideoCatalogsController < ApplicationController
  before_action :find_user
  before_action :check_authorization, only:[:edit, :create, :update, :destroy]
  before_action :find_video_catalog, only:[:show, :update, :destroy]

  def index
  end

  def new
  end

  def show
  end

  def edit
  end

  def create
    @video_catalog = @user.video_catalogs.build(video_catalog_params)
    respond_to do |format|
      if @video_catalog.save
        format.html {redirect_to user_video_catalogs_path(@user)}
      else
        format.html do
          @errors = @video_catalog.errors.full_messages
          render 'new'
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @video_catalog.update(video_catalog_params)
        format.html do
          flash[:notice] = 'Video Catalog Successfully Updated'
          redirect_to user_video_catalog_path(@user, @video_catalog)
        end
      else
        format.html do
          @errors = @video_catalog.errors.full_messages
          render 'edit'
        end
      end
    end
  end

  def destroy
    @video_catalog.destroy
    redirect_to user_video_catalogs_path(@user)
  end





  def add_video_to_catalog
    binding.pry
  end


  private

  def video_catalog_params
    params.require(:video_catalog).permit(:name)
  end

  def check_authorization
    unless params[:user_id].to_i == current_user.id
      redirect_to current_user
    end
  end

  def find_video_catalog
    @video_catalog = @user.video_catalogs.find(params[:id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end
end
