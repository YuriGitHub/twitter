class VideoCatalogsController < ApplicationController
  before_action :find_user
  before_action :check_authorization, only:[:edit, :create, :update, :destroy, :remove_video, :add_video_to_catalog]
  before_action :find_video_catalog, only:[:show, :update, :destroy, :add_video_to_catalog, :remove_video]

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
   if name_uniquess(@video_catalog.name)
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
   else
     flash[:notice] = 'Name must be uniquess.'
     redirect_to new_user_video_catalog_path(@user)
   end
  end



  def update
    if name_uniquess(params[:video_catalog][:name]) || @video_catalog.name == params[:video_catalog][:name]
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
      else
        flash[:error] = 'Name must be uniquess.'
        redirect_to edit_user_video_catalog_path(@user, @video_catalog)
      end
  end

  def destroy
    @video_catalog.destroy
    redirect_to user_video_catalogs_path(@user)
  end



  def remove_video
    flash[:notice] = @video_catalog.remove_video(params[:video_id])
    redirect_to user_video_catalog_path(@user, @video_catalog)
  end


  def  add_video_to_catalog
    unless params[:attachment]
      set_flash_error('No file selected.')
      redirect_to user_video_catalog_path(@user, @video_catalog)
      return
    end
    flash[:notice] = @video_catalog.load_video(video_params, current_user)
    redirect_to user_video_catalog_path(@user, @video_catalog)
  end



  private

  def set_flash_error(errors = nil)
    errors ||= @video_catalog.errors.full_messages
    flash[:error] = errors
  end

  def name_uniquess(name)
    if @user.video_catalogs.find_by_name(name)
      false
    else
      true
    end
  end

  def video_params
    params.require(:attachment).permit(:file)
  end

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
